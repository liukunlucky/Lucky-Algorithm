// 成就类型枚举
export enum AchievementType {
  FIRST_PROBLEM = 'first_problem',           // 初出茅庐：完成第一道题目
  CONTINUOUS_DAYS = 'continuous_days',       // 持之以恒：连续学习7天
  PROBLEM_COUNT = 'problem_count',           // 题海战术：累计完成50道题目
  PERFECT_SCORE = 'perfect_score',           // 完美主义：获得10次满分
  CATEGORY_MASTER = 'category_master',       // 分类大师：完成所有分类的题目
  SPEED_DEMON = 'speed_demon'                // 速度之王：单题用时少于30秒达到20次
}

// 成就状态
export interface AchievementStatus {
  type: AchievementType;
  title: string;
  description: string;
  icon: string;
  isCompleted: boolean;
  progress: number;        // 当前进度
  target: number;          // 目标值
  completedAt?: string;    // 完成时间
}

// 成就模型
export class AchievementModel {
  type: AchievementType = AchievementType.FIRST_PROBLEM;
  title: string = '';
  description: string = '';
  icon: string = '';
  isCompleted: boolean = false;
  progress: number = 0;
  target: number = 0;
  completedAt?: string;

  constructor() {}

  // 获取进度百分比
  getProgressPercentage(): number {
    if (this.target === 0) return 0;
    return Math.min(100, Math.round((this.progress / this.target) * 100));
  }

  // 获取进度文本
  getProgressText(): string {
    if (this.isCompleted) {
      return '已完成';
    }
    return `${this.progress}/${this.target}`;
  }

  // 静态方法：获取所有成就定义
  static getAllAchievements(): AchievementModel[] {
    const achievements: AchievementModel[] = [];

    // 1. 初出茅庐：完成第一道题目
    const firstProblem = new AchievementModel();
    firstProblem.type = AchievementType.FIRST_PROBLEM;
    firstProblem.title = '初出茅庐';
    firstProblem.description = '完成第一道题目';
    firstProblem.icon = '🌱';
    firstProblem.target = 1;
    achievements.push(firstProblem);

    // 2. 持之以恒：连续学习7天
    const continuousDays = new AchievementModel();
    continuousDays.type = AchievementType.CONTINUOUS_DAYS;
    continuousDays.title = '持之以恒';
    continuousDays.description = '连续学习7天';
    continuousDays.icon = '🔥';
    continuousDays.target = 7;
    achievements.push(continuousDays);

    // 3. 题海战术：累计完成50道题目
    const problemCount = new AchievementModel();
    problemCount.type = AchievementType.PROBLEM_COUNT;
    problemCount.title = '题海战术';
    problemCount.description = '累计完成50道题目';
    problemCount.icon = '📚';
    problemCount.target = 50;
    achievements.push(problemCount);

    // 4. 完美主义：获得10次满分
    const perfectScore = new AchievementModel();
    perfectScore.type = AchievementType.PERFECT_SCORE;
    perfectScore.title = '完美主义';
    perfectScore.description = '获得10次满分';
    perfectScore.icon = '⭐';
    perfectScore.target = 10;
    achievements.push(perfectScore);

    // 5. 分类大师：完成所有分类的题目
    const categoryMaster = new AchievementModel();
    categoryMaster.type = AchievementType.CATEGORY_MASTER;
    categoryMaster.title = '分类大师';
    categoryMaster.description = '完成所有分类的题目';
    categoryMaster.icon = '🏆';
    categoryMaster.target = 8; // 假设有8个分类
    achievements.push(categoryMaster);

    // 6. 速度之王：单题用时少于30秒达到20次
    const speedDemon = new AchievementModel();
    speedDemon.type = AchievementType.SPEED_DEMON;
    speedDemon.title = '速度之王';
    speedDemon.description = '单题用时少于30秒达到20次';
    speedDemon.icon = '⚡';
    speedDemon.target = 20;
    achievements.push(speedDemon);

    return achievements;
  }
}