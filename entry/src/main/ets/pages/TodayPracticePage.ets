import { ProblemModel, ProblemDifficulty, ProblemCategory } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { TabNavigationService } from '../service/TabNavigationService';
import { TimeUtils } from '../utils/TimeUtils';
import router from '@ohos.router';

interface CategoryInfo {
  key: ProblemCategory;
  name: string;
}

@Component
export struct TodayPracticePage {
  @State dailyProblem: ProblemModel | null = null;
  @State reviewProblem: ProblemModel | null = null;
  @State continuousDays: number = 0;
  @State totalSolved: number = 0;
  @State todayCompleted: number = 0;
  @State isDailyProblemCompleted: boolean = false;
  @StorageLink('refreshTodayPage') @Watch('onRefreshTrigger') refreshTrigger: number = 0;
  
  // 分类进度数据
  @State categoryProgress: Map<string, number> = new Map();

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
        // 顶部日期和欢迎语
        this.buildHeader()

        // 功能图标网格（3行4列，共9个图标）
        this.buildFunctionGrid()

        // 每日一题卡片
        this.buildDailyProblemCard()

        // 随机复习卡片
        this.buildReviewCard()

        // 学习状态卡片
        this.buildStudyStatsCard()

        // 当前学习进度
        this.buildStudyProgressCard()

