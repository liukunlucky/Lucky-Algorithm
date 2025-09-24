import { StudyGoalModel, GoalStatus, GoalType } from '../model/StudyGoalModel';
import { StudyGoalDao } from '../dao/StudyGoalDao';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct AddEditStudyGoalPage {
  @State isEditMode: boolean = false;
  @State goalId: number = 0;
  @State isLoading: boolean = false;
  
  // 表单数据
  @State formTitle: string = '';
  @State formDescription: string = '';
  @State formType: GoalType = GoalType.DAILY;
  @State formTargetValue: string = '';
  @State formStartDate: string = '';
  @State formEndDate: string = '';

  private studyGoalDao: StudyGoalDao = new StudyGoalDao();

  async aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params.goal) {
      this.isEditMode = true;
      const goal = params.goal as StudyGoalModel;
      this.goalId = goal.id;
      this.formTitle = goal.title;
      this.formDescription = goal.description;
      this.formTargetValue = goal.targetValue.toString();
      this.formType = goal.type;
      this.formStartDate = goal.startDate || '';
      this.formEndDate = goal.endDate || '';
    }
  }

  build() {
    Column() {
      this.buildHeader()
      
      Scroll() {
        Column({ space: 20 }) {
          this.buildGoalForm()
        }
        .padding(16)
      }
      .layoutWeight(1)
      
      this.buildBottomButtons()
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

      Text(this.isEditMode ? '编辑学习目标' : '添加学习目标')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 占位，保持标题居中
      Column().width(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildGoalForm() {
    Column({ space: 16 }) {
      // 目标标题
      Column({ space: 8 }) {
        Row() {
          Text('目标标题')
            .fontSize(14)
            .fontColor('#333333')
          
          Text('*')
            .fontSize(14)
            .fontColor('#FF4444')
        }
        .alignSelf(ItemAlign.Start)

        TextInput({ 
          placeholder: '请输入目标标题',
          text: this.formTitle
        })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .onChange((value: string) => {
            this.formTitle = value;
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)

      // 目标类型
      Column({ space: 8 }) {
        Text('目标类型')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Row({ space: 12 }) {
          Button('每日目标')
            .fontSize(14)
            .fontColor(this.formType === GoalType.DAILY ? '#FFFFFF' : '#666666')
            .backgroundColor(this.formType === GoalType.DAILY ? '#F34F40' : '#F0F0F0')
            .borderRadius(6)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onClick(() => {
              this.formType = GoalType.DAILY;
            })

          Button('每周目标')
            .fontSize(14)
            .fontColor(this.formType === GoalType.WEEKLY ? '#FFFFFF' : '#666666')
            .backgroundColor(this.formType === GoalType.WEEKLY ? '#F34F40' : '#F0F0F0')
            .borderRadius(6)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onClick(() => {
              this.formType = GoalType.WEEKLY;
            })

          Button('每月目标')
            .fontSize(14)
            .fontColor(this.formType === GoalType.MONTHLY ? '#FFFFFF' : '#666666')
            .backgroundColor(this.formType === GoalType.MONTHLY ? '#F34F40' : '#F0F0F0')
            .borderRadius(6)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onClick(() => {
              this.formType = GoalType.MONTHLY;
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)

      // 目标数量
      Column({ space: 8 }) {
        Row() {
          Text('目标数量')
            .fontSize(14)
            .fontColor('#333333')
          
          Text('*')
            .fontSize(14)
            .fontColor('#FF4444')
        }
        .alignSelf(ItemAlign.Start)

        TextInput({ 
          placeholder: '请输入目标数量',
          text: this.formTargetValue
        })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .type(InputType.Number)
          .onChange((value: string) => {
            this.formTargetValue = value;
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)

      // 目标描述
      Column({ space: 8 }) {
        Text('目标描述')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextArea({ 
          placeholder: '请输入目标描述（可选）',
          text: this.formDescription
        })
          .fontSize(14)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .height(100)
          .onChange((value: string) => {
            this.formDescription = value;
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
  }

  @Builder
  buildBottomButtons() {
    Column({ space: 12 }) {
      // 保存按钮
      Button(this.isLoading ? '保存中...' : '保存')
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor(this.isLoading ? '#CCCCCC' : '#F34F40')
        .borderRadius(8)
        .width('100%')
        .height(48)
        .enabled(!this.isLoading)
        .onClick(() => {
          this.saveGoal();
        })

      // 删除按钮（仅编辑模式显示）
      if (this.isEditMode) {
        Button('删除目标')
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
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  private validateForm(): boolean {
    if (!this.formTitle.trim()) {
      promptAction.showToast({
        message: '请输入目标标题',
        duration: 2000
      });
      return false;
    }

    if (!this.formTargetValue.trim()) {
      promptAction.showToast({
        message: '请输入目标数量',
        duration: 2000
      });
      return false;
    }

    const targetValue = parseInt(this.formTargetValue);
    if (isNaN(targetValue) || targetValue <= 0) {
      promptAction.showToast({
        message: '目标数量必须是大于0的数字',
        duration: 2000
      });
      return false;
    }

    return true;
  }

  private async saveGoal(): Promise<void> {
    if (!this.validateForm()) {
      return;
    }

    try {
      this.isLoading = true;

      if (this.isEditMode) {
        // 编辑模式
        const goal = new StudyGoalModel();
        goal.id = this.goalId;
        goal.title = this.formTitle.trim();
        goal.description = this.formDescription.trim();
        goal.type = this.formType;
        goal.targetValue = parseInt(this.formTargetValue);
        
        await this.studyGoalDao.updateGoal(goal);
        
        promptAction.showToast({
          message: '学习目标更新成功',
          duration: 2000
        });
      } else {
        // 添加模式
        const goal = new StudyGoalModel();
        goal.title = this.formTitle.trim();
        goal.description = this.formDescription.trim();
        goal.type = this.formType;
        goal.targetValue = parseInt(this.formTargetValue);
        goal.startDate = new Date().toISOString().split('T')[0];
        
        await this.studyGoalDao.addGoal(goal);
        
        promptAction.showToast({
          message: '学习目标添加成功',
          duration: 2000
        });
      }

      router.back();
    } catch (error) {
      console.error('保存学习目标失败:', error);
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
      message: '确定要删除这个学习目标吗？删除后无法恢复。',
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
          this.deleteGoal();
        }
      }
    });
  }

  private async deleteGoal(): Promise<void> {
    try {
      this.isLoading = true;
      
      await this.studyGoalDao.deleteGoal(this.goalId);
      
      promptAction.showToast({
        message: '学习目标删除成功',
        duration: 2000
      });
      
      router.back();
    } catch (error) {
      console.error('删除学习目标失败:', error);
      promptAction.showToast({
        message: '删除失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }
}