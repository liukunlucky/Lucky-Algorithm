/**
 * Tab导航服务
 * 用于管理全局Tab切换，避免页面跳转导致的导航问题
 */
export class TabNavigationService {
  private static instance: TabNavigationService;
  private tabsController: TabsController | null = null;
  private currentTabIndex: number = 0;

  private constructor() {}

  static getInstance(): TabNavigationService {
    if (!TabNavigationService.instance) {
      TabNavigationService.instance = new TabNavigationService();
    }
    return TabNavigationService.instance;
  }

  /**
   * 设置Tab控制器
   */
  setTabsController(controller: TabsController): void {
    this.tabsController = controller;
  }

  /**
   * 切换到指定Tab
   */
  switchToTab(tabIndex: number): void {
    if (this.tabsController && tabIndex >= 0 && tabIndex <= 4) {
      this.currentTabIndex = tabIndex;
      this.tabsController.changeIndex(tabIndex);
    }
  }

  /**
   * 切换到练习中心Tab
   */
  switchToPracticeCenter(): void {
    this.switchToTab(2);
  }

  /**
   * 切换到模拟考试Tab
   */
  switchToExam(): void {
    this.switchToTab(3);
  }

  /**
   * 切换到今日练习Tab
   */
  switchToTodayPractice(): void {
    this.switchToTab(0);
  }

  /**
   * 切换到学习路线Tab
   */
  switchToLearningPath(): void {
    this.switchToTab(1);
  }

  /**
   * 切换到统计Tab
   */
  switchToStatistics(): void {
    this.switchToTab(4);
  }

  /**
   * 获取当前Tab索引
   */
  getCurrentTabIndex(): number {
    return this.currentTabIndex;
  }

  /**
   * 更新当前Tab索引（由Tab组件调用）
   */
  updateCurrentTabIndex(index: number): void {
    this.currentTabIndex = index;
  }
}