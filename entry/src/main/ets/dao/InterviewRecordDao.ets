import { relationalStore } from '@kit.ArkData';
import { InterviewRecordModel, InterviewStatus, InterviewRound, InterviewResult, OfferStatus } from '../model/InterviewRecordModel';
import { DatabaseHelper } from '../database/DatabaseHelper';

export interface InterviewStats {
  total: number;
  pending: number;
  completed: number;
  passed: number;
  failed: number;
  offers: number;
}

export class InterviewRecordDao {
  private static instance: InterviewRecordDao;
  private dbHelper: DatabaseHelper;

  private constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  static getInstance(): InterviewRecordDao {
    if (!InterviewRecordDao.instance) {
      InterviewRecordDao.instance = new InterviewRecordDao();
    }
    return InterviewRecordDao.instance;
  }

  // 插入面试记录
  async insertInterviewRecord(record: InterviewRecordModel): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      INSERT INTO interview_records (
        company, position, interview_date, round, status, result, offer_status,
        interview_type, interviewer, duration, questions, answers, tech_stack,
        difficulty, experience, notes, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const now = new Date().toISOString();
    const result = await store.executeSql(sql, [
      record.company,
      record.position,
      record.interviewDate,
      record.round,
      record.status,
      record.result,
      record.offerStatus,
      record.interviewType,
      record.interviewer || '',
      record.duration,
      JSON.stringify(record.questions),
      JSON.stringify(record.answers),
      JSON.stringify(record.techStack),
      record.difficulty,
      record.experience || '',
      record.notes || '',
      now,
      now
    ]);

    return 1;
  }

  // 更新面试记录
  async updateInterviewRecord(record: InterviewRecordModel): Promise<boolean> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      UPDATE interview_records SET
        company = ?, position = ?, interview_date = ?, round = ?, status = ?,
        result = ?, offer_status = ?, interview_type = ?, interviewer = ?,
        duration = ?, questions = ?, answers = ?, tech_stack = ?, difficulty = ?,
        experience = ?, notes = ?, updated_at = ?
      WHERE id = ?
    `;

    const result = await store.executeSql(sql, [
      record.company,
      record.position,
      record.interviewDate,
      record.round,
      record.status,
      record.result,
      record.offerStatus,
      record.interviewType,
      record.interviewer || '',
      record.duration,
      JSON.stringify(record.questions),
      JSON.stringify(record.answers),
      JSON.stringify(record.techStack),
      record.difficulty,
      record.experience || '',
      record.notes || '',
      new Date().toISOString(),
      record.id
    ]);

    return true;
  }

  // 删除面试记录
  async deleteInterviewRecord(id: number): Promise<boolean> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'DELETE FROM interview_records WHERE id = ?';
    await store.executeSql(sql, [id]);
    return true;
  }

  // 根据ID获取面试记录
  async getInterviewRecordById(id: number): Promise<InterviewRecordModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM interview_records WHERE id = ?';
    const result = await store.querySql(sql, [id]);

    if (result.rowCount === 0) {
      return null;
    }

    result.goToRow(0);
    return this.mapResultToModel(result);
  }

  // 获取所有面试记录
  async getAllInterviewRecords(): Promise<InterviewRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM interview_records ORDER BY interview_date DESC, created_at DESC';
    const result = await store.querySql(sql);

    const records: InterviewRecordModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      records.push(this.mapResultToModel(result));
    }

    return records;
  }

  // 根据状态筛选面试记录
  async getInterviewRecordsByStatus(status: InterviewStatus): Promise<InterviewRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM interview_records WHERE status = ? ORDER BY interview_date DESC';
    const result = await store.querySql(sql, [status]);

    const records: InterviewRecordModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      records.push(this.mapResultToModel(result));
    }

    return records;
  }

  // 根据结果筛选面试记录
  async getInterviewRecordsByResult(result: InterviewResult): Promise<InterviewRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM interview_records WHERE result = ? ORDER BY interview_date DESC';
    const queryResult = await store.querySql(sql, [result]);

    const records: InterviewRecordModel[] = [];
    for (let i = 0; i < queryResult.rowCount; i++) {
      queryResult.goToRow(i);
      records.push(this.mapResultToModel(queryResult));
    }

    return records;
  }

  // 搜索面试记录
  async searchInterviewRecords(keyword: string): Promise<InterviewRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT * FROM interview_records 
      WHERE company LIKE ? OR position LIKE ? OR notes LIKE ?
      ORDER BY interview_date DESC
    `;
    const searchTerm = `%${keyword}%`;
    const result = await store.querySql(sql, [searchTerm, searchTerm, searchTerm]);

