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
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
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
    }

    return goals;
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
}