import { StudyGoalModel, GoalStatus, GoalType } from '../model/StudyGoalModel';
import { DatabaseHelper } from '../database/DatabaseHelper';
import relationalStore from '@ohos.data.relationalStore';

interface DatabaseResult {
  insertedRowId: number;
  rowsAffected: number;
}

/**
 * 学习目标数据访问对象
 */
export class StudyGoalDao {
  private dbHelper: DatabaseHelper;

  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  /**
   * 添加学习目标
   */
  async addGoal(goal: StudyGoalModel): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      INSERT INTO study_goals (
        title, description, type, target_value, current_value, 
        status, start_date, end_date, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const now = new Date().toISOString();
    const result = await store.executeSql(sql, [
      goal.title,
      goal.description,
      goal.type,
      goal.targetValue,
      goal.currentValue,
      goal.status,
      goal.startDate,
      goal.endDate,
      now,
      now
    ]);

  }

  /**
   * 获取所有学习目标
   */
  async getAllGoals(): Promise<StudyGoalModel[]> {
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        console.warn('数据库未初始化，返回mock数据');
        return this.getMockGoals();
      }

      const sql = `
        SELECT * FROM study_goals 
        ORDER BY created_at DESC
      `;

      const result = await store.querySql(sql);
      const goals: StudyGoalModel[] = [];

