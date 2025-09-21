import { TodayPracticePage } from './TodayPracticePage';
import { LearningPathPage } from './LearningPathPage';
import { PracticeCenterPage } from './PracticeCenterPage';
import { ExamPage } from './ExamPage';
import { StatisticsPage } from './StatisticsPage';
import { TabNavigationService } from '../service/TabNavigationService';
import { DatabaseHelper } from '../database/DatabaseHelper';

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabNavigationService: TabNavigationService = TabNavigationService.getInstance();

  aboutToAppear() {
    // 初始化Tab导航服务
    this.tabNavigationService.setTabsController(this.tabsController);
    
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
        StatisticsPage()
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
      this.tabNavigationService.updateCurrentTabIndex(index);
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