// 题目状态枚举
export enum ProblemStatus {
  NOT_ATTEMPTED = 0,
  COMPLETED = 1,
  WRONG = 2
}

// 用户进度模型
export class UserProgressModel {
  id: number = 0;
  problemId: number = 0;
  status: ProblemStatus = ProblemStatus.NOT_ATTEMPTED;
  isFavorite: boolean = false;
  lastAttempted: string = '';
  attemptCount: number = 0;
  successCount: number = 0;

  constructor() {}

  // 获取状态文本
  getStatusText(): string {
    switch (this.status) {
      case ProblemStatus.NOT_ATTEMPTED:
        return '未做';
      case ProblemStatus.COMPLETED:
        return '已完成';
      case ProblemStatus.WRONG:
        return '错题';
      default:
        return '未知';
    }
  }

  // 获取状态图标
  getStatusIcon(): string {
    switch (this.status) {
      case ProblemStatus.NOT_ATTEMPTED:
        return '⭕';
      case ProblemStatus.COMPLETED:
        return '✅';
      case ProblemStatus.WRONG:
        return '❌';
      default:
        return '❓';
    }
  }

  // 获取正确率
  getAccuracyRate(): number {
    if (this.attemptCount === 0) {
      return 0;
    }
    return Math.round((this.successCount / this.attemptCount) * 100);
  }

  // 更新最后尝试时间
  updateLastAttempted(): void {
    this.lastAttempted = new Date().toISOString();
  }

  // 记录尝试
  recordAttempt(isSuccess: boolean): void {
    this.attemptCount++;
    if (isSuccess) {
      this.successCount++;
      this.status = ProblemStatus.COMPLETED;
    } else {
      this.status = ProblemStatus.WRONG;
    }
    this.updateLastAttempted();
  }

  // 切换收藏状态
  toggleFavorite(): void {
    this.isFavorite = !this.isFavorite;
  }
}