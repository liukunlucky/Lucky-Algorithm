import { StudyGoalModel, GoalStatus, GoalType } from '../model/StudyGoalModel';
import { StudyGoalDao } from '../dao/StudyGoalDao';
import router from '@ohos.router';

@Entry
@Component
struct StudyGoalsPage {
  @State goals: StudyGoalModel[] = [];
  @State isLoading: boolean = true;
  @State showAddDialog: boolean = false;
  @State showEditDialog: boolean = false;
  @State currentEditGoal: StudyGoalModel | null = null;
  
  // 表单数据
  @State formTitle: string = '';
  @State formDescription: string = '';
  @State formType: GoalType = GoalType.DAILY;
  @State formTargetValue: string = '';
  @State formStartDate: string = '';
  @State formEndDate: string = '';

  private studyGoalDao: StudyGoalDao = new StudyGoalDao();

  async aboutToAppear() {
    await this.loadGoals();
  }

  async onPageShow() {
    await this.loadGoals();
  }

  async loadGoals() {
    try {
      this.isLoading = true;
      this.goals = await this.studyGoalDao.getAllGoals();
      console.info('加载学习目标成功，数量:', this.goals.length);
    } catch (error) {
      console.error('加载学习目标失败:', error);
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

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
        // 目标列表
        this.buildGoalsList()
      }

      // 添加目标对话框
      if (this.showAddDialog) {
        this.buildAddGoalDialog()
      }

      // 编辑目标对话框
      if (this.showEditDialog) {
        this.buildEditGoalDialog()
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

      Text('学习目标')
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
          url: 'pages/AddEditStudyGoalPage'
        }).catch((error: Error) => {
          console.error('跳转到添加目标页面失败:', error);
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
  buildGoalsList() {
    if (this.goals.length === 0) {
      Column() {
        Image($r('app.media.icon_empty'))
          .width(173)
          .height(128)

        Text('还没有学习目标')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
        Text('还没有学习目标')
          .fontSize(14)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
    } else {
      List({ space: 12 }) {
        ForEach(this.goals, (goal: StudyGoalModel) => {
          this.buildGoalCard(goal)
        }, (goal: StudyGoalModel) => goal.id.toString())
      }
      .padding(16)
      .width('100%').height('100%')
    }
  }

  @Builder
  buildGoalCard(goal: StudyGoalModel) {
    Column() {
      // 目标标题和状态
      Row() {
        Column({ space: 4 }) {
          Text(goal.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(goal.getTypeDisplayText())
            .fontSize(12)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(goal.getStatusDisplayText())
          .fontSize(12)
          .fontColor(this.getStatusColor(goal.status))
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(this.getStatusBackgroundColor(goal.status))
          .borderRadius(4)
      }
      .width('100%')

      // 目标描述
      if (goal.description) {
        Text(goal.description)
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }

      // 进度条
      Column({ space: 8 }) {
        Row() {
          Text(`进度: ${goal.currentValue}/${goal.targetValue}`)
            .fontSize(14)
            .fontColor('#333333')
            .layoutWeight(1)

          Text(`${Math.round(goal.getProgressPercentage())}%`)
            .fontSize(14)
            .fontColor('#F34F40')
        }
        .width('100%')

        Progress({ value: goal.getProgressPercentage(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .color('#F34F40')
          .backgroundColor('#F0F0F0')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/AddEditStudyGoalPage',
        params: { goal: goal }
      }).catch((error: Error) => {
        console.error('跳转到编辑目标页面失败:', error);
      });
    })
  }

  @Builder
  buildAddGoalDialog() {
    Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .onClick(() => {
          this.hideAddGoalDialog();
        })

      // 对话框内容
      Column({ space: 20 }) {
        Text('添加学习目标')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        this.buildGoalForm()

        Row({ space: 12 }) {
          Button('取消')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .borderRadius(8)
            .layoutWeight(1)
            .onClick(() => {
              this.hideAddGoalDialog();
            })

          Button('确定')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#F34F40')
            .borderRadius(8)
            .layoutWeight(1)
            .onClick(() => {
              this.addGoal();
            })
        }
        .width('100%')
      }
      .width('80%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .position({ x: '10%', y: '20%' })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(1000)
  }

  @Builder
  buildEditGoalDialog() {
    Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .onClick(() => {
          this.hideEditGoalDialog();
        })

      // 对话框内容
      Column({ space: 20 }) {
        Text('编辑学习目标')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        this.buildGoalForm()

        Row({ space: 12 }) {
          Button('取消')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .borderRadius(8)
            .layoutWeight(1)
            .onClick(() => {
              this.hideEditGoalDialog();
            })

          Button('保存')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#F34F40')
            .borderRadius(8)
            .layoutWeight(1)
            .onClick(() => {
              this.updateGoal();
            })
        }
        .width('100%')
      }
      .width('80%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .position({ x: '10%', y: '20%' })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(1000)
  }

  @Builder
  buildGoalForm() {
    Column({ space: 16 }) {
      // 目标标题
      Column({ space: 8 }) {
        Text('目标标题')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: '请输入目标标题' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .onChange((value: string) => {
            this.formTitle = value;
          })
      }

      // 目标描述
      Column({ space: 8 }) {
        Text('目标描述')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextArea({ placeholder: '请输入目标描述（可选）' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .height(80)
          .onChange((value: string) => {
            this.formDescription = value;
          })
      }

      // 目标数量
      Column({ space: 8 }) {
        Text('目标数量')
          .fontSize(14)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        TextInput({ placeholder: '请输入目标数量' })
          .fontSize(14)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .type(InputType.Number)
          .onChange((value: string) => {
            this.formTargetValue = value;
          })
      }
    }
  }

  private showAddGoalDialog(): void {
    this.clearForm();
    this.showAddDialog = true;
  }

  private hideAddGoalDialog(): void {
    this.showAddDialog = false;
  }

  private showEditGoalDialog(goal?: StudyGoalModel): void {
    if (goal) {
      this.currentEditGoal = goal;
      this.formTitle = goal.title;
      this.formDescription = goal.description;
      this.formTargetValue = goal.targetValue.toString();
      this.formType = goal.type;
    }
    this.showEditDialog = true;
  }

  private hideEditGoalDialog(): void {
    this.showEditDialog = false;
    this.currentEditGoal = null;
  }

  private clearForm(): void {
    this.formTitle = '';
    this.formDescription = '';
    this.formTargetValue = '';
    this.formType = GoalType.DAILY;
    this.formStartDate = '';
    this.formEndDate = '';
  }

  private async addGoal(): Promise<void> {
    if (!this.formTitle.trim() || !this.formTargetValue.trim()) {
      console.error('请填写完整信息');
      return;
    }

    try {
      const goal = new StudyGoalModel();
      goal.title = this.formTitle.trim();
      goal.description = this.formDescription.trim();
      goal.type = this.formType;
      goal.targetValue = parseInt(this.formTargetValue);
      goal.startDate = new Date().toISOString().split('T')[0];

      await this.studyGoalDao.addGoal(goal);
      await this.loadGoals();
      this.hideAddGoalDialog();
      console.info('添加学习目标成功');
    } catch (error) {
      console.error('添加学习目标失败:', error);
    }
  }

  private async updateGoal(): Promise<void> {
    if (!this.currentEditGoal || !this.formTitle.trim() || !this.formTargetValue.trim()) {
      console.error('请填写完整信息');
      return;
    }

    try {
      this.currentEditGoal.title = this.formTitle.trim();
      this.currentEditGoal.description = this.formDescription.trim();
      this.currentEditGoal.targetValue = parseInt(this.formTargetValue);
      this.currentEditGoal.type = this.formType;

      await this.studyGoalDao.updateGoal(this.currentEditGoal);
      await this.loadGoals();
      this.hideEditGoalDialog();
      console.info('更新学习目标成功');
    } catch (error) {
      console.error('更新学习目标失败:', error);
    }
  }

  private async deleteGoal(id: number): Promise<void> {
    try {
      await this.studyGoalDao.deleteGoal(id);
      await this.loadGoals();
      console.info('删除学习目标成功');
    } catch (error) {
      console.error('删除学习目标失败:', error);
    }
  }

  private getStatusColor(status: GoalStatus): string {
    switch (status) {
      case GoalStatus.ACTIVE:
        return '#52c41a';
      case GoalStatus.COMPLETED:
        return '#1890ff';
      case GoalStatus.PAUSED:
        return '#faad14';
      default:
        return '#999999';
    }
  }

  private getStatusBackgroundColor(status: GoalStatus): string {
    switch (status) {
      case GoalStatus.ACTIVE:
        return '#f6ffed';
      case GoalStatus.COMPLETED:
        return '#e6f7ff';
      case GoalStatus.PAUSED:
        return '#fffbe6';
      default:
        return '#f5f5f5';
    }
  }
}