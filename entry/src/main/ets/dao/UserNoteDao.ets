import { DatabaseHelper } from '../database/DatabaseHelper';
import { UserNoteModel } from '../model/UserNoteModel';
import relationalStore from '@ohos.data.relationalStore';

export class UserNoteDao {
  private dbHelper: DatabaseHelper;

  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  // 获取指定题目的笔记
  async getNoteByProblemId(problemId: number): Promise<UserNoteModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM user_notes WHERE problem_id = ?';
    const result = await store.querySql(sql, [problemId]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToNote(result);
    }

    return null;
  }

  // 保存或更新笔记
  async saveNote(note: UserNoteModel): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const existingNote = await this.getNoteByProblemId(note.problemId);

    if (existingNote) {
      // 更新现有笔记
      const sql = `
        UPDATE user_notes 
        SET content = ?, updated_at = ? 
        WHERE problem_id = ?
      `;
      await store.executeSql(sql, [note.content, note.updatedAt, note.problemId]);
    } else {
      // 插入新笔记
      const sql = `
        INSERT INTO user_notes (problem_id, content, created_at, updated_at) 
        VALUES (?, ?, ?, ?)
      `;
      await store.executeSql(sql, [note.problemId, note.content, note.createdAt, note.updatedAt]);
    }
  }

  // 删除笔记
  async deleteNote(problemId: number): Promise<void> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'DELETE FROM user_notes WHERE problem_id = ?';
    await store.executeSql(sql, [problemId]);
  }

  private mapResultToNote(result: relationalStore.ResultSet): UserNoteModel {
    const note = new UserNoteModel();
    note.id = result.getLong(result.getColumnIndex('id'));
    note.problemId = result.getLong(result.getColumnIndex('problem_id'));
    note.content = result.getString(result.getColumnIndex('content')) || '';
    note.createdAt = result.getString(result.getColumnIndex('created_at')) || '';
    note.updatedAt = result.getString(result.getColumnIndex('updated_at')) || '';
    return note;
  }
}