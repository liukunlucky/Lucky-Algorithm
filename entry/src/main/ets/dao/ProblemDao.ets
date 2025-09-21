import relationalStore from '@ohos.data.relationalStore';
import { ProblemModel, ProblemDifficulty, ProblemCategory, TestCase } from '../model/ProblemModel';
import { DatabaseHelper } from '../database/DatabaseHelper';

export class ProblemDao {
  private dbHelper: DatabaseHelper;

  constructor() {
    this.dbHelper = DatabaseHelper.getInstance();
  }

  // 获取所有题目
  async getAllProblems(): Promise<ProblemModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems ORDER BY id';
    const result = await store.querySql(sql);
    const problems: ProblemModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const problem = this.mapResultToProblem(result);
        problems.push(problem);
      }
    }

    return problems;
  }

  // 根据ID获取题目
  async getProblemById(id: number): Promise<ProblemModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems WHERE id = ?';
    const result = await store.querySql(sql, [id]);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToProblem(result);
    }

    return null;
  }

  // 根据分类获取题目
  async getProblemsByCategory(category: ProblemCategory): Promise<ProblemModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems WHERE category = ? ORDER BY id';
    const result = await store.querySql(sql, [category]);
    const problems: ProblemModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const problem = this.mapResultToProblem(result);
        problems.push(problem);
      }
    }

    return problems;
  }

  // 根据分类获取题目数量
  async getProblemCountByCategory(category: ProblemCategory): Promise<number> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT COUNT(*) as count FROM problems WHERE category = ?';
    const result = await store.querySql(sql, [category]);
    
    if (result.rowCount > 0) {
      result.goToRow(0);
      return result.getLong(result.getColumnIndex('count'));
    }

    return 0;
  }

  // 根据难度获取题目
  async getProblemsByDifficulty(difficulty: ProblemDifficulty): Promise<ProblemModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems WHERE difficulty = ? ORDER BY id';
    const result = await store.querySql(sql, [difficulty]);
    const problems: ProblemModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const problem = this.mapResultToProblem(result);
        problems.push(problem);
      }
    }

    return problems;
  }

  // 搜索题目
  async searchProblems(keyword: string): Promise<ProblemModel[]> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems WHERE title LIKE ? OR description LIKE ? ORDER BY id';
    const searchPattern = `%${keyword}%`;
    const result = await store.querySql(sql, [searchPattern, searchPattern]);
    const problems: ProblemModel[] = [];

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const problem = this.mapResultToProblem(result);
        problems.push(problem);
      }
    }

    return problems;
  }

  // 获取随机题目
  async getRandomProblem(): Promise<ProblemModel | null> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT * FROM problems ORDER BY RANDOM() LIMIT 1';
    const result = await store.querySql(sql);

    if (result.rowCount > 0) {
      result.goToRow(0);
      return this.mapResultToProblem(result);
    }

    return null;
  }

  // 获取分类统计
  async getCategoryStats(): Promise<Record<string, number>> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT category, COUNT(*) as count FROM problems GROUP BY category';
    const result = await store.querySql(sql);
    const stats: Record<string, number> = {};

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const category = result.getString(result.getColumnIndex('category'));
        const count = result.getLong(result.getColumnIndex('count'));
        stats[category] = count;
      }
    }

    return stats;
  }

  // 获取难度统计
  async getDifficultyStats(): Promise<Record<number, number>> {
    const store = this.dbHelper.getStore();
    if (!store) {
      throw new Error('数据库未初始化');
    }

    const sql = 'SELECT difficulty, COUNT(*) as count FROM problems GROUP BY difficulty';
    const result = await store.querySql(sql);
    const stats: Record<number, number> = {};

    if (result.rowCount > 0) {
      for (let i = 0; i < result.rowCount; i++) {
        result.goToRow(i);
        const difficulty = result.getLong(result.getColumnIndex('difficulty'));
        const count = result.getLong(result.getColumnIndex('count'));
        stats[difficulty] = count;
      }
    }

    return stats;
  }

  // 将查询结果映射为题目模型
  private mapResultToProblem(result: relationalStore.ResultSet): ProblemModel {
    const problem = new ProblemModel();
    problem.id = result.getLong(result.getColumnIndex('id'));
    problem.title = result.getString(result.getColumnIndex('title'));
    problem.description = result.getString(result.getColumnIndex('description'));
    problem.difficulty = result.getLong(result.getColumnIndex('difficulty')) as ProblemDifficulty;
    problem.category = result.getString(result.getColumnIndex('category')) as ProblemCategory;
    problem.constraints = result.getString(result.getColumnIndex('constraints')) || '';
    problem.hint = result.getString(result.getColumnIndex('hint')) || '';
    problem.solutionCode = result.getString(result.getColumnIndex('solution_code')) || '';
    
    const testCasesJson = result.getString(result.getColumnIndex('test_cases'));
    try {
      problem.testCases = JSON.parse(testCasesJson) as TestCase[];
    } catch (error) {
      console.error('Failed to parse test cases:', error);
      problem.testCases = [];
    }

    return problem;
  }
}