        // 底部留白，确保最后一个元素不会被遮挡
        Column()
          .height(30)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
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
    .borderRadius({bottomLeft: 16, bottomRight: 16})
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  buildDailyProblemCard() {
    Stack() {
      Column({ space: 16 }) {
        // 卡片头部
        Row() {
          Row({ space: 12 }) {
            // 图标背景
            Column() {
              Image($r('app.media.icon_rl')).width(26).height(26).fillColor('#FFFFFF')
            }
            .width(48)
            .height(48)
            .backgroundColor('#FF6B35')
            .borderRadius(24)
            .justifyContent(FlexAlign.Center)

            Column({ space: 4 }) {
              Text('每日一题')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6B35')

              Text('坚持每日练习，提升算法能力')
                .fontSize(12)
                .fontColor('#8c8c8c')
            }
            .alignItems(HorizontalAlign.Start)
          }

          Blank()

          if (this.dailyProblem && !this.isDailyProblemCompleted) {
            Column() {
              Text('开始')
                .fontSize(14)
                .fontColor('#ffffff')
                .fontWeight(FontWeight.Medium)
            }
            .width(60)
            .height(32)
            .backgroundColor('#FF6B35')
            .borderRadius(16)
            .justifyContent(FlexAlign.Center)
          }
        }
        .width('100%')

      if (this.dailyProblem) {
        Column({ space: 16 }) {
          // 题目内容区域
          Column({ space: 12 }) {
            Text(this.dailyProblem.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#262626')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(24)

            // 标签区域
            Row({ space: 12 }) {
              Row({ space: 6 }) {
                Text(this.dailyProblem.getDifficultyText())
                  .fontSize(12)
                  .fontColor('#ffffff')
                  .backgroundColor(this.dailyProblem.getDifficultyColor())
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4)
              }

              Row({ space: 6 }) {
                Text(this.dailyProblem.getCategoryText())
                  .fontSize(12)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#787408')
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4)
              }
            }
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          if (this.isDailyProblemCompleted) {
            // 已完成状态的UI
            Row({ space: 12 }) {
              Image($r('app.media.icon_wc')).width(26).height(26).fillColor('#52c41a')

              Column({ space: 2 }) {
                Text('今日挑战已完成')
                  .fontSize(15)
                  .fontColor('#52c41a')
                  .fontWeight(FontWeight.Medium)

                Text('明天继续加油！')
                  .fontSize(12)
                  .fontColor('#8c8c8c')
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#f6ffed')
            .borderRadius(12)
            .border({ width: 1, color: '#d9f7be' })
          }
        }
        .alignItems(HorizontalAlign.Start)
      } else {
        Row({ space: 12 }) {
          Text('⏳')
            .fontSize(20)

          Text('正在为您准备今日题目...')
            .fontSize(14)
            .fontColor('#8c8c8c')
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.Center)
      }
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#ffffff')
      .borderRadius(16)
      .shadow({ radius: 8, color: '#00000008', offsetX: 0, offsetY: 4 })

      // 完成状态图标 - 右上角
      if (this.isDailyProblemCompleted) {
        Row() {
          Image($r('app.media.icon_complete'))
            .width(78)
            .fillColor(Color.Red)
            .height(78)
            .zIndex(10)
        }
        .width(100)
        .height(100)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

      }
    }
    .alignContent(Alignment.TopEnd)
    .onClick(() => {
      if (this.dailyProblem) {
        this.navigateToDailyProblem(this.dailyProblem.id);
      }
    })
  }

  @Builder
  buildReviewCard() {
    Column({ space: 16 }) {
      // 卡片头部
      Row() {
        Row({ space: 12 }) {
          // 图标背景
          Column() {
            Image($r('app.media.icon_fx')).width(26).height(26).fillColor('#FFFFFF')
          }
          .width(48)
          .height(48)
          .backgroundColor('#fa8c16')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)

          Column({ space: 4 }) {
            Text('智能复习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#fa8c16')

            Text('巩固薄弱知识点，提升解题能力')
              .fontSize(12)
              .fontColor('#8c8c8c')
          }
          .alignItems(HorizontalAlign.Start)
        }

        Blank()

        if (this.reviewProblem) {
          Column() {
            Text('复习')
              .fontSize(14)
              .fontColor('#ffffff')
              .fontWeight(FontWeight.Medium)
          }
          .width(60)
          .height(32)
          .backgroundColor('#fa8c16')
          .borderRadius(16)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')

      if (this.reviewProblem) {
        Column({ space: 16 }) {
          // 题目内容区域
          Column({ space: 12 }) {
            Text(this.reviewProblem.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#262626')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(24)

            // 标签区域
            Row({ space: 12 }) {
              Row({ space: 6 }) {
                Text(this.reviewProblem.getDifficultyText())
                  .fontSize(12)
                  .fontColor('#ffffff')
                  .backgroundColor(this.reviewProblem.getDifficultyColor())
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4)
              }

              Row({ space: 6 }) {
                Text(this.reviewProblem.getCategoryText())
                  .fontSize(12)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#787408')
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4)
              }
            }
            .justifyContent(FlexAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // 复习提示
          Row({ space: 12 }) {
            Text('来自错题本，建议重点复习')
              .fontSize(13)
              .fontColor('#fa8c16')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#fff7e6')
          .borderRadius(8)
          .border({ width: 1, color: '#ffd591' })
        }
        .alignItems(HorizontalAlign.Start)
      } else {
        Column({ space: 12 }) {
          Image($r('app.media.icon_empty'))
            .width(58)
            .height(42)

          Column({ space: 6 }) {
            Text('暂无需要复习的题目')
              .fontSize(16)
              .fontColor('#262626')
              .fontWeight(FontWeight.Medium)

            Text('完成更多练习后会有智能复习推荐')
              .fontSize(13)
              .fontColor('#8c8c8c')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#00000008', offsetX: 0, offsetY: 4 })
    .onClick(() => {
      if (this.reviewProblem) {
        this.navigateToProblemDetail(this.reviewProblem.id);
      }
    })
  }

  @Builder
  buildStudyStatsCard() {
    Column({ space: 20 }) {
      // 卡片头部
      Row() {
        Row({ space: 12 }) {
          // 图标背景
          Column() {
            Image($r('app.media.icon_tj')).width(26).height(26).fillColor('#FFFFFF')
          }
          .width(48)
          .height(48)
          .backgroundColor('#0ea5e9')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)

          Column({ space: 4 }) {
            Text('学习统计')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0ea5e9')

            Text('查看您的学习成果和进步')
              .fontSize(12)
              .fontColor('#8c8c8c')
          }
          .alignItems(HorizontalAlign.Start)
        }

        Blank()

        Column() {
          Text('详情')
            .fontSize(14)
            .fontColor('#ffffff')
            .fontWeight(FontWeight.Medium)
        }
        .width(60)
        .height(32)
        .backgroundColor('#0ea5e9')
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')

      // 统计数据区域
      Row({ space: 20 }) {
        this.buildContinuousDayStatItem('连续学习', '#ff6b35')
        this.buildTotalSoledStatItem('总攻克数', '#1890ff')
        this.buildTodayCompletedStatItem('今日完成', '#52c41a')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#00000008', offsetX: 0, offsetY: 4 })
    .onClick(() => {
      this.navigateToPage('pages/StatisticsPage');
    })
  }

  @Builder
  buildModernStatItem(icon: string, value: string, label: string, color: string) {
    Column({ space: 8 }) {
      // 数值
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      // 标签
      Text(label)
        .fontSize(12)
        .fontColor('#8c8c8c')
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .backgroundColor('#fafafa')
    .borderRadius(12)
    .layoutWeight(1)
  }

  @Builder
  buildContinuousDayStatItem(title: string, color: string) {
    Column({ space: 8 }) {
      // 数值
      Text(`${this.continuousDays}天`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      // 标签
      Text(title)
        .fontSize(12)
        .fontColor('#8c8c8c')
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .backgroundColor('#fafafa')
    .borderRadius(12)
    .layoutWeight(1)
    .onClick(() => {
      this.navigateToPage('pages/ContinuousStudyPage');
    })
  }

  @Builder
  buildTotalSoledStatItem(title: string, color: string) {
    Column({ space: 8 }) {
      // 数值
      Text(`${this.totalSolved}题`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      // 标签
      Text(title)
        .fontSize(12)
        .fontColor('#8c8c8c')
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .backgroundColor('#fafafa')
    .borderRadius(12)
    .layoutWeight(1)
    .onClick(() => {
      this.navigateToPage('pages/TotalSolvedPage');
    })
  }

  @Builder
  buildTodayCompletedStatItem(title: string, color: string) {
    Column({ space: 8 }) {
      // 数值
      Text(`${this.todayCompleted}题`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      // 标签
      Text(title)
        .fontSize(12)
        .fontColor('#8c8c8c')
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .backgroundColor('#fafafa')
    .borderRadius(12)
    .layoutWeight(1)
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

      // 加载分类进度
      await this.loadCategoryProgress();

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
        console.log('lucky dailyProblem is ' + JSON.stringify(this.dailyProblem))
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
      console.log('lucky daily progress is ' + JSON.stringify(progress))
      // 检查今天是否已经完成该题目
      if (progress && progress.status !== ProblemStatus.NOT_ATTEMPTED) {
        // 使用统一的本地时间格式进行比较，避免时区问题
        const todayDateString = TimeUtils.getLocalDateString(); // YYYY-MM-DD格式
        const completedDateString = TimeUtils.getLocalDateString(new Date(progress.lastAttempted)); // YYYY-MM-DD格式
        // 判断是否是今天完成的
        const isCompletedToday = todayDateString === completedDateString;
        this.isDailyProblemCompleted = isCompletedToday;
        
        console.log(`时间比较: 今天=${todayDateString}, 完成日期=${completedDateString}, 是否今天完成=${isCompletedToday}`);
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
      this.continuousDays = 0;
      this.totalSolved = 0;
      this.todayCompleted = 0;
    }
  }

  private getCategoryColor(categoryName: string): string {
    const colorMap: Record<string, string> = {
      '数组与字符串': '#1890ff',
      '链表操作': '#52c41a',
      '字符串算法': '#fa8c16',
      '二叉树': '#13c2c2',
      '双指针技巧': '#722ed1',
      '动态规划': '#eb2f96',
      '二分查找': '#f5222d',
      '数学算法': '#fa541c',
      '栈与队列': '#52c41a',
      '哈希表': '#2f54eb',
      '回溯算法': '#722ed1',
      '贪心算法': '#52c41a',
      '位运算': '#13c2c2',
      '设计题': '#fa8c16',
      '分治算法': '#eb2f96',
      '滑动窗口': '#f5222d',
      '前缀和': '#fa541c',
      '单调栈': '#1890ff',
      '字典树': '#722ed1',
      '图算法': '#13c2c2',
      '排序算法': '#52c41a'
    };
    
    return colorMap[categoryName] || '#666666';
  }

  private async loadCategoryProgress(): Promise<void> {
    try {
      console.info('📊 开始加载分类进度数据');
      
      // 获取各分类的总题目数量
      const allProblems = ProblemMockData.getAllProblems();
      const categoryTotals = new Map<string, number>();
      
      // 统计各分类的总题目数
      allProblems.forEach(problem => {
        const category = problem.category;
        const currentCount = categoryTotals.get(category) || 0;
        categoryTotals.set(category, currentCount + 1);
      });
      
      // 获取各分类的学习进度
      const progressMap = new Map<string, number>();
      
      // 使用与学习路线页面相同的所有类目配置
      const allCategories: CategoryInfo[] = [];
      
      // 添加所有21个分类
      allCategories.push({ key: ProblemCategory.ARRAY, name: '数组与字符串' });
      allCategories.push({ key: ProblemCategory.LINKED_LIST, name: '链表操作' });
      allCategories.push({ key: ProblemCategory.STRING, name: '字符串算法' });
      allCategories.push({ key: ProblemCategory.BINARY_TREE, name: '二叉树' });
      allCategories.push({ key: ProblemCategory.TWO_POINTERS, name: '双指针技巧' });
      allCategories.push({ key: ProblemCategory.DYNAMIC_PROGRAMMING, name: '动态规划' });
      allCategories.push({ key: ProblemCategory.BINARY_SEARCH, name: '二分查找' });
      allCategories.push({ key: ProblemCategory.MATH, name: '数学算法' });
      allCategories.push({ key: ProblemCategory.STACK, name: '栈与队列' });
      allCategories.push({ key: ProblemCategory.HASH_TABLE, name: '哈希表' });
      allCategories.push({ key: ProblemCategory.BACKTRACKING, name: '回溯算法' });
      allCategories.push({ key: ProblemCategory.GREEDY, name: '贪心算法' });
      allCategories.push({ key: ProblemCategory.BIT_MANIPULATION, name: '位运算' });
      allCategories.push({ key: ProblemCategory.DESIGN, name: '设计题' });
      allCategories.push({ key: ProblemCategory.DIVIDE_CONQUER, name: '分治算法' });
      allCategories.push({ key: ProblemCategory.SLIDING_WINDOW, name: '滑动窗口' });
      allCategories.push({ key: ProblemCategory.PREFIX_SUM, name: '前缀和' });
      allCategories.push({ key: ProblemCategory.MONOTONIC_STACK, name: '单调栈' });
      allCategories.push({ key: ProblemCategory.TRIE, name: '字典树' });
      allCategories.push({ key: ProblemCategory.GRAPH, name: '图算法' });
      allCategories.push({ key: ProblemCategory.SORT, name: '排序算法' });
      
      for (const category of allCategories) {
        const studiedCount = await this.userProgressDao.getStudyProgressCountByCategory(category.key);
        const totalCount = categoryTotals.get(category.key) || 1; // 避免除零
        const progress = totalCount > 0 ? studiedCount / totalCount : 0;
        progressMap.set(category.name, progress);
        
        console.info(`📈 分类进度 - ${category.name}: ${studiedCount}/${totalCount} = ${(progress * 100).toFixed(1)}%`);
      }
      
      this.categoryProgress = progressMap;
      console.info('✅ 分类进度数据加载完成');
      
    } catch (error) {
      console.error('❌ 加载分类进度失败:', error);
      // 使用默认数据
      this.categoryProgress = new Map();
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



  @Builder
  buildFunctionGrid() {
    Column({ space: 16 }) {
      // 第一行：学习路线、题库、考核、统计
      Row({ space: 20 }) {
        this.buildFunctionItem($r('app.media.icon_route'), '学习路线', () => this.switchToTab(1))
        this.buildFunctionItem($r('app.media.icon_train_center'), '题库', () => this.switchToTab(2))
        this.buildFunctionItem($r('app.media.icon_exam'), '考核', () => this.switchToTab(3))
        this.buildFunctionItem($r('app.media.icon_tj'), '统计', () => this.navigateToPage('pages/StatisticsPage'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      // 第二行：学习笔记、错题本、我的收藏、学习日记
      Row({ space: 20 }) {
        this.buildFunctionItem($r('app.media.icon_note'), '学习笔记', () => this.navigateToPage('pages/StudyNotesPage'))
        this.buildFunctionItem($r('app.media.icon_error'), '错题本', () => this.navigateToPage('pages/WrongProblemsPage'))
        this.buildFunctionItem($r('app.media.icon_like'), '我的收藏', () => this.navigateToPage('pages/FavoritesPage'))
        this.buildFunctionItem($r('app.media.icon_rj'), '学习日记', () => this.navigateToPage('pages/StudyDiaryPage'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      // 第三行：学习目标（只有一个，居中显示）
      Row() {
        this.buildFunctionItem($r('app.media.icon_traget'), '学习目标', () => this.navigateToPage('pages/StudyGoalsPage'))// 添加占位空间，保持与上一行对齐
        Blank().width(220) // 与图标宽度相同
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildFunctionItem(icon: Resource, title: string, onClickAction: () => void) {
    Column({ space: 8 }) {
      Stack() {
        Circle({ width: 60, height: 60 })
          .fill('#FF6B35')
          .shadow({
            radius: 8,
            color: '#00000010',
            offsetX: 0,
            offsetY: 2
          })

        Image(icon)
          .width(32)
          .height(32)
          .fillColor('#FFFFFF')
      }
      .width(60)
      .height(60)

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
        .textAlign(TextAlign.Center)
    }
    .width(60)
    .onClick(onClickAction)
  }

  @Builder
  buildStudyProgressCard() {
    Column({ space: 20 }) {
      // 卡片头部
      Row() {
        Row({ space: 12 }) {
          // 图标背景
          Column() {
            Image($r('app.media.icon_progress')).width(26).height(26).fillColor('#FFFFFF')
          }
          .width(48)
          .height(48)
          .backgroundColor('#722ed1')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)

          Column({ space: 4 }) {
            Text('学习进度')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#722ed1')

            Text('各类目掌握情况一览')
              .fontSize(12)
              .fontColor('#8c8c8c')
          }
          .alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')

      // 进度条区域
      Column({ space: 16 }) {
        ForEach(Array.from(this.categoryProgress.keys()), (categoryName: string) => {
          this.buildModernProgressItem(
            categoryName, 
            this.categoryProgress.get(categoryName) || 0, 
            this.getCategoryColor(categoryName)
          )
        }, (categoryName: string) => categoryName)
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#00000008', offsetX: 0, offsetY: 4 })
  }

  @Builder
  buildProgressItem(category: string, progress: number, color: string) {
    Column({ space: 8 }) {
      Row() {
        Text(category)
          .fontSize(14)
          .fontColor('#333333')
          .layoutWeight(1)

        Text(`${Math.round(progress * 100)}%`)
          .fontSize(12)
          .fontColor('#666666')
      }
      .width('100%')

      Row() {
        Progress({ value: progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .color(color)
          .backgroundColor('#F0F0F0')
      }
    }
    .width('100%')
  }

  @Builder
  buildModernProgressItem(category: string, progress: number, color: string) {
    Row({ space: 16 }) {
      // 左侧图标和类别
      Row({ space: 12 }) {
        Column({ space: 2 }) {
          Text(category)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#262626')

          Text(`${Math.round(progress * 100)}% 完成`)
            .fontSize(12)
            .fontColor('#8c8c8c')
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      // 右侧进度条
      Column({ space: 6 }) {
        Row() {
          Text(`${Math.round(progress * 100)}%`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(color)
        }
        .width(60)
        .justifyContent(FlexAlign.End)

        Progress({ value: progress * 100, total: 100, type: ProgressType.Linear })
          .width(120)
          .height(6)
          .color(color)
          .backgroundColor('#F1EEEE')
          .borderRadius(3)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#fafafa')
    .borderRadius(12)
    .border({ width: 1, color: '#f0f0f0' })
  }

  private switchToTab(tabIndex: number): void {
    const tabNavigationService = TabNavigationService.getInstance();
    tabNavigationService.switchToTab(tabIndex);
  }

  private navigateToPage(pagePath: string): void {
    router.pushUrl({
      url: pagePath
    }).catch((error: Error) => {
      console.error('页面跳转失败:', error);
    });
  }
}