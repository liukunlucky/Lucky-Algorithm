import { StudyDiaryModel, DiaryMood } from '../model/StudyDiaryModel';
import { StudyDiaryDao } from '../dao/StudyDiaryDao';
import router from '@ohos.router';

interface MoodOption {
  mood: DiaryMood;
  emoji: string;
  text: string;
}

@Entry
@Component
struct StudyDiaryPage {
  @State diaries: StudyDiaryModel[] = [];
  @State isLoading: boolean = true;
  @State showAddDialog: boolean = false;
  @State showEditDialog: boolean = false;
  @State showDetailDialog: boolean = false;
  @State currentEditDiary: StudyDiaryModel | null = null;
  @State currentDetailDiary: StudyDiaryModel | null = null;
  @State searchKeyword: string = '';
  
  // 表单数据
  @State formTitle: string = '';
  @State formContent: string = '';
  @State formMood: DiaryMood = DiaryMood.NORMAL;
  @State formStudyDuration: string = '';
  @State formProblemsSolved: string = '';
  @State formTags: string = '';

  private studyDiaryDao: StudyDiaryDao = new StudyDiaryDao();

  async aboutToAppear() {
    await this.loadDiaries();
  }

  async onPageShow() {
    await this.loadDiaries();
  }

  async loadDiaries() {
    try {
      this.isLoading = true;
      if (this.searchKeyword.trim()) {
        this.diaries = await this.studyDiaryDao.searchDiaries(this.searchKeyword.trim());
      } else {
        this.diaries = await this.studyDiaryDao.getAllDiaries();
      }
      console.info('加载学习日记成功，数量:', this.diaries.length);
    } catch (error) {
      console.error('加载学习日记失败:', error);
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      // 搜索栏
      this.buildSearchBar()

      if (this.isLoading) {
        // 加载状态
        Column() {
          Text('加载中...')
            .fontSize(16)
            .fontColor('#999999')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      } else {
        // 日记列表
        this.buildDiariesList()
      }

      // 添加日记对话框
      if (this.showAddDialog) {
        this.buildAddDiaryDialog()
      }

      // 编辑日记对话框
      if (this.showEditDialog) {
        this.buildEditDiaryDialog()
      }

      // 日记详情对话框
      if (this.showDetailDialog) {
        this.buildDetailDialog()
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
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        router.back();
      })

      Text('学习日记')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button() {
        Image($r('app.media.icon_add'))
          .width(36)
          .height(36)
          .fillColor('#FF6B35')
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/AddEditStudyDiaryPage'
        }).catch((error: Error) => {
          console.error('跳转到添加日记页面失败:', error);
        });
      })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildSearchBar() {
    Row({ space: 12 }) {
      TextInput({ placeholder: '搜索日记标题、内容或标签...' })
        .fontSize(14)
        .backgroundColor('#F8F9FA')
        .borderRadius(20)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .layoutWeight(1)
        .onChange((value: string) => {
          this.searchKeyword = value;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildDiariesList() {
    if (this.diaries.length === 0) {
      Column() {
        Image($r('app.media.icon_empty'))
          .width(173)
          .height(128)

        Text(this.searchKeyword.trim() ? '没有找到相关日记' : '还没有学习日记')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
        Text(this.searchKeyword.trim() ? '试试其他关键词' : '点击右上角记录你的学习心得吧')
          .fontSize(14)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
    } else {
      Column() { List({ space: 12 }) {
        ForEach(this.diaries, (diary: StudyDiaryModel) => {
          this.buildDiaryCard(diary)
        }, (diary: StudyDiaryModel) => diary.id.toString())
      }
      .padding(16)
      .width('100%').height('100%')}.layoutWeight(1)

    }
  }

  @Builder
  buildDiaryCard(diary: StudyDiaryModel) {
    Column() {
      // 日记标题和心情
      Row() {
        Column({ space: 4 }) {
          Text(diary.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Row({ space: 8 }) {
            Text(diary.getFormattedDate())
              .fontSize(12)
              .fontColor('#999999')

            Text(diary.getFormattedTime())
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Row({ space: 8 }) {
          Text(diary.getMoodEmoji())
            .fontSize(20)

          Text(diary.getMoodDisplayText())
            .fontSize(12)
            .fontColor(diary.getMoodColor())
        }
      }
      .width('100%')

      Row() {
        // 日记内容预览
        Text(diary.content)
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }.width('100%')


      // 学习数据
      Row({ space: 16 }) {
        if (diary.studyDuration > 0) {
          Row({ space: 4 }) {
            Text('⏱️')
              .fontSize(14)
            Text(diary.getStudyDurationText())
              .fontSize(12)
              .fontColor('#666666')
          }
        }

        if (diary.problemsSolved > 0) {
          Row({ space: 4 }) {
            Text('✅')
              .fontSize(14)
            Text(`${diary.problemsSolved}题`)
              .fontSize(12)
              .fontColor('#666666')
          }
        }
      }
      .width('100%')

      // 标签
      if (diary.tags) {
        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(diary.getTagsArray(), (tag: string) => {
            Text(`#${tag}`)
              .fontSize(12)
              .fontColor('#F34F40')
              .backgroundColor('#FFF5F5')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(12)
          }, (tag: string) => tag)
        }
        .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/AddEditStudyDiaryPage',
        params: { diary: diary }
      }).catch((error: Error) => {
        console.error('跳转到编辑日记页面失败:', error);
      });
    })
  }

  @Builder
  buildAddDiaryDialog() {
    Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .onClick(() => {
          this.hideAddDiaryDialog();
        })

      // 对话框内容
      Scroll() {
        Column({ space: 20 }) {
          Text('写学习日记')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          this.buildDiaryForm()

          Row({ space: 12 }) {
            Button('取消')
              .fontSize(16)
              .fontColor('#666666')
              .backgroundColor('#F0F0F0')
              .borderRadius(8)
              .layoutWeight(1)
              .onClick(() => {
                this.hideAddDiaryDialog();
              })

            Button('保存')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .backgroundColor('#F34F40')
              .borderRadius(8)
              .layoutWeight(1)
              .onClick(() => {
                this.addDiary();
              })
          }
          .width('100%')
        }
        .width('90%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
      }
      .width('90%')
      .height('80%')
      .position({ x: '5%', y: '10%' })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(1000)
    }

  @Builder
  buildEditDiaryDialog() {
    Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .onClick(() => {
          this.hideEditDiaryDialog();
        })

      // 对话框内容
      Scroll() {
        Column({ space: 20 }) {
          Text('编辑学习日记')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          this.buildDiaryForm()

          Row({ space: 12 }) {
            Button('取消')
              .fontSize(16)
              .fontColor('#666666')
              .backgroundColor('#F0F0F0')
              .borderRadius(8)
              .layoutWeight(1)
              .onClick(() => {
                this.hideEditDiaryDialog();
              })

            Button('保存')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .backgroundColor('#F34F40')
              .borderRadius(8)
              .layoutWeight(1)
              .onClick(() => {
                this.updateDiary();
              })
          }
          .width('100%')
        }
        .width('90%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
      }
      .width('90%')
      .height('80%')
      .position({ x: '5%', y: '10%' })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(1000)
  }

  @Builder
  buildDetailDialog() {
    if (!this.currentDetailDiary) {
      Column()
    } else {

      Column() {
        // 遮罩层
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#00000080')
          .onClick(() => {
            this.hideDetailDialog();
          })

        // 对话框内容
        Scroll() {
          Column({ space: 20 }) {
            // 标题和心情
            Row() {
              Text(this.currentDetailDiary.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .layoutWeight(1)

              Row({ space: 8 }) {
                Text(this.currentDetailDiary.getMoodEmoji())
                  .fontSize(24)
                Text(this.currentDetailDiary.getMoodDisplayText())
                  .fontSize(14)
                  .fontColor(this.currentDetailDiary.getMoodColor())
              }
            }
            .width('100%')

            // 日期时间
            Text(`${this.currentDetailDiary.getFormattedDate()} ${this.currentDetailDiary.getFormattedTime()}`)
              .fontSize(14)
              .fontColor('#999999')

            // 内容
            Text(this.currentDetailDiary.content)
              .fontSize(16)
              .fontColor('#333333')
              .lineHeight(24)

            // 学习数据
            if (this.currentDetailDiary.studyDuration > 0 || this.currentDetailDiary.problemsSolved > 0) {
              Column({ space: 8 }) {
                Text('学习数据')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')

                Row({ space: 16 }) {
                  if (this.currentDetailDiary.studyDuration > 0) {
                    Column({ space: 4 }) {
                      Text('⏱️')
                        .fontSize(20)
                      Text(this.currentDetailDiary.getStudyDurationText())
                        .fontSize(14)
                        .fontColor('#666666')
                    }
                  }

                  if (this.currentDetailDiary.problemsSolved > 0) {
                    Column({ space: 4 }) {
                      Text('✅')
                        .fontSize(20)
                      Text(`${this.currentDetailDiary.problemsSolved}题`)
                        .fontSize(14)
                        .fontColor('#666666')
                    }
                  }
                }
              }
              .alignItems(HorizontalAlign.Start)
            }

            // 标签
            if (this.currentDetailDiary.tags) {
              Column({ space: 8 }) {
                Text('标签')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                  .alignSelf(ItemAlign.Start)

                Flex({ wrap: FlexWrap.Wrap }) {
                  ForEach(this.currentDetailDiary.getTagsArray(), (tag: string) => {
                    Text(`#${tag}`)
                      .fontSize(14)
                      .fontColor('#F34F40')
                      .backgroundColor('#FFF5F5')
                      .padding({
                        left: 12,
                        right: 12,
                        top: 6,
                        bottom: 6
                      })
                      .borderRadius(16)
                  }, (tag: string) => tag)
                }
              }
              .alignItems(HorizontalAlign.Start)
            }

            Button('关闭')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .backgroundColor('#F34F40')
              .borderRadius(8)
              .width('100%')
              .onClick(() => {
                this.hideDetailDialog();
              })
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
        .width('90%')
        .height('80%')
        .position({ x: '5%', y: '10%' })
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
      .zIndex(1000)
    }
  }

  @Builder
  buildDiaryForm() {
    Column({ space: 16 }) {
      // 日记标题
      Column({ space: 8 }) {
        Text('标题')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: '请输入日记标题' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .onChange((value: string) => {
            this.formTitle = value;
          })
      }

      // 心情选择
      Column({ space: 8 }) {
        Text('今日心情')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Row({ space: 12 }) {
          ForEach([
            { mood: DiaryMood.EXCELLENT, emoji: '😄', text: '非常好' },
            { mood: DiaryMood.GOOD, emoji: '😊', text: '良好' },
            { mood: DiaryMood.NORMAL, emoji: '😐', text: '一般' },
            { mood: DiaryMood.BAD, emoji: '😔', text: '不好' },
            { mood: DiaryMood.TERRIBLE, emoji: '😢', text: '很差' }
          ], (item: MoodOption) => {
            Column({ space: 4 }) {
              Text(item.emoji)
                .fontSize(24)
              Text(item.text)
                .fontSize(12)
                .fontColor(this.formMood === item.mood ? '#F34F40' : '#999999')
            }
            .padding(8)
            .backgroundColor(this.formMood === item.mood ? '#FFF5F5' : '#F8F9FA')
            .borderRadius(8)
            .onClick(() => {
              this.formMood = item.mood;
            })
          }, (item: MoodOption) => item.mood)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }

      // 学习时长
      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('学习时长（分钟）')
            .fontSize(14)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          TextInput({ placeholder: '0' })
            .fontSize(14)
            .backgroundColor('#F8F9FA')
            .borderRadius(8)
            .padding({ left: 12, right: 12, top: 10, bottom: 10 })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.formStudyDuration = value;
            })
        }
        .layoutWeight(1)

        Column({ space: 8 }) {
          Text('解决题目数')
            .fontSize(14)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          TextInput({ placeholder: '0' })
            .fontSize(14)
            .backgroundColor('#F8F9FA')
            .borderRadius(8)
            .padding({ left: 12, right: 12, top: 10, bottom: 10 })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.formProblemsSolved = value;
            })
        }
        .layoutWeight(1)
      }

      // 日记内容
      Column({ space: 8 }) {
        Text('学习心得')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextArea({ placeholder: '记录今天的学习心得、遇到的问题、收获等...' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .height(120)
          .onChange((value: string) => {
            this.formContent = value;
          })
      }

      // 标签
      Column({ space: 8 }) {
        Text('标签（用逗号分隔）')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: '例如：算法,数据结构,动态规划' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .onChange((value: string) => {
            this.formTags = value;
          })
      }
    }
  }

  private showAddDiaryDialog(): void {
    this.clearForm();
    this.showAddDialog = true;
  }

  private hideAddDiaryDialog(): void {
    this.showAddDialog = false;
  }

  private showEditDiaryDialog(diary?: StudyDiaryModel): void {
    if (diary) {
      this.currentEditDiary = diary;
      this.formTitle = diary.title;
      this.formContent = diary.content;
      this.formMood = diary.mood;
      this.formStudyDuration = diary.studyDuration.toString();
      this.formProblemsSolved = diary.problemsSolved.toString();
      this.formTags = diary.tags;
    }
    this.showEditDialog = true;
  }

  private hideEditDiaryDialog(): void {
    this.showEditDialog = false;
    this.currentEditDiary = null;
  }

  private showDetailDiaryDialog(diary: StudyDiaryModel): void {
    this.currentDetailDiary = diary;
    this.showDetailDialog = true;
  }

  private hideDetailDialog(): void {
    this.showDetailDialog = false;
    this.currentDetailDiary = null;
  }

  private clearForm(): void {
    this.formTitle = '';
    this.formContent = '';
    this.formMood = DiaryMood.NORMAL;
    this.formStudyDuration = '';
    this.formProblemsSolved = '';
    this.formTags = '';
  }

  private async addDiary(): Promise<void> {
    if (!this.formTitle.trim() || !this.formContent.trim()) {
      console.error('请填写标题和内容');
      return;
    }

    try {
      const diary = new StudyDiaryModel();
      diary.title = this.formTitle.trim();
      diary.content = this.formContent.trim();
      diary.mood = this.formMood;
      diary.studyDuration = parseInt(this.formStudyDuration) || 0;
      diary.problemsSolved = parseInt(this.formProblemsSolved) || 0;
      diary.tags = this.formTags.trim();

      await this.studyDiaryDao.addDiary(diary);
      await this.loadDiaries();
      this.hideAddDiaryDialog();
      console.info('添加学习日记成功');
    } catch (error) {
      console.error('添加学习日记失败:', error);
    }
  }

  private async updateDiary(): Promise<void> {
    if (!this.currentEditDiary || !this.formTitle.trim() || !this.formContent.trim()) {
      console.error('请填写完整信息');
      return;
    }

    try {
      this.currentEditDiary.title = this.formTitle.trim();
      this.currentEditDiary.content = this.formContent.trim();
      this.currentEditDiary.mood = this.formMood;
      this.currentEditDiary.studyDuration = parseInt(this.formStudyDuration) || 0;
      this.currentEditDiary.problemsSolved = parseInt(this.formProblemsSolved) || 0;
      this.currentEditDiary.tags = this.formTags.trim();

      await this.studyDiaryDao.updateDiary(this.currentEditDiary);
      await this.loadDiaries();
      this.hideEditDiaryDialog();
      console.info('更新学习日记成功');
    } catch (error) {
      console.error('更新学习日记失败:', error);
    }
  }

  private async deleteDiary(id: number): Promise<void> {
    try {
      await this.studyDiaryDao.deleteDiary(id);
      await this.loadDiaries();
      console.info('删除学习日记成功');
    } catch (error) {
      console.error('删除学习日记失败:', error);
    }
  }
}