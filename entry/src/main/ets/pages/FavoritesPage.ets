import { ProblemModel, ChoiceOption } from '../model/ProblemModel';
import { UserNoteModel } from '../model/UserNoteModel';
import { UserProgressDao } from '../dao/UserProgressDao';
import { UserNoteDao } from '../dao/UserNoteDao';
import { ProblemMockData } from '../mock/ProblemMockData';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface FavoriteProblemInfo {
  problem: ProblemModel;
  favoriteTime: string;
}

@Entry
@Component
struct FavoritesPage {
  @State favoriteProblems: ProblemModel[] = [];
  @State favoriteProblemInfos: FavoriteProblemInfo[] = [];
  @State isLoading: boolean = true;
  @State searchText: string = '';
  @State filteredProblems: ProblemModel[] = [];
  @State filteredProblemInfos: FavoriteProblemInfo[] = [];
  @State selectedProblem: ProblemModel | null = null;
  @State userNote: string = '';
  
  private detailDialogController: CustomDialogController | null = null;

  
  private userProgressDao: UserProgressDao = new UserProgressDao();
  private userNoteDao: UserNoteDao = new UserNoteDao();

  onPageShow(): void {
    this.initializeFavorites();
  }

  // 初始化收藏夹
  private async initializeFavorites(): Promise<void> {
    this.loadFavoriteProblems();
  }

