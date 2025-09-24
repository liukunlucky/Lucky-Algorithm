import relationalStore from '@ohos.data.relationalStore';
import { DatabaseHelper } from '../database/DatabaseHelper';
import { StudyDiaryModel, DiaryMood } from '../model/StudyDiaryModel';

interface StudyStats {
  totalDiaries: number;
  totalStudyTime: number;
  totalProblems: number;
}

interface DatabaseResult {
  insertRowId: number;
  rowsAffected: number;
}

export class StudyDiaryDao {
  private dbHelper: DatabaseHelper;
  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  // 添加学习日记
  async addDiary(diary: StudyDiaryModel): Promise<void> {
    const sql = `
      INSERT INTO study_diary (title, content, mood, study_duration, problems_solved, tags, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;
    
    try {
      const store =  this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }
      const result = await store.executeSql(sql, [
        diary.title,
        diary.content,
        diary.mood,
        diary.studyDuration,
        diary.problemsSolved,
        diary.tags,
        diary.createdAt,
        diary.updatedAt
      ]);
      
      console.info('添加学习日记成功，ID:');
    } catch (error) {
      console.error('添加学习日记失败:', error);
      throw new Error('添加学习日记失败');
    }
  }

  // 获取所有学习日记
  async getAllDiaries(): Promise<StudyDiaryModel[]> {
    const sql = 'SELECT * FROM study_diary ORDER BY created_at DESC';
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }
      const result = await store.querySql(sql);
      const diaries: StudyDiaryModel[] = [];
      
      if (result.rowCount > 0) {
        for (let i = 0; i < result.rowCount; i++) {
          result.goToRow(i);
          const diary = this.mapResultSetToDiary(result);
          diaries.push(diary);
        }
      }
      
      console.info('获取学习日记成功，数量:', diaries.length);
      return diaries;
    } catch (error) {
      console.error('获取学习日记失败:', error);
      throw new Error('获取学习日记失败');
    }
  }

  // 根据ID获取学习日记
  async getDiaryById(id: number): Promise<StudyDiaryModel | null> {
    const sql = 'SELECT * FROM study_diary WHERE id = ?';
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }

      const result = await store.querySql(sql, [id]);
      
      if (result.rowCount > 0) {
        result.goToRow(0);
        const diary = this.mapResultSetToDiary(result);
        console.info('根据ID获取学习日记成功');
        return diary;
      }
      
      return null;
    } catch (error) {
      console.error('根据ID获取学习日记失败:', error);
      throw new Error('根据ID获取学习日记失败');
    }
  }

  // 根据日期范围获取学习日记
  async getDiariesByDateRange(startDate: string, endDate: string): Promise<StudyDiaryModel[]> {
    const sql = `
      SELECT * FROM study_diary 
      WHERE SUBSTR(created_at, 1, 10) BETWEEN ? AND ?
      ORDER BY created_at DESC
    `;
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }

      const result = await store.querySql(sql, [startDate, endDate]);
      const diaries: StudyDiaryModel[] = [];
      
      if (result.rowCount > 0) {
        for (let i = 0; i < result.rowCount; i++) {
          result.goToRow(i);
          const diary = this.mapResultSetToDiary(result);
          diaries.push(diary);
        }
      }
      
      console.info('根据日期范围获取学习日记成功，数量:', diaries.length);
      return diaries;
    } catch (error) {
      console.error('根据日期范围获取学习日记失败:', error);
      throw new Error('根据日期范围获取学习日记失败');
    }
  }

  // 搜索学习日记
  async searchDiaries(keyword: string): Promise<StudyDiaryModel[]> {
    const sql = `
      SELECT * FROM study_diary 
      WHERE title LIKE ? OR content LIKE ? OR tags LIKE ?
      ORDER BY created_at DESC
    `;
    
    const searchPattern = `%${keyword}%`;
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }

      const result = await store.querySql(sql, [searchPattern, searchPattern, searchPattern]);
      const diaries: StudyDiaryModel[] = [];
      
      if (result.rowCount > 0) {
        for (let i = 0; i < result.rowCount; i++) {
          result.goToRow(i);
          const diary = this.mapResultSetToDiary(result);
          diaries.push(diary);
        }
      }
      
      console.info('搜索学习日记成功，数量:', diaries.length);
      return diaries;
    } catch (error) {
      console.error('搜索学习日记失败:', error);
      throw new Error('搜索学习日记失败');
    }
  }

  // 更新学习日记
  async updateDiary(diary: StudyDiaryModel): Promise<void> {
    const sql = `
      UPDATE study_diary 
      SET title = ?, content = ?, mood = ?, study_duration = ?, problems_solved = ?, tags = ?, updated_at = ?
      WHERE id = ?
    `;
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }
      diary.updatedAt = new Date().toISOString();
      
      const result = await store.executeSql(sql, [
        diary.title,
        diary.content,
        diary.mood,
        diary.studyDuration,
        diary.problemsSolved,
        diary.tags,
        diary.updatedAt,
        diary.id
      ]);
      
      console.info('更新学习日记成功');
    } catch (error) {
      console.error('更新学习日记失败:', error);
      throw new Error('更新学习日记失败');
    }
  }

  // 删除学习日记
  async deleteDiary(id: number): Promise<void> {
    const sql = 'DELETE FROM study_diary WHERE id = ?';
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }
      await store.executeSql(sql, [id]);
      
      console.info('删除学习日记成功');
    } catch (error) {
      console.error('删除学习日记失败:', error);
      throw new Error('删除学习日记失败');
    }
  }

  // 获取学习统计数据
  async getStudyStats(): Promise<StudyStats> {
    const sql = `
      SELECT 
        COUNT(*) as total_diaries,
        SUM(study_duration) as total_study_time,
        SUM(problems_solved) as total_problems
      FROM study_diary
    `;
    
    try {
      const store = this.dbHelper.getStore();
      if (!store) {
        throw new Error('数据库未初始化');
      }

      const result = await store.querySql(sql);
      
      if (result.rowCount > 0) {
        result.goToRow(0);
        const stats: StudyStats = {
          totalDiaries: result.getLong(result.getColumnIndex('total_diaries')),
          totalStudyTime: result.getLong(result.getColumnIndex('total_study_time')) || 0,
          totalProblems: result.getLong(result.getColumnIndex('total_problems')) || 0
        };
        
        console.info('获取学习统计数据成功');
        return stats;
      }
      
      const defaultStats: StudyStats = { totalDiaries: 0, totalStudyTime: 0, totalProblems: 0 };
      return defaultStats;
    } catch (error) {
      console.error('获取学习统计数据失败:', error);
      throw new Error('获取学习统计数据失败');
    }
  }

  // 将查询结果映射为StudyDiaryModel对象
  private mapResultSetToDiary(result: relationalStore.ResultSet): StudyDiaryModel {
    const diary = new StudyDiaryModel();
    
    diary.id = result.getLong(result.getColumnIndex('id'));
    diary.title = result.getString(result.getColumnIndex('title'));
    diary.content = result.getString(result.getColumnIndex('content'));
    diary.mood = result.getString(result.getColumnIndex('mood')) as DiaryMood;
    diary.studyDuration = result.getLong(result.getColumnIndex('study_duration'));
    diary.problemsSolved = result.getLong(result.getColumnIndex('problems_solved'));
    diary.tags = result.getString(result.getColumnIndex('tags'));
    diary.createdAt = result.getString(result.getColumnIndex('created_at'));
    diary.updatedAt = result.getString(result.getColumnIndex('updated_at'));
    
    return diary;
  }
}