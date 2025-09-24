import { ProblemModel, TestCase, ChoiceOption, ProblemType } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { AppButton, AppButtonType } from '../components/AppButton';
import { TimeUtils } from '../utils/TimeUtils';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface TestResult {
  id: string;
  passed: boolean;
  executionTime: number;
  error?: string;
}

interface RouterParams {
  problemId: number;
}

@Entry
@Component
struct DailyProblemPage {
  @State problem: ProblemModel | null = null;
  @State userProgress: UserProgressModel | null = null;
  @State userCode: string = '';
  @State userAnswer: string[] = []; // 选择题答案，支持多选
  @State testResults: TestResult[] = [];
  @State isRunning: boolean = false;
  @State showSubmitDialog: boolean = false;
  @State isSubmitted: boolean = false;
  @State isLoading: boolean = true;
  @State isFavorite: boolean = false;
  @State problemId: number = 0;
  @State showResultDialog: boolean = false;
  @State isCorrect: boolean = false;
  @State hasAnswered: boolean = false; // 是否已答题
  
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params && params.problemId) {
      this.problemId = params.problemId;
      this.loadProblemDetail(params.problemId);
    }
  }

  build() {
    Stack() {
      Column() {
        this.buildHeader()

        if (this.problem) {
          Scroll() {
            Column({ space: 16 }) {
              // 题目信息卡片
              this.buildProblemInfo()
              
              // 题目内容
              this.buildProblemContent()
              
              // 答题区域
              if (this.problem.type === ProblemType.SINGLE_CHOICE || this.problem.type === ProblemType.MULTIPLE_CHOICE) {
                this.buildChoiceOptions()
              }
              
              // 解析区域（只有答题后才显示）
              if (this.hasAnswered) {
                this.buildSolutionSection()
              }
            }
            .width('100%')
            .padding(16)
          }
          .layoutWeight(1)
          .width('100%')

          // 底部操作按钮
          if (!this.hasAnswered) {
            this.buildBottomActions()
          }
        } else {
          this.buildLoadingState()
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')

      if (this.showSubmitDialog) {
        this.buildSubmitDialog()
      }

      if (this.showResultDialog) {
        this.buildResultDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildHeader() {
    Row({ space: 16 }) {
      // 返回按钮
      Button() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
          .fillColor('#333333')
      }
      .width(40)
      .height(40)
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      // 标题
      Text('每日一题')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 收藏按钮
      Button() {
        Image(this.isFavorite ? $r('app.media.icon_like_full') : $r('app.media.icon_like'))
          .width(24)
          .height(24)
          .fillColor(this.isFavorite ? '#ff4757' : '#666666')
      }
      .width(40)
      .height(40)
      .backgroundColor('transparent')
      .onClick(() => {
        this.toggleFavorite();
      })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildProblemInfo() {
    Column({ space: 12 }) {
      // 题目标题
      Text(this.problem!.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)

      // 题目标签：类型、难度、类别统一在一行
      Row({ space: 8 }) {
        // 题目类型标注
        Row({ space: 6 }) {
          Text(this.problem!.type === ProblemType.SINGLE_CHOICE ? '单选题' : '多选题')
            .fontSize(12)
            .fontColor('#ffffff')
            .fontWeight(FontWeight.Medium)
        }
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(this.problem!.type === ProblemType.SINGLE_CHOICE ? '#1890ff' : '#52c41a')
        .borderRadius(12)
        .border({
          width: 1,
          color: this.problem!.type === ProblemType.SINGLE_CHOICE ? '#1890ff' : '#52c41a'
        })

        // 题目难度
        Text(this.problem!.getDifficultyText())
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor(this.problem!.getDifficultyColor())
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(12)

        // 题目类别
        Text(this.problem!.getCategoryText())
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#787408')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(12)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .alignItems(HorizontalAlign.Start)
  }



  @Builder
  buildProblemContent() {
    Column({ space: 12 }) {
      Text('题目描述')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text(this.problem!.description)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(22)
        .width('100%')

      // 约束条件
      if (this.problem!.constraints) {
        Column({ space: 8 }) {
          Text('约束条件')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(this.problem!.constraints)
            .fontSize(12)
            .fontColor('#333333')
            .backgroundColor('#f8f9fa')
            .padding(8)
            .borderRadius(4)
            .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildChoiceOptions() {
    Column({ space: 12 }) {
      Text('请选择答案')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Column({ space: 8 }) {
        ForEach(this.problem!.choices || [], (option: ChoiceOption) => {
          this.buildOptionItem(option)
        }, (option: ChoiceOption) => option.id)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildOptionItem(option: ChoiceOption) {
    Row({ space: 12 }) {
      // 选择框
      if (this.problem!.type === ProblemType.MULTIPLE_CHOICE) {
        // 多选框
        Checkbox({ name: option.id, group: 'choices' })
          .select(this.isOptionSelected(option.id))
          .selectedColor('#F34F40')
          .onChange((value: boolean) => {
            this.selectOption(option.id, value);
          })
      } else {
        // 单选框
        Radio({ value: option.id, group: 'choices' })
          .checked(this.isOptionSelected(option.id))
          .radioStyle({ checkedBackgroundColor: '#F34F40' })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.selectOption(option.id, true);
            }
          })
      }

      // 选项内容
      Text(option.text)
        .fontSize(14)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.isOptionSelected(option.id) ? '#e6f7ff' : '#ffffff')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isOptionSelected(option.id) ? '#F34F40' : '#e0e0e0'
    })
    .onClick(() => {
      this.selectOption(option.id, !this.isOptionSelected(option.id));
    })
  }

  @Builder
  buildCodeEditor() {
    Column({ space: 12 }) {
      Text('💻 代码编辑器')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      TextArea({
        text: this.userCode,
        placeholder: '请在此处编写您的代码...'
      })
        .width('100%')
        .height(300)
        .fontSize(14)
        .fontFamily('monospace')
        .backgroundColor('#f8f9fa')
        .borderRadius(8)
        .padding(12)
        .onChange((value: string) => {
          this.userCode = value;
        })

      // 运行按钮
      AppButton({
        buttonText: this.isRunning ? '运行中...' : '运行代码',
        type: AppButtonType.PRIMARY,
        buttonWidth: 120,
        onButtonClick: () => {
          this.runCode();
        }
      })

      // 测试结果
      if (this.testResults.length > 0) {
        this.buildTestResults()
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildTestResults() {
    Column({ space: 8 }) {
      Text('🧪 测试结果')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')

      ForEach(this.testResults, (result: TestResult) => {
        Row({ space: 8 }) {
          Image(result.passed ? $r('app.media.icon_correct_color') : $r('app.media.icon_error_color'))
            .width(16)
            .height(16)

          Text(`测试用例 ${result.id}`)
            .fontSize(12)
            .fontColor('#666666')
            .layoutWeight(1)

          Text(result.passed ? '通过' : '失败')
            .fontSize(12)
            .fontColor(result.passed ? '#52c41a' : '#f5222d')

          Text(`${result.executionTime}ms`)
            .fontSize(12)
            .fontColor('#999999')
        }
        .width('100%')
        .padding(8)
        .backgroundColor(result.passed ? '#f6ffed' : '#fff2f0')
        .borderRadius(4)
      }, (result: TestResult) => result.id)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
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
  buildSolutionSection() {
    Column({ space: 16 }) {
      // 解析标题
      Row({ space: 8 }) {
        Image($r('app.media.bulb_icon'))
          .width(20)
          .height(20)
          .fillColor('#ff6b35')
        
        Text('题目解析')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width('100%')

      // 解题思路
      Column({ space: 8 }) {
        Text('解题思路')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Text(this.problem!.explanation || '暂无解题思路')
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(22)
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 参考代码
      if (this.problem!.solutionCode) {
        Column({ space: 8 }) {
          Text('🔧 参考代码')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(this.problem!.solutionCode)
            .fontSize(12)
            .fontFamily('monospace')
            .fontColor('#333333')
            .backgroundColor('#f8f9fa')
            .padding(12)
            .borderRadius(8)
            .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildBottomActions() {
    Row({ space: 12 }) {
      AppButton({
        buttonText: '提交答案',
        type: AppButtonType.PRIMARY,
        buttonWidth: 200,
        onButtonClick: () => {
          this.submitAnswer();
        }
      })
    }
    .width('100%')
    .height(80)
    .padding(16)
    .backgroundColor('#ffffff')
    .border({ width: { top: 1 }, color: '#f0f0f0' })
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildDailyBottomActions() {
    Row({ space: 12 }) {
      AppButton({
        buttonText: '提交答案',
        type: AppButtonType.PRIMARY,
        buttonWidth: 200,
        onButtonClick: () => {
          this.showSubmitDialog = true;
        }
      })
    }
    .width('100%')
    .height(80)
    .padding(16)
    .backgroundColor('#ffffff')
    .border({ width: { top: 1 }, color: '#f0f0f0' })
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildSubmitDialog() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .onClick(() => {
        this.showSubmitDialog = false;
      })
      .position({ x: 0, y: 0 })
      .zIndex(999)

    Column({ space: 20 }) {
      Text('提交答案')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text('确定要提交当前答案吗？提交后将显示答题结果。')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .lineHeight(20)

      Row({ space: 12 }) {
        AppButton({
          buttonText: '取消',
          type: AppButtonType.SECONDARY,
          buttonWidth: 100,
          onButtonClick: () => {
            this.showSubmitDialog = false;
          }
        })

        AppButton({
          buttonText: '确定提交',
          type: AppButtonType.PRIMARY,
          buttonWidth: 100,
          onButtonClick: () => {
            this.showSubmitDialog = false;
            this.submitAnswer();
          }
        })
      }
    }
    .width(280)
    .padding(24)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
    .position({ x: '50%', y: '50%' })
    .translate({ x: '-50%', y: '-50%' })
    .zIndex(1000)
  }

  @Builder
  buildResultDialog() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .onClick(() => {
        this.showResultDialog = false;
      })
      .position({ x: 0, y: 0 })
      .zIndex(999)

    Column({ space: 20 }) {
      // 结果图标
      Image(this.isCorrect ? $r('app.media.icon_correct_color') : $r('app.media.icon_error_color'))
        .width(40)
        .height(40)

      Text(this.isCorrect ? '回答正确！' : '回答错误')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isCorrect ? '#52c41a' : '#f5222d')

      Text(this.isCorrect ? '恭喜您完成今日挑战！' : '不要气馁，查看解析继续学习吧！')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)

      Row({ space: 12 }) {
        AppButton({
          buttonText: '查看解析',
          type: AppButtonType.SECONDARY,
          buttonWidth: 100,
          onButtonClick: () => {
            this.showResultDialog = false;
          }
        })

        AppButton({
          buttonText: '完成',
          type: AppButtonType.PRIMARY,
          buttonWidth: 100,
          onButtonClick: () => {
            this.showResultDialog = false;
            router.back(); // 返回首页
          }
        })
      }
    }
    .width(300)
    .padding(24)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
    .position({ x: '50%', y: '50%' })
    .translate({ x: '-50%', y: '-50%' })
    .zIndex(1000)
  }

  private async loadProblemDetail(problemId: number): Promise<void> {
    try {
      this.isLoading = true;
      
      // 加载题目数据
      this.problem = ProblemMockData.getProblemById(problemId);
      
      if (this.problem) {
        // 初始化用户答案
        this.userAnswer = [];
        
        // 加载用户进度
        await this.loadUserProgress();
      }
    } catch (error) {
      console.error('Failed to load problem detail:', error);
    } finally {
      this.isLoading = false;
    }
  }

  private async loadUserProgress(): Promise<void> {
    try {
      this.userProgress = await this.userProgressDao.getUserProgress(this.problemId);
      if (this.userProgress) {
        this.isFavorite = this.userProgress.isFavorite;
        this.isSubmitted = this.userProgress.status !== ProblemStatus.NOT_ATTEMPTED;
      }
    } catch (error) {
      console.error('Failed to load user progress:', error);
    }
  }

  private isOptionSelected(optionId: string): boolean {
    return this.userAnswer.includes(optionId);
  }

  private selectOption(optionId: string, isSelected: boolean): void {
    if (this.problem!.type === ProblemType.SINGLE_CHOICE) {
      // 单选：替换选择
      if (isSelected) {
        this.userAnswer = [optionId];
      }
    } else {
      // 多选：根据isSelected参数添加或移除
      const index = this.userAnswer.indexOf(optionId);
      if (isSelected && index < 0) {
        this.userAnswer.push(optionId);
      } else if (!isSelected && index >= 0) {
        this.userAnswer.splice(index, 1);
      }
    }
  }

  private async runCode(): Promise<void> {
    if (!this.userCode.trim()) {
      return;
    }

    this.isRunning = true;
    this.testResults = [];

    try {
      // 模拟代码运行
      await new Promise<void>((resolve) => {
        setTimeout(() => {
          resolve();
        }, 1000);
      });

      // 模拟测试结果
      const testCases = this.problem!.testCases || [];
      const results: TestResult[] = [];

      for (let i = 0; i < testCases.length; i++) {
        const testCase = testCases[i];
        const result: TestResult = {} as TestResult;
        result.id = (i + 1).toString();
        result.passed = Math.random() > 0.3; // 70%通过率
        result.executionTime = Math.floor(Math.random() * 100) + 10;
        results.push(result);
      }

      this.testResults = results;
    } catch (error) {
      console.error('Failed to run code:', error);
    } finally {
      this.isRunning = false;
    }
  }

  private async submitAnswer(): Promise<void> {
    if (!this.problem) return;

    // 检查是否有答案
    if (this.problem.type === ProblemType.SINGLE_CHOICE || this.problem.type === ProblemType.MULTIPLE_CHOICE) {
      if (this.userAnswer.length === 0) {
        return;
      }
    }

    try {
      let isCorrect = false;

      if (this.problem.type === ProblemType.SINGLE_CHOICE || this.problem.type === ProblemType.MULTIPLE_CHOICE) {
        // 选择题：检查答案
        const correctAnswers = this.problem.getCorrectOptions().map(option => option.id);
        isCorrect = this.userAnswer.length === correctAnswers.length && 
                   this.userAnswer.every(answer => correctAnswers.includes(answer));
      } else {
        // 编程题：检查测试结果
        isCorrect = this.testResults.length > 0 && this.testResults.every(result => result.passed);
      }

      this.isCorrect = isCorrect;

      // 保存用户进度
      await this.saveUserProgress(isCorrect);

      // 标记为已答题，显示解析
      this.hasAnswered = true;
      this.isSubmitted = true;

      // 显示结果对话框
      this.showResultDialog = true;

    } catch (error) {
      console.error('Failed to submit answer:', error);
    }
  }

  private async saveUserProgress(isCorrect: boolean): Promise<void> {
    try {
      const progress = new UserProgressModel();
      progress.problemId = this.problemId;
      progress.status = isCorrect ? ProblemStatus.COMPLETED : ProblemStatus.WRONG;
      progress.isFavorite = this.isFavorite;
      progress.lastAttempted = TimeUtils.getLocalISOString();
      progress.attemptCount = (this.userProgress?.attemptCount || 0) + 1;

      // 记录答题尝试
      progress.recordAttempt(isCorrect);

      await this.userProgressDao.saveUserProgress(progress);
      this.userProgress = progress;
    } catch (error) {
      console.error('Failed to save user progress:', error);
    }
  }

  private async toggleFavorite(): Promise<void> {
    try {
      this.isFavorite = !this.isFavorite;
      
      if (this.userProgress) {
        this.userProgress.isFavorite = this.isFavorite;
        await this.userProgressDao.saveUserProgress(this.userProgress);
      } else {
        // 创建新的用户进度记录
        const progress = new UserProgressModel();
        progress.problemId = this.problemId;
        progress.status = ProblemStatus.NOT_ATTEMPTED;
        progress.isFavorite = this.isFavorite;
        progress.lastAttempted = TimeUtils.getLocalISOString();
        progress.attemptCount = 0;
        
        await this.userProgressDao.saveUserProgress(progress);
        this.userProgress = progress;
      }
      
      // 显示toast提示
      promptAction.showToast({
        message: this.isFavorite ? '已添加到收藏夹' : '已取消收藏',
        duration: 2000
      });
    } catch (error) {
      console.error('Failed to toggle favorite:', error);
      // 回滚状态
      this.isFavorite = !this.isFavorite;
      
      // 显示错误提示
      promptAction.showToast({
        message: '操作失败，请重试',
        duration: 2000
      });
    }
  }
}