  build() {
    Stack() {
      Column() {
        // 顶部导航栏
        this.buildHeader()

        // 搜索栏
        this.buildSearchBar()

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
    .width('100%')
    .height('100%')
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

      Text('我的收藏')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text(`${this.favoriteProblems.length}题`)
        .fontSize(14)
        .fontColor('#666666')
        .width(40)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 1 }, color: '#f0f0f0' })
  }

  @Builder
  buildSearchBar() {
    Row({ space: 12 }) {
      TextInput({ placeholder: '搜索收藏的题目...' })
        .layoutWeight(1)
        .height(40)
        .placeholderColor('#D5DBDB')
        .backgroundColor('#ffffff')
        .borderRadius(20)
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.searchText = value;
          this.filterProblems();
        })
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      Image($r('app.media.loading_icon'))
        .width(48)
        .height(48)
        .fillColor('#cccccc')

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

      Text(this.searchText ? '没有找到相关题目' : '还没有收藏任何题目')
        .fontSize(18)
        .fontColor('#999999')

      Text(this.searchText ? '试试其他关键词' : '在题目详情页点击收藏按钮来收藏题目')
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
      ForEach(this.filteredProblemInfos, (info: FavoriteProblemInfo) => {
        ListItem() {
          this.buildProblemCard(info.problem, info.favoriteTime)
        }
      }, (info: FavoriteProblemInfo) => info.problem.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 16, right: 16, bottom: 16 })
  }

  @Builder
  private buildProblemCard(problem: ProblemModel, favoriteTime?: string) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(problem.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignSelf(ItemAlign.Start)

          Row({ space: 8 }) {
            Text(problem.getDifficultyText())
              .fontSize(12)
              .fontColor('#ffffff')
              .backgroundColor(problem.getDifficultyColor())
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)

            Text(problem.getCategoryText())
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#787408')
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
          this.showRemoveAlertDialog(problem.id);
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      if (problem.description) {
        Text(problem.description)
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(18)
          .alignSelf(ItemAlign.Start)
      }

      Row() {
        Text('收藏时间: ' + this.formatDate(favoriteTime || new Date().toISOString()))
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
      this.navigateToProblemDetail(problem);
    })
  }

  private async loadFavoriteProblems(): Promise<void> {
    try {
      this.isLoading = true;
      
      // 从数据库获取收藏的题目进度
      const favoriteProgress = await this.userProgressDao.getFavoriteProblems();
      console.log('lucky favourite problem size = ' + favoriteProgress.length);
      
      // 根据题目ID从MockData获取完整的题目信息
      const problems: ProblemModel[] = [];
      const problemInfos: FavoriteProblemInfo[] = [];
      const invalidIds: number[] = [];
      
      for (const progress of favoriteProgress) {
        console.log('lucky processing problemId = ' + progress.problemId);
        // 使用ProblemMockData而不是数据库查询
        const problem = ProblemMockData.getProblemById(progress.problemId);
        console.log('lucky got problem = ' + (problem ? problem.title : 'null'));
        if (problem) {
          problems.push(problem);
          problemInfos.push({
            problem: problem,
            favoriteTime: progress.lastAttempted || new Date().toISOString()
          });
        } else {
          invalidIds.push(progress.problemId);
          console.warn('lucky invalid problemId found: ' + progress.problemId);
        }
      }
      
      // 清理无效的收藏记录
      if (invalidIds.length > 0) {
        console.log('lucky cleaning invalid favorite records: ' + invalidIds.join(', '));
        for (const invalidId of invalidIds) {
          try {
            await this.userProgressDao.toggleFavorite(invalidId);
          } catch (cleanupError) {
            console.error('Failed to cleanup invalid favorite:', cleanupError);
          }
        }
      }
      
      console.log('lucky final problems count = ' + problems.length);
      this.favoriteProblems = problems;
      this.favoriteProblemInfos = problemInfos;
      this.filteredProblems = this.favoriteProblems;
      this.filteredProblemInfos = this.favoriteProblemInfos;
      console.log('lucky favoriteProblems state = ' + this.favoriteProblems.length);
      console.log('lucky filteredProblems state = ' + this.filteredProblems.length);
      this.isLoading = false;
    } catch (error) {
      console.error('Failed to load favorite problems:', error);
      this.favoriteProblems = [];
      this.favoriteProblemInfos = [];
      this.filteredProblems = [];
      this.filteredProblemInfos = [];
      this.isLoading = false;
    }
  }

  private filterProblems(): void {
    if (!this.searchText.trim()) {
      this.filteredProblems = [...this.favoriteProblems];
      this.filteredProblemInfos = [...this.favoriteProblemInfos];
      return;
    }

    const searchLower = this.searchText.toLowerCase();
    this.filteredProblemInfos = this.favoriteProblemInfos.filter(info =>
      info.problem.title.toLowerCase().includes(searchLower) ||
      info.problem.description.toLowerCase().includes(searchLower)
    );
    this.filteredProblems = this.filteredProblemInfos.map(info => info.problem);
  }

  private async removeFavorite(problemId: number): Promise<void> {
    try {
      // 从数据库移除收藏状态
      await this.userProgressDao.toggleFavorite(problemId);
      
      // 从本地列表移除
      this.favoriteProblems = this.favoriteProblems.filter(p => p.id !== problemId);
      this.filterProblems();
    } catch (error) {
      console.error('Failed to remove favorite:', error);
    }
  }

  private formatDate(dateString: string): string {
    console.log('formatDate input:', dateString, 'type:', typeof dateString);
    
    // 检查输入是否为空或无效
    if (!dateString || dateString.trim() === '') {
      console.warn('Empty date string provided');
      return '未知时间';
    }
    
    const date = new Date(dateString);
    console.log('Created date object:', date, 'getTime():', date.getTime());
    
    // 检查日期是否有效
    if (isNaN(date.getTime())) {
      console.warn('Invalid date string:', dateString);
      return '未知时间';
    }
    
    // 确保使用本地时间显示
    const localDate = new Date(date.getTime());
    const month = (localDate.getMonth() + 1).toString().padStart(2, '0');
    const day = localDate.getDate().toString().padStart(2, '0');
    const hours = localDate.getHours().toString().padStart(2, '0');
    const minutes = localDate.getMinutes().toString().padStart(2, '0');
    const seconds = localDate.getSeconds().toString().padStart(2, '0');
    const result = `${month}-${day} ${hours}:${minutes}:${seconds}`;
    console.log('formatDate result:', result);
    return result;
  }

  // 跳转到题目详情页面
  private navigateToProblemDetail(problem: ProblemModel): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: {
        problemId: problem.id,
        fromFavorites: true
      }
    }).catch((error: Error) => {
      console.error('Failed to navigate to problem detail:', error);
      promptAction.showToast({
        message: '页面跳转失败',
        duration: 2000
      });
    });
  }

  // 显示题目详情弹窗
  private async showProblemDetail(problem: ProblemModel): Promise<void> {
    this.selectedProblem = problem;
    // 加载用户笔记
    try {
      const note = await this.userNoteDao.getNoteByProblemId(problem.id);
      this.userNote = note ? note.content : '';
    } catch (error) {
      console.error('Failed to load user note:', error);
      this.userNote = '';
    }
    
    // 创建并显示CustomDialog
    this.detailDialogController = new CustomDialogController({
      builder: ProblemDetailDialog({
        selectedProblem: this.selectedProblem,
        userNote: this.userNote,
        onSaveNote: (note: string) => {
          this.userNote = note;
        }
      }),
      autoCancel: true,
      alignment: DialogAlignment.Center,
      customStyle: false
    });
    
    this.detailDialogController.open();
  }

  // 显示取消收藏确认弹窗
  private showRemoveAlertDialog(problemId: number): void {
    AlertDialog.show({
      title: '确认取消收藏',
      message: '确定要取消收藏这道题目吗？',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('User canceled remove favorite');
        }
      },
      secondaryButton: {
        value: '确认',
        action: () => {
          this.confirmRemoveFavorite(problemId);
        }
      }
    });
  }



  // 确认取消收藏
  private async confirmRemoveFavorite(problemId: number): Promise<void> {
    try {
      await this.removeFavorite(problemId);
      
      promptAction.showToast({
        message: '已取消收藏',
        duration: 2000
      });
    } catch (error) {
      console.error('Failed to remove favorite:', error);
      promptAction.showToast({
        message: '取消收藏失败',
        duration: 2000
      });
    }
  }

}

