import { ProblemModel, ProblemDifficulty, ProblemCategory } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { TabNavigationService } from '../service/TabNavigationService';
import router from '@ohos.router';

interface StudyStats {
  continuousDays: number;
  totalSolved: number;
  todayCompleted: number;
}

@Component
export struct TodayPracticePage {
  @State dailyProblem: ProblemModel | null = null;
  @State reviewProblem: ProblemModel | null = null;
  @State studyStats: StudyStats = {
    continuousDays: 0,
    totalSolved: 0,
    todayCompleted: 0
  };
  @State isDailyProblemCompleted: boolean = false;
  
  // 使用mock数据，不再需要数据库实例
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadTodayData();
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        // 顶部横幅
        this.buildHeader()

        // 每日一题卡片
        this.buildDailyProblemCard()

        // 随机复习卡片
        this.buildReviewCard()

        // 学习状态卡片
        this.buildStudyStatsCard()

        // 快捷入口
        this.buildQuickActions()

        // 底部留白，确保最后一个元素不会被遮挡
        Column()
          .height(30)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 20, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  buildHeader() {
    Column({ space: 8 }) {
      Text(this.getCurrentDateText())
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)

      Row({ space: 8 }) {
        Text('开启今日的练习吧')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  buildDailyProblemCard() {
    Column({ space: 12 }) {
      Row() {
        Row({ space: 8 }) {
          Text('每日一题')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        
        Blank()
        
        Text('推荐')
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor('#ff6b35')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(10)
      }
      .width('100%')

      if (this.dailyProblem) {
        Column({ space: 12 }) {
          // 题目标题区域
          Column({ space: 8 }) {
            Text(this.dailyProblem.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(22)

            // 标签区域 - 增强视觉一体性
            Row({ space: 8 }) {
              Text(this.dailyProblem.getDifficultyText())
                .fontSize(12)
                .fontColor('#ffffff')
                .backgroundColor(this.dailyProblem.getDifficultyColor())
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(6)

              Text(this.dailyProblem.getCategoryText())
                .fontSize(12)
                .fontColor('#FFFFFF')
                .backgroundColor('#787408')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(6)
            }
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          if (this.isDailyProblemCompleted) {
            // 已完成状态的UI
            Row({ space: 8 }) {
              Image($r('app.media.icon_check'))
                .width(16)
                .height(16)
                .fillColor('#52c41a')
              
              Text('今日已完成')
                .fontSize(14)
                .fontColor('#52c41a')
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height(40)
            .backgroundColor('#f6ffed')
            .borderRadius(8)
            .border({ width: 1, color: '#b7eb8f' })

            Button('查看详情')
              .width('100%')
              .height(40)
              .backgroundColor('#52c41a')
              .fontColor('#ffffff')
              .borderRadius(8)
              .margin({ top: 8 })
              .onClick(() => {
                this.navigateToDailyProblem(this.dailyProblem!.id);
              })
          } else {
            // 未完成状态的UI
            Button('开始挑战')
              .width('100%')
              .height(40)
              .backgroundColor('#F34F40')
              .borderRadius(8)
              .onClick(() => {
                this.navigateToDailyProblem(this.dailyProblem!.id);
              })
          }
        }
        .alignItems(HorizontalAlign.Start)
      } else {
        Text('正在加载今日题目...')
          .fontSize(14)
          .fontColor('#999999')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(80)
      }
    }
      .width('100%')
      .padding(16)
      .backgroundColor('#ffffff')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
      .onClick(() => {
        if (this.dailyProblem) {
          this.navigateToDailyProblem(this.dailyProblem.id);
        }
      })
    }

  @Builder
  buildReviewCard() {
    Column({ space: 12 }) {
      Row() {
        Row({ space: 8 }) {
          Text('随机复习')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        
        Blank()
        
        if (this.reviewProblem) {
          Text('来自错题本')
            .fontSize(12)
            .fontColor('#ffffff')
            .backgroundColor('#ff6b35')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(10)
        }
      }
      .width('100%')

      if (this.reviewProblem) {
        Column({ space: 12 }) {
          // 题目标题区域
          Column({ space: 8 }) {
            Text(this.reviewProblem.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(22)

            // 标签区域 - 增强视觉一体性
            Row({ space: 8 }) {
              Text(this.reviewProblem.getDifficultyText())
                .fontSize(12)
                .fontColor('#ffffff')
                .backgroundColor(this.reviewProblem.getDifficultyColor())
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(6)

              Text(this.reviewProblem.getCategoryText())
                .fontSize(12)
                .fontColor('#FFFFFF')
                .backgroundColor('#787408')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .borderRadius(6)
            }
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Button('开始复习')
            .width('100%')
            .height(40)
            .backgroundColor('#F34F40')
            .borderRadius(8)
            .onClick(() => {
              this.navigateToProblemDetail(this.reviewProblem!.id);
            })
        }
        .alignItems(HorizontalAlign.Start)
      } else {
        Column({ space: 8 }) {
          Text('暂无需要复习的题目')
            .fontSize(14)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)

          Text('完成更多练习后会有复习推荐')
            .fontSize(12)
            .fontColor('#cccccc')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildStudyStatsCard() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('学习状态')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Row({ space: 16 }) {
        this.buildStatItem('连续学习', this.studyStats.continuousDays + '天', '#ff6b35')
        this.buildStatItem('总攻克题数', this.studyStats.totalSolved + '题', '#1890ff')
        this.buildStatItem('今日完成', this.studyStats.todayCompleted + '题', '#52c41a')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      // 跳转到统计页面
      console.info('Navigate to statistics page');
    })
  }

  @Builder
  buildStatItem(title: string, value: string, color: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(20)
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
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('快捷入口')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Row({ space: 16 }) {
        this.buildQuickActionItem($r('app.media.icon_like'), '收藏夹', () => {
          this.navigateToPage('pages/FavoritesPage');
        })

        this.buildQuickActionItem($r('app.media.icon_error'), '错题本', () => {
          this.navigateToPage('pages/WrongProblemsPage');
        })

        this.buildQuickActionItem($r('app.media.icon_train_center'), '专项练习', () => {
          const tabNavigationService = TabNavigationService.getInstance();
          tabNavigationService.switchToPracticeCenter();
        })

        this.buildQuickActionItem($r('app.media.icon_exam'), '模拟考试', () => {
          const tabNavigationService = TabNavigationService.getInstance();
          tabNavigationService.switchToExam();
        })
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
  buildQuickActionItem(iconResource: Resource, title: string, onClick: () => void) {
    Column({ space: 8 }) {
      Image(iconResource)
        .width(24)
        .height(24)
        .fillColor('#666666')

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .width(60)
    .height(60)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
    .onClick(onClick)
  }

  private getCurrentDateText(): string {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth() + 1;
    const day = now.getDate();
    const weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    const weekday = weekdays[now.getDay()];
    
    return `${year}年${month}月${day}日 ${weekday}`;
  }

  private async loadTodayData(): Promise<void> {
    try {
      // 加载每日题目
      await this.loadDailyProblem();
      
      // 加载复习题目
      await this.loadReviewProblem();
      
      // 加载学习统计
      await this.loadStudyStats();
    } catch (error) {
      console.error('Failed to load today data:', error);
    }
  }

  private async loadDailyProblem(): Promise<void> {
    try {
      // 获取所有可用的题目
      const allProblems = ProblemMockData.getAllProblems();
      if (allProblems.length === 0) {
        this.dailyProblem = this.createDefaultProblem();
        return;
      }
      
      // 根据日期生成每日题目索引（使用实际题目数量）
      const today = new Date();
      const dayOfYear = Math.floor((today.getTime() - new Date(today.getFullYear(), 0, 0).getTime()) / 86400000);
      const problemIndex = dayOfYear % allProblems.length;
      
      this.dailyProblem = allProblems[problemIndex];
      
      // 如果仍然没有找到题目，使用第一题作为默认
      if (!this.dailyProblem) {
        this.dailyProblem = allProblems[0];
      }

      // 检查每日题目是否已完成
      if (this.dailyProblem) {
        await this.checkDailyProblemStatus();
      }
    } catch (error) {
      console.error('Failed to load daily problem:', error);
      // 创建一个默认题目
      this.dailyProblem = this.createDefaultProblem();
    }
  }

  // 检查每日题目完成状态
  private async checkDailyProblemStatus(): Promise<void> {
    if (!this.dailyProblem) return;
    
    try {
      const progress = await this.userProgressDao.getUserProgress(this.dailyProblem.id);
      // 检查今天是否已经完成该题目
      if (progress && progress.status === ProblemStatus.COMPLETED) {
        const today = new Date();
        const completedDate = new Date(progress.lastAttempted);
        // 判断是否是今天完成的
        const isCompletedToday = today.toDateString() === completedDate.toDateString();
        this.isDailyProblemCompleted = isCompletedToday;
      } else {
        this.isDailyProblemCompleted = false;
      }
    } catch (error) {
      console.error('Failed to check daily problem status:', error);
      this.isDailyProblemCompleted = false;
    }
  }

  private async loadReviewProblem(): Promise<void> {
    try {
      // 获取用户做错的题目进行复习
      const wrongProblems = await this.userProgressDao.getWrongProblems();
      if (wrongProblems.length > 0) {
        // 随机选择一个错题
        const randomIndex = Math.floor(Math.random() * wrongProblems.length);
        const problemId = wrongProblems[randomIndex].problemId;
        this.reviewProblem = ProblemMockData.getProblemById(problemId);
      }
    } catch (error) {
      console.error('Failed to load review problem:', error);
    }
  }

  private async loadStudyStats(): Promise<void> {
    try {
      // 获取用户学习统计
      const totalSolved = await this.userProgressDao.getCompletedCount();
      const todayCompleted = await this.userProgressDao.getTodayCompletedCount();
      const continuousDays = await this.userProgressDao.getContinuousDays();
      
      const stats: StudyStats = {
        continuousDays: continuousDays,
        totalSolved: totalSolved,
        todayCompleted: todayCompleted
      };
      this.studyStats = stats;
    } catch (error) {
      console.error('Failed to load study stats:', error);
      // 使用默认数据
      const defaultStats: StudyStats = {
        continuousDays: 1,
        totalSolved: 0,
        todayCompleted: 0
      };
      this.studyStats = defaultStats;
    }
  }

  private createDefaultProblem(): ProblemModel {
    const problem = new ProblemModel();
    problem.id = 1;
    problem.title = '两数之和';
    problem.description = '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。';
    problem.difficulty = ProblemDifficulty.EASY;
    problem.category = ProblemCategory.ARRAY;
    return problem;
  }

  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: { problemId: problemId }
    }).catch((error: Error) => {
      console.error('Failed to navigate to problem detail:', error);
    });
  }

  private navigateToDailyProblem(problemId: number): void {
    router.pushUrl({
      url: 'pages/DailyProblemPage',
      params: { problemId: problemId }
    }).catch((error: Error) => {
      console.error('Failed to navigate to daily problem:', error);
    });
  }

  private navigateToPage(url: string): void {
    router.pushUrl({
      url: url
    }).catch((error: Error) => {
      console.error('Failed to navigate to page:', error);
    });
  }
}