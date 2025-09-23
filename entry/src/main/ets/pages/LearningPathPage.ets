import { ProblemCategory } from '../model/ProblemModel';
import { ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { TabNavigationService } from '../service/TabNavigationService';
import router from '@ohos.router';

interface LearningPath {
  category: ProblemCategory;
  title: string;
  description: string;
  icon: Resource;
  totalProblems: number;
  completedProblems: number;
  difficulty: string;
  estimatedTime: string;
  color: string;
}

interface PathConfig {
  category: ProblemCategory;
  title: string;
  description: string;
  icon: Resource;
  difficulty: string;
  estimatedTime: string;
  color: string;
}

@Entry
@Component
export struct LearningPathPage {
  @State learningPaths: LearningPath[] = [];
  @State selectedPath: LearningPath | null = null;
  @State isLoading: boolean = true;
  @StorageLink('learningPathRefreshTrigger') @Watch('onRefreshTriggerChange') refreshTrigger: number = 0;
  
  // 使用mock数据，不再需要数据库实例
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadLearningPaths();
  }

  /**
   * 监听refreshTrigger变化，实现Tab切换时自动刷新
   */
  onRefreshTriggerChange() {
    if (this.refreshTrigger > 0) {
      this.loadLearningPaths();
    }
  }

  /**
   * 刷新学习路线数据
   * 供外部调用，用于Tab切换时更新数据
   */
  refreshData(): void {
    this.loadLearningPaths();
  }

  build() {
    Column({ space: 16 }) {
      // 页面标题
      // this.buildHeader()

      if (this.isLoading) {
        // 加载状态
        this.buildLoadingState()
      } else {
        // 学习路线列表
        this.buildPathList()
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
      Text('🗺️ 学习路线')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .textAlign(TextAlign.Center)

      Text('系统化学习算法，循序渐进提升能力')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#1890ff')

      Text('正在加载学习路线...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildPathList() {
    List({ space: 12 }) {
      ForEach(this.learningPaths, (path: LearningPath) => {
        ListItem() {
          this.buildPathCard(path)
        }
      }, (path: LearningPath) => path.category.toString())
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildPathCard(path: LearningPath) {
    Column({ space: 12 }) {
      // 卡片头部
      Row({ space: 12 }) {
        Column({ space: 4 }) {
          Text(path.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          Text(path.description)
            .fontSize(14)
            .fontColor('#666666')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 4 }) {
          Text(path.difficulty)
            .fontSize(12)
            .fontColor('#ffffff')
            .backgroundColor(this.getDifficultyColor(path.difficulty))
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(10)

          Text(path.estimatedTime)
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 进度条
      Column({ space: 8 }) {
        Row() {
          Text('学习进度')
            .fontSize(14)
            .fontColor('#666666')

          Blank()

          Text(path.completedProblems + '/' + path.totalProblems)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')

        Progress({
          value: path.completedProblems,
          total: path.totalProblems,
          type: ProgressType.Linear
        })
        .width('100%')
        .height(6)
        .color(path.color)
        .backgroundColor('#f0f0f0')
      }

      // 操作按钮
      Row({ space: 12 }) {
        Button('查看详情')
          .layoutWeight(1)
          .height(36)
          .backgroundColor('#ffffff')
          .fontColor(path.color)
          .border({ width: 1, color: path.color })
          .borderRadius(8)
          .onClick(() => {
            this.showPathDetail(path);
          })

        Button(path.completedProblems > 0 ? '继续学习' : '开始学习')
          .layoutWeight(1)
          .height(36)
          .backgroundColor(path.color)
          .fontColor('#ffffff')
          .borderRadius(8)
          .onClick(() => {
            this.startLearning(path);
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      this.showPathDetail(path);
    })
  }

  private async loadLearningPaths(): Promise<void> {
    try {
      this.isLoading = true;
      
      // 获取基础路线配置
      const pathConfigs = this.getPathConfigs();
      const paths: LearningPath[] = [];
      
      // 为每个路线加载真实数据
      for (const config of pathConfigs) {
        const allProblems = ProblemMockData.getAllProblems();
        const totalProblems = allProblems.filter(p => p.category === config.category).length;
        const completedProblems = await this.userProgressDao.getCompletedCountByCategory(config.category);
        
        const path: LearningPath = {
          category: config.category,
          title: config.title,
          description: config.description,
          icon: config.icon,
          totalProblems: totalProblems,
          completedProblems: completedProblems,
          difficulty: config.difficulty,
          estimatedTime: config.estimatedTime,
          color: config.color
        };
        
        paths.push(path);
      }
      
      this.learningPaths = paths;
    } catch (error) {
      console.error('Failed to load learning paths:', error);
      // 如果加载失败，使用默认数据
      this.learningPaths = this.getDefaultPaths();
    } finally {
      this.isLoading = false;
    }
  }

  private getPathConfigs(): PathConfig[] {
    const configs: PathConfig[] = [];
    
    const config1: PathConfig = {
      category: ProblemCategory.ARRAY,
      title: '数组与字符串',
      description: '掌握基础数据结构操作，学习双指针、滑动窗口等经典技巧',
      icon: $r('app.media.chart_icon'),
      difficulty: '入门',
      estimatedTime: '2-3周',
      color: '#1890ff'
    };
    
    const config2: PathConfig = {
      category: ProblemCategory.LINKED_LIST,
      title: '链表操作',
      description: '理解指针概念，掌握链表的增删改查、反转、合并等操作',
      icon: $r('app.media.search_icon'),
      difficulty: '基础',
      estimatedTime: '1-2周',
      color: '#52c41a'
    };
    
    const config3: PathConfig = {
      category: ProblemCategory.STRING,
      title: '字符串算法',
      description: '学习字符串匹配、编辑距离、回文等经典字符串问题',
      icon: $r('app.media.note_icon'),
      difficulty: '基础',
      estimatedTime: '1-2周',
      color: '#fa8c16'
    };
    
    const config4: PathConfig = {
      category: ProblemCategory.BINARY_TREE,
      title: '二叉树',
      description: '掌握树的遍历、搜索、构建，理解二叉搜索树的性质',
      icon: $r('app.media.book_icon'),
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#13c2c2'
    };
    
    const config5: PathConfig = {
      category: ProblemCategory.TWO_POINTERS,
      title: '双指针技巧',
      description: '学习快慢指针、左右指针等技巧，解决数组和链表问题',
      icon: $r('app.media.target_icon'),
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#722ed1'
    };
    
    const config6: PathConfig = {
      category: ProblemCategory.DYNAMIC_PROGRAMMING,
      title: '动态规划',
      description: '掌握状态转移思想，解决背包、路径、序列等经典DP问题',
      icon: $r('app.media.computer_icon'),
      difficulty: '高级',
      estimatedTime: '4-5周',
      color: '#eb2f96'
    };
    
    const config7: PathConfig = {
      category: ProblemCategory.BINARY_SEARCH,
      title: '二分查找',
      description: '学习二分查找思想，解决搜索、边界查找等问题',
      icon: $r('app.media.search_icon'),
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#f5222d'
    };
    
    const config8: PathConfig = {
      category: ProblemCategory.MATH,
      title: '数学算法',
      description: '掌握数学思维，解决数论、几何、概率等数学问题',
      icon: $r('app.media.computer_icon'),
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#fa541c'
    };
    
    const config9: PathConfig = {
      category: ProblemCategory.STACK,
      title: '栈与队列',
      description: '掌握栈和队列的基本操作，学习单调栈、优先队列等高级应用',
      icon: $r('app.media.book_icon'),
      difficulty: '基础',
      estimatedTime: '2-3周',
      color: '#52c41a'
    };
    
    configs.push(config1, config2, config3, config4, config5, config6, config7, config8, config9);
    return configs;
  }

  private getDefaultPaths(): LearningPath[] {
    const paths: LearningPath[] = [];
    
    const path1: LearningPath = {
      category: ProblemCategory.ARRAY,
      title: '数组与字符串',
      description: '掌握基础数据结构操作，学习双指针、滑动窗口等经典技巧',
      icon: $r('app.media.chart_icon'),
      totalProblems: 25,
      completedProblems: 0,
      difficulty: '入门',
      estimatedTime: '2-3周',
      color: '#1890ff'
    };
    
    const path2: LearningPath = {
      category: ProblemCategory.LINKED_LIST,
      title: '链表操作',
      description: '理解指针概念，掌握链表的增删改查、反转、合并等操作',
      icon: $r('app.media.book_icon'),
      totalProblems: 18,
      completedProblems: 0,
      difficulty: '基础',
      estimatedTime: '1-2周',
      color: '#52c41a'
    };
    
    const path3: LearningPath = {
      category: ProblemCategory.STRING,
      title: '字符串算法',
      description: '学习字符串匹配、编辑距离、回文等经典字符串问题',
      icon: $r('app.media.note_icon'),
      totalProblems: 20,
      completedProblems: 0,
      difficulty: '基础',
      estimatedTime: '1-2周',
      color: '#fa8c16'
    };
    
    const path4: LearningPath = {
      category: ProblemCategory.BINARY_TREE,
      title: '二叉树',
      description: '掌握树的遍历、搜索、构建，理解二叉搜索树的性质',
      icon: $r('app.media.book_icon'),
      totalProblems: 22,
      completedProblems: 0,
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#13c2c2'
    };
    
    const path5: LearningPath = {
      category: ProblemCategory.TWO_POINTERS,
      title: '双指针技巧',
      description: '学习快慢指针、左右指针等技巧，解决数组和链表问题',
      icon: $r('app.media.target_icon'),
      totalProblems: 15,
      completedProblems: 0,
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#722ed1'
    };
    
    const path6: LearningPath = {
      category: ProblemCategory.DYNAMIC_PROGRAMMING,
      title: '动态规划',
      description: '掌握状态转移思想，解决背包、路径、序列等经典DP问题',
      icon: $r('app.media.computer_icon'),
      totalProblems: 30,
      completedProblems: 0,
      difficulty: '高级',
      estimatedTime: '4-5周',
      color: '#eb2f96'
    };
    
    const path7: LearningPath = {
      category: ProblemCategory.BINARY_SEARCH,
      title: '二分查找',
      description: '掌握二分查找思想，解决搜索、边界查找等问题',
      icon: $r('app.media.search_icon'),
      totalProblems: 12,
      completedProblems: 0,
      difficulty: '进阶',
      estimatedTime: '1-2周',
      color: '#f5222d'
    };
    
    const path8: LearningPath = {
      category: ProblemCategory.MATH,
      title: '数学算法',
      description: '学习数论、组合数学、概率等数学相关算法',
      icon: $r('app.media.computer_icon'),
      totalProblems: 18,
      completedProblems: 0,
      difficulty: '进阶',
      estimatedTime: '2-3周',
      color: '#fa541c'
    };
    
    const path9: LearningPath = {
      category: ProblemCategory.STACK,
      title: '栈与队列',
      description: '掌握栈和队列的基本操作，学习单调栈、优先队列等高级应用',
      icon: $r('app.media.book_icon'),
      totalProblems: 20,
      completedProblems: 0,
      difficulty: '基础',
      estimatedTime: '2-3周',
      color: '#52c41a'
    };
    
    paths.push(path1, path2, path3, path4, path5, path6, path7, path8, path9);
    return paths;
  }

  private getDifficultyColor(difficulty: string): string {
    switch (difficulty) {
      case '入门':
        return '#52c41a';
      case '基础':
        return '#1890ff';
      case '进阶':
        return '#fa8c16';
      case '高级':
        return '#f5222d';
      default:
        return '#666666';
    }
  }

  private showPathDetail(path: LearningPath): void {
    // 切换到练习中心Tab，并传递分类参数
    const tabNavigationService = TabNavigationService.getInstance();
    tabNavigationService.switchToPracticeCenter();
    
    // 使用AppStorage来传递参数到练习中心页面
    AppStorage.setOrCreate('selectedCategory', path.category);
    AppStorage.setOrCreate('selectedCategoryTitle', path.title);
  }

  private async startLearning(path: LearningPath): Promise<void> {
    try {
      // 获取该分类的第一道未完成题目
      const allProblems = ProblemMockData.getAllProblems();
      const problems = allProblems.filter(p => p.category === path.category);
      if (problems.length === 0) {
        console.info('No problems found for category:', path.category);
        return;
      }

      // 查找第一道未完成的题目
      let targetProblem = problems[0];
      for (const problem of problems) {
        const progress = await this.userProgressDao.getUserProgress(problem.id);
        if (!progress || progress.status !== ProblemStatus.COMPLETED) {
          targetProblem = problem;
          break;
        }
      }

      // 跳转到题目详情页面
      router.pushUrl({
        url: 'pages/ProblemDetailPage',
        params: {
          problemId: targetProblem.id,
          fromPath: true,
          pathCategory: path.category
        }
      }).catch((error: Error) => {
        console.error('Failed to navigate to problem detail:', error);
      });
    } catch (error) {
      console.error('Failed to start learning:', error);
    }
  }
}