    const records: InterviewRecordModel[] = [];
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      records.push(this.mapResultToModel(result));
    }

    return records;
  }

  // 获取面试统计数据
  async getInterviewStats(): Promise<InterviewStats> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const totalResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records');
    totalResult.goToRow(0);
    const total = totalResult.getLong(totalResult.getColumnIndex('count'));

    const pendingResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records WHERE status = ?', [InterviewStatus.SCHEDULED]);
    pendingResult.goToRow(0);
    const pending = pendingResult.getLong(pendingResult.getColumnIndex('count'));

    const completedResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records WHERE status = ?', [InterviewStatus.COMPLETED]);
    completedResult.goToRow(0);
    const completed = completedResult.getLong(completedResult.getColumnIndex('count'));

    const passedResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records WHERE result = ?', [InterviewResult.PASS]);
    passedResult.goToRow(0);
    const passed = passedResult.getLong(passedResult.getColumnIndex('count'));

    const failedResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records WHERE result = ?', [InterviewResult.FAIL]);
    failedResult.goToRow(0);
    const failed = failedResult.getLong(failedResult.getColumnIndex('count'));

    const offersResult = await store.querySql('SELECT COUNT(*) as count FROM interview_records WHERE offer_status = ?', [OfferStatus.RECEIVED]);
    offersResult.goToRow(0);
    const offers = offersResult.getLong(offersResult.getColumnIndex('count'));

    const stats: InterviewStats = {
      total: Number(total),
      pending: Number(pending),
      completed: Number(completed),
      passed: Number(passed),
      failed: Number(failed),
      offers: Number(offers)
    };
    
    return stats;
  }

  // 将查询结果映射为模型对象
  private mapResultToModel(result: relationalStore.ResultSet): InterviewRecordModel {
    const record = new InterviewRecordModel();
    
    record.id = result.getLong(result.getColumnIndex('id'));
    record.company = result.getString(result.getColumnIndex('company'));
    record.position = result.getString(result.getColumnIndex('position'));
    record.interviewDate = result.getString(result.getColumnIndex('interview_date'));
    record.round = result.getString(result.getColumnIndex('round')) as InterviewRound;
    record.status = result.getString(result.getColumnIndex('status')) as InterviewStatus;
    record.result = result.getString(result.getColumnIndex('result')) as InterviewResult;
    record.offerStatus = result.getString(result.getColumnIndex('offer_status')) as OfferStatus;
    record.interviewType = result.getString(result.getColumnIndex('interview_type'));
    record.interviewer = result.getString(result.getColumnIndex('interviewer'));
    record.duration = result.getLong(result.getColumnIndex('duration'));
    
    const questionsStr = result.getString(result.getColumnIndex('questions'));
    record.questions = questionsStr ? JSON.parse(questionsStr) : [];
    
    const answersStr = result.getString(result.getColumnIndex('answers'));
    record.answers = answersStr ? JSON.parse(answersStr) : [];
    
    const techStackStr = result.getString(result.getColumnIndex('tech_stack'));
    record.techStack = techStackStr ? JSON.parse(techStackStr) : [];
    
    record.difficulty = result.getLong(result.getColumnIndex('difficulty'));
    record.experience = result.getString(result.getColumnIndex('experience'));
    record.notes = result.getString(result.getColumnIndex('notes'));
    record.createdAt = result.getString(result.getColumnIndex('created_at'));

    return record;
  }
}