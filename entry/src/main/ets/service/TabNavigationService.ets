/**
 * Tab导航服务
 * 用于管理Tab页面间的导航和状态同步
 */
export class TabNavigationService {
  private static instance: TabNavigationService;
  private currentTabIndex: number = 0;

  private constructor() {}

  static getInstance(): TabNavigationService {
    if (!TabNavigationService.instance) {
      TabNavigationService.instance = new TabNavigationService();
    }
    return TabNavigationService.instance;
  }

  /**
   * 获取当前Tab索引
   */
  getCurrentTabIndex(): number {
    return this.currentTabIndex;
  }

  /**
   * 设置当前Tab索引
   * @param index Tab索引
   */
  setCurrentTabIndex(index: number): void {
    this.currentTabIndex = index;
  }

  /**
   * 切换到今日练习Tab
   */
  switchToToday(): void {
    this.currentTabIndex = 0;
  }

  /**
   * 切换到学习路线Tab
   */
  switchToLearningPath(): void {
    this.currentTabIndex = 1;
  }

  /**
   * 切换到练习中心Tab
   */
  switchToPracticeCenter(): void {
    console.info('📱 TabNavigationService: 切换到练习中心');
    this.currentTabIndex = 2;
    // 使用AppStorage通知Index页面切换Tab
    AppStorage.setOrCreate('switchToTabIndex', 2);
    console.info('✅ 已发送切换信号到Index页面');
  }

  /**
   * 切换到模拟考试Tab，并触发数据刷新
   */
  switchToExam(): void {
    console.info('📱 TabNavigationService: 切换到模拟考试');
    this.currentTabIndex = 3;
    // 使用AppStorage通知Index页面切换Tab
    AppStorage.setOrCreate('switchToTabIndex', 3);
    // 触发ExamPage数据刷新
    this.triggerExamDataRefresh();
    console.info('✅ 已发送切换信号到Index页面');
  }

  /**
   * 切换到统计页面Tab
   */
  switchToStatistics(): void {
    this.currentTabIndex = 4;
  }

  /**
   * 触发考试数据刷新
   */
  private triggerExamDataRefresh(): void {
    const currentTrigger = AppStorage.get<number>('examDataRefreshTrigger') || 0;
    AppStorage.setOrCreate('examDataRefreshTrigger', currentTrigger + 1);
  }

  /**
   * 触发考试记录更新
   */
  static triggerExamRecordUpdate(): void {
    const currentTrigger = AppStorage.get<number>('examDataRefreshTrigger') || 0;
    AppStorage.setOrCreate('examDataRefreshTrigger', currentTrigger + 1);
  }

  /**
   * 触发考试完成事件
   */
  static triggerExamCompleted(): void {
    const currentTrigger = AppStorage.get<number>('examDataRefreshTrigger') || 0;
    AppStorage.setOrCreate('examDataRefreshTrigger', currentTrigger + 1);
  }
}