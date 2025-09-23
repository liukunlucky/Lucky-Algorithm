// 使用数据库数据，导入相关DAO类
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { ProblemDao } from '../dao/ProblemDao';
import { router } from '@kit.ArkUI';
import { ProblemCategory } from '../model/ProblemModel';
import { pasteboard } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';

// 导入hm_chart图表组件


interface StudyStats {
  totalSolved: number;
  continuousDays: number;
  totalStudyTime: number; // 分钟
  averageAccuracy: number; // 百分比
  favoriteCount: number;
  wrongCount: number;
}

interface ChartDataset {
  label?: string;
  data: number[];
  backgroundColor?: string | string[];
  borderColor?: string;
  borderWidth?: number;
  borderRadius?: number;
  tension?: number;
}

interface ChartData {
  labels: string[];
  datasets: ChartDataset[];
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

// 分类配置接口
interface CategoryConfig {
  category: ProblemCategory;
  name: string;
  icon: Resource;
  color: string;
}

@Entry
@Component
struct StatisticsPage {
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
  @State isLoading: boolean = false;
  
  // DAO实例
  private userProgressDao: UserProgressDao = new UserProgressDao();
  private problemDao: ProblemDao = new ProblemDao();

  aboutToAppear() {
    this.loadStatistics();
  }

