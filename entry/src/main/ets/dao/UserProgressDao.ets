import relationalStore from '@ohos.data.relationalStore';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemCategory } from '../model/ProblemModel';
import { DatabaseHelper } from '../database/DatabaseHelper';

interface UserStatistics {
  totalAttempted: number;
  totalCompleted: number;
  totalWrong: number;
  totalFavorites: number;
  overallAccuracy: number;
}

export class UserProgressDao {
  private dbHelper: DatabaseHelper;

  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  // 获取用户对指定题目的进度
  async getUserProgress(problemId: number): Promise<UserProgressModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_progress WHERE problem_id = ?';
    const result = await store.querySql(sql, [problemId]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToProgress(result);
    }

    return null;
  }

  // 获取所有用户进度
  async getAllUserProgress(): Promise<UserProgressModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_progress ORDER BY problem_id';
    const result = await store.querySql(sql);
    const progressList: UserProgressModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const progress = this.mapResultToProgress(result);
        progressList.push(progress);
      }
    }

    return progressList;
  }

  // 获取用户收藏的题目ID列表（通过用户进度记录）
  async getFavoriteProblems(): Promise<UserProgressModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_progress WHERE is_favorite = 1 ORDER BY last_attempted DESC';
    const result = await store.querySql(sql);
    const progressList: UserProgressModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const progress = this.mapResultToProgress(result);
        progressList.push(progress);
      }
    }

    return progressList;
  }

  // 获取错题
  async getWrongProblems(): Promise<UserProgressModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_progress WHERE status = ? ORDER BY last_attempted DESC';
    const result = await store.querySql(sql, [ProblemStatus.WRONG]);
    const progressList: UserProgressModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const progress = this.mapResultToProgress(result);
        progressList.push(progress);
      }
    }

    return progressList;
  }

  // 获取已完成的题目
  async getCompletedProblems(): Promise<UserProgressModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_progress WHERE status = ? ORDER BY last_attempted DESC';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED]);
    const progressList: UserProgressModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const progress = this.mapResultToProgress(result);
        progressList.push(progress);
      }
    }

    return progressList;
  }

  // 保存或更新用户进度
  async saveUserProgress(progress: UserProgressModel): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const existingProgress = await this.getUserProgress(progress.problemId);

    if (existingProgress) {
      // 更新现有记录
      const sql = `
        UPDATE user_progress 
        SET status = ?, is_favorite = ?, last_attempted = ?, attempt_count = ?, success_count = ?
        WHERE problem_id = ?
      `;
      await store.executeSql(sql, [
        progress.status,
        progress.isFavorite ? 1 : 0,
        progress.lastAttempted,
        progress.attemptCount,
        progress.successCount,
        progress.problemId
      ]);
    } else {
      // 插入新记录
      const sql = `
        INSERT INTO user_progress (problem_id, status, is_favorite, last_attempted, attempt_count, success_count)
        VALUES (?, ?, ?, ?, ?, ?)
      `;
      await store.executeSql(sql, [
        progress.problemId,
        progress.status,
        progress.isFavorite ? 1 : 0,
        progress.lastAttempted,
        progress.attemptCount,
        progress.successCount
      ]);
    }
  }

  // 更新题目状态
  async updateProblemStatus(problemId: number, status: ProblemStatus, isSuccess: boolean = false): Promise<void> {
    let progress = await this.getUserProgress(problemId);
    
    if (!progress) {
      progress = new UserProgressModel();
      progress.problemId = problemId;
    }

    progress.recordAttempt(isSuccess);
    progress.status = status;
    
    await this.saveUserProgress(progress);
  }

  // 切换收藏状态
  async toggleFavorite(problemId: number): Promise<boolean> {
    let progress = await this.getUserProgress(problemId);
    
    if (!progress) {
      progress = new UserProgressModel();
      progress.problemId = problemId;
    }

    progress.toggleFavorite();
    await this.saveUserProgress(progress);
    
    return progress.isFavorite;
  }

  // 清理所有收藏记录（用于重置数据）
  async clearAllFavorites(): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'UPDATE user_progress SET is_favorite = 0 WHERE is_favorite = 1';
    await store.executeSql(sql);
    console.log('All favorite records cleared');
  }

  // 删除错题记录
  async deleteWrongProblem(problemId: number): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 删除用户进度记录
    const sql = 'DELETE FROM user_progress WHERE problem_id = ? AND status = ?';
    await store.executeSql(sql, [problemId, ProblemStatus.WRONG]);
    console.log('Wrong problem record deleted for problemId:', problemId);
  }

  // 获取已完成题目数量
  async getCompletedCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE status = ?';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 根据分类获取已完成题目数量
  async getCompletedCountByCategory(category: ProblemCategory): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT COUNT(*) as count 
      FROM user_progress up 
      JOIN problems p ON up.problem_id = p.id 
      WHERE up.status = ? AND p.category = ?
    `;
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, category]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 获取今日完成题目数量
  async getTodayCompletedCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD格式
    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE status = ? AND DATE(last_attempted) = ?';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, today]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 获取连续学习天数
  async getContinuousDays(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 获取最近的学习记录，按日期分组
    const sql = `
      SELECT DISTINCT DATE(last_attempted) as study_date 
      FROM user_progress 
      WHERE status = ? AND last_attempted IS NOT NULL 
      ORDER BY study_date DESC
    `;
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED]);

    if (result.rowCount === 0) {
      return 0;
    }

    let continuousDays = 0;
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      const studyDateStr = result.getString(result.getColumnIndex('study_date'));
      const studyDate = new Date(studyDateStr);
      studyDate.setHours(0, 0, 0, 0);

      const expectedDate = new Date(today);
      expectedDate.setDate(today.getDate() - continuousDays);

      if (studyDate.getTime() === expectedDate.getTime()) {
        continuousDays++;
      } else {
        break;
      }
    }

    return continuousDays;
  }

  // 获取统计信息
  async getStatistics(): Promise<UserStatistics> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT 
        COUNT(*) as total_attempted,
        SUM(CASE WHEN status = ? THEN 1 ELSE 0 END) as total_completed,
        SUM(CASE WHEN status = ? THEN 1 ELSE 0 END) as total_wrong,
        SUM(CASE WHEN is_favorite = 1 THEN 1 ELSE 0 END) as total_favorites,
        SUM(success_count) as total_success,
        SUM(attempt_count) as total_attempts
      FROM user_progress
    `;
    
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const totalAttempted = result.getLong(result.getColumnIndex('total_attempted'));
      const totalCompleted = result.getLong(result.getColumnIndex('total_completed'));
      const totalWrong = result.getLong(result.getColumnIndex('total_wrong'));
      const totalFavorites = result.getLong(result.getColumnIndex('total_favorites'));
      const totalSuccess = result.getLong(result.getColumnIndex('total_success'));
      const totalAttempts = result.getLong(result.getColumnIndex('total_attempts'));
      
      const overallAccuracy = totalAttempts > 0 ? Math.round((totalSuccess / totalAttempts) * 100) : 0;
      
      const statistics: UserStatistics = {
        totalAttempted,
        totalCompleted,
        totalWrong,
        totalFavorites,
        overallAccuracy
      };
      return statistics;
    }

    const defaultStatistics: UserStatistics = {
      totalAttempted: 0,
      totalCompleted: 0,
      totalWrong: 0,
      totalFavorites: 0,
      overallAccuracy: 0
    };
    return defaultStatistics;
  }

  // 将查询结果映射为进度模型
  private mapResultToProgress(result: relationalStore.ResultSet): UserProgressModel {
    const progress = new UserProgressModel();
    progress.id = result.getLong(result.getColumnIndex('id'));
    progress.problemId = result.getLong(result.getColumnIndex('problem_id'));
    progress.status = result.getLong(result.getColumnIndex('status')) as ProblemStatus;
    progress.isFavorite = result.getLong(result.getColumnIndex('is_favorite')) === 1;
    progress.lastAttempted = result.getString(result.getColumnIndex('last_attempted')) || '';
    progress.attemptCount = result.getLong(result.getColumnIndex('attempt_count'));
    progress.successCount = result.getLong(result.getColumnIndex('success_count'));
    return progress;
  }
}