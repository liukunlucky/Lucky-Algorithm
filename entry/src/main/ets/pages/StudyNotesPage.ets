import { ProblemModel } from '../model/ProblemModel';
import { UserNoteModel } from '../model/UserNoteModel';
import { UserNoteDao } from '../dao/UserNoteDao';
import { ProblemMockData } from '../mock/ProblemMockData';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface NoteWithProblem {
  note: UserNoteModel;
  problem: ProblemModel | null;
}

@Entry
@Component
struct StudyNotesPage {
  @State allNotes: UserNoteModel[] = [];
  @State notesWithProblems: NoteWithProblem[] = [];
  @State isLoading: boolean = true;
  @State searchText: string = '';
  @State filteredNotes: NoteWithProblem[] = [];
  @State selectedNote: NoteWithProblem | null = null;
  @State isEditingNote: boolean = false;
  @State editingContent: string = '';
  @State showEditSheet: boolean = false; // 新增：控制编辑Sheet的显示
  
  private userNoteDao: UserNoteDao = new UserNoteDao();

  onPageShow(): void {
    this.loadNotes();
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      // 搜索栏
      this.buildSearchBar()

      // 内容区域
      if (this.isLoading) {
        this.buildLoadingState()
      } else if (this.filteredNotes.length === 0) {
        this.buildEmptyState()
      } else {
        this.buildNotesList()
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
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Text('学习笔记')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 占位元素，保持标题居中
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
  buildSearchBar() {
    Row({ space: 12 }) {
      TextInput({
        placeholder: '搜索笔记内容或题目标题...',
        text: this.searchText
      })
        .layoutWeight(1)
        .placeholderColor('#D5DBDB')
        .height(40)
        .fontSize(14)
        .backgroundColor('#f8f9fa')
        .borderRadius(20)
        .onChange((value: string) => {
          this.searchText = value;
          this.filterNotes();
        })

    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#52c41a')

      Text('正在加载笔记...')
        .fontSize(14)
        .fontColor('#666666')
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

      Text('还没有学习笔记')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#666666')

      Text('在做题过程中记录笔记，\n总结解题思路和知识点')
        .fontSize(14)
        .fontColor('#999999')
        .textAlign(TextAlign.Center)
        .lineHeight(20)

      Button('去练习题目')
        .fontSize(14)
        .fontColor('#ffffff')
        .backgroundColor('#F34F40')
        .borderRadius(20)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .onClick(() => {
          // 切换到练习中心
          router.back();
          // 可以通过AppStorage触发Tab切换
          AppStorage.setOrCreate('switchToTabIndex', 2);
        })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(32)
  }

  @Builder
  buildNotesList() {
    List({ space: 12 }) {
      ForEach(this.filteredNotes, (noteWithProblem: NoteWithProblem, index: number) => {
        ListItem() {
          this.buildNoteItem(noteWithProblem)
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 16, right: 16, top: 8, bottom: 16 })
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
    .bindSheet($$this.showEditSheet, this.buildEditSheet(), {
      height: 500,
      dragBar: true,
      preferType:SheetType.CENTER,
      showClose: false,
      backgroundColor: '#ffffff'
    })
  }

  @Builder
  buildNoteItem(noteWithProblem: NoteWithProblem) {
    Column({ space: 12 }) {
      // 题目标题和时间
      Row() {
        Column({ space: 4 }) {
          Text(noteWithProblem.problem?.title || '未知题目')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Row({ space: 8 }) {
            Text(this.formatDate(noteWithProblem.note.updatedAt))
              .fontSize(12)
              .fontColor('#999999')

            if (noteWithProblem.problem) {
              Text(noteWithProblem.problem.getCategoryText())
                .fontSize(12)
                .fontColor('#ffffff')
                .backgroundColor('#52c41a')
                .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                .borderRadius(4)
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 右下角查看题目按钮
        Row() {
          Blank()
          
          Row({ space: 8 }) {
            Button() {
              Image($r('app.media.icon_delete'))
                .width(16)
                .height(16)
                .fillColor('#ff4757')
            }
            .backgroundColor('transparent')
            .width(32)
            .height(32)
            .onClick(() => {
              this.showDeleteConfirmDialog(noteWithProblem.note.id);
            })
          }
        }
      }
      .width('100%')

      Row() {
        // 笔记内容预览
        Text(noteWithProblem.note.content)
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(20)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)
          .textAlign(TextAlign.Start)
        Blank().width(40)
        Button() {
          Text('查看题目')
            .fontSize(12)
            .fontColor(Color.White)
        }
        .backgroundColor('#ff4757')
        .borderRadius(16)
        .height(28)
        .padding({ left: 8, right: 8 })
        .onClick(() => {
          if (noteWithProblem.problem) {
            this.navigateToProblemDetail(noteWithProblem.problem.id);
          }
        })
      }.justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
    .onClick(() => {
      // 点击笔记本身进入编辑模式
      this.editNote(noteWithProblem);
    })
  }

  // 加载所有笔记
  private async loadNotes(): Promise<void> {
    try {
      this.isLoading = true;
      console.info('📝 开始加载学习笔记');

      // 从数据库获取所有笔记
      this.allNotes = await this.userNoteDao.getAllNotes();
      console.info(`📋 找到 ${this.allNotes.length} 条笔记`);

      // 为每个笔记关联题目信息
      this.notesWithProblems = [];
      for (const note of this.allNotes) {
        const problem = ProblemMockData.getProblemById(note.problemId);
        this.notesWithProblems.push({
          note: note,
          problem: problem
        });
      }

      // 按更新时间降序排序
      this.notesWithProblems.sort((a, b) => {
        return new Date(b.note.updatedAt).getTime() - new Date(a.note.updatedAt).getTime();
      });

      this.filterNotes();
      console.info('✅ 学习笔记加载完成');
    } catch (error) {
      console.error('❌ 加载学习笔记失败:', error);
    } finally {
      this.isLoading = false;
    }
  }

  // 过滤笔记
  private filterNotes(): void {
    console.info('🔍 开始过滤笔记，搜索文本:', this.searchText);
    
    if (this.searchText.trim() === '') {
      // 创建完全新的数组副本，确保状态变化
      this.filteredNotes = this.notesWithProblems.map((item: NoteWithProblem): NoteWithProblem => {
        const noteWithProblem: NoteWithProblem = {
          note: item.note,
          problem: item.problem
        };
        return noteWithProblem;
      });
    } else {
      const searchLower = this.searchText.toLowerCase();
      this.filteredNotes = this.notesWithProblems
        .filter((noteWithProblem: NoteWithProblem): boolean => {
          const contentMatch = noteWithProblem.note.content.toLowerCase().includes(searchLower);
          const titleMatch = noteWithProblem.problem?.title.toLowerCase().includes(searchLower) || false;
          return contentMatch || titleMatch;
        })
        .map((item: NoteWithProblem): NoteWithProblem => {
          const noteWithProblem: NoteWithProblem = {
            note: item.note,
            problem: item.problem
          };
          return noteWithProblem;
        });
    }
    
    console.info('🔍 笔记过滤完成，显示', this.filteredNotes.length, '条笔记');
    console.info('🔍 过滤结果的第一条笔记内容:', JSON.stringify(this.filteredNotes[0]?.note));
  }

  // 编辑笔记
  private editNote(noteWithProblem: NoteWithProblem): void {
    this.selectedNote = noteWithProblem;
    this.editingContent = noteWithProblem.note.content;
    this.isEditingNote = true;
    
    // 显示编辑Sheet
    this.showEditSheet = true;
  }

  // 构建编辑Sheet
  @Builder
  buildEditSheet() {
    Column({ space: 16 }) {
      // 标题
      Row() {
        Text('编辑笔记')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
        
        Button('取消')
          .fontSize(14)
          .fontColor('#666666')
          .backgroundColor('transparent')
          .onClick(() => {
            this.showEditSheet = false;
            this.isEditingNote = false;
            this.selectedNote = null;
          })
      }
      .width('100%')
      
      // 题目信息
      if (this.selectedNote?.problem) {
        Row({ space: 8 }) {
          Text('题目：')
            .fontSize(14)
            .fontColor('#666666')
          
          Text(this.selectedNote.problem.title)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
        }
        .width('100%')
      }
      
      // 编辑区域
      Column({ space: 8 }) {
        Text('笔记内容')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)
        
        TextArea({
          placeholder: '请输入笔记内容...',
          text: this.editingContent
        })
          .width('100%')
          .height(200)
          .fontSize(14)
          .backgroundColor('#f8f9fa')
          .borderRadius(8)
          .padding(12)
          .onChange((value: string) => {
            this.editingContent = value;
          })
      }
      .width('100%')
      
      // 操作按钮
      Row({ space: 12 }) {
        Button('保存')
          .layoutWeight(1)
          .height(40)
          .backgroundColor('#52c41a')
          .fontColor('#ffffff')
          .borderRadius(8)
          .enabled(this.editingContent.trim().length > 0)
          .opacity(this.editingContent.trim().length > 0 ? 1 : 0.5)
          .onClick(() => {
            this.saveEditedNote();
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
  }



  // 保存编辑的笔记
  private async saveEditedNote(): Promise<void> {
    if (!this.selectedNote || this.editingContent.trim() === '') {
      promptAction.showToast({
        message: '笔记内容不能为空',
        duration: 2000
      });
      return;
    }

    try {
      console.info('🔄 开始保存笔记，原内容:', this.selectedNote.note.content);
      console.info('🔄 新内容:', this.editingContent.trim());
      
      // 更新笔记内容和时间戳
      this.selectedNote.note.updateContent(this.editingContent.trim());
      const updatedTimestamp = this.selectedNote.note.updatedAt; // 保存更新后的时间戳
      
      console.info('🔄 更新时间戳:', updatedTimestamp);
      
      // 保存到数据库
      await this.userNoteDao.saveNote(this.selectedNote.note);
      
      console.info('✅ 笔记保存到数据库成功');

      // 创建新的笔记对象以确保引用变化，使用相同的时间戳
      const updatedNote = new UserNoteModel();
      updatedNote.id = this.selectedNote.note.id;
      updatedNote.problemId = this.selectedNote.note.problemId;
      updatedNote.content = this.editingContent.trim();
      updatedNote.createdAt = this.selectedNote.note.createdAt;
      updatedNote.updatedAt = updatedTimestamp; // 使用相同的时间戳

      // 更新本地数据 - 完全重建数组以确保状态变化
      const index = this.notesWithProblems.findIndex(item => item.note.id === this.selectedNote!.note.id);
      if (index !== -1) {
        // 创建完全新的数组和对象
        const updatedNotes = [...this.notesWithProblems];
        const updatedNoteWithProblem: NoteWithProblem = {
          note: updatedNote, // 使用新创建的笔记对象
          problem: updatedNotes[index].problem
        };
        updatedNotes[index] = updatedNoteWithProblem;
        this.notesWithProblems = updatedNotes;
        
        console.info('✅ 本地数据更新完成，新内容:', updatedNotes[index].note.content);
        console.info('✅ 本地数据更新时间:', updatedNotes[index].note.updatedAt);
      }

      // 重新排序笔记（按更新时间降序）
      this.notesWithProblems.sort((a, b) => {
        return new Date(b.note.updatedAt).getTime() - new Date(a.note.updatedAt).getTime();
      });

      // 强制重新过滤笔记以更新显示
      this.filterNotes();

      // 重置编辑状态
      this.isEditingNote = false;
      this.selectedNote = null;
      this.showEditSheet = false; // 关闭Sheet

      promptAction.showToast({
        message: '笔记保存成功',
        duration: 2000
      });
    } catch (error) {
      console.error('保存笔记失败:', error);
      promptAction.showToast({
        message: '保存失败，请重试',
        duration: 2000
      });
    }
  }

  // 显示删除确认对话框
  private showDeleteConfirmDialog(noteId: number): void {
    AlertDialog.show({
      title: '删除笔记',
      message: '确定要删除这条笔记吗？删除后无法恢复',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('用户取消删除笔记');
        }
      },
      secondaryButton: {
        value: '删除',
        fontColor: '#ff4757',
        action: () => {
          this.deleteNote(noteId);
        }
      }
    });
  }

  // 删除笔记
  private async deleteNote(noteId: number): Promise<void> {
    try {
      await this.userNoteDao.deleteNote(noteId);

      // 从本地数据中移除
      this.notesWithProblems = this.notesWithProblems.filter(item => item.note.id !== noteId);
      this.filterNotes();

      promptAction.showToast({
        message: '笔记已删除',
        duration: 2000
      });
    } catch (error) {
      console.error('删除笔记失败:', error);
      promptAction.showToast({
        message: '删除失败，请重试',
        duration: 2000
      });
    }
  }

  // 跳转到题目详情页面
  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: {
        problemId: problemId,
        fromNotes: true
      }
    }).catch((error: Error) => {
      console.error('跳转题目详情失败:', error);
      promptAction.showToast({
        message: '页面跳转失败',
        duration: 2000
      });
    });
  }

  // 格式化日期
  private formatDate(dateString: string): string {
    const date = new Date(dateString);
    const now = new Date();
    
    // 获取当地时间的年月日，忽略时分秒
    const dateYear = date.getFullYear();
    const dateMonth = date.getMonth();
    const dateDay = date.getDate();
    
    const nowYear = now.getFullYear();
    const nowMonth = now.getMonth();
    const nowDay = now.getDate();
    
    // 创建当地时间的日期对象用于比较（只比较年月日）
    const dateOnly = new Date(dateYear, dateMonth, dateDay);
    const nowOnly = new Date(nowYear, nowMonth, nowDay);
    
    const diffMs = nowOnly.getTime() - dateOnly.getTime();
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

    console.info(`📅 时间格式化调试: 原始时间=${dateString}, 解析后=${date.toLocaleString('zh-CN')}, 当前时间=${now.toLocaleString('zh-CN')}, 天数差=${diffDays}`);

    if (diffDays === 0) {
      // 今天
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `今天 ${hours}:${minutes}`;
    } else if (diffDays === 1) {
      // 昨天
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `昨天 ${hours}:${minutes}`;
    } else if (diffDays < 7) {
      // 一周内
      return `${diffDays}天前`;
    } else {
      // 超过一周
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      return `${month}-${day}`;
    }
  }
}