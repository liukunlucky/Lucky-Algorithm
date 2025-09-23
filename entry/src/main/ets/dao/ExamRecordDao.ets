import relationalStore from '@ohos.data.relationalStore';
import { ExamRecordModel, ExamMode, ExamProblemResult } from '../model/ExamRecordModel';
import { DatabaseHelper } from '../database/DatabaseHelper';

interface ExamStatistics {
  totalExams: number;
  averageScore: number;
  bestScore: number;
  totalTimeSpent: number;
}

interface ExamRecordDetails {
  totalProblems: number;
  correctCount: number;
  timeUsed: number;
  startTime: string;
  endTime: string;
  problemResults: ExamProblemResult[];
}

export class ExamRecordDao {
  private dbHelper: DatabaseHelper;

  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  // 保存考核记录
  async saveExamRecord(record: ExamRecordModel): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      INSERT INTO exam_records (date, mode, score, duration, details)
      VALUES (?, ?, ?, ?, ?)
    `;

    // 将考核记录详情序列化为JSON字符串
    const details = JSON.stringify({
      totalProblems: record.totalProblems,
      correctCount: record.correctCount,
      timeUsed: record.timeUsed,
      startTime: record.startTime.toISOString(),
      endTime: record.endTime.toISOString(),
      problemResults: record.problemResults
    });

    await store.executeSql(sql, [
      record.date,
      record.mode,
      record.score,
      record.duration,
      details
    ]);

    console.info('Exam record saved successfully');
  }

  // 获取所有考核记录
  async getAllExamRecords(): Promise<ExamRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM exam_records ORDER BY date DESC';
    const result = await store.querySql(sql);
    const records: ExamRecordModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const record = this.mapResultToRecord(result);
        records.push(record);
      }
    }

    return records;
  }

  // 获取最近的考核记录（限制数量）
  async getRecentExamRecords(limit: number = 5): Promise<ExamRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM exam_records ORDER BY date DESC LIMIT ?';
    const result = await store.querySql(sql, [limit]);
    const records: ExamRecordModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const record = this.mapResultToRecord(result);
        records.push(record);
      }
    }

    return records;
  }

  // 根据模式获取考核记录
  async getExamRecordsByMode(mode: ExamMode): Promise<ExamRecordModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM exam_records WHERE mode = ? ORDER BY date DESC';
    const result = await store.querySql(sql, [mode]);
    const records: ExamRecordModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const record = this.mapResultToRecord(result);
        records.push(record);
      }
    }

    return records;
  }

  // 根据ID获取考核记录
  async getExamRecordById(id: number): Promise<ExamRecordModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM exam_records WHERE id = ?';
    const result = await store.querySql(sql, [id]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToRecord(result);
    }

    return null;
  }

  // 删除考核记录
  async deleteExamRecord(id: number): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'DELETE FROM exam_records WHERE id = ?';
    await store.executeSql(sql, [id]);
    console.info('Exam record deleted successfully');
  }

  // 获取考核统计信息
  async getExamStatistics(): Promise<ExamStatistics> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT 
        COUNT(*) as total_exams,
        AVG(score) as average_score,
        MAX(score) as best_score,
        SUM(duration) as total_time_spent
      FROM exam_records
    `;
    
    const result = await store.querySql(sql);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const totalExams = result.getLong(result.getColumnIndex('total_exams'));
      const averageScore = result.getDouble(result.getColumnIndex('average_score'));
      const bestScore = result.getDouble(result.getColumnIndex('best_score'));
      const totalTimeSpent = result.getLong(result.getColumnIndex('total_time_spent'));
      
      const statistics: ExamStatistics = {
        totalExams: totalExams,
        averageScore: Math.round(averageScore),
        bestScore: Math.round(bestScore),
        totalTimeSpent: totalTimeSpent
      };
      return statistics;
    }

    const emptyStatistics: ExamStatistics = {
      totalExams: 0,
      averageScore: 0,
      bestScore: 0,
      totalTimeSpent: 0
    };
    return emptyStatistics;
  }

  // 将查询结果映射为考核记录模型
  private mapResultToRecord(result: relationalStore.ResultSet): ExamRecordModel {
    const record = new ExamRecordModel();
    record.id = result.getLong(result.getColumnIndex('id'));
    record.date = result.getString(result.getColumnIndex('date')) || '';
    record.mode = result.getString(result.getColumnIndex('mode')) as ExamMode || ExamMode.QUICK;
    record.score = result.getDouble(result.getColumnIndex('score'));
    record.duration = result.getLong(result.getColumnIndex('duration'));

    // 解析详情JSON
    const detailsStr = result.getString(result.getColumnIndex('details')) || '{}';
    try {
      const details = JSON.parse(detailsStr) as ExamRecordDetails;
      record.totalProblems = details.totalProblems || 0;
      record.correctCount = details.correctCount || 0;
      record.timeUsed = details.timeUsed || record.duration;
      record.startTime = details.startTime ? new Date(details.startTime) : new Date();
      record.endTime = details.endTime ? new Date(details.endTime) : new Date();
      record.problemResults = details.problemResults || [];
    } catch (error) {
      console.error('Failed to parse exam record details:', error);
      record.totalProblems = 0;
      record.correctCount = 0;
      record.timeUsed = record.duration;
      record.startTime = new Date();
      record.endTime = new Date();
      record.problemResults = [];
    }

    return record;
  }
}