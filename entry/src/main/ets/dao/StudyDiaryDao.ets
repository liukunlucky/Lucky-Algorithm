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
      
      // 如果数据库为空，返回mock数据
      if (diaries.length === 0) {
        return this.getMockDiaries();
      }
      
      console.info('获取学习日记成功，数量:', diaries.length);
      return diaries;
    } catch (error) {
      console.error('获取学习日记失败:', error);
      // 出错时也返回mock数据
      return this.getMockDiaries();
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

  // 获取mock数据
  private getMockDiaries(): StudyDiaryModel[] {
    const mockDiaries: StudyDiaryModel[] = [];
    const now = new Date();

    // 今天的学习日记
    const diary1 = new StudyDiaryModel();
    diary1.id = 1;
    diary1.title = '【示例数据】动态规划专题突破';
    diary1.content = '今天深入学习了动态规划的核心思想，通过"最长递增子序列"和"背包问题"两个经典题目，终于理解了状态转移方程的设计思路。特别是在处理二维DP时，学会了如何优化空间复杂度。虽然过程有些困难，但看到代码通过所有测试用例的那一刻，成就感满满！';
    diary1.mood = DiaryMood.EXCELLENT;
    diary1.studyDuration = 180;
    diary1.problemsSolved = 5;
    diary1.tags = '动态规划,算法优化,状态转移';
    diary1.createdAt = now.toISOString();
    diary1.updatedAt = now.toISOString();
    mockDiaries.push(diary1);

    // 昨天的学习日记
    const yesterday = new Date(now.getTime() - 24 * 60 * 60 * 1000);
    const diary2 = new StudyDiaryModel();
    diary2.id = 2;
    diary2.title = '【示例数据】二叉树遍历算法复习';
    diary2.content = '复习了二叉树的前序、中序、后序遍历，包括递归和迭代两种实现方式。递归版本比较直观，但迭代版本需要借助栈来模拟递归过程，理解起来稍微复杂一些。通过画图分析，加深了对树结构的理解。明天准备挑战一些更复杂的树形DP问题。';
    diary2.mood = DiaryMood.NORMAL;
    diary2.studyDuration = 120;
    diary2.problemsSolved = 8;
    diary2.tags = '二叉树,遍历算法,数据结构';
    diary2.createdAt = yesterday.toISOString();
    diary2.updatedAt = yesterday.toISOString();
    mockDiaries.push(diary2);

    // 前天的学习日记
    const dayBefore = new Date(now.getTime() - 2 * 24 * 60 * 60 * 1000);
    const diary3 = new StudyDiaryModel();
    diary3.id = 3;
    diary3.title = '【示例数据】图算法初探';
    diary3.content = '开始学习图算法，今天主要了解了图的基本概念和表示方法（邻接矩阵vs邻接表）。实现了DFS和BFS两种遍历算法，发现图算法比树算法复杂很多，需要考虑环的存在。在做"岛屿数量"这道题时卡了很久，最后通过DFS解决了。感觉图算法还需要更多练习。';
    diary3.mood = DiaryMood.BAD;
    diary3.studyDuration = 150;
    diary3.problemsSolved = 3;
    diary3.tags = '图算法,DFS,BFS,数据结构';
    diary3.createdAt = dayBefore.toISOString();
    diary3.updatedAt = dayBefore.toISOString();
    mockDiaries.push(diary3);

    // 一周前的学习日记
    const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
    const diary4 = new StudyDiaryModel();
    diary4.id = 4;
    diary4.title = '【示例数据】排序算法总结';
    diary4.content = '花了一整天时间系统复习了各种排序算法：冒泡、选择、插入、快排、归并、堆排序。重点分析了时间复杂度和空间复杂度，以及各自的适用场景。快排的分治思想很巧妙，归并排序的稳定性很重要。通过手写代码加深了理解，感觉对算法的掌握更扎实了。';
    diary4.mood = DiaryMood.GOOD;
    diary4.studyDuration = 240;
    diary4.problemsSolved = 12;
    diary4.tags = '排序算法,时间复杂度,算法分析';
    diary4.createdAt = weekAgo.toISOString();
    diary4.updatedAt = weekAgo.toISOString();
    mockDiaries.push(diary4);

    // 两周前的学习日记
    const twoWeeksAgo = new Date(now.getTime() - 14 * 24 * 60 * 60 * 1000);
    const diary5 = new StudyDiaryModel();
    diary5.id = 5;
    diary5.title = '【示例数据】链表操作专项训练';
    diary5.content = '专门练习了链表相关的算法题，包括反转链表、合并有序链表、检测环等经典问题。发现链表题目的关键在于指针操作，需要特别小心边界条件。"反转链表"这道题用了三种方法：迭代、递归、栈，每种方法都有其特点。通过大量练习，现在对指针操作更有信心了。';
    diary5.mood = DiaryMood.EXCELLENT;
    diary5.studyDuration = 90;
    diary5.problemsSolved = 6;
    diary5.tags = '链表,指针操作,数据结构';
    diary5.createdAt = twoWeeksAgo.toISOString();
    diary5.updatedAt = twoWeeksAgo.toISOString();
    mockDiaries.push(diary5);

    return mockDiaries;
  }
}