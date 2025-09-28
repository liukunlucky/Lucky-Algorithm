import { relationalStore } from '@kit.ArkData';
import { OfferModel, OfferStatus, JobType, WorkMode } from '../model/OfferModel';
import { DatabaseHelper } from '../database/DatabaseHelper';

export interface OfferStatistics {
  total: number;
  pending: number;
  accepted: number;
  rejected: number;
  expired: number;
  avgSalary: number;
  maxSalary: number;
}

export interface GroupedOffers {
  urgent: OfferModel[];      // 紧急处理
  received: OfferModel[];    // 已收到
  pending: OfferModel[];     // 待定
  accepted: OfferModel[];    // 已接受
  rejected: OfferModel[];    // 已拒绝
  expired: OfferModel[];     // 已过期
}

export class OfferDao {
  private static instance: OfferDao;
  private dbHelper: DatabaseHelper;

  private constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  static getInstance(): OfferDao {
    if (!OfferDao.instance) {
      OfferDao.instance = new OfferDao();
    }
    return OfferDao.instance;
  }

  // 插入Offer
  async insertOffer(offer: OfferModel): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      INSERT INTO offers (
        company, position, base_salary, bonus, stock_options, other_benefits,
        work_type, work_mode, work_location, offer_date, response_deadline,
        start_date, hr_contact, hr_name, hr_phone, hr_email, notes, satisfaction_score,
        status, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const now = new Date().toISOString();
    await store.executeSql(sql, [
      offer.company,
      offer.position,
      offer.baseSalary,
      offer.bonus,
      offer.stockOptions,
      offer.benefits,
      offer.jobType,
      offer.workMode,
      offer.location || '',
      offer.offerDate,
      offer.responseDate || '',
      offer.startDate || '',
      offer.hrContact || '',
      offer.hrName || '',
      '', // hr_phone - 暂时为空字符串，因为OfferModel中没有此字段
      '', // hr_email - 暂时为空字符串，因为OfferModel中没有此字段
      offer.notes || '',
      offer.satisfactionScore,
      offer.status,
      now,
      now
    ]);

    return 1;
  }

  // 更新Offer
  async updateOffer(offer: OfferModel): Promise<boolean> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      UPDATE offers SET
        company = ?, position = ?, base_salary = ?, bonus = ?, stock_options = ?,
        other_benefits = ?, work_type = ?, work_mode = ?, work_location = ?,
        offer_date = ?, response_deadline = ?, start_date = ?, hr_contact = ?,
        hr_name = ?, hr_phone = ?, hr_email = ?, notes = ?, satisfaction_score = ?,
        status = ?, updated_at = ?
      WHERE id = ?
    `;

    await store.executeSql(sql, [
      offer.company,
      offer.position,
      offer.baseSalary,
      offer.bonus,
      offer.stockOptions,
      offer.benefits,
      offer.jobType,
      offer.workMode,
      offer.location || '',
      offer.offerDate,
      offer.responseDate || '',
      offer.startDate || '',
      offer.hrContact || '',
      offer.hrName || '',
      '', // hr_phone - 暂时为空字符串，因为OfferModel中没有此字段
      '', // hr_email - 暂时为空字符串，因为OfferModel中没有此字段
      offer.notes || '',
      offer.satisfactionScore,
      offer.status,
      new Date().toISOString(),
      offer.id
    ]);

    return true;
  }

  // 删除Offer
  async deleteOffer(id: number): Promise<boolean> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'DELETE FROM offers WHERE id = ?';
    await store.executeSql(sql, [id]);
    return true;
  }

  // 根据ID获取Offer
  async getOfferById(id: number): Promise<OfferModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM offers WHERE id = ?';
    const result = await store.querySql(sql, [id]);

    if (result.rowCount === 0) {
      return null;
    }

    result.goToRow(0);
    return this.mapResultToModel(result);
  }

  // 获取所有Offer
  async getAllOffers(): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM offers ORDER BY offer_date DESC, created_at DESC';
    const result = await store.querySql(sql);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 根据状态筛选Offer
  async getOffersByStatus(status: OfferStatus): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM offers WHERE status = ? ORDER BY offer_date DESC';
    const result = await store.querySql(sql, [status]);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 根据工作类型筛选Offer
  async getOffersByWorkType(workType: JobType): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM offers WHERE work_type = ? ORDER BY offer_date DESC';
    const result = await store.querySql(sql, [workType]);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 搜索Offer
  async searchOffers(keyword: string): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT * FROM offers 
      WHERE company LIKE ? OR position LIKE ? OR notes LIKE ?
      ORDER BY offer_date DESC
    `;
    const searchTerm = `%${keyword}%`;
    const result = await store.querySql(sql, [searchTerm, searchTerm, searchTerm]);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 获取即将过期的Offer
  async getExpiringOffers(days: number = 7): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const futureDate = new Date();
    futureDate.setDate(futureDate.getDate() + days);
    const futureDateStr = futureDate.toISOString().split('T')[0];