  build() {
    Column() {
      // 页面标题
      this.buildHeader()
      Blank().height(16)
      // Tab切换
      this.buildTabBar()
      Blank().height(16)
      
      // 内容区域
      if (this.isLoading) {
        // 加载状态
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
      } else {
        // 正常内容
        if (this.selectedTab === 0) {
          this.buildOverviewTab()
        } else if (this.selectedTab === 1) {
          this.buildCategoryTab()
        } else if (this.selectedTab === 2) {
          this.buildTrendTab()
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  @Builder
  buildHeader() {
    Row({ space: 16 }) {
      // 返回按钮
      Button() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
          .fillColor('#333333')
      }
      .width(40)
      .height(40)
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      // 标题
      Text('我的统计')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank().width(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildTabBar() {
    Row() {
      this.buildTabItem('总览', 0)
      this.buildTabItem('分类', 1)
      this.buildTabItem('趋势', 2)
    }
    .margin(16)
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
      .backgroundColor(this.selectedTab === index ? '#F34F40' : 'transparent')
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
    .padding({left: 16, right: 16})
    .layoutWeight(1)
  }

  @Builder
  buildCoreStatsCard() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
          Text('核心数据')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      Grid() {
        GridItem() {
          this.buildStatItem('学习题数', this.studyStats.totalSolved + '题', $r('app.media.target_icon'), '#1890ff')
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
  buildStatItem(title: string, value: string, _icon: Resource, color: string) {
    Column({ space: 8 }) {
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
  buildAchievementItem(title: string, value: string, _icon: Resource, color: string) {
    Column({ space: 6 }) {
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
          Text('分类进度')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      // // 分类完成度柱状图
      // Column({ space: 12 }) {
      //   Text('各分类完成度对比')
      //     .fontSize(16)
      //     .fontWeight(FontWeight.Medium)
      //     .fontColor('#333333')
      //     .alignSelf(ItemAlign.Start)
      //
      //   // 暂时使用简单的图表替代，等待hm_chart组件修复
      //   Column({ space: 8 }) {
      //     Text('分类完成度统计')
      //       .fontSize(14)
      //       .fontColor('#666666')
      //
      //     // 简单的进度条图表
      //     ForEach(this.categoryProgress.slice(0, 5), (category: CategoryProgress) => {
      //       Row({ space: 8 }) {
      //         Text(category.categoryName)
      //           .fontSize(12)
      //           .fontColor('#333333')
      //           .width(60)
      //
      //         Progress({
      //           value: category.solved,
      //           total: category.total,
      //           type: ProgressType.Linear
      //         })
      //         .width('100%')
      //         .height(8)
      //         .color(category.color)
      //         .backgroundColor('#f0f0f0')
      //         .layoutWeight(1)
      //
      //         Text(category.solved + '/' + category.total)
      //           .fontSize(12)
      //           .fontColor('#666666')
      //           .width(40)
      //       }
      //       .width('100%')
      //     }, (category: CategoryProgress) => category.categoryName)
      //   }
      //   .width('100%')
      //   .height(250)
      //   .justifyContent(FlexAlign.SpaceEvenly)
      // }
      // .width('100%')
      // .padding(16)
      // .backgroundColor('#ffffff')
      // .borderRadius(12)
      // .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })

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
    .padding({left: 16, right: 16})
    .layoutWeight(1)
  }

  @Builder
  buildCategoryProgressCard(category: CategoryProgress) {
    Row({ space: 12 }) {
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
          Text('学习进度: ' + Math.round((category.solved / category.total) * 100) + '%')
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
    Scroll() {
      Column({ space: 16 }) {
        Row({ space: 8 }) {
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
      .padding({left: 16, right: 16})
    }.layoutWeight(1)

  }

  @Builder
  buildWeeklyChart() {
    Column({ space: 16 }) {
      Text('近7天学习情况')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      // 暂时使用简单的趋势图替代
      Column({ space: 8 }) {
        Text('近7天解题趋势')
          .fontSize(14)
          .fontColor('#666666')
        
        Row({ space: 4 }) {
          ForEach(this.weeklyData, (item: WeeklyData, index: number) => {
            Column({ space: 4 }) {
              // 简单的柱状图表示 - 修复对齐问题
              Column()
                .width(30)
                .height(Math.max(item.solved * 12, 5)) // 调整高度计算
                .backgroundColor('#1890ff')
                .borderRadius(2)
              
              Text(item.solved.toString())
                .fontSize(10)
                .fontColor('#333333')
              
              Text(item.date)
                .fontSize(10)
                .fontColor('#666666')
            }
            .justifyContent(FlexAlign.End)
            .height(100) // 固定高度确保底部对齐
          }, (item: WeeklyData) => item.date)
        }
        .width('100%')
        .height(120)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)

      // 分类进度饼图
      Text('分类学习进度分布')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)
        .margin({ top: 16 })

      // 暂时使用简单的分类统计替代
      Column({ space: 8 }) {
        Text('分类学习进度分布')
          .fontSize(14)
          .fontColor('#666666')
        
        Grid() {
          ForEach(this.categoryProgress.slice(0, 6), (category: CategoryProgress) => {
            GridItem() {
              Column({ space: 4 }) {
                // 圆形进度指示器
                Stack() {
                  Circle({ width: 40, height: 40 })
                    .fill('#f0f0f0')
                  
                  Circle({ width: 40, height: 40 })
                    .fill('transparent')
                    .stroke(category.color)
                    .strokeWidth(4)
                    .strokeDashArray([
                      (category.solved / category.total) * 125, 
                      125 - (category.solved / category.total) * 125
                    ])
                  
                  Text(Math.round((category.solved / category.total) * 100) + '%')
                    .fontSize(8)
                    .fontColor('#333333')
                }
                .width(40)
                .height(40)
                
                Text(category.categoryName)
                  .fontSize(10)
                  .fontColor('#333333')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center)
            }
          }, (category: CategoryProgress) => category.categoryName)
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .width('100%')
        .height(120)
        .columnsGap(8)
        .rowsGap(8)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)

      // 学习时间柱状图
      Text('每日学习时长统计')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)
        .margin({ top: 16 })

      // 暂时使用简单的柱状图替代
      Column({ space: 8 }) {
        Text('每日学习时长统计')
          .fontSize(14)
          .fontColor('#666666')
        
        Row({ space: 4 }) {
          ForEach(this.weeklyData, (item: WeeklyData, index: number) => {
            Column({ space: 4 }) {
              // 柱状图 - 修复对齐问题，使用真实数据
              Column()
                .width(30)
                .height(Math.max(item.solved * 15, 5)) // 使用真实数据，高度基于解题数
                .backgroundColor(['#ff6b6b', '#4ecdc4', '#45b7d1', '#96ceb4', '#feca57', '#ff9ff3', '#54a0ff'][index])
                .borderRadius(2)
              
              Text(item.solved + '题')
                .fontSize(9)
                .fontColor('#333333')
              
              Text(item.date)
                .fontSize(10)
                .fontColor('#666666')
            }
            .justifyContent(FlexAlign.End)
            .height(120) // 固定高度确保底部对齐
          }, (item: WeeklyData) => item.date)
        }
        .width('100%')
        .height(140)
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
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
      this.isLoading = true;
      console.info('📊 开始加载统计数据');
      
      // 从数据库加载真实统计数据
      await this.loadStudyStatistics();
      await this.loadCategoryProgress();
      await this.loadWeeklyData();
      
      console.info('✅ 统计数据加载完成');
    } catch (error) {
      console.error('❌ 加载统计数据失败:', error);
      // 使用默认数据作为降级方案
      this.setDefaultData();
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 加载学习统计数据
   */
  private async loadStudyStatistics(): Promise<void> {
    try {
      // 获取学习进度数（包括答对和答错的题目）
      const totalStudied = await this.userProgressDao.getStudyProgressCount();
      
      // 获取连续学习天数
      const continuousDays = await this.userProgressDao.getContinuousDays();
      
      // 获取今日学习数（包括答对和答错）
      const todayCompleted = await this.userProgressDao.getTodayCompletedCount();
      
      // 获取收藏题目数
      const favoriteProblems = await this.userProgressDao.getFavoriteProblems();
      
      // 获取错题数
      const wrongProblems = await this.userProgressDao.getWrongProblems();
      
      // 获取统计信息（包括准确率）
      const statistics = await this.userProgressDao.getStatistics();
      
      // 计算学习时长（暂时使用估算：每题平均5分钟）
      const estimatedStudyTime = totalStudied * 5;
      
      this.studyStats = {
        totalSolved: totalStudied, // 修改：使用学习进度数（包括答对和答错）
        continuousDays: continuousDays,
        totalStudyTime: estimatedStudyTime,
        averageAccuracy: statistics.overallAccuracy,
        favoriteCount: favoriteProblems.length,
        wrongCount: wrongProblems.length
      };
      
      console.info('📈 学习统计数据:', this.studyStats);
      console.info('🎯 学习进度数（包括答对和答错）:', totalStudied);
      console.info('🎯 正确率:', statistics.overallAccuracy + '%');
    } catch (error) {
      console.error('❌ 加载学习统计失败:', error);
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      throw new Error('加载学习统计失败: ' + errorMessage);
    }
  }

  /**
   * 加载分类进度数据
   */
  private async loadCategoryProgress(): Promise<void> {
    try {
      const categories: CategoryConfig[] = [
        { category: ProblemCategory.ARRAY, name: '数组', icon: $r('app.media.chart_icon'), color: '#1890ff' },
        { category: ProblemCategory.STRING, name: '字符串', icon: $r('app.media.note_icon'), color: '#52c41a' },
        { category: ProblemCategory.LINKED_LIST, name: '链表', icon: $r('app.media.link_icon'), color: '#fa8c16' },
        { category: ProblemCategory.BINARY_TREE, name: '二叉树', icon: $r('app.media.tree_icon'), color: '#13c2c2' },
        { category: ProblemCategory.TWO_POINTERS, name: '双指针', icon: $r('app.media.target_icon'), color: '#722ed1' },
        { category: ProblemCategory.BINARY_SEARCH, name: '二分查找', icon: $r('app.media.search_icon'), color: '#eb2f96' },
        { category: ProblemCategory.MATH, name: '数学', icon: $r('app.media.computer_icon'), color: '#f5222d' },
        { category: ProblemCategory.DYNAMIC_PROGRAMMING, name: '动态规划', icon: $r('app.media.laptop_icon'), color: '#fa541c' },
        { category: ProblemCategory.STACK, name: '栈', icon: $r('app.media.book_icon'), color: '#faad14' },
        { category: ProblemCategory.HASH_TABLE, name: '哈希表', icon: $r('app.media.computer_icon'), color: '#52c41a' },
        { category: ProblemCategory.BACKTRACKING, name: '回溯', icon: $r('app.media.star_icon'), color: '#13c2c2' },
        { category: ProblemCategory.GREEDY, name: '贪心', icon: $r('app.media.target_icon'), color: '#722ed1' },
        { category: ProblemCategory.BIT_MANIPULATION, name: '位运算', icon: $r('app.media.computer_icon'), color: '#eb2f96' },
        { category: ProblemCategory.DESIGN, name: '设计', icon: $r('app.media.computer_icon'), color: '#f5222d' },
        { category: ProblemCategory.DIVIDE_CONQUER, name: '分治', icon: $r('app.media.star_icon'), color: '#fa541c' },
        { category: ProblemCategory.SLIDING_WINDOW, name: '滑动窗口', icon: $r('app.media.chart_icon'), color: '#1890ff' },
        { category: ProblemCategory.PREFIX_SUM, name: '前缀和', icon: $r('app.media.chart_icon'), color: '#faad14' },
        { category: ProblemCategory.MONOTONIC_STACK, name: '单调栈', icon: $r('app.media.book_icon'), color: '#52c41a' },
        { category: ProblemCategory.TRIE, name: '字典树', icon: $r('app.media.tree_icon'), color: '#13c2c2' },
        { category: ProblemCategory.GRAPH, name: '图', icon: $r('app.media.map_icon'), color: '#722ed1' },
        { category: ProblemCategory.SORT, name: '排序', icon: $r('app.media.target_icon'), color: '#eb2f96' }
      ];
      
      const progressList: CategoryProgress[] = [];
      
      for (const categoryConfig of categories) {
        // 获取该分类的总题目数
        const allProblems = ProblemMockData.getAllProblems();
        const totalProblems = allProblems.filter(p => p.category === categoryConfig.category).length;
        
        // 获取该分类的学习进度数（包括答对和答错的题目）
        const studiedCount = await this.userProgressDao.getStudyProgressCountByCategory(categoryConfig.category);
        
        // 获取该分类的正确率
        const accuracy = await this.userProgressDao.getAccuracyByCategory(categoryConfig.category);
        
        const progress: CategoryProgress = {
          categoryName: categoryConfig.name,
          icon: categoryConfig.icon,
          solved: studiedCount, // 修改：使用学习进度数而不是只计算答对的
          total: totalProblems,
          accuracy: accuracy, // 修改：使用真实的正确率计算
          color: categoryConfig.color
        };
        
        progressList.push(progress);
      }
      
      this.categoryProgress = progressList;
      console.info('📊 分类进度数据:', this.categoryProgress);
    } catch (error) {
      console.error('❌ 加载分类进度失败:', error);
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      throw new Error('加载分类进度失败: ' + errorMessage);
    }
  }

  /**
   * 加载周学习数据
   */
  private async loadWeeklyData(): Promise<void> {
    try {
      // 生成近7天的数据
      const weeklyData: WeeklyData[] = [];
      const today = new Date();
      const dayNames = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
      
      for (let i = 6; i >= 0; i--) {
        const date = new Date(today);
        date.setDate(today.getDate() - i);
        
        // 获取该日期的完成题目数（从数据库查询真实数据）
        const solved = await this.userProgressDao.getCompletedCountByDate(date);
        
        weeklyData.push({
          date: dayNames[date.getDay()],
          solved: solved
        });
      }
      
      this.weeklyData = weeklyData;
      console.info('📅 周学习数据:', this.weeklyData);
    } catch (error) {
      console.error('❌ 加载周学习数据失败:', error);
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      throw new Error('加载周学习数据失败: ' + errorMessage);
    }
  }

  /**
   * 设置默认数据（降级方案）
   */
  private setDefaultData(): void {
    console.info('🎯 使用默认统计数据');
    this.studyStats = {
      totalSolved: 0,
      continuousDays: 0,
      totalStudyTime: 0,
      averageAccuracy: 0,
      favoriteCount: 0,
      wrongCount: 0
    };

    this.categoryProgress = [
      { categoryName: '数组', icon: $r('app.media.chart_icon'), solved: 0, total: 10, accuracy: 0, color: '#1890ff' },
      { categoryName: '链表', icon: $r('app.media.link_icon'), solved: 0, total: 10, accuracy: 0, color: '#52c41a' },
      { categoryName: '栈', icon: $r('app.media.book_icon'), solved: 0, total: 10, accuracy: 0, color: '#fa8c16' },
      { categoryName: '二叉树', icon: $r('app.media.tree_icon'), solved: 0, total: 10, accuracy: 0, color: '#13c2c2' },
      { categoryName: '图', icon: $r('app.media.map_icon'), solved: 0, total: 10, accuracy: 0, color: '#722ed1' },
      { categoryName: '动态规划', icon: $r('app.media.laptop_icon'), solved: 0, total: 10, accuracy: 0, color: '#eb2f96' },
      { categoryName: '贪心', icon: $r('app.media.target_icon'), solved: 0, total: 10, accuracy: 0, color: '#f5222d' },
      { categoryName: '回溯', icon: $r('app.media.star_icon'), solved: 0, total: 10, accuracy: 0, color: '#fa541c' }
    ];

    this.weeklyData = [
      { date: '周一', solved: 0 },
      { date: '周二', solved: 0 },
      { date: '周三', solved: 0 },
      { date: '周四', solved: 0 },
      { date: '周五', solved: 0 },
      { date: '周六', solved: 0 },
      { date: '周日', solved: 0 }
    ];
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

  // 获取周学习趋势图表数据
  private getWeeklyChartData(): ChartData {
    const result: ChartData = {
      labels: this.weeklyData.map((item: WeeklyData): string => item.date),
      datasets: []
    };
    
    const dataset: ChartDataset = {
      label: '每日解题数',
      data: this.weeklyData.map((item: WeeklyData): number => item.solved),
      borderColor: '#1890ff',
      backgroundColor: 'rgba(24, 144, 255, 0.1)',
      tension: 0.4
    };
    result.datasets.push(dataset);
    
    return result;
  }

  // 获取分类进度饼图数据
  private getCategoryPieData(): ChartData {
    const completedCategories: CategoryProgress[] = this.categoryProgress.filter((cat: CategoryProgress): boolean => cat.solved > 0);
    
    const result: ChartData = {
      labels: completedCategories.map((cat: CategoryProgress): string => cat.categoryName),
      datasets: []
    };
    
    const dataset: ChartDataset = {
      data: completedCategories.map((cat: CategoryProgress): number => cat.solved),
      backgroundColor: completedCategories.map((cat: CategoryProgress): string => cat.color),
      borderWidth: 2,
      borderColor: '#ffffff'
    };
    result.datasets.push(dataset);
    
    return result;
  }

  // 获取学习时间柱状图数据
  private getStudyTimeBarData(): ChartData {
    // 模拟每日学习时间数据（分钟）
    const dailyStudyTime: number[] = [45, 60, 30, 75, 90, 40, 35];
    const days: string[] = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    
    const result: ChartData = {
      labels: days,
      datasets: []
    };
    
    const colors: string[] = [
      '#ff6b6b', '#4ecdc4', '#45b7d1', 
      '#96ceb4', '#feca57', '#ff9ff3', '#54a0ff'
    ];
    
    const dataset: ChartDataset = {
      label: '学习时长(分钟)',
      data: dailyStudyTime,
      backgroundColor: colors,
      borderRadius: 4
    };
    result.datasets.push(dataset);
    
    return result;
  }

  // 获取分类完成度柱状图数据
  private getCategoryBarData(): ChartData {
    const result: ChartData = {
      labels: this.categoryProgress.map((cat: CategoryProgress): string => cat.categoryName),
      datasets: []
    };
    
    const dataset1: ChartDataset = {
      label: '已完成',
      data: this.categoryProgress.map((cat: CategoryProgress): number => cat.solved),
      backgroundColor: this.categoryProgress.map((cat: CategoryProgress): string => cat.color),
      borderRadius: 4
    };
    result.datasets.push(dataset1);
    
    const dataset2: ChartDataset = {
      label: '总题数',
      data: this.categoryProgress.map((cat: CategoryProgress): number => cat.total),
      backgroundColor: this.categoryProgress.map((cat: CategoryProgress): string => cat.color + '30'),
      borderRadius: 4
    };
    result.datasets.push(dataset2);
    
    return result;
  }

  private navigateToFavorites(): void {
    // 导航到收藏页面
    router.pushUrl({
      url: 'pages/FavoritesPage'
    }).then(() => {
      console.info('✅ 成功导航到收藏页面');
    }).catch((error: Error) => {
      console.error('❌ 导航到收藏页面失败:', error);
    });
  }

  private navigateToWrongProblems(): void {
    // 导航到错题本
    router.pushUrl({
      url: 'pages/WrongProblemsPage'
    }).then(() => {
      console.info('✅ 成功导航到错题本页面');
    }).catch((error: Error) => {
      console.error('❌ 导航到错题本页面失败:', error);
    });
  }

  private generateReport(): void {
    try {
      console.info('📊 开始生成学习报告');
      
      // 生成报告内容
      const reportContent = this.buildReportContent();
      
      // 显示报告对话框
      this.showReportDialog(reportContent);
      
      console.info('✅ 学习报告生成完成');
    } catch (error) {
      console.error('❌ 生成学习报告失败:', error);
    }
  }

  /**
   * 构建报告内容
   */
  private buildReportContent(): string {
    const stats = this.studyStats;
    const topCategories = this.categoryProgress
      .filter(cat => cat.solved > 0)
      .sort((a, b) => b.solved - a.solved)
      .slice(0, 3);
    
    const currentDate = new Date().toLocaleDateString('zh-CN');
    
    let report = `📊 学习报告\n\n`;
    report += `📅 报告日期：${currentDate}\n\n`;
    
    // 核心数据
    report += `🎯 核心成就：\n`;
    report += `• 学习题数：${stats.totalSolved}题\n`;
    report += `• 连续学习：${stats.continuousDays}天\n`;
    report += `• 学习时长：${this.formatStudyTime(stats.totalStudyTime)}\n`;
    report += `• 平均正确率：${stats.averageAccuracy}%\n\n`;
    
    // 学习等级
    report += `🏆 学习等级：${this.getStudyLevel()}\n\n`;
    
    // 收藏和错题
    report += `📂 学习管理：\n`;
    report += `• 收藏题目：${stats.favoriteCount}题\n`;
    report += `• 错题数量：${stats.wrongCount}题\n\n`;
    
    // 优势分类
    if (topCategories.length > 0) {
      report += `🔥 优势分类：\n`;
      topCategories.forEach((cat, index) => {
        report += `${index + 1}. ${cat.categoryName}: ${cat.solved}/${cat.total}题 (学习进度${Math.round((cat.solved/cat.total)*100)}%, 正确率${cat.accuracy}%)\n`;
      });
      report += `\n`;
    }
    
    // 学习建议
    report += `📝 学习建议：\n`;
    if (stats.continuousDays < 7) {
      report += `• 建议保持每日练习，提高连续学习天数\n`;
    }
    if (stats.wrongCount > 0) {
      report += `• 关注错题本，及时复习错误题目\n`;
    }
    if (stats.averageAccuracy < 80) {
      report += `• 需要加强练习，提高解题准确率\n`;
    }
    report += `• 尝试挑战更高难度的题目，拓展知识面\n`;
    
    return report;
  }

  /**
   * 显示报告对话框
   */
  private showReportDialog(content: string): void {
    // 这里使用简单的提示，实际项目中可以使用更美观的对话框
    AlertDialog.show({
      title: '📊 学习报告',
      message: content,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: '关闭',
        action: () => {
          console.info('关闭学习报告对话框');
        }
      },
      secondaryButton: {
        value: '复制报告',
        action: () => {
          this.copyReportToClipboard(content);
        }
      }
    });
  }

  /**
   * 复制报告到剪贴板
   */
  private copyReportToClipboard(content: string): void {
    try {
      // 创建剪贴板数据
      const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, content);
      
      // 获取系统剪贴板
      const systemPasteboard = pasteboard.getSystemPasteboard();
      
      // 将数据写入剪贴板
      systemPasteboard.setData(pasteData).then(() => {
        console.info('✅ 学习报告已复制到剪贴板');
        
        // 显示成功提示
        promptAction.showToast({
          message: '学习报告已复制到剪贴板 📋',
          duration: 2000
        });
      }).catch((error: Error) => {
        console.error('❌ 复制到剪贴板失败:', error);
        
        // 显示错误提示
        promptAction.showToast({
          message: '复制失败，请重试',
          duration: 2000
        });
      });
    } catch (error) {
      console.error('❌ 创建剪贴板数据失败:', error);
      
      // 显示错误提示
      promptAction.showToast({
        message: '复制功能暂不可用',
        duration: 2000
      });
    }
  }
}