      if (result.rowCount > 0) {
        for (let i = 0; i < result.rowCount; i++) {
          result.goToRow(i);
          const goal = this.mapResultToGoal(result);
          goals.push(goal);
        }
        return goals;
      } else {
        // 数据库为空时返回mock数据
        console.info('数据库中没有学习目标数据，返回mock数据');
        return this.getMockGoals();
      }
    } catch (error) {
      console.error('获取学习目标失败，返回mock数据:', error);
      return this.getMockGoals();
    }
  }

  /**
   * 根据ID获取学习目标
   */
  async getGoalById(id: number): Promise<StudyGoalModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `SELECT * FROM study_goals WHERE id = ?`;
    const result = await store.querySql(sql, [id]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToGoal(result);
    }

    return null;
  }

  /**
   * 更新学习目标
   */
  async updateGoal(goal: StudyGoalModel): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      UPDATE study_goals SET 
        title = ?, description = ?, type = ?, target_value = ?, 
        current_value = ?, status = ?, start_date = ?, end_date = ?, 
        updated_at = ?
      WHERE id = ?
    `;

    const now = new Date().toISOString();
    const result = await store.executeSql(sql, [
      goal.title,
      goal.description,
      goal.type,
      goal.targetValue,
      goal.currentValue,
      goal.status,
      goal.startDate,
      goal.endDate,
      now,
      goal.id
    ]);

  }

  /**
   * 删除学习目标
   */
  async deleteGoal(id: number): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `DELETE FROM study_goals WHERE id = ?`;
    const result = await store.executeSql(sql, [id]);

  }

  /**
   * 获取活跃的学习目标
   */
  async getActiveGoals(): Promise<StudyGoalModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      SELECT * FROM study_goals 
      WHERE status = ? 
      ORDER BY created_at DESC
    `;

    const result = await store.querySql(sql, [GoalStatus.ACTIVE]);
    const goals: StudyGoalModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const goal = this.mapResultToGoal(result);
        goals.push(goal);
      }
    }

    return goals;
  }

  /**
   * 更新目标进度
   */
  async updateGoalProgress(id: number, currentValue: number): Promise<boolean> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = `
      UPDATE study_goals SET 
        current_value = ?, updated_at = ?
      WHERE id = ?
    `;

    const now = new Date().toISOString();
    const result = await store.executeSql(sql, [currentValue, now, id]);

    return true;
  }

  /**
   * 将查询结果映射为StudyGoalModel对象
   */
  private mapResultToGoal(result: relationalStore.ResultSet): StudyGoalModel {
    const goal = new StudyGoalModel();
    goal.id = result.getLong(result.getColumnIndex('id'));
    goal.title = result.getString(result.getColumnIndex('title'));
    goal.description = result.getString(result.getColumnIndex('description'));
    goal.type = result.getString(result.getColumnIndex('type')) as GoalType;
    goal.targetValue = result.getLong(result.getColumnIndex('target_value'));
    goal.currentValue = result.getLong(result.getColumnIndex('current_value'));
    goal.status = result.getString(result.getColumnIndex('status')) as GoalStatus;
    goal.startDate = result.getString(result.getColumnIndex('start_date'));
    goal.endDate = result.getString(result.getColumnIndex('end_date'));
    goal.createdAt = result.getString(result.getColumnIndex('created_at'));
    goal.updatedAt = result.getString(result.getColumnIndex('updated_at'));
    return goal;
  }

  /**
   * 获取mock学习目标数据
   */
  private getMockGoals(): StudyGoalModel[] {
    const goals: StudyGoalModel[] = [];
    const now = new Date();
    const today = now.toISOString().split('T')[0];
    
    // 目标1：每日算法练习
    const dailyGoal = new StudyGoalModel();
    dailyGoal.id = 1;
    dailyGoal.title = '【示例数据】每日算法练习';
    dailyGoal.description = '每天完成5道算法题，提升编程思维和解题能力';
    dailyGoal.type = GoalType.DAILY;
    dailyGoal.targetValue = 5;
    dailyGoal.currentValue = 3;
    dailyGoal.status = GoalStatus.ACTIVE;
    dailyGoal.startDate = today;
    dailyGoal.endDate = '';
    dailyGoal.createdAt = now.toISOString();
    dailyGoal.updatedAt = now.toISOString();
    goals.push(dailyGoal);

    // 目标2：数据结构专项突破
    const weeklyGoal = new StudyGoalModel();
    weeklyGoal.id = 2;
    weeklyGoal.title = '【示例数据】数据结构专项突破';
    weeklyGoal.description = '本周专攻链表和二叉树相关题目，掌握核心数据结构';
    weeklyGoal.type = GoalType.WEEKLY;
    weeklyGoal.targetValue = 25;
    weeklyGoal.currentValue = 18;
    weeklyGoal.status = GoalStatus.ACTIVE;
    weeklyGoal.startDate = this.getWeekStart(now);
    weeklyGoal.endDate = this.getWeekEnd(now);
    weeklyGoal.createdAt = now.toISOString();
    weeklyGoal.updatedAt = now.toISOString();
    goals.push(weeklyGoal);

    // 目标3：动态规划月度挑战
    const monthlyGoal = new StudyGoalModel();
    monthlyGoal.id = 3;
    monthlyGoal.title = '【示例数据】动态规划月度挑战';
    monthlyGoal.description = '本月重点攻克动态规划题目，从入门到进阶全面提升';
    monthlyGoal.type = GoalType.MONTHLY;
    monthlyGoal.targetValue = 50;
    monthlyGoal.currentValue = 32;
    monthlyGoal.status = GoalStatus.ACTIVE;
    monthlyGoal.startDate = this.getMonthStart(now);
    monthlyGoal.endDate = this.getMonthEnd(now);
    monthlyGoal.createdAt = now.toISOString();
    monthlyGoal.updatedAt = now.toISOString();
    goals.push(monthlyGoal);

    // 目标4：已完成的目标
    const completedGoal = new StudyGoalModel();
    completedGoal.id = 4;
    completedGoal.title = '【示例数据】数组基础强化';
    completedGoal.description = '掌握数组相关的基础算法，包括排序、查找、双指针等技巧';
    completedGoal.type = GoalType.WEEKLY;
    completedGoal.targetValue = 20;
    completedGoal.currentValue = 20;
    completedGoal.status = GoalStatus.COMPLETED;
    completedGoal.startDate = this.getLastWeekStart(now);
    completedGoal.endDate = this.getLastWeekEnd(now);
    completedGoal.createdAt = this.getLastWeekStart(now) + 'T09:00:00.000Z';
    completedGoal.updatedAt = now.toISOString();
    goals.push(completedGoal);

    // 目标5：自定义挑战
    const customGoal = new StudyGoalModel();
    customGoal.id = 5;
    customGoal.title = '【示例数据】LeetCode Top 100';
    customGoal.description = '挑战LeetCode热门100题，覆盖面试高频算法题目';
    customGoal.type = GoalType.CUSTOM;
    customGoal.targetValue = 100;
    customGoal.currentValue = 45;
    customGoal.status = GoalStatus.ACTIVE;
    customGoal.startDate = this.getCustomStartDate(now);
    customGoal.endDate = this.getCustomEndDate(now);
    customGoal.createdAt = this.getCustomStartDate(now) + 'T10:00:00.000Z';
    customGoal.updatedAt = now.toISOString();
    goals.push(customGoal);

    return goals;
  }

  /**
   * 获取本周开始日期
   */
  private getWeekStart(date: Date): string {
    const d = new Date(date);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? -6 : 1); // 周一为一周开始
    d.setDate(diff);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取本周结束日期
   */
  private getWeekEnd(date: Date): string {
    const d = new Date(date);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? 0 : 7); // 周日为一周结束
    d.setDate(diff);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取本月开始日期
   */
  private getMonthStart(date: Date): string {
    const d = new Date(date.getFullYear(), date.getMonth(), 1);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取本月结束日期
   */
  private getMonthEnd(date: Date): string {
    const d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取上周开始日期
   */
  private getLastWeekStart(date: Date): string {
    const d = new Date(date);
    d.setDate(d.getDate() - 7);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? -6 : 1);
    d.setDate(diff);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取上周结束日期
   */
  private getLastWeekEnd(date: Date): string {
    const d = new Date(date);
    d.setDate(d.getDate() - 7);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? 0 : 7);
    d.setDate(diff);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取自定义目标开始日期（30天前）
   */
  private getCustomStartDate(date: Date): string {
    const d = new Date(date);
    d.setDate(d.getDate() - 30);
    return d.toISOString().split('T')[0];
  }

  /**
   * 获取自定义目标结束日期（30天后）
   */
  private getCustomEndDate(date: Date): string {
    const d = new Date(date);
    d.setDate(d.getDate() + 30);
    return d.toISOString().split('T')[0];
  }
}