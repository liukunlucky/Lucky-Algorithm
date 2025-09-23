import router from '@ohos.router';
import { ExamMode, ExamRecordModel, ExamProblemResult } from '../model/ExamRecordModel';
import { ProblemModel, ChoiceOption, ProblemType } from '../model/ProblemModel';
import { ExamService } from '../service/ExamService';
import { TabNavigationService } from '../service/TabNavigationService';

interface ExamParams {
  mode: ExamMode;
  problems: ProblemModel[];
  timeLimit: number; // 秒
}

@Entry
@Component
struct ExamConductPage {
  @State examParams: ExamParams | null = null;
  @State currentProblemIndex: number = 0;
  @State userAnswers: string[][] = []; // 改为二维数组，支持多选题
  @State timeRemaining: number = 0; // 秒
  @State isSubmitted: boolean = false;
  @State showSubmitDialog: boolean = false;
  
  private timerId: number = -1;
  private startTime: number = 0;

  aboutToAppear() {
    const params = router.getParams() as ExamParams;
    if (params) {
      console.log('lucky exam info is ' + JSON.stringify(params))
      this.examParams = params;
      this.timeRemaining = params.timeLimit;
      this.userAnswers = new Array(params.problems.length).fill(null).map(() => []);
      this.startTime = Date.now();
      this.startTimer();
    }
  }

  aboutToDisappear() {
    this.stopTimer();
  }

