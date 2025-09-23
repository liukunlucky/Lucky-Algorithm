import { ExamMode, ExamRecordModel } from '../model/ExamRecordModel';
import { ProblemModel, ProblemDifficulty, ProblemCategory, TestCase, ProblemType, ChoiceOption } from '../model/ProblemModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { ExamRecordDao } from '../dao/ExamRecordDao';

enum DifficultyLevel {
  EASY = 'easy',
  MEDIUM = 'medium',
  HARD = 'hard',
  MIXED = 'mixed'
}

interface ChoiceOptionsResult {
  options: ChoiceOption[];
  explanation: string;
}

export class ExamService {
  private static instance: ExamService;
  private examRecordDao: ExamRecordDao;

  private constructor() {
    this.examRecordDao = new ExamRecordDao();
  }

  public static getInstance(): ExamService {
    if (!ExamService.instance) {
      ExamService.instance = new ExamService();
    }
    return ExamService.instance;
  }

  /**
   * 根据考核模式和难度选择题目
   */
  public async selectProblemsForExam(mode: ExamMode, difficulty: DifficultyLevel = DifficultyLevel.MIXED): Promise<ProblemModel[]> {
    try {
      // 获取所有题目
      const allProblems = await this.getAllProblems();
      
      // 根据难度过滤题目
      const filteredProblems = this.filterProblemsByDifficulty(allProblems, difficulty);
      
      // 根据模式配置选择题目
      const config = this.getModeConfig(mode);
      const selectedProblems = this.selectProblemsByMode(filteredProblems, config);
      
      // 随机打乱题目顺序
      return this.shuffleArray(selectedProblems);
    } catch (error) {
      console.error('Failed to select problems for exam:', error);
      return [];
    }
  }

  /**
   * 获取模式配置
   */
  private getModeConfig(mode: ExamMode): ExamModeConfig {
    switch (mode) {
      case ExamMode.QUICK:
        const quickDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        quickDistribution[ProblemDifficulty.EASY] = 3;
        quickDistribution[ProblemDifficulty.MEDIUM] = 2;
        quickDistribution[ProblemDifficulty.HARD] = 0;
        return {
          problemCount: 5,
          timeLimit: 15 * 60, // 15分钟
          difficultyDistribution: quickDistribution
        };
      case ExamMode.STANDARD:
        const standardDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        standardDistribution[ProblemDifficulty.EASY] = 4;
        standardDistribution[ProblemDifficulty.MEDIUM] = 4;
        standardDistribution[ProblemDifficulty.HARD] = 2;
        return {
          problemCount: 10,
          timeLimit: 45 * 60, // 45分钟
          difficultyDistribution: standardDistribution
        };
      case ExamMode.HARD:
        const hardDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        hardDistribution[ProblemDifficulty.EASY] = 2;
        hardDistribution[ProblemDifficulty.MEDIUM] = 6;
        hardDistribution[ProblemDifficulty.HARD] = 7;
        return {
          problemCount: 15,
          timeLimit: 90 * 60, // 90分钟
          difficultyDistribution: hardDistribution
        };
      default:
        const distribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        distribution[ProblemDifficulty.EASY] = 3;
        distribution[ProblemDifficulty.MEDIUM] = 2;
        distribution[ProblemDifficulty.HARD] = 0;
        return {
          problemCount: 5,
          timeLimit: 15 * 60,
          difficultyDistribution: distribution
        };
    }
  }

  /**
   * 根据模式配置选择题目
   */
  private selectProblemsByMode(allProblems: ProblemModel[], config: ExamModeConfig): ProblemModel[] {
    const selectedProblems: ProblemModel[] = [];
    
    // 按难度分组
    const problemsByDifficulty = this.groupProblemsByDifficulty(allProblems);
    
    // 按配置的难度分布选择题目
    const difficulties = [ProblemDifficulty.EASY, ProblemDifficulty.MEDIUM, ProblemDifficulty.HARD];
    for (const difficulty of difficulties) {
      const count = config.difficultyDistribution[difficulty];
      const problems = problemsByDifficulty[difficulty] || [];
      
      if (problems.length > 0) {
        const shuffled = this.shuffleArray([...problems]);
        const selected = shuffled.slice(0, Math.min(count, shuffled.length));
        selectedProblems.push(...selected);
      }
    }
    
    // 如果选择的题目不够，从剩余题目中随机补充
    if (selectedProblems.length < config.problemCount) {
      const remaining = allProblems.filter(p => !selectedProblems.includes(p));
      const shuffled = this.shuffleArray(remaining);
      const needed = config.problemCount - selectedProblems.length;
      selectedProblems.push(...shuffled.slice(0, needed));
    }
    
    return selectedProblems.slice(0, config.problemCount);
  }

