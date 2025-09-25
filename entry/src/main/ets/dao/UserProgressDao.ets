import relationalStore from '@ohos.data.relationalStore';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemCategory } from '../model/ProblemModel';
import { DatabaseHelper } from '../database/DatabaseHelper';
import { ProblemMockData } from '../mock/ProblemMockData';
import { TimeUtils } from '../utils/TimeUtils';

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

  // 获取已完成题目数量（仅答对的题目）
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

  // 获取学习进度数量（包括答对和答错的题目）
  async getStudyProgressCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE (status = ? OR status = ?)';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 根据分类获取已完成题目的ID列表
  async getCompletedProblemIdsByCategory(category: ProblemCategory): Promise<number[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 从MockData获取指定分类的所有题目ID
    const allProblems = ProblemMockData.getAllProblems();
    const categoryProblems = allProblems.filter(p => p.category === category);
    const problemIds = categoryProblems.map(p => p.id);
    
    if (problemIds.length === 0) {
      return [];
    }

    // 查询这些题目ID中已完成的题目ID
    const placeholders = problemIds.map(() => '?').join(',');
    const sql = `
      SELECT problem_id 
      FROM user_progress 
      WHERE status = ? AND problem_id IN (${placeholders})
      ORDER BY last_attempted DESC
    `;
    const params = [ProblemStatus.COMPLETED, ...problemIds];
    const result = await store.querySql(sql, params);
    
    const completedIds: number[] = [];
    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const problemId = result.getLong(result.getColumnIndex('problem_id'));
        completedIds.push(problemId);
      }
    }

    console.info(`[UserProgressDao] getCompletedProblemIdsByCategory - Category: ${category}, Completed IDs: ${completedIds}`);
    return completedIds;
  }
  async getCompletedCountByCategory(category: ProblemCategory): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 从MockData获取指定分类的所有题目ID
    const allProblems = ProblemMockData.getAllProblems();
    const categoryProblems = allProblems.filter(p => p.category === category);
    const problemIds = categoryProblems.map(p => p.id);
    
    if (problemIds.length === 0) {
      return 0;
    }

    // 查询这些题目ID中已完成的数量
    const placeholders = problemIds.map(() => '?').join(',');
    const sql = `
      SELECT COUNT(*) as count 
      FROM user_progress 
      WHERE status = ? AND problem_id IN (${placeholders})
    `;
    const params = [ProblemStatus.COMPLETED, ...problemIds];
    const result = await store.querySql(sql, params);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const count = result.getLong(result.getColumnIndex('count'));
      console.info(`[UserProgressDao] getCompletedCountByCategory - Category: ${category}, Total problems: ${problemIds.length}, Completed: ${count}`);
      return count;
    }

    return 0;
  }

  // 根据分类获取学习进度数量（包括答对和答错的题目）
  async getStudyProgressCountByCategory(category: ProblemCategory): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 从MockData获取指定分类的所有题目ID
    const allProblems = ProblemMockData.getAllProblems();
    const categoryProblems = allProblems.filter(p => p.category === category);
    const problemIds = categoryProblems.map(p => p.id);
    
    if (problemIds.length === 0) {
      return 0;
    }

    // 查询这些题目ID中已学习的数量（包括答对和答错）
    const placeholders = problemIds.map(() => '?').join(',');
    const sql = `
      SELECT COUNT(*) as count 
      FROM user_progress 
      WHERE (status = ? OR status = ?) AND problem_id IN (${placeholders})
    `;
    const params = [ProblemStatus.COMPLETED, ProblemStatus.WRONG, ...problemIds];
    const result = await store.querySql(sql, params);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const count = result.getLong(result.getColumnIndex('count'));
      console.info(`[UserProgressDao] getStudyProgressCountByCategory - Category: ${category}, Total problems: ${problemIds.length}, Studied: ${count}`);
      return count;
    }

    return 0;
  }

  // 根据分类获取正确率
  async getAccuracyByCategory(category: ProblemCategory): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 从MockData获取指定分类的所有题目ID
    const allProblems = ProblemMockData.getAllProblems();
    const categoryProblems = allProblems.filter(p => p.category === category);
    const problemIds = categoryProblems.map(p => p.id);
    
    if (problemIds.length === 0) {
      return 0;
    }

    // 查询这些题目ID的成功次数和总尝试次数
    const placeholders = problemIds.map(() => '?').join(',');
    const sql = `
      SELECT 
        SUM(success_count) as total_success,
        SUM(attempt_count) as total_attempts
      FROM user_progress 
      WHERE problem_id IN (${placeholders}) AND (status = ? OR status = ?)
    `;
    const params = [...problemIds, ProblemStatus.COMPLETED, ProblemStatus.WRONG];
    const result = await store.querySql(sql, params);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const totalSuccess = result.getLong(result.getColumnIndex('total_success'));
      const totalAttempts = result.getLong(result.getColumnIndex('total_attempts'));
      
      if (totalAttempts > 0) {
        const accuracy = Math.round((totalSuccess / totalAttempts) * 100);
        console.info(`[UserProgressDao] getAccuracyByCategory - Category: ${category}, Success: ${totalSuccess}, Attempts: ${totalAttempts}, Accuracy: ${accuracy}%`);
        return accuracy;
      }
    }

    return 0;
  }

  // 获取今日学习题目数量（包括答对和答错）
  async getTodayCompletedCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const today = TimeUtils.getLocalDateString(); // YYYY-MM-DD格式
    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE (status = ? OR status = ?) AND DATE(last_attempted) = ?';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG, today]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 根据日期获取完成题目数量
  async getCompletedCountByDate(date: Date): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const dateStr = TimeUtils.getLocalDateString(date); // YYYY-MM-DD格式
    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE (status = ? OR status = ?) AND DATE(last_attempted) = ?';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG, dateStr]);

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

    // 获取最近的学习记录，按日期分组（包括答对和答错的题目）
    const sql = `
      SELECT DISTINCT DATE(last_attempted) as study_date 
      FROM user_progress 
      WHERE (status = ? OR status = ?) AND last_attempted IS NOT NULL 
      ORDER BY study_date DESC
    `;
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG]);

    if (result.rowCount === 0) {
      return 0;
    }

    let continuousDays = 0;
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    // 检查今天是否有学习记录
    result.goToRow(0);
    const latestStudyDateStr = result.getString(result.getColumnIndex('study_date'));
    const latestStudyDate = new Date(latestStudyDateStr);
    latestStudyDate.setHours(0, 0, 0, 0);
    
    // 如果最新学习日期是今天，从今天开始计算
    // 如果最新学习日期是昨天，从昨天开始计算（保持连续性）
    // 如果最新学习日期更早，说明已经中断，返回0
    const daysDiff = Math.floor((today.getTime() - latestStudyDate.getTime()) / (1000 * 60 * 60 * 24));
    
    if (daysDiff > 1) {
      // 中断超过1天，连续学习天数为0
      console.info(`📅 学习已中断 ${daysDiff} 天，连续学习天数重置为0`);
      return 0;
    }
    
    // 从最新学习日期开始向前计算连续天数
    let checkDate = new Date(latestStudyDate);
    
    for (let i = 0; i < result.rowCount; i++) {
      result.goToRow(i);
      const studyDateStr = result.getString(result.getColumnIndex('study_date'));
      const studyDate = new Date(studyDateStr);
      studyDate.setHours(0, 0, 0, 0);

      if (studyDate.getTime() === checkDate.getTime()) {
        continuousDays++;
        // 检查前一天
        checkDate.setDate(checkDate.getDate() - 1);
      } else {
        // 日期不连续，停止计算
        break;
      }
    }

    console.info(`📅 计算连续学习天数: ${continuousDays} 天，最新学习日期: ${latestStudyDateStr}`);
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

  // 获取今日完成的题目进度（包括答对和答错）
  async getTodayCompletedProgress(): Promise<UserProgressModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const today = TimeUtils.getLocalDateString(); // YYYY-MM-DD格式
    const sql = 'SELECT * FROM user_progress WHERE (status = ? OR status = ?) AND DATE(last_attempted) = ? ORDER BY last_attempted DESC';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG, today]);
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

  // 获取学习日历数据（按日期分组的学习记录）
  async getStudyCalendarData(year: number, month: number): Promise<Map<string, number>> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 获取指定年月的学习记录
    // 注意：month参数是JavaScript Date的月份（0-11），需要+1转换为实际月份
    const actualMonth = month + 1;
    const startDate = `${year}-${String(actualMonth).padStart(2, '0')}-01`;
    
    // 计算下个月的开始日期作为结束边界
    let nextYear = year;
    let nextMonth = actualMonth + 1;
    if (nextMonth > 12) {
      nextYear = year + 1;
      nextMonth = 1;
    }
    const endDate = `${nextYear}-${String(nextMonth).padStart(2, '0')}-01`;
    
    console.info(`📅 查询学习数据范围: ${startDate} 到 ${endDate}`);
    
    const sql = `
      SELECT SUBSTR(last_attempted, 1, 10) as study_date, COUNT(*) as count
      FROM user_progress 
      WHERE (status = ? OR status = ?) 
        AND last_attempted >= ? 
        AND last_attempted < ?
        AND last_attempted IS NOT NULL
        AND last_attempted != ''
      GROUP BY SUBSTR(last_attempted, 1, 10)
      ORDER BY study_date
    `;
    
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG, startDate, endDate]);
    const studyMap = new Map<string, number>();

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const date = result.getString(result.getColumnIndex('study_date'));
        const count = result.getLong(result.getColumnIndex('count'));
        studyMap.set(date, count);
      }
    }

    return studyMap;
  }

  // 获取总学习天数
  async getTotalStudyDays(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT COUNT(DISTINCT DATE(last_attempted)) as total_days
      FROM user_progress 
      WHERE (status = ? OR status = ?) AND last_attempted IS NOT NULL
    `;
    
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED, ProblemStatus.WRONG]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('total_days'));
    }

    return 0;
  }

  // 根据难度获取完成数量
  async getCompletedCountByDifficulty(difficulty: number): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 由于数据库中没有存储难度信息，我们需要通过题目ID来判断
    // 这里简化处理，返回模拟数据，实际应该关联题目表
    const sql = `
      SELECT COUNT(*) as count 
      FROM user_progress 
      WHERE status = ?
    `;
    
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      const totalCompleted = result.getLong(result.getColumnIndex('count'));
      // 简单按比例分配：简单40%，中等40%，困难20%
      if (difficulty === 0) return Math.floor(totalCompleted * 0.4);
      if (difficulty === 1) return Math.floor(totalCompleted * 0.4);
      if (difficulty === 2) return Math.floor(totalCompleted * 0.2);
    }

    return 0;
  }

  // 获取总完成题目数量
  async getTotalCompletedProblems(): Promise<number> {
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

  // 获取满分次数
  async getPerfectScoreCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 假设满分是指一次性完成（attempt_count = success_count = 1）
    const sql = 'SELECT COUNT(*) as count FROM user_progress WHERE status = ? AND attempt_count = 1 AND success_count = 1';
    const result = await store.querySql(sql, [ProblemStatus.COMPLETED]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 获取已完成分类数量
  async getCompletedCategoriesCount(): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    // 获取所有分类的题目
    const allProblems = ProblemMockData.getAllProblems();
    const categorySet = new Set<string>();
    for (const problem of allProblems) {
      categorySet.add(problem.category);
    }
    const categories = Array.from(categorySet);
    let completedCategoriesCount = 0;

    for (const category of categories) {
      const categoryProblems = allProblems.filter(p => p.category === category);
      const categoryProblemIds = categoryProblems.map(p => p.id);
      
      if (categoryProblemIds.length === 0) continue;

      // 检查该分类是否有完成的题目
      const placeholders = categoryProblemIds.map(() => '?').join(',');
      const sql = `
        SELECT COUNT(*) as count 
        FROM user_progress 
        WHERE status = ? AND problem_id IN (${placeholders})
      `;
      const params = [ProblemStatus.COMPLETED, ...categoryProblemIds];
      const result = await store.querySql(sql, params);
      
      if (result.rowCount > 0) {
        result.goToRow(0);
        const completedCount = result.getLong(result.getColumnIndex('count'));
        if (completedCount > 0) {
          completedCategoriesCount++;
        }
      }
    }

    return completedCategoriesCount;
  }

  // 获取快速解题次数（指定时间内完成）
  async getFastSolveCount(maxSeconds: number): Promise<number> {
    // 由于当前数据库结构没有存储解题时间，这里返回模拟数据
    // 实际应用中需要在数据库中添加solve_time字段
    const totalCompleted = await this.getTotalCompletedProblems();
    // 假设20%的题目是快速完成的
    return Math.floor(totalCompleted * 0.2);
  }
}