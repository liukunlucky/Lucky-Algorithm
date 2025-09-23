import { ProblemModel, ProblemCategory } from '../model/ProblemModel';
import { UserProgressDao } from '../dao/UserProgressDao';
import { ProblemMockData } from '../mock/ProblemMockData';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface WrongProblemInfo {
  problem: ProblemModel;
  wrongCount: number;
  lastWrongDate: Date;
  isRetried: boolean;
}

@Entry
@Component
struct WrongProblemsPage {
  @State wrongProblems: WrongProblemInfo[] = [];
  @State isLoading: boolean = true;
  @State searchText: string = '';
  @State filteredProblems: WrongProblemInfo[] = [];
  @State selectedCategory: ProblemCategory | null = null;
  
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    this.loadWrongProblems();
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      // 搜索和筛选栏
      this.buildSearchAndFilter()

      // 统计信息
      this.buildStatsBar()

      // 内容区域
      if (this.isLoading) {
        this.buildLoadingState()
      } else if (this.filteredProblems.length === 0) {
        this.buildEmptyState()
      } else {
        this.buildProblemList()
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
      .width(40)
      .height(40)
      .backgroundColor('#ffffff')
      .borderRadius(20)
      .onClick(() => {
        router.back();
      })

      Text('错题本')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text(`${this.wrongProblems.length}题`)
        .fontSize(14)
        .fontColor('#666666')
        .width(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 1 }, color: '#f0f0f0' })
  }

  @Builder
  buildSearchAndFilter() {
    Column({ space: 12 }) {
      // 搜索栏
      Row({ space: 12 }) {
        TextInput({ placeholder: '搜索错题...' })
          .layoutWeight(1)
          .placeholderColor('#D5DBDB')
          .height(40)
          .backgroundColor('#ffffff')
          .borderRadius(20)
          .padding({ left: 16, right: 16 })
          .onChange((value: string) => {
            this.searchText = value;
            this.filterProblems();
          })
      }
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  buildStatsBar() {
    Row({ space: 16 }) {
      this.buildTotalWrongStatItem('总错题', '#ff4d4f')
      this.buildRetryStatItem('待重做', '#faad14')
      this.buildRetriedStatItem('已重做', '#52c41a')
    }
    .width('100%')
    .padding({ left: 16, right: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceAround)
  }

  @Builder
  buildTotalWrongStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.wrongProblems.length}题`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildRetryStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.getRetryCount()}题`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildRetriedStatItem(title: string, color: string) {
    Column({ space: 4 }) {
      Text(`${this.getRetriedCount()}题`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      Text('⏳')
        .fontSize(48)
        .fontColor('#cccccc')

      Text('加载中...')
        .fontSize(16)
        .fontColor('#999999')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildEmptyState() {
    Column({ space: 16 }) {
      Image($r('app.media.icon_empty'))
        .width(173)
        .height(128)

      Text(this.searchText || this.selectedCategory ? '没有找到相关错题' : '暂无错题记录')
        .fontSize(18)
        .fontColor('#999999')

      Text(this.searchText || this.selectedCategory ? '试试调整筛选条件' : '继续练习，做错的题目会自动收录到这里')
        .fontSize(14)
        .fontColor('#cccccc')
        .textAlign(TextAlign.Center)
        .lineHeight(20)
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(32)
  }

  @Builder
  buildProblemList() {
    List({ space: 12 }) {
      ForEach(this.filteredProblems, (wrongInfo: WrongProblemInfo) => {
        ListItem() {
          this.buildWrongProblemCard(wrongInfo)
        }
      }, (wrongInfo: WrongProblemInfo) => wrongInfo.problem.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 16, right: 16, bottom: 16 })
  }

  @Builder
  buildWrongProblemCard(wrongInfo: WrongProblemInfo) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(wrongInfo.problem.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignSelf(ItemAlign.Start)

          Row({ space: 8 }) {
            Text(wrongInfo.problem.getDifficultyText())
              .fontSize(12)
              .fontColor('#ffffff')
              .backgroundColor(wrongInfo.problem.getDifficultyColor())
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)

            Text(wrongInfo.problem.getCategoryText())
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#787408')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)

            Text(`错${wrongInfo.wrongCount}次`)
              .fontSize(12)
              .fontColor('#ffffff')
              .backgroundColor('#ff4d4f')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)
          }
          .justifyContent(FlexAlign.Start)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        Button() {
          Image($r('app.media.icon_delete'))
            .width(20)
            .height(20)
            .fillColor('#ff4d4f')
        }
        .width(40)
        .height(40)
        .backgroundColor('#fff2f0')
        .borderRadius(20)
        .onClick(() => {
          this.showDeleteConfirmDialog(wrongInfo.problem.id);
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      if (wrongInfo.problem.description) {
        Text(wrongInfo.problem.description)
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(18)
          .alignSelf(ItemAlign.Start)
      }

      Row() {
        Text('最近错误: ' + this.formatDate(wrongInfo.lastWrongDate))
          .fontSize(12)
          .fontColor('#999999')
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      this.navigateToProblemDetail(wrongInfo.problem.id);
    })
  }

  private async loadWrongProblems(): Promise<void> {
    try {
      this.isLoading = true;
      
      // 从数据库获取错题进度
      const wrongProgress = await this.userProgressDao.getWrongProblems();
      console.log('lucky wrong problem is ' + JSON.stringify(wrongProgress))
      
      // 根据题目ID获取完整的题目信息并构建错题信息
      const wrongProblemsInfo: WrongProblemInfo[] = [];
      for (const progress of wrongProgress) {
        console.log(`正在查找错题ID: ${progress.problemId}`);
        // 优先从Mock数据获取题目信息，确保能找到所有题目
        const problem = ProblemMockData.getProblemById(progress.problemId);
        if (problem) {
          console.log(`找到错题: ${problem.title}`);
          const wrongInfo: WrongProblemInfo = {
            problem: problem,
            wrongCount: progress.attemptCount - progress.successCount,
            lastWrongDate: new Date(progress.lastAttempted),
            isRetried: progress.successCount > 0
          };
          wrongProblemsInfo.push(wrongInfo);
        } else {
          console.error(`找不到错题ID ${progress.problemId} 对应的题目信息`);
        }
      }
      
      console.log(`最终加载了 ${wrongProblemsInfo.length} 道错题`);
      this.wrongProblems = wrongProblemsInfo;
      this.filteredProblems = this.wrongProblems;
      this.isLoading = false;
    } catch (error) {
      console.error('Failed to load wrong problems:', error);
      this.wrongProblems = [];
      this.filteredProblems = [];
      this.isLoading = false;
    }
  }

  private filterProblems(): void {
    let filtered = this.wrongProblems;

    // 按搜索文本筛选
    if (this.searchText.trim()) {
      const searchLower = this.searchText.toLowerCase();
      filtered = filtered.filter(wrongInfo => 
        wrongInfo.problem.title.toLowerCase().includes(searchLower) ||
        wrongInfo.problem.description.toLowerCase().includes(searchLower)
      );
    }

    // 按分类筛选
    if (this.selectedCategory) {
      filtered = filtered.filter(wrongInfo => wrongInfo.problem.category === this.selectedCategory);
    }

    this.filteredProblems = filtered;
  }

  private clearFilters(): void {
    this.searchText = '';
    this.selectedCategory = null;
    this.filteredProblems = this.wrongProblems;
  }

  private getRetryCount(): number {
    return this.wrongProblems.filter(info => !info.isRetried).length;
  }

  private getRetriedCount(): number {
    return this.wrongProblems.filter(info => info.isRetried).length;
  }

  private getCategoryName(category: ProblemCategory): string {
    switch (category) {
      case ProblemCategory.ARRAY:
        return '数组';
      case ProblemCategory.STRING:
        return '字符串';
      case ProblemCategory.LINKED_LIST:
        return '链表';
      case ProblemCategory.BINARY_TREE:
        return '二叉树';
      case ProblemCategory.TWO_POINTERS:
        return '双指针';
      case ProblemCategory.BINARY_SEARCH:
        return '二分查找';
      case ProblemCategory.MATH:
        return '数学';
      case ProblemCategory.DYNAMIC_PROGRAMMING:
        return '动态规划';
      default:
        return '未知分类';
    }
  }

  private showCategorySelector(): void {
    // TODO: 显示分类选择器
    console.info('Show category selector');
  }



  // 显示删除确认对话框
  private showDeleteConfirmDialog(problemId: number): void {
    AlertDialog.show({
      title: '确认删除',
      message: '确定要删除这道错题吗？删除后将无法恢复。',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('User canceled delete wrong problem');
        }
      },
      secondaryButton: {
        value: '删除',
        action: () => {
          this.removeWrongProblem(problemId);
        }
      }
    });
  }

  // 从数据库移除错题记录
  private async removeWrongProblem(problemId: number): Promise<void> {
    try {
      // 从数据库删除错题记录
      await this.userProgressDao.deleteWrongProblem(problemId);
      
      // 从本地列表中移除
      this.wrongProblems = this.wrongProblems.filter((wrongInfo: WrongProblemInfo) => wrongInfo.problem.id !== problemId);
      this.filteredProblems = this.filteredProblems.filter((wrongInfo: WrongProblemInfo) => wrongInfo.problem.id !== problemId);
      
      // 显示成功提示
      promptAction.showToast({
        message: '错题已删除',
        duration: 2000
      });
      
      console.info('Wrong problem deleted successfully:', problemId);
    } catch (error) {
      console.error('Failed to delete wrong problem:', error);
      
      // 显示错误提示
      promptAction.showToast({
        message: '删除失败，请重试',
        duration: 2000
      });
    }
  }

  private async retryProblem(problemId: number): Promise<void> {
    try {
      // 标记为重做状态
      const wrongInfo = this.wrongProblems.find(info => info.problem.id === problemId);
      if (wrongInfo) {
        wrongInfo.isRetried = true;
      }
      
      // 跳转到题目详情页
      this.navigateToProblemDetail(problemId);
    } catch (error) {
      console.error('Failed to retry problem:', error);
    }
  }

  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: { problemId: problemId, fromWrongProblems: true }
    }).catch((error: Error) => {
      console.error('Failed to navigate to problem detail:', error);
    });
  }

  private formatDate(date: Date): string {
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const seconds = date.getSeconds().toString().padStart(2, '0');
    return `${month}-${day} ${hours}:${minutes}:${seconds}`;
  }
}