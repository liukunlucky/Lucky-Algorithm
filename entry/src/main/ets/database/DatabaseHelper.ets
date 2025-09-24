import { ProblemModel, ProblemDifficulty, ProblemCategory } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ExamRecordModel, ExamMode } from '../model/ExamRecordModel';
import Context from '@ohos.app.ability.common';
import { relationalStore } from '@kit.ArkData';

interface SampleProblem {
  title: string;
  description: string;
  difficulty: ProblemDifficulty;
  category: ProblemCategory;
  constraints: string;
  hint: string;
  solutionCode: string;
  testCases: string;
}

export class DatabaseHelper {
  private static instance: DatabaseHelper;
  private store: relationalStore.RdbStore | null = null;
  private readonly DATABASE_NAME = 'algorithm_practice.db';
  private readonly DATABASE_VERSION = 1;

  private constructor() {}

  static getInstance(): DatabaseHelper {
    if (!DatabaseHelper.instance) {
      DatabaseHelper.instance = new DatabaseHelper();
    }
    return DatabaseHelper.instance;
  }

  // 初始化数据库
  async initDatabase(context: Context): Promise<void> {
    try {
      const config: relationalStore.StoreConfig = {
        name: this.DATABASE_NAME,
        securityLevel: relationalStore.SecurityLevel.S1
      };

      this.store = await relationalStore.getRdbStore(context, config);
      await this.createTables();
      await this.initDefaultData();
    } catch (error) {
      console.error('Database initialization failed:', error);
      throw new Error('数据库初始化失败');
    }
  }

  // 创建数据表
  private async createTables(): Promise<void> {
    if (!this.store) {
      throw new Error('数据库未初始化');
    }

    // 创建题目表
    const createProblemsTable = `
      CREATE TABLE IF NOT EXISTS problems (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        difficulty INTEGER NOT NULL,
        category TEXT NOT NULL,
        constraints TEXT,
        hint TEXT,
        solution_code TEXT,
        test_cases TEXT NOT NULL
      )
    `;

    // 创建用户进度表
    const createUserProgressTable = `
      CREATE TABLE IF NOT EXISTS user_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        problem_id INTEGER NOT NULL,
        status INTEGER DEFAULT 0,
        is_favorite INTEGER DEFAULT 0,
        last_attempted TEXT,
        attempt_count INTEGER DEFAULT 0,
        success_count INTEGER DEFAULT 0,
        FOREIGN KEY (problem_id) REFERENCES problems (id)
      )
    `;

    // 创建考核记录表
    const createExamRecordsTable = `
      CREATE TABLE IF NOT EXISTS exam_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        mode TEXT NOT NULL,
        score REAL NOT NULL,
        duration INTEGER NOT NULL,
        details TEXT NOT NULL
      )
    `;

    // 创建用户笔记表
    const createUserNotesTable = `
      CREATE TABLE IF NOT EXISTS user_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        problem_id INTEGER NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (problem_id) REFERENCES problems (id)
      )
    `;
    
    // 创建学习日记表
    const createStudyDiaryTable = `
      CREATE TABLE IF NOT EXISTS study_diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        mood TEXT NOT NULL DEFAULT 'normal',
        study_duration INTEGER DEFAULT 0,
        problems_solved INTEGER DEFAULT 0,
        tags TEXT DEFAULT '',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    `;
    
    // 创建学习目标表
    const createStudyGoalsTable = `
      CREATE TABLE IF NOT EXISTS study_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        type TEXT NOT NULL,
        target_value INTEGER NOT NULL,
        current_value INTEGER DEFAULT 0,
        status TEXT DEFAULT 'active',
        start_date TEXT,
        end_date TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    `;
    await this.store.executeSql(createProblemsTable);
    await this.store.executeSql(createUserProgressTable);
    await this.store.executeSql(createExamRecordsTable);
    await this.store.executeSql(createUserNotesTable);
    await this.store.executeSql(createStudyDiaryTable);
    await this.store.executeSql(createStudyGoalsTable);
  }

  // 初始化默认数据
  private async initDefaultData(): Promise<void> {
    if (!this.store) {
      return;
    }

    // 检查是否已有数据
    const result = await this.store.querySql('SELECT COUNT(*) as count FROM problems');
    if (result.rowCount > 0) {
      result.goToRow(0);
      const count = result.getLong(result.getColumnIndex('count'));
      if (count > 0) {
        return; // 已有数据，不需要初始化
      }
    }

    // 插入示例题目数据
    await this.insertSampleProblems();
  }

  // 插入示例题目
  private async insertSampleProblems(): Promise<void> {
    if (!this.store) {
      return;
    }

    const sampleProblems: SampleProblem[] = [];
    
    const problem1: SampleProblem = {
      title: '两数之和',
      description: '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。',
      difficulty: ProblemDifficulty.EASY,
      category: ProblemCategory.ARRAY,
      constraints: '2 <= nums.length <= 10^4\n-10^9 <= nums[i] <= 10^9\n-10^9 <= target <= 10^9',
      hint: '可以使用哈希表来存储数组中的元素和对应的索引。',
      solutionCode: 'function twoSum(nums, target) {\n    const map = new Map();\n    for (let i = 0; i < nums.length; i++) {\n        const complement = target - nums[i];\n        if (map.has(complement)) {\n            return [map.get(complement), i];\n        }\n        map.set(nums[i], i);\n    }\n    return [];\n}',
      testCases: JSON.stringify([
        { input: 'nums = [2,7,11,15], target = 9', expectedOutput: '[0,1]' },
        { input: 'nums = [3,2,4], target = 6', expectedOutput: '[1,2]' },
        { input: 'nums = [3,3], target = 6', expectedOutput: '[0,1]' }
      ])
    };
    
    const problem2: SampleProblem = {
      title: '反转链表',
      description: '给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。',
      difficulty: ProblemDifficulty.EASY,
      category: ProblemCategory.LINKED_LIST,
      constraints: '链表中节点的数目范围是 [0, 5000]\n-5000 <= Node.val <= 5000',
      hint: '可以使用迭代或递归的方法来反转链表。',
      solutionCode: 'function reverseList(head) {\n    let prev = null;\n    let current = head;\n    while (current !== null) {\n        const next = current.next;\n        current.next = prev;\n        prev = current;\n        current = next;\n    }\n    return prev;\n}',
      testCases: JSON.stringify([
        { input: 'head = [1,2,3,4,5]', expectedOutput: '[5,4,3,2,1]' },
        { input: 'head = [1,2]', expectedOutput: '[2,1]' },
        { input: 'head = []', expectedOutput: '[]' }
      ])
    };
    
    sampleProblems.push(problem1, problem2);

    for (const problem of sampleProblems) {
      const sql = `
        INSERT INTO problems (title, description, difficulty, category, constraints, hint, solution_code, test_cases)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `;
      await this.store.executeSql(sql, [
        problem.title,
        problem.description,
        problem.difficulty,
        problem.category,
        problem.constraints,
        problem.hint,
        problem.solutionCode,
        problem.testCases
      ]);
    }
  }

  // 获取数据库实例
  getStore(): relationalStore.RdbStore | null {
    return this.store;
  }

  // 关闭数据库
  async closeDatabase(): Promise<void> {
    if (this.store) {
      await this.store.close();
      this.store = null;
    }
  }
}