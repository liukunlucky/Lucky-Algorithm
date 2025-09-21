// 使用mock数据，不再需要数据库实例
import { ProblemMockData } from '../mock/ProblemMockData';

interface StudyStats {
  totalSolved: number;
  continuousDays: number;
  totalStudyTime: number; // 分钟
  averageAccuracy: number; // 百分比
  favoriteCount: number;
  wrongCount: number;
}

interface CategoryProgress {
  categoryName: string;
  icon: Resource;
  solved: number;
  total: number;
  accuracy: number;
  color: string;
}

interface WeeklyData {
  date: string;
  solved: number;
}

@Entry
@Component
export struct StatisticsPage {
  @State studyStats: StudyStats = {
    totalSolved: 0,
    continuousDays: 0,
    totalStudyTime: 0,
    averageAccuracy: 0,
    favoriteCount: 0,
    wrongCount: 0
  };
  @State categoryProgress: CategoryProgress[] = [];
  @State weeklyData: WeeklyData[] = [];
  @State selectedTab: number = 0; // 0: 总览, 1: 分类, 2: 趋势

  aboutToAppear() {
    this.loadStatistics();
  }

  build() {
    Column({ space: 16 }) {
      // 页面标题
      this.buildHeader()

      // Tab切换
      this.buildTabBar()

      // 内容区域
      if (this.selectedTab === 0) {
        this.buildOverviewTab()
      } else if (this.selectedTab === 1) {
        this.buildCategoryTab()
      } else {
        this.buildTrendTab()
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor('#f5f5f5')
  }

  @Builder
  buildHeader() {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Image($r('app.media.chart_icon'))
          .width(20)
          .height(20)
          .fillColor('#333333')
        Text('我的统计')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .textAlign(TextAlign.Center)
      }

      Text('数据驱动学习，持续进步成长')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  buildTabBar() {
    Row() {
      this.buildTabItem('总览', 0)
      this.buildTabItem('分类', 1)
      this.buildTabItem('趋势', 2)
    }
    .width('100%')
    .height(44)
    .backgroundColor('#ffffff')
    .borderRadius(22)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
  }

  @Builder
  buildTabItem(title: string, index: number) {
    Text(title)
      .fontSize(14)
      .fontColor(this.selectedTab === index ? '#ffffff' : '#666666')
      .fontWeight(this.selectedTab === index ? FontWeight.Medium : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height('100%')
      .backgroundColor(this.selectedTab === index ? '#1890ff' : 'transparent')
      .borderRadius(22)
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  @Builder
  buildOverviewTab() {
    Column({ space: 16 }) {
      // 核心数据卡片
      this.buildCoreStatsCard()

      // 学习成就
      this.buildAchievementsCard()

      // 快捷操作
      this.buildQuickActions()
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildCoreStatsCard() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
          Image($r('app.media.chart_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('核心数据')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      Grid() {
        GridItem() {
          this.buildStatItem('总攻克题数', this.studyStats.totalSolved + '题', $r('app.media.target_icon'), '#1890ff')
        }
        GridItem() {
          this.buildStatItem('连续学习', this.studyStats.continuousDays + '天', $r('app.media.star_icon'), '#ff6b35')
        }
        GridItem() {
          this.buildStatItem('学习时长', this.formatStudyTime(this.studyStats.totalStudyTime), $r('app.media.star_icon'), '#52c41a')
        }
        GridItem() {
          this.buildStatItem('平均正确率', this.studyStats.averageAccuracy + '%', $r('app.media.target_icon'), '#722ed1')
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .height(160)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildStatItem(title: string, value: string, icon: Resource, color: string) {
    Column({ space: 8 }) {
      Image(icon)
        .width(20)
        .height(20)
        .fillColor(color)

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#f8f9fa')
    .borderRadius(8)
  }

  @Builder
  buildAchievementsCard() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Image($r('app.media.star_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('学习成就')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      Row({ space: 16 }) {
        this.buildAchievementItem('收藏题目', this.studyStats.favoriteCount + '题', $r('app.media.star_icon'), '#fa8c16')
        this.buildAchievementItem('错题回顾', this.studyStats.wrongCount + '题', $r('app.media.note_icon'), '#f5222d')
        this.buildAchievementItem('学习等级', this.getStudyLevel(), $r('app.media.target_icon'), '#13c2c2')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildAchievementItem(title: string, value: string, icon: Resource, color: string) {
    Column({ space: 6 }) {
      Image(icon)
        .width(18)
        .height(18)
        .fillColor(color)

      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildQuickActions() {
    Row({ space: 12 }) {
      Button('查看收藏')
        .layoutWeight(1)
        .height(40)
        .backgroundColor('#ffffff')
        .fontColor('#fa8c16')
        .border({ width: 1, color: '#fa8c16' })
        .borderRadius(8)
        .onClick(() => {
          this.navigateToFavorites();
        })

      Button('错题本')
        .layoutWeight(1)
        .height(40)
        .backgroundColor('#ffffff')
        .fontColor('#f5222d')
        .border({ width: 1, color: '#f5222d' })
        .borderRadius(8)
        .onClick(() => {
          this.navigateToWrongProblems();
        })

      Button('学习报告')
        .layoutWeight(1)
        .height(40)
        .backgroundColor('#1890ff')
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          this.generateReport();
        })
    }
    .width('100%')
  }

  @Builder
  buildCategoryTab() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
          Image($r('app.media.book_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('分类进度')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      List({ space: 12 }) {
        ForEach(this.categoryProgress, (category: CategoryProgress) => {
          ListItem() {
            this.buildCategoryProgressCard(category)
          }
        }, (category: CategoryProgress) => category.categoryName)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildCategoryProgressCard(category: CategoryProgress) {
    Row({ space: 12 }) {
      Image(category.icon)
        .width(24)
        .height(24)
        .fillColor('#333333')
        .margin(8)
        .backgroundColor(category.color + '20')
        .borderRadius(20)

      Column({ space: 6 }) {
        Row() {
          Text(category.categoryName)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Blank()

          Text(category.solved + '/' + category.total)
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')

        Progress({
          value: category.solved,
          total: category.total,
          type: ProgressType.Linear
        })
        .width('100%')
        .height(6)
        .color(category.color)
        .backgroundColor('#f0f0f0')

        Row() {
          Text('完成率: ' + Math.round((category.solved / category.total) * 100) + '%')
            .fontSize(12)
            .fontColor('#666666')

          Blank()

          Text('正确率: ' + category.accuracy + '%')
            .fontSize(12)
            .fontColor('#666666')
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
  }

  @Builder
  buildTrendTab() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
          Image($r('app.media.chart_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('学习趋势')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      // 周学习统计
      this.buildWeeklyChart()

      // 学习建议
      this.buildStudySuggestions()
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildWeeklyChart() {
    Column({ space: 12 }) {
      Text('近7天学习情况')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      // 简化的图表显示
      Row({ space: 8 }) {
        ForEach(this.weeklyData, (data: WeeklyData) => {
          Column({ space: 4 }) {
            Column()
              .width(20)
              .height(Math.max(data.solved * 10, 5))
              .backgroundColor('#1890ff')
              .borderRadius(2)

            Text(data.date)
              .fontSize(10)
              .fontColor('#666666')

            Text(data.solved + '')
              .fontSize(10)
              .fontColor('#333333')
          }
          .alignItems(HorizontalAlign.Center)
        }, (data: WeeklyData) => data.date)
      }
      .width('100%')
      .height(100)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildStudySuggestions() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Image($r('app.media.target_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('学习建议')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      Column({ space: 8 }) {
        this.buildSuggestionItem('保持每日练习习惯，连续学习效果更佳')
        this.buildSuggestionItem('重点关注错误率较高的算法分类')
        this.buildSuggestionItem('定期复习已完成的题目，巩固知识点')
        this.buildSuggestionItem('尝试挑战更高难度的题目')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildSuggestionItem(text: string) {
    Row({ space: 8 }) {
      Text('•')
        .fontSize(14)
        .fontColor('#1890ff')

      Text(text)
        .fontSize(14)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  private async loadStatistics(): Promise<void> {
    try {
      // TODO: 从数据库加载统计数据
      this.studyStats = {
        totalSolved: 25,
        continuousDays: 7,
        totalStudyTime: 480, // 8小时
        averageAccuracy: 78,
        favoriteCount: 12,
        wrongCount: 8
      };

      this.categoryProgress = [
        { categoryName: '数组', icon: $r('app.media.chart_icon'), solved: 8, total: 25, accuracy: 85, color: '#1890ff' },
        { categoryName: '链表', icon: $r('app.media.link_icon'), solved: 3, total: 18, accuracy: 67, color: '#52c41a' },
        { categoryName: '栈队列', icon: $r('app.media.book_icon'), solved: 0, total: 20, accuracy: 0, color: '#fa8c16' },
        { categoryName: '树', icon: $r('app.media.tree_icon'), solved: 0, total: 22, accuracy: 0, color: '#13c2c2' },
        { categoryName: '图', icon: $r('app.media.map_icon'), solved: 0, total: 15, accuracy: 0, color: '#722ed1' },
        { categoryName: '动态规划', icon: $r('app.media.laptop_icon'), solved: 0, total: 30, accuracy: 0, color: '#eb2f96' },
        { categoryName: '贪心', icon: $r('app.media.target_icon'), solved: 0, total: 18, accuracy: 0, color: '#f5222d' },
        { categoryName: '回溯', icon: $r('app.media.star_icon'), solved: 0, total: 12, accuracy: 0, color: '#fa541c' }
      ];

      this.weeklyData = [
        { date: '周一', solved: 3 },
        { date: '周二', solved: 5 },
        { date: '周三', solved: 2 },
        { date: '周四', solved: 4 },
        { date: '周五', solved: 6 },
        { date: '周六', solved: 3 },
        { date: '周日', solved: 2 }
      ];
    } catch (error) {
      console.error('Failed to load statistics:', error);
    }
  }

  private formatStudyTime(minutes: number): string {
    if (minutes < 60) {
      return minutes + '分钟';
    } else {
      const hours = Math.floor(minutes / 60);
      const remainingMinutes = minutes % 60;
      return hours + '小时' + (remainingMinutes > 0 ? remainingMinutes + '分钟' : '');
    }
  }

  private getStudyLevel(): string {
    const solved = this.studyStats.totalSolved;
    if (solved < 10) return '新手';
    if (solved < 30) return '入门';
    if (solved < 60) return '进阶';
    if (solved < 100) return '熟练';
    return '专家';
  }

  private navigateToFavorites(): void {
    // TODO: 导航到收藏页面
    console.info('Navigate to favorites');
  }

  private navigateToWrongProblems(): void {
    // TODO: 导航到错题本
    console.info('Navigate to wrong problems');
  }

  private generateReport(): void {
    // TODO: 生成学习报告
    console.info('Generate study report');
  }
}