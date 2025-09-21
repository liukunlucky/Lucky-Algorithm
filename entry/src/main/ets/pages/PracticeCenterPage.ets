import { ProblemModel, ProblemDifficulty, ProblemCategory } from '../model/ProblemModel';
import { UserProgressModel } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import router from '@ohos.router';

interface CategoryConfig {
  category: ProblemCategory;
  name: string;
  icon: Resource;
  color: string;
}

@Component
export struct PracticeCenterPage {
  @State searchText: string = '';
  @State problems: ProblemModel[] = [];
  @State isLoading: boolean = false;
  @State selectedCategory: ProblemCategory | null = null;
  @State selectedDifficulty: ProblemDifficulty | null = null;
  @StorageLink('selectedCategory') externalSelectedCategory: ProblemCategory | null = null;
  @StorageLink('selectedCategoryTitle') externalSelectedCategoryTitle: string = '';
  
  // 使用mock数据，不再需要数据库实例
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadProblems();
    
    // 检查是否有外部传递的分类参数
    if (this.externalSelectedCategory) {
      this.selectedCategory = this.externalSelectedCategory;
      this.loadProblems();
      
      // 清除参数，避免下次进入时还保持选中状态
      AppStorage.setOrCreate('selectedCategory', null);
      AppStorage.setOrCreate('selectedCategoryTitle', '');
    }
  }

  build() {
    Column({ space: 16 }) {
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
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor('#f5f5f5')
  }

  @Builder
  buildSearchBar() {
    Row({ space: 12 }) {
      TextInput({ placeholder: '搜索题目名称或关键词...' })
        .layoutWeight(1)
        .height(40)
        .placeholderColor('#D5DBDB')
        .backgroundColor('#ffffff')
        .borderRadius(20)
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.searchText = value;
          this.searchProblems();
        })
    }
    .width('100%')
  }



  @Builder
  buildCategoryTabs() {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Text('题目类型')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Scroll() {
        Row({ space: 12 }) {
          // 全部标签
          Button('全部')
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedCategory === null ? '#F34F40' : '#F2F2F7')
            .fontColor(this.selectedCategory === null ? '#FFFFFF' : '#3C3C43')
            .fontSize(14)
            .fontWeight(this.selectedCategory === null ? FontWeight.Medium : FontWeight.Normal)
            .borderRadius(16)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onClick(() => {
              this.selectedCategory = null;
              this.loadProblems();
            })

          // 各种题目类型标签
          ForEach(this.getCategoryConfigs(), (config: CategoryConfig) => {
            Button(config.name)
              .type(ButtonType.Normal)
              .backgroundColor(this.selectedCategory === config.category ? '#F34F40' : '#F2F2F7')
              .fontColor(this.selectedCategory === config.category ? '#FFFFFF' : '#3C3C43')
              .fontSize(14)
              .fontWeight(this.selectedCategory === config.category ? FontWeight.Medium : FontWeight.Normal)
              .borderRadius(16)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .onClick(() => {
                this.selectedCategory = config.category;
                this.loadProblems();
              })
          }, (config: CategoryConfig) => config.category.toString())
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
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
    Column({ space: 12 }) {
      Row() {
        Row({ space: 8 }) {
          Text(this.selectedCategory !== null ? this.getCategoryName(this.selectedCategory) : '全部题目')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }

        Blank()

        Text('共' + this.problems.length + '题')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')

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
    
    configs.push(config1, config2, config3, config4, config5, config6, config7, config8);
    return configs;
  }

  private async loadProblems(): Promise<void> {
    this.isLoading = true;
    try {
      let allProblems = ProblemMockData.getAllProblems();
      
      // 首先按分类筛选
      if (this.selectedCategory !== null) {
        console.log('Filtering by category:', this.selectedCategory);
        allProblems = allProblems.filter(p => p.category === this.selectedCategory);
      }
      
      // 然后按搜索文本筛选
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
}