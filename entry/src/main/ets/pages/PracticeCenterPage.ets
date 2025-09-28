import router from '@ohos.router';
import util from '@ohos.util';
import { ProblemModel, ProblemType, ProblemCategory, ProblemDifficulty, ProblemSource } from '../model/ProblemModel';
import { ProblemService } from '../service/ProblemService';

import { AppButton } from '../components/AppButton';

import { ProblemMockData } from '../mock/ProblemMockData';

interface InterviewQuestion {
  id: number;
  title: string;
  answer: string;
  category: number;
  difficulty: number;
}

interface CategoryConfig {
  category: ProblemCategory;
  name: string;
  icon: Resource;
  color: string;
}

@Component
export struct PracticeCenterPage {
  // 笔试题相关状态
  @State problems: ProblemModel[] = [];
  @State filteredProblems: ProblemModel[] = [];
  @State selectedCategory: ProblemCategory | null = null;
  @State searchText: string = '';
  @State isLoading: boolean = false;

  
  // Tab控制
  @State currentTabIndex: number = 0; // 0: 面试题, 1: 笔试题
  private tabsController: TabsController = new TabsController();
  
  // 面试题相关状态
  @State interviewQuestions: InterviewQuestion[] = [];
  @State filteredInterviewQuestions: InterviewQuestion[] = [];
  @State interviewSelectedCategory: string = '全部';
  @State interviewSearchKeyword: string = '';
  @State showDetailDialog: boolean = false;
  @State selectedQuestion: InterviewQuestion | null = null;
  @State showInterviewCategoryDialog: boolean = false;
  
  @State selectedDifficulty: ProblemDifficulty | null = null;
  @State isExpanded: boolean = false; // 控制题目类型展开状态
  @State interviewCount: number = 0; // 面试题数量
  @State writtenTestCount: number = 0; // 笔试题数量
  @StorageLink('selectedCategory') @Watch('onExternalCategoryChange') externalSelectedCategory: ProblemCategory | null = null;
  @StorageLink('selectedCategoryTitle') externalSelectedCategoryTitle: string = '';

  aboutToAppear() {
    this.loadInterviewQuestions();
    this.loadProblems();
    this.loadProblemsCount();
  }

  /**
   * 监听外部分类变化，实现学习路线跳转时自动切换分类
   */
  onExternalCategoryChange() {
    if (this.externalSelectedCategory) {
      this.selectedCategory = this.externalSelectedCategory;
      this.loadProblems();
      
      // 清除参数，避免下次进入时还保持选中状态
       AppStorage.set('selectedCategory', null);
       AppStorage.set('selectedCategoryTitle', '');
    }
  }