    const sql = `
      SELECT * FROM offers 
      WHERE status = ? AND response_deadline <= ? AND response_deadline != ''
      ORDER BY response_deadline ASC
    `;
    const result = await store.querySql(sql, [OfferStatus.PENDING, futureDateStr]);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 获取Offer统计数据
  async getOfferStats(): Promise<OfferStatistics> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const totalResult = await store.querySql('SELECT COUNT(*) as count FROM offers');
    totalResult.goToRow(0);
    const total = totalResult.getLong(totalResult.getColumnIndex('count'));

    const pendingResult = await store.querySql('SELECT COUNT(*) as count FROM offers WHERE status = ?', [OfferStatus.PENDING]);
    pendingResult.goToRow(0);
    const pending = pendingResult.getLong(pendingResult.getColumnIndex('count'));

    const acceptedResult = await store.querySql('SELECT COUNT(*) as count FROM offers WHERE status = ?', [OfferStatus.ACCEPTED]);
    acceptedResult.goToRow(0);
    const accepted = acceptedResult.getLong(acceptedResult.getColumnIndex('count'));

    const rejectedResult = await store.querySql('SELECT COUNT(*) as count FROM offers WHERE status = ?', [OfferStatus.REJECTED]);
    rejectedResult.goToRow(0);
    const rejected = rejectedResult.getLong(rejectedResult.getColumnIndex('count'));

    const expiredResult = await store.querySql('SELECT COUNT(*) as count FROM offers WHERE status = ?', [OfferStatus.EXPIRED]);
    expiredResult.goToRow(0);
    const expired = expiredResult.getLong(expiredResult.getColumnIndex('count'));

    const salaryResult = await store.querySql('SELECT AVG(base_salary + bonus) as avg_salary, MAX(base_salary + bonus) as max_salary FROM offers');
    salaryResult.goToRow(0);
    const avgSalary = salaryResult.getDouble(salaryResult.getColumnIndex('avg_salary'));
    const maxSalary = salaryResult.getDouble(salaryResult.getColumnIndex('max_salary'));

    return {
      total: Number(total),
      pending: Number(pending),
      accepted: Number(accepted),
      rejected: Number(rejected),
      expired: Number(expired),
      avgSalary: Number(avgSalary) || 0,
      maxSalary: Number(maxSalary) || 0
    };
  }

  // 按薪资排序获取Offer
  async getOffersSortedBySalary(ascending: boolean = false): Promise<OfferModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const order = ascending ? 'ASC' : 'DESC';
    const sql = `SELECT * FROM offers ORDER BY (base_salary + bonus) ${order}`;
    const result = await store.querySql(sql);

    const offers: OfferModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      offers.push(this.mapResultToModel(result));
    }

    return offers;
  }

  // 将查询结果映射为模型对象
  private mapResultToModel(result: relationalStore.ResultSet): OfferModel {
    const offer = new OfferModel();
    
    offer.id = result.getLong(result.getColumnIndex('id'));
    offer.company = result.getString(result.getColumnIndex('company'));
    offer.position = result.getString(result.getColumnIndex('position'));
    offer.baseSalary = result.getDouble(result.getColumnIndex('base_salary'));
    offer.bonus = result.getDouble(result.getColumnIndex('bonus'));
    offer.stockOptions = result.getString(result.getColumnIndex('stock_options'));
    
    const benefitsStr = result.getString(result.getColumnIndex('other_benefits'));
    offer.benefits = benefitsStr ? benefitsStr : '';
    
    offer.jobType = result.getString(result.getColumnIndex('work_type')) as JobType;
    offer.workMode = result.getString(result.getColumnIndex('work_mode')) as WorkMode;
    offer.location = result.getString(result.getColumnIndex('work_location'));
    offer.offerDate = result.getString(result.getColumnIndex('offer_date'));
    offer.responseDate = result.getString(result.getColumnIndex('response_deadline'));
    offer.startDate = result.getString(result.getColumnIndex('start_date'));
    offer.hrContact = result.getString(result.getColumnIndex('hr_contact'));
    offer.hrName = result.getString(result.getColumnIndex('hr_name'));
    offer.notes = result.getString(result.getColumnIndex('notes'));
    offer.satisfactionScore = result.getLong(result.getColumnIndex('satisfaction_score'));
    offer.status = result.getString(result.getColumnIndex('status')) as OfferStatus;

    return offer;
  }
}