  /**
   * 根据难度过滤题目
   */
  private filterProblemsByDifficulty(problems: ProblemModel[], difficulty: DifficultyLevel): ProblemModel[] {
    if (difficulty === DifficultyLevel.MIXED) {
      return problems; // 混合难度返回所有题目
    }
    
    let targetDifficulty: ProblemDifficulty;
    switch (difficulty) {
      case DifficultyLevel.EASY:
        targetDifficulty = ProblemDifficulty.EASY;
        break;
      case DifficultyLevel.MEDIUM:
        targetDifficulty = ProblemDifficulty.MEDIUM;
        break;
      case DifficultyLevel.HARD:
        targetDifficulty = ProblemDifficulty.HARD;
        break;
      default:
        return problems;
    }
    
    return problems.filter(problem => problem.difficulty === targetDifficulty);
  }

  /**
   * 按难度分组题目
   */
  private groupProblemsByDifficulty(problems: ProblemModel[]): Record<ProblemDifficulty, ProblemModel[]> {
    const groups: Record<ProblemDifficulty, ProblemModel[]> = {} as Record<ProblemDifficulty, ProblemModel[]>;
    groups[ProblemDifficulty.EASY] = [];
    groups[ProblemDifficulty.MEDIUM] = [];
    groups[ProblemDifficulty.HARD] = [];
    
    problems.forEach(problem => {
      groups[problem.difficulty].push(problem);
    });
    
    return groups;
  }

  /**
   * 随机打乱数组
   */
  private shuffleArray<T>(array: T[]): T[] {
    const shuffled = [...array];
    for (let i = shuffled.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      const temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    return shuffled;
  }

  /**
   * 获取所有题目（模拟数据）
   */
  private async getAllProblems(): Promise<ProblemModel[]> {
    // TODO: 从数据库或API获取题目数据
    // 这里返回模拟数据
    return this.getMockProblems();
  }

  /**
   * 创建选择题选项
   */
  private createChoiceOptions(correctAnswers: string[], wrongAnswers: string[]): ChoiceOption[] {
    const options: ChoiceOption[] = [];
    
    // 添加正确答案
    correctAnswers.forEach((answer, index) => {
      const option: ChoiceOption = {
        id: String.fromCharCode(65 + options.length), // A, B, C, D...
        text: answer,
        isCorrect: true
      };
      options.push(option);
    });
    
    // 添加错误答案
    wrongAnswers.forEach((answer, index) => {
      const option: ChoiceOption = {
        id: String.fromCharCode(65 + options.length), // A, B, C, D...
        text: answer,
        isCorrect: false
      };
      options.push(option);
    });
    
    // 随机打乱选项顺序
    return this.shuffleArray(options);
  }

  /**
   * 获取模拟题目数据
   */
  private getMockProblems(): ProblemModel[] {
    // 直接使用ProblemMockData获取真正的ProblemModel实例
    const problems = ProblemMockData.getAllProblems();
    console.info(`ExamService: Loaded ${problems.length} problems from ProblemMockData`);
    
    // 验证题目数据完整性
    problems.forEach((problem, index) => {
      if (!problem.choices || problem.choices.length === 0) {
        console.error(`ExamService: Problem ${problem.id} (${problem.title}) has no choices`);
      } else {
        console.info(`ExamService: Problem ${problem.id} (${problem.title}) has ${problem.choices.length} choices:`);
        problem.choices.forEach((choice, choiceIndex) => {
          console.info(`  ${choice.id}: ${choice.text} (correct: ${choice.isCorrect})`);
        });
      }
    });
    
    return problems;
  }



  /**
   * 获取考核记录列表
   */
  public async getExamRecords(): Promise<ExamRecordModel[]> {
    try {
      return await this.examRecordDao.getAllExamRecords();
    } catch (error) {
      console.error('Failed to get exam records:', error);
      return [];
    }
  }

  /**
   * 根据ID获取考核记录
   */
  public async getExamRecordById(id: number): Promise<ExamRecordModel | null> {
    try {
      return await this.examRecordDao.getExamRecordById(id);
    } catch (error) {
      console.error('Failed to get exam record by id:', error);
      return null;
    }
  }

  /**
   * 保存考核记录
   */
  public async saveExamRecord(record: ExamRecordModel): Promise<void> {
    try {
      await this.examRecordDao.saveExamRecord(record);
      console.info('Exam record saved successfully');
    } catch (error) {
      console.error('Failed to save exam record:', error);
      throw new Error('Failed to save exam record');
    }
  }

  /**
   * 获取最近的考核记录
   */
  public async getRecentExamRecords(limit: number = 5): Promise<ExamRecordModel[]> {
    try {
      return await this.examRecordDao.getRecentExamRecords(limit);
    } catch (error) {
      console.error('Failed to get recent exam records:', error);
      return [];
    }
  }
}

// 考核模式配置接口
interface ExamModeConfig {
  problemCount: number;
  timeLimit: number;
  difficultyDistribution: Record<ProblemDifficulty, number>;
}

// 题目数据接口
interface ProblemData {
  id: number;
  title: string;
  difficulty: ProblemDifficulty;
  category: ProblemCategory;
}