// 题目详情弹窗组件
@CustomDialog
struct ProblemDetailDialog {
  @State selectedProblem: ProblemModel | null = null;
  @State userNote: string = '';
  
  private controller: CustomDialogController;
  private onSaveNote?: (note: string) => void;
  private userNoteDao: UserNoteDao = new UserNoteDao();

  build() {
    Column({ space: 16 }) {
      // 标题栏
      Row() {
        Text('题目详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
        
        Blank()
        
        Button() {
          Image($r('app.media.close_icon'))
            .width(20)
            .height(20)
            .fillColor('#666666')
        }
        .width(32)
        .height(32)
        .backgroundColor('#f5f5f5')
        .borderRadius(16)
        .onClick(() => {
          this.controller.close();
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      Scroll() {
        Column({ space: 16 }) {
          if (this.selectedProblem) {
            // 题目信息
            Column({ space: 12 }) {
              Text(this.selectedProblem.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')

              Text(this.selectedProblem.description)
                .fontSize(14)
                .fontColor('#666666')
                .width('100%')
                .lineHeight(20)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 20, right: 20 })

            // 答案选项
            Column({ space: 8 }) {
              Text('答案选项')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')

              ForEach(this.selectedProblem.choices, (choice: ChoiceOption, index: number) => {
                Row({ space: 8 }) {
                  Text(String.fromCharCode(65 + index) + '.')
                    .fontSize(14)
                    .fontColor('#666666')
                    .width(20)

                  Text(choice.text)
                    .fontSize(14)
                    .fontColor(choice.isCorrect ? '#52c41a' : '#333333')
                    .layoutWeight(1)

                  if (choice.isCorrect) {
                    Text('✓')
                      .fontSize(16)
                      .fontColor('#52c41a')
                      .fontWeight(FontWeight.Bold)
                  }
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
              }, (choice: ChoiceOption, index: number) => index.toString())
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 20, right: 20 })

            // 答案解析
            Column({ space: 8 }) {
              Text('答案解析')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')

              Text(this.selectedProblem.explanation || '暂无解析')
                .fontSize(14)
                .fontColor('#666666')
                .width('100%')
                .lineHeight(20)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 20, right: 20 })

            // 我的笔记
            Column({ space: 8 }) {
              Text('我的笔记')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .width('100%')

              TextArea({
                placeholder: '在这里记录你的想法和笔记...',
                text: this.userNote
              })
                .width('100%')
                .placeholderColor('#D5DBDB')
                .height(100)
                .fontSize(14)
                .backgroundColor('#f8f9fa')
                .borderRadius(8)
                .onChange((value: string) => {
                  this.userNote = value;
                })

              Button('保存笔记')
                .width('100%')
                .height(40)
                .backgroundColor('#1890ff')
                .fontColor('#ffffff')
                .borderRadius(8)
                .onClick(() => {
                  this.saveUserNote();
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 20, right: 20, bottom: 20 })
          }
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('90%')
    .constraintSize({ maxHeight: '80%' })
    .backgroundColor('#ffffff')
    .borderRadius(12)
  }

  // 保存用户笔记
  private async saveUserNote(): Promise<void> {
    if (!this.selectedProblem) return;
    
    try {
      const note = new UserNoteModel();
      note.problemId = this.selectedProblem.id;
      note.content = this.userNote;
      await this.userNoteDao.saveNote(note);
      
      promptAction.showToast({
        message: '笔记保存成功',
        duration: 2000
      });
      
      if (this.onSaveNote) {
        this.onSaveNote(this.userNote);
      }
    } catch (error) {
      console.error('Failed to save note:', error);
      promptAction.showToast({
        message: '笔记保存失败',
        duration: 2000
      });
    }
  }
}