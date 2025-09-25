import { AchievementModel, AchievementType, AchievementStatus } from '../model/AchievementModel';
import { UserProgressDao } from '../dao/UserProgressDao';
import { ProblemService } from './ProblemService';

export class AchievementService {
  private userProgressDao: UserProgressDao = new UserProgressDao();
  private problemService: ProblemService = new ProblemService();

  constructor() {}

  // 获取所有成就状态
  async getAllAchievements(): Promise<AchievementModel[]> {
    const achievements = AchievementModel.getAllAchievements();
    
    // 计算每个成就的进度
    for (const achievement of achievements) {
      await this.calculateAchievementProgress(achievement);
    }
    
    return achievements;
  }

  // 计算单个成就的进度
  private async calculateAchievementProgress(achievement: AchievementModel): Promise<void> {
    try {
      switch (achievement.type) {
        case AchievementType.FIRST_PROBLEM:
          await this.calculateFirstProblemProgress(achievement);
          break;
        case AchievementType.CONTINUOUS_DAYS:
          await this.calculateContinuousDaysProgress(achievement);
          break;
        case AchievementType.PROBLEM_COUNT:
          await this.calculateProblemCountProgress(achievement);
          break;
        case AchievementType.PERFECT_SCORE:
          await this.calculatePerfectScoreProgress(achievement);
          break;
        case AchievementType.CATEGORY_MASTER:
          await this.calculateCategoryMasterProgress(achievement);
          break;
        case AchievementType.SPEED_DEMON:
          await this.calculateSpeedDemonProgress(achievement);
          break;
      }
    } catch (error) {
      console.error(`Failed to calculate progress for ${achievement.type}:`, error);
    }
  }

  // 计算初出茅庐成就进度
  private async calculateFirstProblemProgress(achievement: AchievementModel): Promise<void> {
    const totalCompleted = await this.userProgressDao.getTotalCompletedProblems();
    achievement.progress = totalCompleted > 0 ? 1 : 0;
    achievement.isCompleted = achievement.progress >= achievement.target;
  }

  // 计算持之以恒成就进度
  private async calculateContinuousDaysProgress(achievement: AchievementModel): Promise<void> {
    const continuousDays = await this.userProgressDao.getContinuousDays();
    achievement.progress = continuousDays;
    achievement.isCompleted = achievement.progress >= achievement.target;
  }

  // 计算题海战术成就进度
  private async calculateProblemCountProgress(achievement: AchievementModel): Promise<void> {
    const totalCompleted = await this.userProgressDao.getTotalCompletedProblems();
    achievement.progress = totalCompleted;
    achievement.isCompleted = achievement.progress >= achievement.target;
  }

  // 计算完美主义成就进度
  private async calculatePerfectScoreProgress(achievement: AchievementModel): Promise<void> {
    const perfectScoreCount = await this.userProgressDao.getPerfectScoreCount();
    achievement.progress = perfectScoreCount;
    achievement.isCompleted = achievement.progress >= achievement.target;
  }

  // 计算分类大师成就进度
  private async calculateCategoryMasterProgress(achievement: AchievementModel): Promise<void> {
    try {
      const categories = await this.problemService.getCategories();
      const completedCategories = await this.userProgressDao.getCompletedCategoriesCount();
      
      achievement.target = categories.length;
      achievement.progress = completedCategories;
      achievement.isCompleted = achievement.progress >= achievement.target;
    } catch (error) {
      console.error('Failed to calculate category master progress:', error);
      achievement.progress = 0;
      achievement.isCompleted = false;
    }
  }

  // 计算速度之王成就进度
  private async calculateSpeedDemonProgress(achievement: AchievementModel): Promise<void> {
    const fastSolveCount = await this.userProgressDao.getFastSolveCount(30); // 30秒以内
    achievement.progress = fastSolveCount;
    achievement.isCompleted = achievement.progress >= achievement.target;
  }

  // 检查是否有新成就解锁
  async checkNewAchievements(): Promise<AchievementModel[]> {
    const achievements = await this.getAllAchievements();
    const newAchievements: AchievementModel[] = [];
    
    for (const achievement of achievements) {
      if (achievement.isCompleted && !achievement.completedAt) {
        // 这是一个新完成的成就
        achievement.completedAt = new Date().toISOString();
        newAchievements.push(achievement);
      }
    }
    
    return newAchievements;
  }

  // 获取成就完成率
  async getAchievementCompletionRate(): Promise<number> {
    const achievements = await this.getAllAchievements();
    const completedCount = achievements.filter(a => a.isCompleted).length;
    return Math.round((completedCount / achievements.length) * 100);
  }

  // 获取下一个即将完成的成就
  async getNextAchievement(): Promise<AchievementModel | null> {
    const achievements = await this.getAllAchievements();
    const incompleteAchievements = achievements.filter(a => !a.isCompleted);
    
    if (incompleteAchievements.length === 0) {
      return null;
    }
    
    // 按进度百分比排序，返回最接近完成的成就
    incompleteAchievements.sort((a, b) => b.getProgressPercentage() - a.getProgressPercentage());
    return incompleteAchievements[0];
  }
}