  build() {
    Stack() {
      if (!this.examParams) {
        Column() {
          Text('加载中...')
            .fontSize(16)
            .fontColor('#666666')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Column({ space: 0 }) {
          // 顶部状态栏
          this.buildStatusBar()

          // 题目内容区域
          this.buildProblemContent()

          // 选择题答题区域
          this.buildChoiceOptions()

          // 底部操作栏
          this.buildBottomActions()
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#f5f5f5')
      }

      // 提交确认对话框
      if (this.showSubmitDialog) {
        this.buildSubmitDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildStatusBar() {
    Row() {
      // 返回按钮
      Button() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
          .fillColor('#666666')
      }
      .width(100)
      .height(40)
      .align(Alignment.Start)
      .backgroundColor(Color.Transparent)
      .borderRadius(6)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.showExitConfirm();
      })

      // 题目进度
      Text(this.examParams && this.examParams.problems ? 
        `${this.currentProblemIndex + 1}/${this.examParams.problems.length}` : '0/0')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 倒计时
      Row({ space: 4 }) {
        Image($r('app.media.icon_clock'))
          .width(24).height(24)

        Text(this.formatTime(this.timeRemaining))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.timeRemaining < 300 ? '#f5222d' : '#333333') // 少于5分钟显示红色
      }
      .width(100)
      .justifyContent(FlexAlign.End)
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor('#ffffff')
      .borderRadius(8)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
  }

  @Builder
  buildProblemContent() {
    if (!this.examParams || !this.examParams.problems || this.currentProblemIndex >= this.examParams.problems.length) {
      Column() {
        Text('题目加载中...')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else if (this.currentProblemIndex >= 0 && this.currentProblemIndex < this.examParams.problems.length && this.examParams.problems[this.currentProblemIndex]) {
        Column({ space: 12 }) {
      // 题目标题
      Row({ space: 8 }) {
        Text(`${this.currentProblemIndex + 1}.`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text(this.examParams.problems[this.currentProblemIndex].title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)

        Text(this.getDifficultyText(this.examParams.problems[this.currentProblemIndex].difficulty))
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor(this.getDifficultyColor(this.examParams.problems[this.currentProblemIndex].difficulty))
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // 题目描述
      Scroll() {
        Text(this.examParams.problems[this.currentProblemIndex].description)
          .fontSize(14)
          .fontColor('#333333')
          .lineHeight(20)
      }
      .width('100%')
      .height(120)
      .backgroundColor('#ffffff')
      .borderRadius(8)
      .padding(12)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    } else {
      Column() {
        Text('题目不存在')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
  }

  @Builder
  buildChoiceOptions() {
    Column({ space: 12 }) {
      Row() {
        Text('请选择答案')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank()

        Text(this.getCurrentProblemTypeText())
          .fontSize(12)
          .fontColor('#666666')
          .backgroundColor('#f0f0f0')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
      }
      .width('100%')

      // 选项列表
      Column({ space: 8 }) {
        ForEach(this.getCurrentProblemOptions(), (option: ChoiceOption) => {
          this.buildOptionItem(option)
        }, (option: ChoiceOption) => `${this.currentProblemIndex}-${option.id}`)
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .layoutWeight(1)
  }

  @Builder
  buildOptionItem(option: ChoiceOption) {
    Row({ space: 12 }) {
      // 选择框
      if (this.getCurrentProblemType() === ProblemType.MULTIPLE_CHOICE) {
        // 多选框
        Checkbox({ name: option.id, group: `choices-${this.currentProblemIndex}` })
          .select(this.isOptionSelected(option.id))
          .selectedColor('#F34F40')
          .onChange((value: boolean) => {
            this.selectOption(option.id);
          })
      } else {
        // 单选框
        Radio({ value: option.id, group: `choices-${this.currentProblemIndex}` })
          .checked(this.isOptionSelected(option.id))
          .radioStyle({ checkedBackgroundColor: '#F34F40' })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.selectOption(option.id);
            }
          })
      }

      // 选项内容
      Text(`${option.id}. ${option.text}`)
        .fontSize(14)
        .fontColor('#333333')
        .layoutWeight(1)
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.isOptionSelected(option.id) ? '#e6f7ff' : '#ffffff')
    .borderRadius(8)
    .border({ width: 1, color: this.isOptionSelected(option.id) ? '#F34F40' : '#e0e0e0' })
    .onClick(() => {
      this.selectOption(option.id);
    })
  }

  @Builder
  buildBottomActions() {
    Row({ space: 12 }) {
      // 上一题按钮
      Button('上一题')
        .layoutWeight(1)
        .height(44)
        .backgroundColor(this.currentProblemIndex > 0 ? '#f0f0f0' : '#e0e0e0')
        .fontColor(this.currentProblemIndex > 0 ? '#333333' : '#999999')
        .borderRadius(8)
        .enabled(this.currentProblemIndex > 0)
        .onClick(() => {
          if (this.currentProblemIndex > 0) {
            this.currentProblemIndex--;
          }
        })

      // 下一题按钮
      Button(this.examParams && this.examParams.problems && 
        this.currentProblemIndex < this.examParams.problems.length - 1 ? '下一题' : '完成考核')
        .layoutWeight(2)
        .height(44)
        .backgroundColor('#F34F40')
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          if (this.examParams && this.examParams.problems && 
            this.currentProblemIndex < this.examParams.problems.length - 1) {
            this.currentProblemIndex++;
          } else {
            this.showSubmitDialog = true;
          }
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: -1 })
  }

  @Builder
  buildSubmitDialog() {
    // 遮罩层
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .onClick(() => {
        this.showSubmitDialog = false;
      })
      .position({ x: 0, y: 0 })
      .zIndex(999)

    // 对话框内容
    Column({ space: 20 }) {
      Text('提交考核')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Column({ space: 12 }) {
        Text('确定要提交考核吗？')
          .fontSize(16)
          .fontColor('#333333')
          .textAlign(TextAlign.Center)

        Text('提交后将无法修改答案')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Center)

        // 答题统计
        Row({ space: 16 }) {
          Column({ space: 4 }) {
            Text(this.getAnsweredCount().toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#52c41a')

            Text('已答题')
              .fontSize(12)
              .fontColor('#666666')
          }

          Column({ space: 4 }) {
            Text((this.examParams!.problems.length - this.getAnsweredCount()).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#f5222d')

            Text('未答题')
              .fontSize(12)
              .fontColor('#666666')
          }
        }
        .justifyContent(FlexAlign.Center)
      }

      // 按钮组
      Row({ space: 12 }) {
        Button('继续答题')
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#f5f5f5')
          .fontColor('#666666')
          .borderRadius(8)
          .onClick(() => {
            this.showSubmitDialog = false;
          })

        Button('确定提交')
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#52c41a')
          .fontColor('#ffffff')
          .borderRadius(8)
          .onClick(() => {
            this.submitExam();
          })
      }
      .width('100%')
    }
    .width(320)
    .padding(24)
    .backgroundColor('#ffffff')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
    .position({ x: '50%', y: '50%' })
    .translate({ x: '-50%', y: '-50%' })
    .zIndex(1000)
  }

  private startTimer(): void {
    this.timerId = setInterval(() => {
      if (this.timeRemaining > 0) {
        this.timeRemaining--;
      } else {
        this.timeUp();
      }
    }, 1000);
  }

  private getCurrentProblemTypeText(): string {
    if (!this.examParams || !this.examParams.problems || this.currentProblemIndex >= this.examParams.problems.length) {
      return '';
    }
    const currentProblem = this.examParams.problems[this.currentProblemIndex];
    if (!currentProblem) return '';
    return currentProblem.type === ProblemType.SINGLE_CHOICE ? '单选题' : '多选题';
  }

  private getCurrentProblemOptions(): ChoiceOption[] {
    if (!this.examParams || !this.examParams.problems || this.currentProblemIndex >= this.examParams.problems.length) {
      return [];
    }
    const currentProblem = this.examParams.problems[this.currentProblemIndex];
    if (!currentProblem) return [];
    return currentProblem.choices || [];
  }

  private getCurrentProblemType(): ProblemType {
    if (!this.examParams || !this.examParams.problems || this.currentProblemIndex >= this.examParams.problems.length) {
      return ProblemType.SINGLE_CHOICE;
    }
    const currentProblem = this.examParams.problems[this.currentProblemIndex];
    if (!currentProblem) return ProblemType.SINGLE_CHOICE;
    return currentProblem.type;
  }

  private isOptionSelected(optionId: string): boolean {
    if (this.currentProblemIndex < 0 || this.currentProblemIndex >= this.userAnswers.length) {
      return false;
    }
    return this.userAnswers[this.currentProblemIndex].includes(optionId);
  }

  private selectOption(optionId: string) {
    if (!this.examParams || !this.examParams.problems || this.currentProblemIndex >= this.examParams.problems.length) {
      return;
    }
    
    const currentProblem = this.examParams.problems[this.currentProblemIndex];
    if (!currentProblem) return;
    
    const currentAnswers = this.userAnswers[this.currentProblemIndex];
    
    if (currentProblem.type === ProblemType.SINGLE_CHOICE) {
      // 单选题：替换答案
      this.userAnswers[this.currentProblemIndex] = [optionId];
    } else {
      // 多选题：切换选择状态
      const index = currentAnswers.indexOf(optionId);
      if (index >= 0) {
        // 已选择，取消选择
        this.userAnswers[this.currentProblemIndex] = currentAnswers.filter(id => id !== optionId);
      } else {
        // 未选择，添加选择
        this.userAnswers[this.currentProblemIndex] = [...currentAnswers, optionId];
      }
    }
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private formatTime(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;
    
    if (hours > 0) {
      const hoursStr = hours.toString().padStart(2, '0');
      const minutesStr = minutes.toString().padStart(2, '0');
      const secsStr = secs.toString().padStart(2, '0');
      return `${hoursStr}:${minutesStr}:${secsStr}`;
    } else {
      const minutesStr = minutes.toString().padStart(2, '0');
      const secsStr = secs.toString().padStart(2, '0');
      return `${minutesStr}:${secsStr}`;
    }
  }

  private getAnsweredCount(): number {
    return this.userAnswers.filter(answer => answer.length > 0).length;
  }

  private timeUp(): void {
    this.stopTimer();
    // 时间到，自动提交
    this.submitExam();
  }

  private showExitConfirm(): void {
    AlertDialog.show({
      title: '确认退出',
      message: '确定要退出当前考核吗？退出后答题进度将丢失。',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('User canceled exit exam');
        }
      },
      secondaryButton: {
        value: '确认退出',
        action: () => {
          this.stopTimer();
          router.back();
        }
      }
    });
  }

  private submitExam(): void {
    this.stopTimer();
    this.isSubmitted = true;

    // 计算考核结果
    const endTime = Date.now();
    const totalDuration = Math.floor((endTime - this.startTime) / 1000);

    const problemResults: ExamProblemResult[] = this.examParams!.problems.map((problem, index) => {
      const userAnswer = this.userAnswers[index];
      // 添加防御性检查
      let correctOptions: ChoiceOption[] = [];
      try {
        if (problem && typeof problem.getCorrectOptions === 'function') {
          correctOptions = problem.getCorrectOptions();
        }
      } catch (error) {
        console.error('Error getting correct options for problem:', problem.id, error);
        correctOptions = [];
      }
      const correctAnswer = correctOptions.map(option => option.id);
      
      // 判断答案是否正确
      let isCorrect = false;
      if (userAnswer.length === correctAnswer.length) {
        isCorrect = userAnswer.every(id => correctAnswer.includes(id));
      }
      
      const result: ExamProblemResult = {
        problemId: problem.id,
        problemTitle: problem.title,
        isCorrect: isCorrect,
        userCode: '', // 保留字段，选择题不使用
        userAnswer: userAnswer,
        correctAnswer: correctAnswer,
        timeSpent: Math.floor(totalDuration / this.examParams!.problems.length) // 平均分配时间
      };
      return result;
    });

    // 创建考核记录
    const examRecord = new ExamRecordModel();
    examRecord.id = Date.now();
    examRecord.date = new Date().toISOString();
    examRecord.mode = this.examParams!.mode;
    examRecord.duration = totalDuration;
    examRecord.timeUsed = totalDuration; // 设置timeUsed属性
    examRecord.problemResults = problemResults;
    examRecord.totalProblems = problemResults.length; // 设置总题目数
    examRecord.correctCount = problemResults.filter(result => result.isCorrect).length; // 设置正确题目数
    examRecord.startTime = new Date(Date.now() - totalDuration * 1000); // 设置开始时间
    examRecord.endTime = new Date(); // 设置结束时间
    
    // 计算分数
    examRecord.calculateScore();
    
    console.info(`ExamRecord created: score=${examRecord.score}, accuracy=${examRecord.getAccuracyRate()}%`);

    // 保存考核记录到数据库
    this.saveExamRecordAndNavigate(examRecord);
  }

  // 保存考核记录并跳转到报告页面
  private async saveExamRecordAndNavigate(examRecord: ExamRecordModel): Promise<void> {
    try {
      // 保存考核记录到数据库
      await ExamService.getInstance().saveExamRecord(examRecord);
      console.info('Exam record saved to database successfully');
      
      // 触发考核完成事件，通知ExamPage刷新数据
      TabNavigationService.triggerExamCompleted();
      
      // 替换当前页面为考核报告页面，避免考核页面留在页面栈中
      router.replaceUrl({
        url: 'pages/ExamReportPage',
        params: { 
          examRecord: examRecord
        }
      }).catch((error: Error) => {
        console.error('Failed to navigate to exam report:', error);
      });
    } catch (error) {
      console.error('Failed to save exam record:', error);
      // 即使保存失败，也要替换到报告页面，确保用户能看到结果
      router.replaceUrl({
        url: 'pages/ExamReportPage',
        params: { 
          examRecord: examRecord
        }
      }).catch((navError: Error) => {
        console.error('Failed to navigate to exam report after save error:', navError);
      });
    }
  }

  // 获取难度文本的辅助方法
  private getDifficultyText(difficulty: number): string {
    switch (difficulty) {
      case 0:
        return '简单';
      case 1:
        return '中等';
      case 2:
        return '困难';
      default:
        return '未知';
    }
  }

  // 获取难度颜色的辅助方法
  private getDifficultyColor(difficulty: number): string {
    switch (difficulty) {
      case 0:
        return '#52c41a';
      case 1:
        return '#fa8c16';
      case 2:
        return '#f5222d';
      default:
        return '#666666';
    }
  }
}