// 考核模式枚举
export enum ExamMode {
  QUICK = 'quick',
  STANDARD = 'standard',
  HARD = 'hard'
}

// 考核题目结果接口
export interface ExamProblemResult {
  problemId: number;
  problemTitle: string;
  isCorrect: boolean;
  userAnswer: string[];  // 用户选择的选项ID数组，如 ['A'] 或 ['A', 'C']
  correctAnswer: string[];  // 正确答案选项ID数组
  userCode: string;  // 保留字段，用于代码题（如果以后需要）
  timeSpent: number; // 秒
}

// 模式配置接口
interface ModeConfig {
  problemCount: number;
  timeLimit: number;
}

// 考核记录模型
export class ExamRecordModel {
  id: number = 0;
  date: string = '';
  mode: ExamMode = ExamMode.QUICK;
  score: number = 0;
  duration: number = 0; // 总用时，秒
  problemResults: ExamProblemResult[] = [];
  
  // 新增属性
  totalProblems: number = 0;
  correctCount: number = 0;
  timeUsed: number = 0; // 用时，秒
  startTime: Date = new Date();
  endTime: Date = new Date();

  constructor() {}

  // 获取模式文本
  getModeText(): string {
    switch (this.mode) {
      case ExamMode.QUICK:
        return '快速模考';
      case ExamMode.STANDARD:
        return '标准模考';
      case ExamMode.HARD:
        return '地狱模考';
      default:
        return '未知模式';
    }
  }

  // 获取模式配置
  getModeConfig(): ModeConfig {
    switch (this.mode) {
      case ExamMode.QUICK:
        const quickConfig: ModeConfig = { problemCount: 5, timeLimit: 25 * 60 }; // 25分钟
        return quickConfig;
      case ExamMode.STANDARD:
        const standardConfig: ModeConfig = { problemCount: 10, timeLimit: 60 * 60 }; // 60分钟
        return standardConfig;
      case ExamMode.HARD:
        const hardConfig: ModeConfig = { problemCount: 15, timeLimit: 90 * 60 }; // 90分钟
        return hardConfig;
      default:
        const defaultConfig: ModeConfig = { problemCount: 5, timeLimit: 25 * 60 };
        return defaultConfig;
    }
  }

  // 获取正确率
  getAccuracyRate(): number {
    if (this.problemResults.length === 0) {
      return 0;
    }
    const correctCount = this.problemResults.filter(result => result.isCorrect).length;
    return Math.round((correctCount / this.problemResults.length) * 100);
  }

  // 获取错题列表
  getWrongProblems(): ExamProblemResult[] {
    return this.problemResults.filter(result => !result.isCorrect);
  }

  // 获取用时文本
  getDurationText(): string {
    const hours = Math.floor(this.duration / 3600);
    const minutes = Math.floor((this.duration % 3600) / 60);
    const seconds = this.duration % 60;

    if (hours > 0) {
      return `${hours}小时${minutes}分${seconds}秒`;
    } else if (minutes > 0) {
      return `${minutes}分${seconds}秒`;
    } else {
      return `${seconds}秒`;
    }
  }

  // 获取等级评价
  getGradeText(): string {
    const accuracy = this.getAccuracyRate();
    if (accuracy >= 90) {
      return '优秀';
    } else if (accuracy >= 80) {
      return '良好';
    } else if (accuracy >= 70) {
      return '中等';
    } else if (accuracy >= 60) {
      return '及格';
    } else {
      return '不及格';
    }
  }

  // 计算分数
  calculateScore(): void {
    const accuracy = this.getAccuracyRate();
    const config = this.getModeConfig();
    const timeBonus = Math.max(0, (config.timeLimit - this.duration) / config.timeLimit * 20);
    this.score = Math.round(accuracy * 0.8 + timeBonus);
  }
}