  build() {
    Stack() {
      // 主要内容
      Column() {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
          // 面试题Tab
          TabContent() {
            this.buildInterviewContent()
          }
          .tabBar(this.buildInterviewTabBarItem('面试题', 0))

          // 笔试题Tab
          TabContent() {
            this.buildAlgorithmContent()
          }
          .tabBar(this.buildTabBarItem('笔试题', this.writtenTestCount, 1))
        }
        .animationDuration(300)
        .scrollable(false)
        .backgroundColor('#F8F9FA')
        .barMode(BarMode.Fixed)
        .barHeight(56)
        .onChange((index: number) => {
          this.currentTabIndex = index;
          // 切换Tab时重置筛选条件
          if (index === 0) {
            // 面试题Tab
            this.interviewSelectedCategory = '全部';
            this.interviewSearchKeyword = '';
            this.filteredInterviewQuestions = this.interviewQuestions;
          } else {
            // 笔试题Tab
            this.selectedCategory = null;
            this.searchText = '';
            this.loadProblems();
          }
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F9FA')

      // 面试题详情弹窗
      if (this.showDetailDialog && this.selectedQuestion) {
        this.buildInterviewDetailDialog()
      }

      // 面试题分类选择器
      if (this.showInterviewCategoryDialog) {
        Stack() {
          // 背景遮罩
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('rgba(0, 0, 0, 0.5)')
            .onClick(() => {
              this.showInterviewCategoryDialog = false;
            })

          // 选择器内容
          this.buildInterviewCategorySelector()
        }
        .width('100%')
        .height('100%')
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildTabBarItem(title: string, count: number, index: number) {
    Column({ space: 4 }) {
      Row({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontColor(this.currentTabIndex === index ? '#F34F40' : '#666666')
          .fontWeight(this.currentTabIndex === index ? FontWeight.Medium : FontWeight.Normal)

        Text(`(${count})`)
          .fontSize(12)
          .fontColor(this.currentTabIndex === index ? '#F34F40' : '#999999')
          .backgroundColor(this.currentTabIndex === index ? '#FFF2F0' : '#F5F5F5')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(10)
      }
      .justifyContent(FlexAlign.Center)

      // 底部指示线
      if (this.currentTabIndex === index) {
        Divider()
          .width(30)
          .height(2)
          .color('#F34F40')
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildInterviewTabBarItem(title: string, index: number) {
    Column({ space: 4 }) {
      Row({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontColor(this.currentTabIndex === index ? '#F34F40' : '#666666')
          .fontWeight(this.currentTabIndex === index ? FontWeight.Medium : FontWeight.Normal)

        Text(`(${this.interviewCount})`)
          .fontSize(12)
          .fontColor(this.currentTabIndex === index ? '#F34F40' : '#999999')
          .backgroundColor(this.currentTabIndex === index ? '#FFF2F0' : '#F5F5F5')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(10)
      }
      .justifyContent(FlexAlign.Center)

      // 底部指示线
      if (this.currentTabIndex === index) {
        Divider()
          .width(30)
          .height(2)
          .color('#F34F40')
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildInterviewContent() {
    Column({ space: 12 }) {
      // 面试题搜索栏
      this.buildInterviewSearchBar()

      // 面试题筛选栏
      this.buildInterviewFilterBar()

      // 面试题列表
      List({ space: 12 }) {
        ForEach(this.filteredInterviewQuestions, (question: InterviewQuestion) => {
          ListItem() {
            this.buildInterviewQuestionItem(question)
          }
        }, (question: InterviewQuestion) => question.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F8F8F8')
  }

  @Builder
  buildAlgorithmContent() {
    Column({ space: 8 }) {
      // 搜索栏
      this.buildSearchBar()

      // 题目类型标签栏
      this.buildCategoryTabs()

      // 题目列表
      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        this.buildProblemsList()
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 16 })
  }

  @Builder
  buildSearchBar() {
    Row({ space: 12 }) {
      TextInput({ placeholder: '搜索题目名称或关键词...' })
        .layoutWeight(1)
        .height(36)
        .placeholderColor('#D5DBDB')
        .backgroundColor('#ffffff')
        .borderRadius(18)
        .padding({ left: 14, right: 14 })
        .fontSize(14)
        .onChange((value: string) => {
          this.searchText = value;
          this.searchProblems();
        })
    }
    .width('100%')
  }



  @Builder
  buildCategoryTabs() {
    Column({ space: 4 }) {
      // 标题和展开/收叠按钮
      Row({ space: 8 }) {
        Text('题目类型')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
        
        Blank()
        
        // 展开/收叠按钮
        Row({ space: 4 }) {
          Text(this.isExpanded ? '收起' : '展开')
            .fontSize(12)
            .fontColor('#666666')
          
          Text(this.isExpanded ? '▲' : '▼')
            .fontSize(10)
            .fontColor('#666666')
            .animation({
              duration: 300,
              curve: Curve.EaseInOut
            })
        }
        .onClick(() => {
          animateTo({
            duration: 300,
            curve: Curve.EaseInOut
          }, () => {
            this.isExpanded = !this.isExpanded;
          })
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // 标签区域
      Column() {
        if (this.isExpanded) {
          // 展开状态：显示所有标签
          this.buildAllCategoryTags()
        } else {
          // 收起状态：显示常用标签和当前选中的标签
          this.buildCompactCategoryTags()
        }
      }
      .width('100%')
      .clip(true)
      .animation({
        duration: 300,
        curve: Curve.EaseInOut
      })
    }
    .width('100%')
    .margin({ bottom: 4 })
  }

  @Builder
  buildAllCategoryTags() {
    Flex({ 
      direction: FlexDirection.Row, 
      wrap: FlexWrap.Wrap, 
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Start
    }) {
      // 全部标签
      this.buildCategoryButton('全部', null)

      // 全部分类标签
      ForEach(this.getCategoryConfigs(), (config: CategoryConfig) => {
        this.buildCategoryButton(config.name, config.category)
      }, (config: CategoryConfig) => config.category.toString())
    }
    .width('100%')
  }

  @Builder
  buildCompactCategoryTags() {
    Flex({ 
      direction: FlexDirection.Row, 
      wrap: FlexWrap.Wrap, 
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Start
    }) {
      // 全部标签
      this.buildCategoryButton('全部', null)

      // 常用分类（前6个）
      ForEach(this.getPopularCategories(), (config: CategoryConfig) => {
        this.buildCategoryButton(config.name, config.category)
      }, (config: CategoryConfig) => config.category.toString())

      // 如果当前选中的分类不在常用列表中，单独显示
      if (this.selectedCategory && !this.isInPopularCategories(this.selectedCategory)) {
        this.buildCategoryButton(this.getCategoryName(this.selectedCategory), this.selectedCategory)
      }
    }
    .width('100%')
  }

  @Builder
  buildCategoryButton(name: string, category: ProblemCategory | null) {
    Button(name)
      .type(ButtonType.Normal)
      .backgroundColor(this.selectedCategory === category ? '#F34F40' : '#F2F2F7')
      .fontColor(this.selectedCategory === category ? '#FFFFFF' : '#3C3C43')
      .fontSize(12)
      .fontWeight(this.selectedCategory === category ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(10)
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
      .margin({ right: 4, bottom: 4 })
      .height(28)
      .onClick(() => {
        this.selectedCategory = category;
        this.loadProblems();
      })
  }



  @Builder
  buildLoadingState() {
    Column() {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#1890ff')
        .margin({ bottom: 16 })
      
      Text('正在加载题目...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildProblemsList() {
    Column({ space: 8 }) {
      Row() {
        Row({ space: 8 }) {
          Text(this.selectedCategory !== null ? this.getCategoryName(this.selectedCategory) : '全部题目')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }

        Blank()

        Text('共' + this.problems.length + '题')
          .fontSize(13)
          .fontColor('#666666')
      }
      .width('100%')
      .margin({ top: 2 })

      if (this.problems.length === 0) {
        Column({ space: 8 }) {
          Image($r('app.media.search_icon'))
            .width(48)
            .height(48)
            .fillColor('#cccccc')

          Text('暂无题目')
            .fontSize(14)
            .fontColor('#999999')

          Text('请稍后再试')
            .fontSize(12)
            .fontColor('#cccccc')
        }
        .width('100%')
        .height(150)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        List({ space: 8 }) {
          ForEach(this.problems, (problem: ProblemModel) => {
            ListItem() {
              this.buildProblemItem(problem)
            }
          }, (problem: ProblemModel) => problem.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  buildProblemItem(problem: ProblemModel) {
    Row({ space: 12 }) {
      // 状态图标
      Text('⭕')
        .fontSize(16)
        .fontColor('#52c41a')

      // 题目信息
      Column({ space: 4 }) {
        Text(problem.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 8 }) {
          Text(problem.getDifficultyText())
            .fontSize(12)
            .fontColor('#ffffff')
            .backgroundColor(problem.getDifficultyColor())
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .borderRadius(4)

          Text(problem.getCategoryText())
            .fontSize(12)
            .fontColor('#666666')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 通过率
      Text('68%')
        .fontSize(12)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .border({ width: 1, color: '#f0f0f0' })
    .onClick(() => {
      this.navigateToProblemDetail(problem.id);
    })
  }

  /**
   * 获取常用分类（前6个）
   */
  private getPopularCategories(): CategoryConfig[] {
    const allConfigs = this.getCategoryConfigs();
    // 返回前6个常用分类
    return allConfigs.slice(0, 6);
  }

  /**
   * 判断分类是否在常用列表中
   */
  private isInPopularCategories(category: ProblemCategory): boolean {
    const popularCategories = this.getPopularCategories();
    return popularCategories.some(config => config.category === category);
  }

  private getCategoryConfigs(): CategoryConfig[] {
    const configs: CategoryConfig[] = [];
    
    const config1: CategoryConfig = { category: ProblemCategory.ARRAY, name: '数组', icon: $r('app.media.chart_icon'), color: '#1890ff' };
    const config2: CategoryConfig = { category: ProblemCategory.STRING, name: '字符串', icon: $r('app.media.note_icon'), color: '#52c41a' };
    const config3: CategoryConfig = { category: ProblemCategory.LINKED_LIST, name: '链表', icon: $r('app.media.search_icon'), color: '#fa8c16' };
    const config4: CategoryConfig = { category: ProblemCategory.BINARY_TREE, name: '二叉树', icon: $r('app.media.book_icon'), color: '#13c2c2' };
    const config5: CategoryConfig = { category: ProblemCategory.TWO_POINTERS, name: '双指针', icon: $r('app.media.target_icon'), color: '#722ed1' };
    const config6: CategoryConfig = { category: ProblemCategory.BINARY_SEARCH, name: '二分查找', icon: $r('app.media.search_icon'), color: '#eb2f96' };
    const config7: CategoryConfig = { category: ProblemCategory.MATH, name: '数学', icon: $r('app.media.computer_icon'), color: '#f5222d' };
    const config8: CategoryConfig = { category: ProblemCategory.DYNAMIC_PROGRAMMING, name: '动态规划', icon: $r('app.media.target_icon'), color: '#fa541c' };
    const config9: CategoryConfig = { category: ProblemCategory.STACK, name: '栈与队列', icon: $r('app.media.book_icon'), color: '#52c41a' };
    const config10: CategoryConfig = { category: ProblemCategory.HASH_TABLE, name: '哈希表', icon: $r('app.media.chart_icon'), color: '#2f54eb' };
    const config11: CategoryConfig = { category: ProblemCategory.BACKTRACKING, name: '回溯算法', icon: $r('app.media.target_icon'), color: '#722ed1' };
    const config12: CategoryConfig = { category: ProblemCategory.GREEDY, name: '贪心算法', icon: $r('app.media.computer_icon'), color: '#52c41a' };
    const config13: CategoryConfig = { category: ProblemCategory.BIT_MANIPULATION, name: '位运算', icon: $r('app.media.note_icon'), color: '#13c2c2' };
    const config14: CategoryConfig = { category: ProblemCategory.DESIGN, name: '设计题', icon: $r('app.media.book_icon'), color: '#fa8c16' };
    const config15: CategoryConfig = { category: ProblemCategory.DIVIDE_CONQUER, name: '分治算法', icon: $r('app.media.target_icon'), color: '#eb2f96' };
    const config16: CategoryConfig = { category: ProblemCategory.SLIDING_WINDOW, name: '滑动窗口', icon: $r('app.media.search_icon'), color: '#f5222d' };
    const config17: CategoryConfig = { category: ProblemCategory.PREFIX_SUM, name: '前缀和', icon: $r('app.media.chart_icon'), color: '#fa541c' };
    const config18: CategoryConfig = { category: ProblemCategory.MONOTONIC_STACK, name: '单调栈', icon: $r('app.media.book_icon'), color: '#1890ff' };
    const config19: CategoryConfig = { category: ProblemCategory.TRIE, name: '字典树', icon: $r('app.media.note_icon'), color: '#722ed1' };
    const config20: CategoryConfig = { category: ProblemCategory.GRAPH, name: '图论', icon: $r('app.media.target_icon'), color: '#13c2c2' };
    const config21: CategoryConfig = { category: ProblemCategory.SORT, name: '排序算法', icon: $r('app.media.computer_icon'), color: '#52c41a' };
    const config22: CategoryConfig = { category: ProblemCategory.RECURSION, name: '递归', icon: $r('app.media.note_icon'), color: '#722ed1' };
    const config23: CategoryConfig = { category: ProblemCategory.HEAP, name: '堆', icon: $r('app.media.target_icon'), color: '#13c2c2' };
    const config24: CategoryConfig = { category: ProblemCategory.QUEUE, name: '队列', icon: $r('app.media.computer_icon'), color: '#52c41a' };
    
    configs.push(config1, config2, config3, config4, config5, config6, config7, config8, config9, config10, config11,
      config12, config13, config14, config15, config16, config17, config18, config19, config20, config21, config22, config23, config24);
    return configs;
  }

  private loadProblemsCount(): void {
    try {
      const allProblems = ProblemMockData.getAllProblems();
      // 面试题数量从interviewQuestions数组获取，因为它们来自JSON文件
      // 这里先设置为0，会在loadInterviewQuestions完成后更新
      this.writtenTestCount = allProblems.filter(p => p.source === ProblemSource.WRITTEN_TEST).length;
    } catch (error) {
      console.error('Failed to load problems count:', error);
      this.interviewCount = 0;
      this.writtenTestCount = 0;
    }
  }

  private async loadProblems(): Promise<void> {
    this.isLoading = true;
    try {
      let allProblems = ProblemMockData.getAllProblems();
      
      // 首先按题目来源筛选（面试题或笔试题）
      const currentSource = this.currentTabIndex === 0 ? ProblemSource.INTERVIEW : ProblemSource.WRITTEN_TEST;
      allProblems = allProblems.filter(p => p.source === currentSource);
      
      // 然后按分类筛选
      if (this.selectedCategory !== null) {
        console.log('Filtering by category:', this.selectedCategory);
        allProblems = allProblems.filter(p => p.category === this.selectedCategory);
      }
      
      // 最后按搜索文本筛选
      if (this.searchText.trim()) {
        const searchKeyword = this.searchText.trim().toLowerCase();
        this.problems = allProblems.filter(p => 
          p.title.toLowerCase().includes(searchKeyword) || 
          p.description.toLowerCase().includes(searchKeyword)
        );
      } else {
        this.problems = allProblems;
      }
      
      console.log('Loaded problems count:', this.problems.length);
    } catch (error) {
      console.error('Failed to load problems:', error);
      this.problems = [];
    } finally {
      this.isLoading = false;
    }
  }

  private async searchProblems(): Promise<void> {
    if (this.searchText.trim()) {
      await this.loadProblems();
    } else {
      // 如果搜索文本为空，重新加载所有题目
      await this.loadProblems();
    }
  }

  // 面试题相关方法
  async loadInterviewQuestions() {
    try {
      const resourceManager = getContext(this).resourceManager;
      const fileData = await resourceManager.getRawFileContent('mianshi.json');
      const decoder = new util.TextDecoder('utf-8');
      const jsonString = decoder.decodeWithStream(new Uint8Array(fileData.buffer));
      const data = JSON.parse(jsonString) as InterviewQuestion[];
      
      this.interviewQuestions = data || [];
      this.filteredInterviewQuestions = this.interviewQuestions;
      // 更新面试题计数
      this.interviewCount = this.interviewQuestions.length;
      console.info(`Successfully loaded ${this.interviewCount} interview questions from file`);
    } catch (error) {
      console.error('Failed to load interview questions:', error);
      // 使用mock数据作为备选
      this.interviewQuestions = this.getMockInterviewQuestions();
      this.filteredInterviewQuestions = this.interviewQuestions;
      // 更新面试题计数
      this.interviewCount = this.interviewQuestions.length;
      console.info(`Using mock data with ${this.interviewCount} interview questions`);
    }
  }

  getMockInterviewQuestions(): InterviewQuestion[] {
    const mockQuestions: InterviewQuestion[] = [];
    
    const question1: InterviewQuestion = {
      id: 1,
      title: 'JavaScript中的闭包是什么？',
      answer: '闭包是指有权访问另一个函数作用域中变量的函数。闭包在JavaScript中非常重要，它允许函数访问并操作函数外部的变量。',
      category: 0,
      difficulty: 1
    };
    mockQuestions.push(question1);

    const question2: InterviewQuestion = {
      id: 2,
      title: 'Java中的多态是什么？',
      answer: '多态是面向对象编程的重要特性，指同一个接口可以有多种不同的实现方式。在Java中，多态主要通过继承和接口实现。',
      category: 0,
      difficulty: 0
    };
    mockQuestions.push(question2);

    return mockQuestions;
  }

  // 分类映射
  getInterviewCategoryName(category: number): string {
    switch (category) {
      case 0: return 'Java基础';
      case 1: return '集合框架';
      case 2: return '并发编程';
      case 3: return 'JVM原理';
      case 4: return '异常处理';
      case 5: return '注解反射';
      case 6: return '新特性';
      default: return '其他';
    }
  }

  // 难度映射
  getInterviewDifficultyName(difficulty: number): string {
    switch (difficulty) {
      case 0: return '简单';
      case 1: return '中等';
      case 2: return '困难';
      default: return '未知';
    }
  }

  filterInterviewQuestions(): void {
    this.filteredInterviewQuestions = this.interviewQuestions.filter((question: InterviewQuestion): boolean => {
      const categoryMatch = this.interviewSelectedCategory === '全部' || this.getInterviewCategoryName(question.category) === this.interviewSelectedCategory;
      const keywordMatch = this.interviewSearchKeyword === '' || 
        question.title.includes(this.interviewSearchKeyword) || 
        question.answer.includes(this.interviewSearchKeyword);
      
      return categoryMatch && keywordMatch;
    });
  }

  getInterviewDifficultyColor(difficulty: number): string {
    switch (difficulty) {
      case 0: // 简单
        return '#4CAF50';
      case 1: // 中等
        return '#FF9800';
      case 2: // 困难
        return '#F44336';
      default:
        return '#666666';
    }
  }

  getInterviewDifficultyBgColor(difficulty: number): string {
    switch (difficulty) {
      case 0: // 简单
        return '#E8F5E8';
      case 1: // 中等
        return '#FFF3E0';
      case 2: // 困难
        return '#FFEBEE';
      default:
        return '#F0F0F0';
    }
  }

  private getCategoryName(category: ProblemCategory): string {
    const categoryConfig = this.getCategoryConfigs().find(config => config.category === category);
    return categoryConfig ? categoryConfig.name : '未知分类';
  }

  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: { problemId: problemId }
    }).catch((error: Error) => {
      console.error('Failed to navigate to problem detail:', error);
    });
  }

  @Builder
  buildInterviewSearchBar() {
    TextInput({ placeholder: '搜索题目名称或关键词...' })
      .height(36)
      .placeholderColor('#D5DBDB')
      .width('100%')
      .borderRadius(18)
      .backgroundColor('#ffffff')
      .onChange((value: string) => {
        this.interviewSearchKeyword = value;
        this.filterInterviewQuestions();
      })
  }

  @Builder
  buildInterviewFilterBar() {
    Row({ space: 12 }) {
      // 分类筛选
      Button(this.interviewSelectedCategory)
        .fontSize(14)
        .backgroundColor(this.interviewSelectedCategory === '全部' ? '#4A90E2' : '#F0F0F0')
        .fontColor(this.interviewSelectedCategory === '全部' ? Color.White : '#666666')
        .borderRadius(16)
        .height(32)
        .onClick(() => {
          this.showInterviewCategorySelector();
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  buildInterviewQuestionItem(question: InterviewQuestion) {
    Column({ space: 8 }) {
      // 题目标题
      Row() {
        Text(question.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Row({ space: 4 }) {
          Text(this.getInterviewCategoryName(question.category))
            .fontSize(12)
            .fontColor('#4A90E2')
            .backgroundColor('#E3F2FD')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)

          Text(this.getInterviewDifficultyName(question.difficulty))
            .fontSize(12)
            .fontColor(this.getInterviewDifficultyColor(question.difficulty))
            .backgroundColor(this.getInterviewDifficultyBgColor(question.difficulty))
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 答案预览
      Text(question.answer)
        .fontSize(14)
        .fontColor('#666666')
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
    .onClick(() => {
      // 显示题目详情弹窗
      this.selectedQuestion = question;
      this.showDetailDialog = true;
    })
  }

  @Builder
  buildInterviewDetailDialog() {
    // 遮罩层
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .onClick(() => {
        this.showDetailDialog = false;
        this.selectedQuestion = null;
      })

    // 弹窗内容
    Column({ space: 20 }) {
      // 标题栏
      Row() {
        Text('题目详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Image($r('app.media.close_icon'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.showDetailDialog = false;
            this.selectedQuestion = null;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 题目信息
      if (this.selectedQuestion) {
        Column({ space: 16 }) {
          // 分类和难度标签
          Row({ space: 8 }) {
            Text(this.getInterviewCategoryName(this.selectedQuestion.category))
              .fontSize(12)
              .fontColor('#4A90E2')
              .backgroundColor('#E3F2FD')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(12)

            Text(this.getInterviewDifficultyName(this.selectedQuestion.difficulty))
              .fontSize(12)
              .fontColor(this.getInterviewDifficultyColor(this.selectedQuestion.difficulty))
              .backgroundColor(this.getInterviewDifficultyBgColor(this.selectedQuestion.difficulty))
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(12)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          // 题目标题
          Text(this.selectedQuestion.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 答案
          Column({ space: 8 }) {
            Text('参考答案')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .textAlign(TextAlign.Start)

            Text(this.selectedQuestion.answer)
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)
              .width('100%')
              .textAlign(TextAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('90%')
    .height('80%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(20)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
    .position({ x: '5%', y: '10%' })
  }

  /**
   * 显示面试题分类选择器
   */
  showInterviewCategorySelector() {
    this.showInterviewCategoryDialog = true;
  }

  /**
   * 获取所有面试题分类
   */
  getInterviewCategories(): string[] {
    // 从实际的面试题数据中提取所有可用的分类
    const categorySet = new Set<string>();
    categorySet.add('全部'); // 始终包含"全部"选项
    
    // 遍历所有面试题，提取分类
    this.interviewQuestions.forEach((question: InterviewQuestion) => {
      const categoryName = this.getInterviewCategoryName(question.category);
      categorySet.add(categoryName);
    });
    
    // 转换为数组并排序，确保"全部"在第一位
    const categories = Array.from(categorySet);
    const sortedCategories = categories.filter(cat => cat !== '全部').sort();
    return ['全部', ...sortedCategories];
  }

  @Builder
  buildInterviewCategorySelector() {
    Column({ space: 16 }) {
      Text('选择面试题类型')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)

      List({ space: 8 }) {
        ForEach(this.getInterviewCategories(), (category: string) => {
          ListItem() {
            Row() {
              Text(category)
                .fontSize(16)
                .layoutWeight(1)
              
              if (this.interviewSelectedCategory === category) {
                Image($r('sys.media.ohos_ic_public_ok'))
                  .width(20)
                  .height(20)
                  .fillColor('#4A90E2')
              }
            }
            .width('100%')
            .height(48)
            .padding({ left: 16, right: 16 })
            .backgroundColor(this.interviewSelectedCategory === category ? '#E3F2FD' : Color.Transparent)
            .borderRadius(8)
            .onClick(() => {
              this.interviewSelectedCategory = category;
              this.showInterviewCategoryDialog = false;
              this.filterInterviewQuestions();
            })
          }
        }, (category: string) => category)
      }
      .width('100%')
      .height(300)

      Button('取消')
        .width('100%')
        .height(40)
        .backgroundColor('#F0F0F0')
        .fontColor('#666666')
        .onClick(() => {
          this.showInterviewCategoryDialog = false;
        })
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(20)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
  }
}