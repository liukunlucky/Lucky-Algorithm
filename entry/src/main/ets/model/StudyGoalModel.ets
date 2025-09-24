/**
 * 学习目标状态枚举
 */
export enum GoalStatus {
  ACTIVE = 'active',      // 进行中
  COMPLETED = 'completed', // 已完成
  PAUSED = 'paused'       // 已暂停
}

/**
 * 学习目标类型枚举
 */
export enum GoalType {
  DAILY = 'daily',        // 每日目标
  WEEKLY = 'weekly',      // 每周目标
  MONTHLY = 'monthly',    // 每月目标
  CUSTOM = 'custom'       // 自定义目标
}

/**
 * 学习目标数据模型
 */
export class StudyGoalModel {
  id: number = 0;
  title: string = '';
  description: string = '';
  type: GoalType = GoalType.DAILY;
  targetValue: number = 0;        // 目标值（如：每日5题）
  currentValue: number = 0;       // 当前进度值
  status: GoalStatus = GoalStatus.ACTIVE;
  startDate: string = '';         // 开始日期
  endDate: string = '';           // 结束日期
  createdAt: string = '';         // 创建时间
  updatedAt: string = '';         // 更新时间

  constructor() {
    const now = new Date().toISOString();
    this.createdAt = now;
    this.updatedAt = now;
  }

  /**
   * 获取进度百分比
   */
  getProgressPercentage(): number {
    if (this.targetValue <= 0) return 0;
    return Math.min((this.currentValue / this.targetValue) * 100, 100);
  }

  /**
   * 检查目标是否已完成
   */
  isCompleted(): boolean {
    return this.currentValue >= this.targetValue;
  }

  /**
   * 获取剩余天数
   */
  getRemainingDays(): number {
    if (!this.endDate) return -1;
    const endTime = new Date(this.endDate).getTime();
    const currentTime = new Date().getTime();
    const diffTime = endTime - currentTime;
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  }

  /**
   * 获取目标类型显示文本
   */
  getTypeDisplayText(): string {
    switch (this.type) {
      case GoalType.DAILY:
        return '每日目标';
      case GoalType.WEEKLY:
        return '每周目标';
      case GoalType.MONTHLY:
        return '每月目标';
      case GoalType.CUSTOM:
        return '自定义目标';
      default:
        return '未知类型';
    }
  }

  /**
   * 获取状态显示文本
   */
  getStatusDisplayText(): string {
    switch (this.status) {
      case GoalStatus.ACTIVE:
        return '进行中';
      case GoalStatus.COMPLETED:
        return '已完成';
      case GoalStatus.PAUSED:
        return '已暂停';
      default:
        return '未知状态';
    }
  }
}