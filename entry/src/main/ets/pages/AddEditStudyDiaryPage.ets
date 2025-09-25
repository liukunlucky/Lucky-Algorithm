import { StudyDiaryModel, DiaryMood } from '../model/StudyDiaryModel';
import { StudyDiaryDao } from '../dao/StudyDiaryDao';
import { TimeUtils } from '../utils/TimeUtils';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface MoodOption {
  mood: DiaryMood;
  emoji: string;
  text: string;
}

@Entry
@Component
struct AddEditStudyDiaryPage {
  @State isEditMode: boolean = false;
  @State diaryId: number = 0;
  @State isLoading: boolean = false;
  
  // 表单数据
  @State formTitle: string = '';
  @State formContent: string = '';
  @State formMood: DiaryMood = DiaryMood.NORMAL;
  @State formStudyDuration: string = '';
  @State formProblemsSolved: string = '';
  @State formTags: string = '';

  private studyDiaryDao: StudyDiaryDao = new StudyDiaryDao();

  async aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.diary) {
      this.isEditMode = true;
      const diary = params.diary as StudyDiaryModel;
      this.diaryId = diary.id;
      this.formTitle = diary.title;
      this.formContent = diary.content;
      this.formMood = diary.mood;
      this.formStudyDuration = diary.studyDuration.toString();
      this.formProblemsSolved = diary.problemsSolved.toString();
      this.formTags = diary.tags;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      // 表单内容
      Scroll() {
        Column({ space: 20 }) {
          this.buildDiaryForm()
        }
        .width('100%')
        .padding(20)
      }
      .layoutWeight(1)

      // 底部按钮区域
      this.buildBottomButtons()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildHeader() {
    Row() {
      // 返回按钮
      Row({ space: 8 }) {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
          .fillColor('#333333')
      }.width(40).justifyContent(FlexAlign.Start)
      .onClick(() => {
        router.back();
      })

      // 标题
      Text(this.isEditMode ? '编辑学习日记' : '写学习日记')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333') .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 保存按钮
      Text('保存')
        .fontSize(16)
        .fontColor('#F34F40')
        .onClick(() => {
          this.saveDiary();
        }).width(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .border({ width: { bottom: 1 }, color: '#E5E5E5' })
  }

  @Builder
  buildDiaryForm() {
    Column({ space: 20 }) {
      // 日记标题 - 必填项
      Column({ space: 8 }) {
        Row() {
          Text('标题')
            .fontSize(14)
            .fontColor('#333333')
          
          Text(' *')
            .fontSize(14)
            .fontColor('#FF4444')
        }
        .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: '请输入日记标题', text: this.formTitle })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .border({ width: 1, color: '#E5E5E5' })
          .onChange((value: string) => {
            this.formTitle = value;
          })
      }

      // 心情选择 - 必填项
      Column({ space: 8 }) {
        Row() {
          Text('今日心情')
            .fontSize(14)
            .fontColor('#333333')
          
          Text(' *')
            .fontSize(14)
            .fontColor('#FF4444')
        }
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
            .backgroundColor(this.formMood === item.mood ? '#FFF5F5' : '#FFFFFF')
            .borderRadius(8)
            .border({ width: 1, color: this.formMood === item.mood ? '#F34F40' : '#E5E5E5' })
            .onClick(() => {
              this.formMood = item.mood;
            })
          }, (item: MoodOption) => item.mood)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }

      // 学习时长和解决题目数
      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('学习时长（分钟）')
            .fontSize(14)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          TextInput({ placeholder: '0', text: this.formStudyDuration })
            .fontSize(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .border({ width: 1, color: '#E5E5E5' })
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

          TextInput({ placeholder: '0', text: this.formProblemsSolved })
            .fontSize(14)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .border({ width: 1, color: '#E5E5E5' })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.formProblemsSolved = value;
            })
        }
        .layoutWeight(1)
      }

      // 日记内容 - 必填项
      Column({ space: 8 }) {
        Row() {
          Text('学习心得')
            .fontSize(14)
            .fontColor('#333333')
          
          Text(' *')
            .fontSize(14)
            .fontColor('#FF4444')
        }
        .alignSelf(ItemAlign.Start)

        TextArea({ placeholder: '记录今天的学习心得、遇到的问题、收获等...', text: this.formContent })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .border({ width: 1, color: '#E5E5E5' })
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

        TextInput({ placeholder: '例如：算法,数据结构,动态规划', text: this.formTags })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .border({ width: 1, color: '#E5E5E5' })
          .onChange((value: string) => {
            this.formTags = value;
          })
      }
    }
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .padding(20)
  }

  @Builder
  buildBottomButtons() {
    Column({ space: 16 }) {
      if (this.isEditMode) {
        // 删除按钮（编辑模式下显示）
        Button('删除日记')
          .fontSize(16)
          .fontColor('#FF4444')
          .backgroundColor('#FFF0F0')
          .borderRadius(8)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.showDeleteConfirmDialog();
          })
      }
    }
    .width('100%')
    .padding({ left: 20, right: 20, bottom: 20 })
    .backgroundColor('#F5F5F5')
  }

  private validateForm(): boolean {
    if (!this.formTitle.trim()) {
      promptAction.showToast({
        message: '请输入日记标题',
        duration: 2000
      });
      return false;
    }

    if (!this.formContent.trim()) {
      promptAction.showToast({
        message: '请输入学习心得',
        duration: 2000
      });
      return false;
    }

    return true;
  }

  private async saveDiary(): Promise<void> {
    if (!this.validateForm()) {
      return;
    }

    try {
      this.isLoading = true;
      
      const diary = new StudyDiaryModel();
      diary.title = this.formTitle.trim();
      diary.content = this.formContent.trim();
      diary.mood = this.formMood;
      diary.studyDuration = parseInt(this.formStudyDuration) || 0;
      diary.problemsSolved = parseInt(this.formProblemsSolved) || 0;
      diary.tags = this.formTags.trim();

      if (this.isEditMode) {
        diary.id = this.diaryId;
        diary.updatedAt = TimeUtils.getLocalISOString();
        await this.studyDiaryDao.updateDiary(diary);
        promptAction.showToast({
          message: '日记更新成功',
          duration: 2000
        });
      } else {
        diary.createdAt = TimeUtils.getLocalISOString();
        diary.updatedAt = TimeUtils.getLocalISOString();
        await this.studyDiaryDao.addDiary(diary);
        promptAction.showToast({
          message: '日记保存成功',
          duration: 2000
        });
      }

      // 确保数据库操作完全完成后再返回
      setTimeout(() => {
        router.back();
      }, 100);
    } catch (error) {
      console.error('保存日记失败:', error);
      promptAction.showToast({
        message: '保存失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }

  private showDeleteConfirmDialog(): void {
    AlertDialog.show({
      title: '确认删除',
      message: '确定要删除这篇学习日记吗？删除后无法恢复。',
      primaryButton: {
        value: '取消',
        action: () => {
          // 取消操作
        }
      },
      secondaryButton: {
        value: '删除',
        fontColor: '#FF4444',
        action: () => {
          this.deleteDiary();
        }
      }
    });
  }

  private async deleteDiary(): Promise<void> {
    try {
      this.isLoading = true;
      await this.studyDiaryDao.deleteDiary(this.diaryId);
      promptAction.showToast({
        message: '日记删除成功',
        duration: 2000
      });
      // 确保数据库操作完全完成后再返回
      setTimeout(() => {
        router.back();
      }, 100);
    } catch (error) {
      console.error('删除日记失败:', error);
      promptAction.showToast({
        message: '删除失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }
}