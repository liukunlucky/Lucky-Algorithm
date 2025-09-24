export enum DiaryMood {
  EXCELLENT = 'excellent',
  GOOD = 'good',
  NORMAL = 'normal',
  BAD = 'bad',
  TERRIBLE = 'terrible'
}

export class StudyDiaryModel {
  id: number = 0;
  title: string = '';
  content: string = '';
  mood: DiaryMood = DiaryMood.NORMAL;
  studyDuration: number = 0; // 学习时长（分钟）
  problemsSolved: number = 0; // 解决的题目数量
  tags: string = ''; // 标签，用逗号分隔
  createdAt: string = '';
  updatedAt: string = '';

  constructor() {
    const now = new Date().toISOString();
    this.createdAt = now;
    this.updatedAt = now;
  }

  // 获取心情显示文本
  getMoodDisplayText(): string {
    switch (this.mood) {
      case DiaryMood.EXCELLENT:
        return '非常好';
      case DiaryMood.GOOD:
        return '良好';
      case DiaryMood.NORMAL:
        return '一般';
      case DiaryMood.BAD:
        return '不好';
      case DiaryMood.TERRIBLE:
        return '很差';
      default:
        return '一般';
    }
  }

  // 获取心情表情
  getMoodEmoji(): string {
    switch (this.mood) {
      case DiaryMood.EXCELLENT:
        return '😄';
      case DiaryMood.GOOD:
        return '😊';
      case DiaryMood.NORMAL:
        return '😐';
      case DiaryMood.BAD:
        return '😔';
      case DiaryMood.TERRIBLE:
        return '😢';
      default:
        return '😐';
    }
  }

  // 获取心情颜色
  getMoodColor(): string {
    switch (this.mood) {
      case DiaryMood.EXCELLENT:
        return '#52c41a';
      case DiaryMood.GOOD:
        return '#1890ff';
      case DiaryMood.NORMAL:
        return '#faad14';
      case DiaryMood.BAD:
        return '#fa8c16';
      case DiaryMood.TERRIBLE:
        return '#f5222d';
      default:
        return '#faad14';
    }
  }

  // 获取标签数组
  getTagsArray(): string[] {
    if (!this.tags) return [];
    return this.tags.split(',').map(tag => tag.trim()).filter(tag => tag.length > 0);
  }

  // 设置标签数组
  setTagsArray(tags: string[]): void {
    this.tags = tags.join(',');
  }

  // 获取格式化的创建日期
  getFormattedDate(): string {
    const date = new Date(this.createdAt);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  // 获取格式化的创建时间
  getFormattedTime(): string {
    const date = new Date(this.createdAt);
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${hours}:${minutes}`;
  }

  // 获取学习时长显示文本
  getStudyDurationText(): string {
    if (this.studyDuration < 60) {
      return `${this.studyDuration}分钟`;
    } else {
      const hours = Math.floor(this.studyDuration / 60);
      const minutes = this.studyDuration % 60;
      if (minutes === 0) {
        return `${hours}小时`;
      } else {
        return `${hours}小时${minutes}分钟`;
      }
    }
  }
}