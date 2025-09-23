import router from '@ohos.router';
import { UserProgressDao } from '../dao/UserProgressDao';

interface PracticeDay {
  date: string;
  problems: number;
  accuracy: number;
}

interface WeeklyStats {
  week: string;
  totalProblems: number;
  averageAccuracy: number;
  streakDays: number;
}

@Entry
@Component
struct PracticeTrendPage {
  @State recentDays: PracticeDay[] = [];
  @State weeklyStats: WeeklyStats[] = [];
  @State isLoading: boolean = true;
  @State currentTab: number = 0; // 0: 每日, 1: 每周
  @State totalStats: {
    totalDays: number;
    currentStreak: number;
    maxStreak: number;
    averageDaily: number;
  } = {
    totalDays: 0,
    currentStreak: 0,
    maxStreak: 0,
    averageDaily: 0
  };

  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadTrendData();
  }

  build() {
    Column({ space: 0 }) {
      // 顶部导航栏
      this.buildHeader()

      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        Column({ space: 0 }) {
          // Tab切换
          this.buildTabBar()

          // 内容区域
          Scroll() {
            Column({ space: 16 }) {
              // 统计概览
              this.buildStatsOverview()

              // 趋势内容
              if (this.currentTab === 0) {
                this.buildDailyTrend()
              } else {
                this.buildWeeklyTrend()
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  @Builder
  buildHeader() {
    Row() {
      Button() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
      }
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Text('练习趋势')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank().width(32)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .shadow({
      radius: 2,
      color: '#00000010',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#1890ff')

      Text('正在加载趋势数据...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildTabBar() {
    Row() {
      ForEach(['每日趋势', '每周统计'], (title: string, index: number) => {
        Button(title)
          .fontSize(14)
          .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.currentTab === index ? '#1890ff' : '#666666')
          .backgroundColor('transparent')
          .layoutWeight(1)
          .height(40)
          .border({
            width: { bottom: this.currentTab === index ? 2 : 0 },
            color: '#1890ff'
          })
          .onClick(() => {
            this.currentTab = index;
          })
      }, (title: string) => title)
    }
    .width('100%')
    .backgroundColor('#ffffff')
    .shadow({
      radius: 1,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildStatsOverview() {
    Column({ space: 16 }) {
      Text('学习概览')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      Row({ space: 12 }) {
        // 总学习天数
        Column({ space: 4 }) {
          Text(this.totalStats.totalDays.toString())
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1890ff')

          Text('学习天数')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding(12)
        .backgroundColor('#ffffff')
        .borderRadius(8)

        // 当前连续
        Column({ space: 4 }) {
          Text(this.totalStats.currentStreak.toString())
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('当前连续')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding(12)
        .backgroundColor('#ffffff')
        .borderRadius(8)

        // 最长连续
        Column({ space: 4 }) {
          Text(this.totalStats.maxStreak.toString())
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fa8c16')

          Text('最长连续')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding(12)
        .backgroundColor('#ffffff')
        .borderRadius(8)

        // 日均题数
        Column({ space: 4 }) {
          Text(this.totalStats.averageDaily.toFixed(1))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#722ed1')

          Text('日均题数')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding(12)
        .backgroundColor('#ffffff')
        .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  buildDailyTrend() {
    Column({ space: 12 }) {
      Text('最近7天练习情况')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      if (this.recentDays.length === 0) {
        Column({ space: 8 }) {
          Text('📊')
            .fontSize(32)

          Text('暂无练习数据')
            .fontSize(14)
            .fontColor('#999999')

          Text('开始练习题目后，这里将显示您的学习趋势')
            .fontSize(12)
            .fontColor('#cccccc')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ffffff')
        .borderRadius(8)
      } else {
        Column({ space: 8 }) {
          ForEach(this.recentDays, (day: PracticeDay) => {
            this.buildDayItem(day)
          }, (day: PracticeDay) => day.date)
        }
        .width('100%')
      }
    }
    .width('100%')
  }

  @Builder
  buildDayItem(day: PracticeDay) {
    Row({ space: 12 }) {
      // 日期
      Column({ space: 2 }) {
        Text(this.formatDate(day.date))
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Text(this.getDayOfWeek(day.date))
          .fontSize(12)
          .fontColor('#666666')
      }
      .width(60)
      .alignItems(HorizontalAlign.Start)

      // 练习情况
      Column({ space: 4 }) {
        Row({ space: 8 }) {
          Text(`${day.problems}题`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          if (day.problems > 0) {
            Text(`${day.accuracy.toFixed(1)}%`)
              .fontSize(12)
              .fontColor(this.getAccuracyColor(day.accuracy))
              .backgroundColor(this.getAccuracyColor(day.accuracy) + '20')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(10)
          }
        }

        // 进度条
        Progress({
          value: day.problems,
          total: 10, // 假设每天目标10题
          type: ProgressType.Linear
        })
        .width('100%')
        .height(4)
        .color(day.problems >= 10 ? '#52c41a' : '#1890ff')
        .backgroundColor('#f0f0f0')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .border({ width: 1, color: '#f0f0f0' })
  }

  @Builder
  buildWeeklyTrend() {
    Column({ space: 12 }) {
      Text('最近4周统计')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      if (this.weeklyStats.length === 0) {
        Column({ space: 8 }) {
          Text('📈')
            .fontSize(32)

          Text('暂无周统计数据')
            .fontSize(14)
            .fontColor('#999999')

          Text('继续练习一周后，这里将显示您的周统计')
            .fontSize(12)
            .fontColor('#cccccc')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ffffff')
        .borderRadius(8)
      } else {
        Column({ space: 8 }) {
          ForEach(this.weeklyStats, (week: WeeklyStats) => {
            this.buildWeekItem(week)
          }, (week: WeeklyStats) => week.week)
        }
        .width('100%')
      }
    }
    .width('100%')
  }

  @Builder
  buildWeekItem(week: WeeklyStats) {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text(week.week)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Blank()

        Text(`${week.streakDays}天连续`)
          .fontSize(12)
          .fontColor('#52c41a')
          .backgroundColor('#52c41a20')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(10)
      }
      .width('100%')

      Row({ space: 20 }) {
        Column({ space: 4 }) {
          Text(week.totalProblems.toString())
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1890ff')

          Text('总题数')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: 4 }) {
          Text(week.averageAccuracy.toFixed(1) + '%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fa8c16')

          Text('平均正确率')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: 4 }) {
          Text((week.totalProblems / 7).toFixed(1))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#722ed1')

          Text('日均题数')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .border({ width: 1, color: '#f0f0f0' })
  }

  private async loadTrendData() {
    try {
      this.isLoading = true;
      
      // 生成模拟数据
      await this.generateMockData();
      
    } catch (error) {
      console.error('Failed to load trend data:', error);
    } finally {
      this.isLoading = false;
    }
  }

  private async generateMockData() {
    // 生成最近7天的模拟数据
    const days: PracticeDay[] = [];
    const today = new Date();
    
    for (let i = 6; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(date.getDate() - i);
      
      const problems = Math.floor(Math.random() * 8) + 2; // 2-10题
      const accuracy = Math.floor(Math.random() * 40) + 60; // 60-100%
      
      days.push({
        date: date.toISOString().split('T')[0],
        problems: problems,
        accuracy: accuracy
      });
    }
    
    this.recentDays = days;

    // 生成最近4周的模拟数据
    const weeks: WeeklyStats[] = [];
    for (let i = 3; i >= 0; i--) {
      const weekStart = new Date(today);
      weekStart.setDate(weekStart.getDate() - (i * 7 + 6));
      
      weeks.push({
        week: `第${4-i}周 (${this.formatWeekRange(weekStart)})`,
        totalProblems: Math.floor(Math.random() * 30) + 20,
        averageAccuracy: Math.floor(Math.random() * 25) + 70,
        streakDays: Math.floor(Math.random() * 7) + 1
      });
    }
    
    this.weeklyStats = weeks;

    // 计算总体统计
    const totalProblems = days.reduce((sum, day) => sum + day.problems, 0);
    this.totalStats = {
      totalDays: days.filter(day => day.problems > 0).length,
      currentStreak: this.calculateCurrentStreak(days),
      maxStreak: 5, // 模拟数据
      averageDaily: totalProblems / 7
    };
  }

  private calculateCurrentStreak(days: PracticeDay[]): number {
    let streak = 0;
    for (let i = days.length - 1; i >= 0; i--) {
      if (days[i].problems > 0) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  private formatDate(dateStr: string): string {
    const date = new Date(dateStr);
    return `${date.getMonth() + 1}/${date.getDate()}`;
  }

  private getDayOfWeek(dateStr: string): string {
    const days = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    const date = new Date(dateStr);
    return days[date.getDay()];
  }

  private formatWeekRange(startDate: Date): string {
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + 6);
    
    return `${startDate.getMonth() + 1}/${startDate.getDate()}-${endDate.getMonth() + 1}/${endDate.getDate()}`;
  }

  private getAccuracyColor(accuracy: number): string {
    if (accuracy >= 80) return '#52c41a';
    if (accuracy >= 60) return '#fa8c16';
    return '#ff7875';
  }
}