import router from '@ohos.router';
import { ProblemMockData } from '../mock/ProblemMockData';
import { ProblemModel, ProblemCategory } from '../model/ProblemModel';
import { UserProgressDao } from '../dao/UserProgressDao';

interface CategoryStats {
  category: ProblemCategory;
  name: string;
  totalProblems: number;
  completedProblems: number;
  accuracy: number;
  color: string;
}

@Entry
@Component
struct CategoryStatsPage {
  @State categoryStats: CategoryStats[] = [];
  @State isLoading: boolean = true;
  @State totalStats: {
    totalProblems: number;
    completedProblems: number;
    overallAccuracy: number;
  } = {
    totalProblems: 0,
    completedProblems: 0,
    overallAccuracy: 0
  };

  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadCategoryStats();
  }

  build() {
    Column({ space: 0 }) {
      // 顶部导航栏
      this.buildHeader()

      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        Scroll() {
          Column({ space: 16 }) {
            // 整体统计概览
            this.buildOverallStats()

            // 分类统计列表
            this.buildCategoryList()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
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

      Text('分类统计')
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
  buildOverallStats() {
    Column({ space: 16 }) {
      Text('整体学习统计')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      Row({ space: 20 }) {
        // 总题目数
        Column({ space: 4 }) {
          Text(this.totalStats.totalProblems.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1890ff')

          Text('总题目')
            .fontSize(14)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // 已完成
        Column({ space: 4 }) {
          Text(this.totalStats.completedProblems.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('已完成')
            .fontSize(14)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // 正确率
        Column({ space: 4 }) {
          Text(this.totalStats.overallAccuracy.toFixed(1) + '%')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fa8c16')

          Text('正确率')
            .fontSize(14)
            .fontColor('#666666')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#ffffff')
      .borderRadius(12)
      .shadow({
        radius: 4,
        color: '#00000010',
        offsetX: 0,
        offsetY: 2
      })
    }
    .width('100%')
  }

  @Builder
  buildCategoryList() {
    Column({ space: 12 }) {
      Text('分类详情')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      ForEach(this.categoryStats, (stats: CategoryStats) => {
        this.buildCategoryItem(stats)
      }, (stats: CategoryStats) => stats.category.toString())
    }
    .width('100%')
  }

  @Builder
  buildCategoryItem(stats: CategoryStats) {
    Column({ space: 12 }) {
      // 分类头部信息
      Row({ space: 12 }) {
        // 分类标识
        Circle({ width: 12, height: 12 })
          .fill(stats.color)

        Column({ space: 4 }) {
          Text(stats.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(`共${stats.totalProblems}题`)
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 完成状态
        Column({ space: 4 }) {
          Text(`${stats.completedProblems}/${stats.totalProblems}`)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(stats.accuracy.toFixed(1) + '%')
            .fontSize(12)
            .fontColor(this.getAccuracyColor(stats.accuracy))
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')

      // 进度条
      Row() {
        Progress({
          value: stats.completedProblems,
          total: stats.totalProblems,
          type: ProgressType.Linear
        })
        .width('100%')
        .height(6)
        .color(stats.color)
        .backgroundColor('#f0f0f0')
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .border({ width: 1, color: '#f0f0f0' })
    .onClick(() => {
      // 跳转到练习中心对应分类
      AppStorage.setOrCreate('selectedCategory', stats.category);
      router.back();
      setTimeout(() => {
        AppStorage.setOrCreate('switchToPracticeCenter', Date.now());
      }, 100);
    })
  }

  private async loadCategoryStats() {
    try {
      this.isLoading = true;
      const allProblems = ProblemMockData.getAllProblems();
      const stats: CategoryStats[] = [];
      
      let totalCompleted = 0;
      let totalCorrect = 0;
      let totalAttempted = 0;

      // 获取所有分类
      const categories = this.getAllCategories();
      
      for (const category of categories) {
        const categoryProblems = allProblems.filter(p => p.category === category.type);
        const completedCount = await this.userProgressDao.getCompletedCountByCategory(category.type);
        const accuracy = await this.userProgressDao.getAccuracyByCategory(category.type);

        stats.push({
          category: category.type,
          name: category.name,
          totalProblems: categoryProblems.length,
          completedProblems: completedCount,
          accuracy: accuracy,
          color: category.color
        });

        totalCompleted += completedCount;
        // 这里可以根据实际需要计算总的正确率
        if (completedCount > 0) {
          totalCorrect += Math.round(completedCount * accuracy / 100);
          totalAttempted += completedCount;
        }
      }

      this.categoryStats = stats;
      
      // 计算整体统计
      this.totalStats = {
        totalProblems: allProblems.length,
        completedProblems: totalCompleted,
        overallAccuracy: totalAttempted > 0 ? (totalCorrect / totalAttempted) * 100 : 0
      };

    } catch (error) {
      console.error('Failed to load category stats:', error);
    } finally {
      this.isLoading = false;
    }
  }

  private getAllCategories() {
    return [
      { type: ProblemCategory.ARRAY, name: '数组', color: '#1890ff' },
      { type: ProblemCategory.STRING, name: '字符串', color: '#52c41a' },
      { type: ProblemCategory.LINKED_LIST, name: '链表', color: '#fa8c16' },
      { type: ProblemCategory.BINARY_TREE, name: '二叉树', color: '#13c2c2' },
      { type: ProblemCategory.TWO_POINTERS, name: '双指针', color: '#722ed1' },
      { type: ProblemCategory.BINARY_SEARCH, name: '二分查找', color: '#eb2f96' },
      { type: ProblemCategory.MATH, name: '数学', color: '#f5222d' },
      { type: ProblemCategory.DYNAMIC_PROGRAMMING, name: '动态规划', color: '#fa541c' },
      { type: ProblemCategory.STACK, name: '栈与队列', color: '#52c41a' },
      { type: ProblemCategory.HASH_TABLE, name: '哈希表', color: '#2f54eb' },
      { type: ProblemCategory.BACKTRACKING, name: '回溯算法', color: '#722ed1' },
      { type: ProblemCategory.GREEDY, name: '贪心算法', color: '#52c41a' },
      { type: ProblemCategory.BIT_MANIPULATION, name: '位运算', color: '#13c2c2' },
      { type: ProblemCategory.DESIGN, name: '设计题', color: '#fa8c16' },
      { type: ProblemCategory.DIVIDE_CONQUER, name: '分治算法', color: '#eb2f96' },
      { type: ProblemCategory.SLIDING_WINDOW, name: '滑动窗口', color: '#f5222d' },
      { type: ProblemCategory.PREFIX_SUM, name: '前缀和', color: '#fa541c' },
      { type: ProblemCategory.MONOTONIC_STACK, name: '单调栈', color: '#1890ff' },
      { type: ProblemCategory.TRIE, name: '字典树', color: '#722ed1' },
      { type: ProblemCategory.GRAPH, name: '图论', color: '#13c2c2' },
      { type: ProblemCategory.SORT, name: '排序算法', color: '#52c41a' }
    ];
  }

  private getAccuracyColor(accuracy: number): string {
    if (accuracy >= 80) return '#52c41a';
    if (accuracy >= 60) return '#fa8c16';
    return '#ff7875';
  }
}