import { TodayPracticePage } from './TodayPracticePage';
import { LearningPathPage } from './LearningPathPage';
import { PracticeCenterPage } from './PracticeCenterPage';
import { ExamPage } from './ExamPage';
import { TabNavigationService } from '../service/TabNavigationService';
import { DatabaseHelper } from '../database/DatabaseHelper';
import { ProfilePage } from './ProfilePage';

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;
  @State lastLearningPathVisit: number = 0; // 记录上次访问学习路线的时间
  @StorageLink('switchToPracticeCenter') @Watch('onSwitchToPracticeCenter') switchTrigger: number = 0;
  @StorageLink('switchToTabIndex') @Watch('onSwitchToTab') switchToTabIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabNavigationService: TabNavigationService = TabNavigationService.getInstance();
  private static readonly REFRESH_THRESHOLD = 300000; // 5分钟内不重复刷新

  aboutToAppear() {
    // 确保数据库已初始化（备用方案）
    this.ensureDatabaseInitialized();
  }

  private async ensureDatabaseInitialized(): Promise<void> {
    try {
      const dbHelper = DatabaseHelper.getInstance();
      const store = dbHelper.getStore();

      if (!store) {
        // 如果数据库未初始化，尝试初始化
        console.info('Database not initialized, attempting to initialize...');
        await dbHelper.initDatabase(getContext(this));
        console.info('Database initialized successfully in Index page');
      }
    } catch (error) {
      console.error('Failed to ensure database initialization:', error);
    }
  }

  /**
   * 监听Tab切换信号
   */
  onSwitchToTab() {
    if (this.switchToTabIndex >= 0) {
      console.info(`🔄 Index接收到Tab切换信号: ${this.switchToTabIndex}`);
      this.currentTabIndex = this.switchToTabIndex;
      this.tabsController.changeIndex(this.switchToTabIndex);
      this.tabNavigationService.setCurrentTabIndex(this.switchToTabIndex);
      
      console.info(`✅ Tab切换完成: ${this.switchToTabIndex}`);
      // 清除触发器
      AppStorage.setOrCreate('switchToTabIndex', -1);
    }
  }

  /**
   * 监听切换到练习中心的触发器
   */
  onSwitchToPracticeCenter() {
    if (this.switchTrigger > 0) {
      this.currentTabIndex = 2; // 切换到练习中心Tab
      this.tabsController.changeIndex(2);
      this.tabNavigationService.setCurrentTabIndex(2);
      
      // 清除触发器
      AppStorage.setOrCreate('switchToPracticeCenter', 0);
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      // 今日练习Tab
      TabContent() {
        TodayPracticePage()
      }
      .tabBar(this.buildTabBarItem($r('app.media.icon_home'), '首页', 0))

      // 学习路线Tab
      TabContent() {
        LearningPathPage()
      }
      .tabBar(this.buildTabBarItem($r('app.media.icon_route'), '学习路线', 1))

      // 练习中心Tab
      TabContent() {
        PracticeCenterPage()
      }
      .tabBar(this.buildTabBarItem($r('app.media.icon_train_center'), '练习中心', 2))

      // 模拟考核Tab
      TabContent() {
        ExamPage()
      }
      .tabBar(this.buildTabBarItem($r('app.media.icon_exam'), '模拟考核', 3))

      // 我的统计Tab
      TabContent() {
        ProfilePage()
      }
      .tabBar(this.buildTabBarItem($r('app.media.icon_mine'), '我的', 4))
    }
    .animationDuration(300)
    .scrollable(false)
    .backgroundColor('#F8F9FA')
    .barMode(BarMode.Fixed)
    .barHeight(56)
    .onChange((index: number) => {
      this.currentTabIndex = index;
      this.tabNavigationService.setCurrentTabIndex(index);
      
      // 当切换到学习路线Tab时，智能判断是否需要刷新
      if (index === 1) {
        const currentTime = Date.now();
        // 只有在超过闾值时间或首次访问时才触发刷新
        if (this.lastLearningPathVisit === 0 || (currentTime - this.lastLearningPathVisit) > Index.REFRESH_THRESHOLD) {
          console.info('触发学习路线数据刷新');
          AppStorage.setOrCreate('learningPathRefreshTrigger', currentTime);
          this.lastLearningPathVisit = currentTime;
        } else {
          console.info('跳过学习路线数据刷新，距离上次访问时间过短');
        }
      }
    })
  }

  @Builder
  buildTabBarItem(icon: Resource, title: string, index: number) {
    Column({ space: 4 }) {
      Image(icon)
        .width(20)
        .height(20)
        .fillColor(this.currentTabIndex === index ? '#F34F40' : '#999999')

      Text(title)
        .fontSize(10)
        .fontColor(this.currentTabIndex === index ? '#F34F40' : '#999999')
        .fontWeight(this.currentTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F9FA')
  }
}