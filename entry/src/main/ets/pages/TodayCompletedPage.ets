import { router } from '@kit.ArkUI';
import promptAction from '@ohos.promptAction';
import { UserProgressDao } from '../dao/UserProgressDao';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { ProblemModel } from '../model/ProblemModel';

interface TodayProgress {
  progress: UserProgressModel;
  problem: ProblemModel | null;
}

interface TodayStats {
  totalCompleted: number;
  correctCount: number;
  wrongCount: number;
  accuracy: number;
  studyTime: number; // 分钟
  targetCount: number; // 今日目标
}

@Entry
@Component
struct TodayCompletedPage {
  @State todayStats: TodayStats = {
    totalCompleted: 0,
    correctCount: 0,
    wrongCount: 0,
    accuracy: 0,
    studyTime: 0,
    targetCount: 10
  };
  @State todayProgress: TodayProgress[] = [];
  @State selectedFilter: number = 0; // 0: 全部, 1: 答对, 2: 答错
  @State isLoading: boolean = true;

  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear(): void {
    this.loadTodayData();
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        // 内容区域
        Column({ space: 16 }) {
          // 今日统计卡片
          this.buildStatsCard()

          // 今日目标进度
          this.buildTargetProgress()

          // 过滤器
          this.buildFilterTabs()

          // 今日完成列表
          this.buildTodayList()
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
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
          .fillColor('#333333')
      }
      .width(32)
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Text('今日完成')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank().width(32)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
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
        .color('#F34F40')

      Text('正在加载今日数据...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildStatsCard() {
    Row() {
      Column({ space: 8 }) {
        Text(this.todayStats.totalCompleted.toString())
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F34F40')

        Text('今日完成')
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      Divider()
        .vertical(true)
        .height(50)
        .strokeWidth(1)
        .color('#E5E7EB')

      Column({ space: 8 }) {
        Text(this.todayStats.correctCount.toString())
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#52c41a')

        Text('答对题数')
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      Divider()
        .vertical(true)
        .height(50)
        .strokeWidth(1)
        .color('#E5E7EB')

      Column({ space: 8 }) {
        Text(`${this.todayStats.accuracy}%`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1890ff')

        Text('正确率')
          .fontSize(14)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 2,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildTargetProgress() {
    Column({ space: 12 }) {
      Row() {
        Text('今日目标进度')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)

        Text(`${this.todayStats.totalCompleted}/${this.todayStats.targetCount}`)
          .fontSize(14)
          .fontColor('#F34F40')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')

      Progress({
        value: this.todayStats.totalCompleted,
        total: this.todayStats.targetCount,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(12)
        .color('#F34F40')
        .backgroundColor('#E5E7EB')
        .borderRadius(6)

      Row() {
        if (this.todayStats.totalCompleted >= this.todayStats.targetCount) {
          Row({ space: 8 }) {
            Image($r('app.media.icon_check'))
              .width(16)
              .height(16)
              .fillColor('#52c41a')

            Text('恭喜！今日目标已达成')
              .fontSize(12)
              .fontColor('#52c41a')
          }
        } else {
          Text(`还需完成 ${this.todayStats.targetCount - this.todayStats.totalCompleted} 道题目`)
            .fontSize(12)
            .fontColor('#666666')
        }

        Blank()

        Text(`学习时长: ${this.formatStudyTime(this.todayStats.studyTime)}`)
          .fontSize(12)
          .fontColor('#666666')
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 2,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildFilterTabs() {
    Row() {
      this.buildFilterTab('全部', 0, this.todayStats.totalCompleted)
      this.buildFilterTab('答对', 1, this.todayStats.correctCount)
      this.buildFilterTab('答错', 2, this.todayStats.wrongCount)
    }
    .height(44)
    .backgroundColor('#ffffff')
    .borderRadius(22)
    .shadow({
      radius: 2,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildFilterTab(title: string, index: number, count: number) {
    Row({ space: 4 }) {
      Text(title)
        .fontSize(14)
        .fontColor(this.selectedFilter === index ? '#ffffff' : '#666666')
        .fontWeight(this.selectedFilter === index ? FontWeight.Medium : FontWeight.Normal)

      if (count > 0) {
        Text(count.toString())
          .fontSize(12)
          .fontColor(this.selectedFilter === index ? '#ffffff' : '#999999')
          .padding({ left: 4, right: 4, top: 1, bottom: 1 })
          .backgroundColor(this.selectedFilter === index ? 'rgba(255,255,255,0.2)' : '#F5F5F5')
          .borderRadius(8)
      }
    }
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
    .height('100%')
    .backgroundColor(this.selectedFilter === index ? '#F34F40' : 'transparent')
    .borderRadius(22)
    .onClick(() => {
      this.selectedFilter = index;
    })
  }

  @Builder
  buildTodayList() {
    if (this.getFilteredProgress().length === 0) {
      this.buildEmptyState()
    } else {
      List({ space: 12 }) {
        ForEach(this.getFilteredProgress(), (item: TodayProgress, index: number) => {
          ListItem() {
            this.buildProgressItem(item, index + 1)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
  }

  @Builder
  buildEmptyState() {
    Column({ space: 16 }) {
      Image($r('app.media.icon_empty'))
        .width(120)
        .height(90)

      Text(this.getEmptyText())
        .fontSize(16)
        .fontColor('#666666')

      Text('继续努力，完成更多题目吧！')
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildProgressItem(item: TodayProgress, sequence: number) {
    Row({ space: 12 }) {
      // 序号和状态
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(item.progress.status === ProblemStatus.COMPLETED ? '#52c41a' : '#ff4757')

        if (item.progress.status === ProblemStatus.COMPLETED) {
          Image($r('app.media.icon_check'))
            .width(16)
            .height(16)
            .fillColor('#ffffff')
        } else {
          Text('×')
            .fontSize(16)
            .fontColor('#ffffff')
            .fontWeight(FontWeight.Bold)
        }
      }

      // 题目信息
      Column({ space: 6 }) {
        Row() {
          Text(`${sequence}. ${item.problem?.title || '未知题目'}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)

          Text(item.problem?.getDifficultyText() || '')
            .fontSize(12)
            .fontColor('#ffffff')
            .backgroundColor(item.problem?.getDifficultyColor() || '#999999')
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)
        }
        .width('100%')

        Row({ space: 12 }) {
          Text(item.problem?.getCategoryText() || '')
            .fontSize(12)
            .fontColor('#666666')

          Text(this.formatTime(item.progress.lastAttempted))
            .fontSize(12)
            .fontColor('#999999')

          Text('用时: 估算' + (item.progress.attemptCount * 2) + '分钟') // 根据尝试次数估算
            .fontSize(12)
            .fontColor('#999999')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 查看详情按钮
      Button() {
        Image($r('app.media.icon_right_arrow'))
          .width(16)
          .height(16)
          .fillColor('#666666')
      }
      .backgroundColor('transparent')
      .width(32)
      .height(32)
      .onClick(() => {
        this.navigateToProblemDetail(item.problem?.id || 0);
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 2,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  // 加载今日数据
  private async loadTodayData(): Promise<void> {
    try {
      this.isLoading = true;
      console.info('📅 开始加载今日完成数据');

      // 获取今日完成的题目进度
      const todayProgressList = await this.userProgressDao.getTodayCompletedProgress();
      
      // 关联题目信息
      const progressWithProblems: TodayProgress[] = [];
      for (const progress of todayProgressList) {
        const problem = ProblemMockData.getProblemById(progress.problemId);
        progressWithProblems.push({
          progress: progress,
          problem: problem
        });
      }

      this.todayProgress = progressWithProblems;

      // 计算统计数据
      this.calculateTodayStats();

      console.info('✅ 今日完成数据加载完成');
    } catch (error) {
      console.error('❌ 加载今日完成数据失败:', error);
      promptAction.showToast({
        message: '加载数据失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }

  // 计算今日统计
  private calculateTodayStats(): void {
    const totalCompleted = this.todayProgress.length;
    const correctCount = this.todayProgress.filter((item: TodayProgress): boolean => {
      return item.progress.status === ProblemStatus.COMPLETED;
    }).length;
    const wrongCount = totalCompleted - correctCount;
    const accuracy = totalCompleted > 0 ? Math.round((correctCount / totalCompleted) * 100) : 0;
    
    // 计算学习时长（根据尝试次数估算）
    const studyTime = this.todayProgress.reduce((total: number, item: TodayProgress): number => {
      return total + (item.progress.attemptCount * 2); // 估算每次尝试2分钟
    }, 0);

    this.todayStats = {
      totalCompleted: totalCompleted,
      correctCount: correctCount,
      wrongCount: wrongCount,
      accuracy: accuracy,
      studyTime: Math.ceil(studyTime / 60), // 转换为分钟
      targetCount: 10
    };
  }

  // 获取过滤后的进度列表
  private getFilteredProgress(): TodayProgress[] {
    switch (this.selectedFilter) {
      case 1: // 答对
        return this.todayProgress.filter((item: TodayProgress): boolean => {
          return item.progress.status === ProblemStatus.COMPLETED;
        });
      case 2: // 答错
        return this.todayProgress.filter((item: TodayProgress): boolean => {
          return item.progress.status === ProblemStatus.WRONG;
        });
      default: // 全部
        return this.todayProgress;
    }
  }

  // 获取空状态文本
  private getEmptyText(): string {
    switch (this.selectedFilter) {
      case 1:
        return '今日还没有答对的题目';
      case 2:
        return '今日没有答错题目，真棒！';
      default:
        return '今日还没有完成任何题目';
    }
  }

  // 格式化学习时长
  private formatStudyTime(minutes: number): string {
    if (minutes < 60) {
      return `${minutes}分钟`;
    } else {
      const hours = Math.floor(minutes / 60);
      const remainingMinutes = minutes % 60;
      return `${hours}小时${remainingMinutes > 0 ? remainingMinutes + '分钟' : ''}`;
    }
  }

  // 格式化时间
  private formatTime(dateString: string): string {
    const date = new Date(dateString);
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return `${hours}:${minutes}`;
  }

  // 格式化做题用时
  private formatDuration(seconds: number): string {
    if (seconds < 60) {
      return `${seconds}秒`;
    } else {
      const minutes = Math.floor(seconds / 60);
      const remainingSeconds = seconds % 60;
      return `${minutes}分${remainingSeconds}秒`;
    }
  }

  // 导航到题目详情
  private navigateToProblemDetail(problemId: number): void {
    if (problemId > 0) {
      router.pushUrl({
        url: 'pages/ProblemDetailPage',
        params: {
          problemId: problemId,
          fromToday: true
        }
      }).catch((error: Error) => {
        console.error('导航失败:', error);
      });
    }
  }
}