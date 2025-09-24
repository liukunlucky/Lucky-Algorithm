import { router } from '@kit.ArkUI';
import promptAction from '@ohos.promptAction';
import { UserProgressDao } from '../dao/UserProgressDao';
import { ProblemCategory, ProblemModel } from '../model/ProblemModel';
import { ProblemMockData } from '../mock/ProblemMockData';

interface CategoryStats {
  category: ProblemCategory;
  categoryName: string;
  solved: number;
  total: number;
  accuracy: number;
  color: string;
  icon: Resource;
  problems?: ProblemModel[];
  completedProblems?: ProblemModel[];
  expanded?: boolean;
}

interface DifficultyStats {
  difficulty: string;
  solved: number;
  total: number;
  color: string;
}

interface CategoryConfig {
  category: ProblemCategory;
  name: string;
  icon: Resource;
  color: string;
}

@Entry
@Component
struct TotalSolvedPage {
  @State totalSolved: number = 0;
  @State totalProblems: number = 0;
  @State categoryStats: CategoryStats[] = [];
  @State difficultyStats: DifficultyStats[] = [];
  @State averageAccuracy: number = 0;
  @State selectedTab: number = 0; // 0: 分类统计, 1: 难度统计
  @State isLoading: boolean = true;
  @State expandedCategories: Set<string> = new Set();

  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear(): void {
    this.loadSolvedStats();
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
          // 总体统计卡片
          this.buildOverviewCard()

          // Tab切换
          this.buildTabBar()

          // 内容区域
          if (this.selectedTab === 0) {
            this.buildCategoryStats()
          } else {
            this.buildDifficultyStats()
          }
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

      Text('总攻克题数')
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

      Text('正在加载统计数据...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildOverviewCard() {
    Column({ space: 20 }) {
      // 主要数据
      Row() {
        Column({ space: 8 }) {
          Text(this.totalSolved.toString())
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F34F40')

          Text('已攻克题目')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Divider()
          .vertical(true)
          .height(60)
          .strokeWidth(1)
          .color('#E5E7EB')

        Column({ space: 8 }) {
          Text(this.totalProblems.toString())
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('题库总数')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')

      // 进度条
      Column({ space: 8 }) {
        Row() {
          Text('完成进度')
            .fontSize(14)
            .fontColor('#333333')
            .layoutWeight(1)

          Text(`${Math.round((this.totalSolved / this.totalProblems) * 100)}%`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F34F40')
        }
        .width('100%')

        Progress({
          value: this.totalSolved,
          total: this.totalProblems,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color('#F34F40')
          .backgroundColor('#E5E7EB')
          .borderRadius(4)
      }
      .width('100%')

      // 正确率
      Row() {
        Column({ space: 4 }) {
          Text(`${this.averageAccuracy}%`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('平均正确率')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text(this.getStudyLevel())
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#722ed1')

          Text('学习等级')
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
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
  buildTabBar() {
    Row() {
      this.buildTabItem('分类统计', 0)
      this.buildTabItem('难度统计', 1)
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
  buildTabItem(title: string, index: number) {
    Text(title)
      .fontSize(14)
      .fontColor(this.selectedTab === index ? '#ffffff' : '#666666')
      .fontWeight(this.selectedTab === index ? FontWeight.Medium : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height('100%')
      .backgroundColor(this.selectedTab === index ? '#F34F40' : 'transparent')
      .borderRadius(22)
      .onClick(() => {
        this.selectedTab = index;
      })
  }

  @Builder
  buildCategoryStats() {
    List({ space: 12 }) {
      ForEach(this.categoryStats, (stats: CategoryStats) => {
        ListItem() {
          this.buildCategoryItem(stats)
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  buildCategoryItem(stats: CategoryStats) {
    Column() {
      // 主要信息行
      Row({ space: 16 }) {
        // 信息
        Column({ space: 4 }) {
          Row() {
            Text(stats.categoryName)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .layoutWeight(1)

            Text(`${stats.solved}/${stats.total}`)
              .fontSize(14)
              .fontColor('#666666')
          }
          .width('100%')

          Row() {
            Progress({
              value: stats.solved,
              total: stats.total,
              type: ProgressType.Linear
            })
              .width(120)
              .height(4)
              .color(stats.color)
              .backgroundColor('#E5E7EB')
              .borderRadius(2)

            Blank()

            Text(`${stats.accuracy}%`)
              .fontSize(12)
              .fontColor(stats.color)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Row() {
            Button() {
              Image($r('app.media.icon_down_arrow'))
                .width(16)
                .height(16)
                .rotate({angle: this.expandedCategories.has(stats.category)? 180: 0})
                .fillColor('#666666')
                .animation({
                  duration: 300,
                  curve: Curve.EaseInOut
                })
            }
            .width(32)
            .height(32)
            .align(Alignment.End)
            .layoutWeight(1)
            .backgroundColor('transparent')
            .onClick(() => {
              this.toggleCategoryExpand(stats.category);
            })
          }
          .width('100%')
          .visibility(stats.solved > 0?Visibility.Visible: Visibility.None)
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
      }
      .width('100%')

      // 展开的题目列表 - 只显示已攻克的题目
      if (this.expandedCategories.has(stats.category) && stats.solved > 0) {
        this.buildCompletedProblemsList(stats)
      }
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
  buildCompletedProblemsList(stats: CategoryStats) {
    Column({ space: 8 }) {
      Divider()
        .strokeWidth(1)
        .color('#E5E7EB')
        .margin({ top: 12, bottom: 8 })

      // 显示已攻克题目数量
      Text(`已攻克 ${stats.solved} 道题目`)
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 8 })

      // 动态加载已攻克的题目列表
      if (stats.completedProblems && stats.completedProblems.length > 0) {
        ForEach(stats.completedProblems, (problem: ProblemModel) => {
          this.buildProblemItem(problem)
        })
      } else {
        Text('正在加载已攻克题目...')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 8, bottom: 8 })
      }
    }
    .width('100%')
    .animation({
      duration: 300,
      curve: Curve.EaseInOut
    })
  }

  @Builder
  buildProblemItem(problem: ProblemModel) {
    Row({ space: 12 }) {
      // 难度标识
      Text(problem.getDifficultyText())
        .fontSize(12)
        .fontColor('#ffffff')
        .backgroundColor(problem.getDifficultyColor())
        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
        .borderRadius(10)

      // 题目标题
      Text(problem.title)
        .fontSize(14)
        .fontColor('#333333')
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 查看题目按钮
      Text('查看题目')
        .fontSize(12)
        .fontColor('#F34F40')
        .onClick(() => {
          this.navigateToProblemDetail(problem.id);
        })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 8, bottom: 8 })
    .backgroundColor('#f8f9fa')
    .borderRadius(8)
  }

  @Builder
  buildDifficultyStats() {
    Column({ space: 12 }) {
      ForEach(this.difficultyStats, (stats: DifficultyStats) => {
        this.buildDifficultyItem(stats)
      }, (stats: DifficultyStats) => stats.difficulty.toString())
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildDifficultyItem(stats: DifficultyStats) {
    Row({ space: 16 }) {
      // 难度标识
      Circle()
        .width(12)
        .height(12)
        .fill(stats.color)

      // 信息
      Column({ space: 8 }) {
        Row() {
          Text(stats.difficulty)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .layoutWeight(1)

          Text(`${stats.solved}/${stats.total}`)
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')

        Progress({
          value: stats.solved,
          total: stats.total,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(stats.color)
          .backgroundColor('#E5E7EB')
          .borderRadius(4)

        Text(`完成率: ${Math.round((stats.solved / stats.total) * 100)}%`)
          .fontSize(12)
          .fontColor('#666666')
      }
      .layoutWeight(1)
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

  // 加载攻克题数统计
  private async loadSolvedStats(): Promise<void> {
    try {
      this.isLoading = true;
      console.info('📊 开始加载攻克题数统计');

      // 获取总攻克题数
      this.totalSolved = await this.userProgressDao.getCompletedCount();

      // 获取题库总数
      const allProblems = ProblemMockData.getAllProblems();
      this.totalProblems = allProblems.length;

      // 获取平均正确率
      const statistics = await this.userProgressDao.getStatistics();
      this.averageAccuracy = statistics.overallAccuracy;

      // 加载分类统计
      await this.loadCategoryStats();

      // 加载难度统计
      await this.loadDifficultyStats();

      console.info('✅ 攻克题数统计加载完成');
    } catch (error) {
      console.error('❌ 加载攻克题数统计失败:', error);
      promptAction.showToast({
        message: '加载数据失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }

  // 加载分类统计
  private async loadCategoryStats(): Promise<void> {
    const categoryConfigs: CategoryConfig[] = [
      { category: ProblemCategory.ARRAY, name: '数组', icon: $r('app.media.chart_icon'), color: '#1890ff' },
      { category: ProblemCategory.STRING, name: '字符串', icon: $r('app.media.note_icon'), color: '#52c41a' },
      { category: ProblemCategory.LINKED_LIST, name: '链表', icon: $r('app.media.book_icon'), color: '#fa8c16' },
      { category: ProblemCategory.BINARY_TREE, name: '二叉树', icon: $r('app.media.book_icon'), color: '#13c2c2' },
      { category: ProblemCategory.TWO_POINTERS, name: '双指针', icon: $r('app.media.target_icon'), color: '#722ed1' },
      { category: ProblemCategory.BINARY_SEARCH, name: '二分查找', icon: $r('app.media.search_icon'), color: '#eb2f96' },
      { category: ProblemCategory.MATH, name: '数学', icon: $r('app.media.computer_icon'), color: '#f5222d' },
      { category: ProblemCategory.DYNAMIC_PROGRAMMING, name: '动态规划', icon: $r('app.media.star_icon'), color: '#fa541c' },
      { category: ProblemCategory.STACK, name: '栈', icon: $r('app.media.book_icon'), color: '#faad14' },
      { category: ProblemCategory.HASH_TABLE, name: '哈希表', icon: $r('app.media.computer_icon'), color: '#52c41a' },
      { category: ProblemCategory.BACKTRACKING, name: '回溯', icon: $r('app.media.star_icon'), color: '#722ed1' },
      { category: ProblemCategory.GREEDY, name: '贪心', icon: $r('app.media.target_icon'), color: '#13c2c2' },
      { category: ProblemCategory.BIT_MANIPULATION, name: '位运算', icon: $r('app.media.computer_icon'), color: '#eb2f96' },
      { category: ProblemCategory.DESIGN, name: '设计', icon: $r('app.media.computer_icon'), color: '#f5222d' },
      { category: ProblemCategory.DIVIDE_CONQUER, name: '分治', icon: $r('app.media.star_icon'), color: '#fa541c' },
      { category: ProblemCategory.SLIDING_WINDOW, name: '滑动窗口', icon: $r('app.media.chart_icon'), color: '#faad14' },
      { category: ProblemCategory.PREFIX_SUM, name: '前缀和', icon: $r('app.media.chart_icon'), color: '#52c41a' },
      { category: ProblemCategory.MONOTONIC_STACK, name: '单调栈', icon: $r('app.media.chart_icon'), color: '#1890ff' },
      { category: ProblemCategory.TRIE, name: '字典树', icon: $r('app.media.book_icon'), color: '#fa8c16' },
      { category: ProblemCategory.GRAPH, name: '图', icon: $r('app.media.computer_icon'), color: '#13c2c2' },
      { category: ProblemCategory.SORT, name: '排序', icon: $r('app.media.star_icon'), color: '#722ed1' }
    ];

    const stats: CategoryStats[] = [];
    const allProblems = ProblemMockData.getAllProblems();

    for (const config of categoryConfigs) {
      const categoryProblems = allProblems.filter(p => p.category === config.category);
      const solved = await this.userProgressDao.getCompletedCountByCategory(config.category);
      const accuracy = await this.userProgressDao.getAccuracyByCategory(config.category);

      const categoryStats: CategoryStats = {
        category: config.category,
        categoryName: config.name,
        solved: solved,
        total: categoryProblems.length,
        accuracy: accuracy,
        color: config.color,
        icon: config.icon,
        problems: categoryProblems,
        expanded: false
      };
      stats.push(categoryStats);
    }

    this.categoryStats = stats.sort((a: CategoryStats, b: CategoryStats): number => b.solved - a.solved);
  }

  // 加载难度统计
  private async loadDifficultyStats(): Promise<void> {
    const allProblems = ProblemMockData.getAllProblems();
    
    // 按难度分组
    const easyProblems = allProblems.filter((p: ProblemModel): boolean => p.difficulty === 0);
    const mediumProblems = allProblems.filter((p: ProblemModel): boolean => p.difficulty === 1);
    const hardProblems = allProblems.filter((p: ProblemModel): boolean => p.difficulty === 2);

    const easySolved = await this.userProgressDao.getCompletedCountByDifficulty(0);
    const mediumSolved = await this.userProgressDao.getCompletedCountByDifficulty(1);
    const hardSolved = await this.userProgressDao.getCompletedCountByDifficulty(2);

    const easyDifficulty: DifficultyStats = {
      difficulty: '简单',
      solved: easySolved,
      total: easyProblems.length,
      color: '#52c41a'
    };
    
    const mediumDifficulty: DifficultyStats = {
      difficulty: '中等',
      solved: mediumSolved,
      total: mediumProblems.length,
      color: '#fa8c16'
    };
    
    const hardDifficulty: DifficultyStats = {
      difficulty: '困难',
      solved: hardSolved,
      total: hardProblems.length,
      color: '#f5222d'
    };
    
    this.difficultyStats = [easyDifficulty, mediumDifficulty, hardDifficulty];
  }

  // 获取学习等级
  private getStudyLevel(): string {
    const solved = this.totalSolved;
    if (solved < 10) return '新手';
    if (solved < 30) return '入门';
    if (solved < 60) return '进阶';
    if (solved < 100) return '熟练';
    if (solved < 200) return '高手';
    return '专家';
  }

  // 切换分类展开状态
  private async toggleCategoryExpand(category: ProblemCategory): Promise<void> {
    if (this.expandedCategories.has(category)) {
      this.expandedCategories.delete(category);
    } else {
      this.expandedCategories.add(category);
      // 展开时加载已攻克的题目
      await this.loadCompletedProblemsForCategory(category);
    }
    // 触发状态更新
    this.expandedCategories = new Set(this.expandedCategories);
  }

  // 加载指定分类的已攻克题目
  private async loadCompletedProblemsForCategory(category: ProblemCategory): Promise<void> {
    try {
      // 获取用户在该分类下已完成的题目 ID 列表
      const completedProblemIds = await this.userProgressDao.getCompletedProblemIdsByCategory(category);
      
      if (completedProblemIds.length > 0) {
        // 从 Mock 数据中获取对应的题目信息
        const allProblems = ProblemMockData.getAllProblems();
        const completedProblems = allProblems.filter(problem => 
          completedProblemIds.includes(problem.id) && problem.category === category
        );
        
        // 更新对应分类的已攻克题目列表
        const categoryIndex = this.categoryStats.findIndex(stats => stats.category === category);
        if (categoryIndex !== -1) {
          this.categoryStats[categoryIndex].completedProblems = completedProblems;
        }
      }
    } catch (error) {
      console.error(`加载分类 ${category} 的已攻克题目失败:`, error);
    }
  }
  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: {
        problemId: problemId
      }
    }).catch((error: Error) => {
      console.error('导航失败:', error);
    });
  }

  // 导航到分类详情
  private navigateToCategoryDetail(category: ProblemCategory): void {
    router.pushUrl({
      url: 'pages/CategoryDetailPage',
      params: {
        category: category
      }
    }).catch((error: Error) => {
      console.error('导航失败:', error);
    });
  }
}