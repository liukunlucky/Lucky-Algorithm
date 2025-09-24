import { ProblemModel, ProblemDifficulty, ProblemCategory } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { TabNavigationService } from '../service/TabNavigationService';
import router from '@ohos.router';

@Component
export struct TodayPracticePage {
  @State dailyProblem: ProblemModel | null = null;
  @State reviewProblem: ProblemModel | null = null;
  @State continuousDays: number = 0;
  @State totalSolved: number = 0;
  @State todayCompleted: number = 0;
  @State isDailyProblemCompleted: boolean = false;
  @StorageLink('refreshTodayPage') @Watch('onRefreshTrigger') refreshTrigger: number = 0;

  // 使用mock数据，不再需要数据库实例
  private userProgressDao: UserProgressDao = new UserProgressDao();

  async aboutToAppear() {
    this.loadTodayData();
  }

  /**
   * 监听页面刷新触发器
   */
  onRefreshTrigger() {
    if (this.refreshTrigger > 0) {
      console.info('首页数据刷新触发');
      this.loadTodayData();
      // 清除触发器
      AppStorage.setOrCreate('refreshTodayPage', 0);
    }
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
    .onClick(() => {
      if (this.reviewProblem) {
        this.navigateToProblemDetail(this.reviewProblem.id);
      }
    })
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
        this.buildContinuousDayStatItem('连续学习', '#ff6b35')
        this.buildTotalSoledStatItem('总攻克题数', '#1890ff')
        this.buildTodayCompletedStatItem('今日完成', '#52c41a')
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
  buildContinuousDayStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.continuousDays}天`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.navigateToPage('pages/ContinuousStudyPage');
    })
  }

  @Builder
  buildTotalSoledStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.totalSolved}题`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.navigateToPage('pages/TotalSolvedPage');
    })
  }

  @Builder
  buildTodayCompletedStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.todayCompleted}题`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.navigateToPage('pages/TodayCompletedPage');
    })
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

      // 第一行
      Row({ space: 16 }) {
        this.buildQuickActionItem($r('app.media.icon_like'), '收藏夹', () => {
          this.navigateToPage('pages/FavoritesPage');
        })

        this.buildQuickActionItem($r('app.media.icon_error'), '错题本', () => {
          this.navigateToPage('pages/WrongProblemsPage');
        })

        this.buildQuickActionItem($r('app.media.icon_note'), '学习笔记', () => {
          this.navigateToPage('pages/StudyNotesPage');
        })

        this.buildQuickActionItem($r('app.media.icon_exam'), '模拟考试', () => {
          console.info('点击模拟考试');
          const tabNavigationService = TabNavigationService.getInstance();
          tabNavigationService.switchToExam();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      // 第二行
      Row({ space: 16 }) {
        this.buildQuickActionItem($r('app.media.icon_tj'), '数据统计', () => {
          this.navigateToPage('pages/StatisticsPage');
        })

        // 占位符，保持对齐
        Column()
          .width(60)
          .height(60)

        Column()
          .width(60)
          .height(60)

        Column()
          .width(60)
          .height(60)
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
      console.info('开始加载首页数据');
      // 加载每日题目
      await this.loadDailyProblem();

      // 加载复习题目
      await this.loadReviewProblem();

      // 加载学习统计
      await this.loadStudyStats();

      console.info('首页数据加载完成');
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
      console.info('🔄 开始加载复习题目');
      // 获取用户做错的题目进行复习
      const wrongProblems = await this.userProgressDao.getWrongProblems();
      console.info(`📊 错题数量：${wrongProblems.length}`);
      console.info('📝 错题列表：', wrongProblems.map(p => `ID:${p.problemId}, 状态:${p.status}`));

      if (wrongProblems.length > 0) {
        // 随机选择一个错题
        const randomIndex = Math.floor(Math.random() * wrongProblems.length);
        const selectedWrongProblem = wrongProblems[randomIndex];
        const problemId = selectedWrongProblem.problemId;
        console.info(`🎯 随机选中错题ID: ${problemId} (索引: ${randomIndex})`);

        this.reviewProblem = ProblemMockData.getProblemById(problemId);
        if (this.reviewProblem) {
          console.info(`✅ 复习题目加载成功: ${this.reviewProblem.title}`);
        } else {
          console.error(`❌ 找不到题目ID ${problemId} 对应的题目信息`);
          this.reviewProblem = null;
        }
      } else {
        this.reviewProblem = null;
        console.info('🔴 暂无错题需要复习');
      }
    } catch (error) {
      console.error('❌ 加载复习题目失败:', error);
      this.reviewProblem = null;
    }
  }

  private async loadStudyStats(): Promise<void> {
    try {
      console.info('📊 开始加载学习统计数据');
      // 获取用户学习统计
      const totalSolvedResult = await this.userProgressDao.getCompletedCount();
      const todayCompletedResult = await this.userProgressDao.getTodayCompletedCount();
      const continuousDaysResult = await this.userProgressDao.getContinuousDays();

      console.info('📋 查询结果 - 连续天数:', continuousDaysResult, '类型:', typeof continuousDaysResult);
      console.info('📋 查询结果 - 总题数:', totalSolvedResult, '类型:', typeof totalSolvedResult);
      console.info('📋 查询结果 - 今日完成:', todayCompletedResult, '类型:', typeof todayCompletedResult);

      console.info('🔄 更新前的数据:', `连续:${this.continuousDays}, 总数:${this.totalSolved}, 今日:${this.todayCompleted}`);

      // 直接更新各个状态变量
      this.continuousDays = parseInt(String(continuousDaysResult)) || 0;
      this.totalSolved = parseInt(String(totalSolvedResult)) || 0;
      this.todayCompleted = parseInt(String(todayCompletedResult)) || 0;

      console.info('✅ 更新后的数据:', `连续:${this.continuousDays}, 总数:${this.totalSolved}, 今日:${this.todayCompleted}`);

      console.info('学习统计：连续天数', this.continuousDays);
      console.info('学习统计：总题数', this.totalSolved);
      console.info('学习统计：今日完成', this.todayCompleted);

      // const all = await this.userProgressDao.getAllUserProgress()
      // console.log('lucky all haha' + JSON.stringify(all) )
    } catch (error) {
      console.error('❌ 加载学习统计失败:', error);
      // 使用默认数据
      this.continuousDays = 1;
      this.totalSolved = 0;
      this.todayCompleted = 0;
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