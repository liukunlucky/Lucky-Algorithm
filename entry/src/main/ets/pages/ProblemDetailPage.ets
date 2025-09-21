import { ProblemModel, TestCase, ChoiceOption, ProblemType } from '../model/ProblemModel';
import { UserProgressModel, ProblemStatus } from '../model/UserProgressModel';
import { UserNoteModel } from '../model/UserNoteModel';
import { ProblemMockData } from '../mock/ProblemMockData';
import { UserProgressDao } from '../dao/UserProgressDao';
import { UserNoteDao } from '../dao/UserNoteDao';
import { AppButton, AppButtonType } from '../components/AppButton';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import pasteboard from '@ohos.pasteboard';

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
struct ProblemDetailPage {
  @State problem: ProblemModel | null = null;
  @State userProgress: UserProgressModel | null = null;
  @State currentTab: number = 0; // 0: 题目, 1: 解析
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
  @State isPracticed: boolean = false;
  @State noteContent: string = '';
  @State isEditingNote: boolean = false;
  @State relatedProblems: ProblemModel[] = [];
  
  // 使用mock数据，不再需要数据库实例
  private userProgressDao: UserProgressDao = new UserProgressDao();
  private userNoteDao: UserNoteDao = new UserNoteDao();

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params && params.problemId) {
      this.loadProblemDetail(params.problemId);
    }
  }

  build() {
    Stack() {
      Column() {
        // 顶部导航栏
        this.buildHeader()

        this.buildProblemInfo()
        // Tab切换
        this.buildTabBar()

        // 内容区域
        if (this.currentTab === 0) {
          this.buildProblemTab()
        } else if (this.currentTab === 1) {
          this.buildSolutionTab()
        } else {
          this.buildNotesTab()
        }

        // 底部操作栏
        this.buildBottomActions()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')

      // 提交确认对话框
      if (this.showSubmitDialog) {
        this.buildSubmitDialog()
      }

      // 答题结果对话框
      if (this.showResultDialog) {
        this.buildResultDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildProblemInfo() {
    Column({ space: 12 }) {
      // 题目标题
      Text(this.problem!.title)
        .fontSize(22)
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
          .fontColor(Color.White)
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
        // 是否练过标签
        Text(this.isPracticed ? '已练过' : '未练过')
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor(this.isPracticed ? '#52c41a' : '#ff7875')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(12)
          .fontWeight(FontWeight.Medium)
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
      Text('提交答案')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text('确定要提交当前答案吗？提交后将记录您的解题状态。')
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
      Image(this.isCorrect ? $r('app.media.icon_correct_color') : $r('app.media.icon_error_color'))
        .width(40)
        .height(40)

      Text(this.isCorrect ? '回答正确！' : '回答错误')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isCorrect ? '#52c41a' : '#f5222d')

      Text(this.isCorrect ? '恭喜您答对了这道题！' : '不要气馁，查看解析继续学习吧！')
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
            this.currentTab = 1; // 切换到解析tab
          }
        })

        AppButton({
          buttonText: '继续练习',
          type: AppButtonType.PRIMARY,
          buttonWidth: 100,
          onButtonClick: () => {
            this.showResultDialog = false;
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

      Text('题目详情')
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
    .justifyContent(FlexAlign.SpaceBetween)
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 1 }, color: '#f0f0f0' })
  }

  @Builder
  buildTabBar() {
    Row() {
      this.buildTabItem('题目', 0)
      this.buildTabItem('解析', 1)
      this.buildTabItem('笔记', 2)
    }
    .width('100%')
    .height(44)
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 1 }, color: '#f0f0f0' })
  }

  @Builder
  buildTabItem(title: string, index: number) {
    Text(title)
      .fontSize(14)
      .fontColor(this.currentTab === index ? '#F34F40' : '#666666')
      .fontWeight(this.currentTab === index ? FontWeight.Medium : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height('100%')
      .border({
        width: { bottom: this.currentTab === index ? 2 : 0 },
        color: '#F34F40'
      })
      .onClick(() => {
        this.currentTab = index;
      })
  }

  @Builder
  buildProblemTab() {
    Scroll() {
      Column({ space: 16 }) {
        // 题目描述
        this.buildProblemDescription()

        // 选择题答题区域
        this.buildChoiceOptions()
      }
      .width('100%')
      .padding({left: 16, right: 16, top: 16, bottom:16 })
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring)

  }

  @Builder
  buildProblemDescription() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Row({ space: 8 }) {
          Text('题目描述')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      if (this.problem) {
        Text(this.problem.description)
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(20)
          .alignSelf(ItemAlign.Start)

        // 示例
        if (this.problem.testCases && this.problem.testCases.length > 0) {
          Column({ space: 8 }) {
            Row({ space: 8 }) {
            Image($r('app.media.target_icon'))
              .width(16)
              .height(16)
              .fillColor('#333333')
            Text('示例')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
          }
              .alignSelf(ItemAlign.Start)

            ForEach(this.problem.testCases.slice(0, 2), (testCase: TestCase, index: number) => {
              Column({ space: 4 }) {
                Text('示例 ' + (index + 1) + ':')
                  .fontSize(12)
                  .fontColor('#999999')
                  .alignSelf(ItemAlign.Start)

                Text('输入: ' + testCase.input + '\n输出: ' + testCase.expectedOutput)
                  .fontSize(12)
                  .fontColor('#333333')
                  .backgroundColor('#f8f9fa')
                  .padding(8)
                  .borderRadius(4)
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
            }, (testCase: TestCase, index: number) => index.toString())
          }
          .alignItems(HorizontalAlign.Start)
        }

        // 约束条件
        if (this.problem.constraints) {
          Column({ space: 4 }) {
            Row({ space: 8 }) {
              Image($r('app.media.warning_icon'))
                .width(14)
                .height(14)
                .fillColor('#333333')
              Text('约束条件')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
            }
            .alignSelf(ItemAlign.Start)

            Text(this.problem.constraints)
              .fontSize(12)
              .fontColor('#666666')
              .alignSelf(ItemAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
        }
      }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#ffffff')
      .borderRadius(12)
      .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
      .alignItems(HorizontalAlign.Start)

  }

  @Builder
  buildChoiceOptions() {
    if (this.problem && this.problem.choices && this.problem.choices.length > 0) {
      Column({ space: 12 }) {
        Row() {
          Row({ space: 8 }) {
            Text('选择答案')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
        }
        .width('100%')

        // 选项列表
        Column({ space: 8 }) {
          ForEach(this.problem.choices, (option: ChoiceOption, index: number) => {
          this.buildOptionItem(option, index)
        }, (option: ChoiceOption, index: number) => option.id)
        }
        .width('100%')
        Blank().height(20)
        // 提交按钮
        Button('提交答案')
          .width('100%')
          .height(40)
          .backgroundColor('#F34F40')
          .fontColor('#ffffff')
          .borderRadius(8)
          .enabled(this.userAnswer.length > 0)
          .onClick(() => {
            this.showSubmitDialog = true;
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#ffffff')
      .borderRadius(12)
      .shadow({
        radius: 2,
        color: '#00000008',
        offsetX: 0,
        offsetY: 1
      })
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  buildOptionItem(option: ChoiceOption, index: number) {
    Row({ space: 12 }) {
      // 选择框
      if (this.problem?.type === ProblemType.MULTIPLE_CHOICE) {
        // 多选框
        Checkbox({ name: option.id, group: 'choices' })
          .select(this.userAnswer.includes(option.id))
          .selectedColor('#F34F40')
          .onChange((value: boolean) => {
            this.selectOption(option.id, value);
          })
      } else {
        // 单选框
        Radio({ value: option.id, group: 'choices' })
          .checked(this.userAnswer.includes(option.id))
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
    .backgroundColor(this.userAnswer.includes(option.id) ? '#e6f7ff' : '#ffffff')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.userAnswer.includes(option.id) ? '#F34F40' : '#e0e0e0'
    })
    .onClick(() => {
      this.selectOption(option.id, !this.userAnswer.includes(option.id));
    })
  }

  @Builder
  buildTestResults() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Image($r('app.media.star_icon'))
            .width(14)
            .height(14)
            .fillColor('#333333')
          Text('测试结果')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      List({ space: 8 }) {
        ForEach(this.testResults, (result: TestResult) => {
          ListItem() {
            this.buildTestResultItem(result)
          }
        }, (result: TestResult, index: number) => index.toString())
      }
      .width('100%')
      .height(150)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildTestResultItem(result: TestResult) {
    Row({ space: 12 }) {
      Image(result.passed ? $r('app.media.check_icon') : $r('app.media.close_icon'))
        .width(16)
        .height(16)
        .fillColor(result.passed ? '#52c41a' : '#f5222d')

      Column({ space: 4 }) {
        Text('测试用例 ' + result.id)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        if (result.passed) {
          Text('通过 (' + result.executionTime + 'ms)')
            .fontSize(12)
            .fontColor('#52c41a')
            .alignSelf(ItemAlign.Start)
        } else {
          Text('失败: ' + result.error)
            .fontSize(12)
            .fontColor('#f5222d')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignSelf(ItemAlign.Start)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#f8f9fa')
    .borderRadius(6)
  }

  @Builder
  buildSolutionTab() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
          Text('官方解析')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      if (this.isSubmitted || (this.userProgress?.status !== ProblemStatus.NOT_ATTEMPTED)) {
        // 显示解析内容
        this.buildSolutionContent()
      } else {
        // 需要先提交才能查看
        Column({ space: 12 }) {
          Image($r('app.media.icon_lock'))
            .width(48)
            .height(48)
            .fillColor('#cccccc')

          Text('请先提交答案后查看解析')
            .fontSize(16)
            .fontColor('#999999')

          Text('完成题目后可以查看官方解析和最优解法')
            .fontSize(14)
            .fontColor('#cccccc')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ffffff')
        .borderRadius(12)
      }
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  buildSolutionContent() {
    Scroll() {
      Column({ space: 16 }) {
        // 解题思路
        this.buildThinkingProcess()

        // 解法对比
        this.buildSolutionComparison()

        // 步骤分解
        this.buildStepByStep()

        // 代码实现
        this.buildCodeImplementation()

        // 复杂度分析
        this.buildComplexityAnalysis()

        // 相关题目
        this.buildRelatedProblems()
      }
      .width('100%')
    }
    .layoutWeight(1)
  }

  @Builder
  buildNotesTab() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
        Text('我的笔记')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      if (this.isEditingNote) {
        // 编辑模式
        Column({ space: 12 }) {
          TextArea({
            placeholder: '在这里记录你的解题思路、心得体会...',
            text: this.noteContent
          })
            .width('100%')
            .height(300)
            .fontSize(14)
            .backgroundColor('#ffffff')
            .borderRadius(8)
            .border({ width: 1, color: '#e0e0e0' })
            .onChange((value: string) => {
              this.noteContent = value;
            })

          Row({ space: 12 }) {
            Button('取消')
              .fontSize(14)
              .fontColor('#666666')
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .layoutWeight(1)
              .onClick(() => {
                this.isEditingNote = false;
              })

            Button('保存')
              .fontSize(14)
              .fontColor('#ffffff')
              .backgroundColor('#F34F40')
              .borderRadius(6)
              .layoutWeight(1)
              .onClick(() => {
                this.saveNote();
              })
          }
          .width('100%')
        }
      } else {
        // 显示模式
        Column({ space: 12 }) {
          if (this.noteContent.length > 0) {
            Text(this.noteContent)
              .fontSize(14)
              .fontColor('#333333')
              .lineHeight(22)
              .width('100%')
              .padding(16)
              .backgroundColor('#ffffff')
              .borderRadius(8)
              .border({ width: 1, color: '#e0e0e0' })
          } else {
            Column({ space: 8 }) {
              Image($r('app.media.icon_note'))
                .width(48)
                .height(48)
                .fillColor('#cccccc')

              Text('还没有笔记')
                .fontSize(16)
                .fontColor('#999999')

              Text('记录你的解题思路和心得体会')
                .fontSize(14)
                .fontColor('#cccccc')
            }
            .width('100%')
            .height(200)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor('#ffffff')
            .borderRadius(8)
            .border({ width: 1, color: '#e0e0e0' })
          }

          Button(this.noteContent.length > 0 ? '编辑笔记' : '添加笔记')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#F34F40')
            .borderRadius(6)
            .width('100%')
            .onClick(() => {
              this.isEditingNote = true;
            })
        }
      }
    }
    .width('100%')
    .layoutWeight(1)
    .padding(16)
  }

  @Builder
  buildThinkingProcess() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('解题思路')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Column({ space: 8 }) {
        Text('核心思想')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1890ff')
          .alignSelf(ItemAlign.Start)

        Text(this.problem?.hint || '这道题考查的是基本的算法思维，需要仔细分析题目要求，找出最优的解决方案。')
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(22)
          .alignSelf(ItemAlign.Start)

        Text('关键点分析')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1890ff')
          .alignSelf(ItemAlign.Start)
          .margin({ top: 8 })

        Column({ space: 6 }) {
          this.buildKeyPoint('1. 理解题目要求和约束条件')
          this.buildKeyPoint('2. 分析数据结构和算法选择')
          this.buildKeyPoint('3. 考虑边界情况和特殊输入')
          this.buildKeyPoint('4. 优化时间和空间复杂度')
        }
        .alignSelf(ItemAlign.Start)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildKeyPoint(text: string) {
    Row({ space: 8 }) {
      Text('•')
        .fontSize(14)
        .fontColor('#1890ff')
      Text(text)
        .fontSize(14)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  buildSolutionComparison() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('解法对比')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Column({ space: 12 }) {
        this.buildSolutionOption('暴力解法', 'O(n²)', 'O(1)', '简单直观，适合理解题意', '#f5222d')
        this.buildSolutionOption('优化解法', 'O(n log n)', 'O(n)', '时间复杂度更优，推荐使用', '#52c41a')
        this.buildSolutionOption('最优解法', 'O(n)', 'O(1)', '时空复杂度最优，需要技巧', '#1890ff')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildSolutionOption(title: string, timeComplexity: string, spaceComplexity: string, description: string, color: string) {
    Row({ space: 12 }) {
      Column() {
        Text('●')
          .fontSize(12)
          .fontColor(color)
      }
      .width(20)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Row({ space: 16 }) {
          Text('时间: ' + timeComplexity)
            .fontSize(12)
            .fontColor('#999999')
          Text('空间: ' + spaceComplexity)
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignSelf(ItemAlign.Start)

        Text(description)
          .fontSize(12)
          .fontColor('#666666')
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#fafafa')
    .borderRadius(8)
    .border({ width: 1, color: color + '20' })
  }

  @Builder
  buildStepByStep() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('步骤分解')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Column({ space: 10 }) {
        this.buildStep(1, '分析输入输出', '理解题目给定的输入格式和期望的输出结果')
        this.buildStep(2, '设计算法', '根据问题特点选择合适的算法和数据结构')
        this.buildStep(3, '编写代码', '将算法思路转化为具体的代码实现')
        this.buildStep(4, '测试验证', '使用示例数据验证代码的正确性')
        this.buildStep(5, '优化改进', '分析性能瓶颈，进行必要的优化')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildStep(stepNumber: number, title: string, description: string) {
    Row({ space: 12 }) {
      Text(stepNumber.toString())
        .fontSize(14)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Bold)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor('#1890ff')
        .borderRadius(12)

      Column({ space: 4 }) {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Text(description)
          .fontSize(12)
          .fontColor('#666666')
          .lineHeight(18)
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  buildCodeImplementation() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('代码实现')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      // 语言选择
      Row({ space: 8 }) {
        Text('Java')
          .fontSize(12)
          .fontColor('#1890ff')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#e6f7ff')
          .borderRadius(4)
          .border({ width: 1, color: '#1890ff' })

        Text('Python')
          .fontSize(12)
          .fontColor('#666666')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#f5f5f5')
          .borderRadius(4)
          .border({ width: 1, color: '#d9d9d9' })

        Text('C++')
          .fontSize(12)
          .fontColor('#666666')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#f5f5f5')
          .borderRadius(4)
          .border({ width: 1, color: '#d9d9d9' })
      }
      .alignSelf(ItemAlign.Start)

      // 代码区域
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Row({ space: 8 }) {
          Text('参考代码')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
            .layoutWeight(1)

          Button('复制')
            .fontSize(12)
            .height(28)
            .backgroundColor('#f0f0f0')
            .fontColor('#666666')
            .borderRadius(4)
            .onClick(() => {
              this.copyCode();
            })
        }
        .width('100%')

        Text(this.problem?.solutionCode || this.getDefaultSolutionCode())
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor('#1e1e1e')
          .fontFamily('Monaco, Consolas, monospace')
          .padding(16)
          .borderRadius(8)
          .width('100%')
          .lineHeight(18)
      }

      // 代码解释
      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Text('代码解释')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

        Column({ space: 6 }) {
          this.buildCodeExplanation('第1-3行', '初始化变量和数据结构')
          this.buildCodeExplanation('第4-8行', '主要算法逻辑实现')
          this.buildCodeExplanation('第9-11行', '处理边界情况和返回结果')
        }
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildCodeExplanation(lineRange: string, explanation: string) {
    Row({ space: 8 }) {
      Text(lineRange)
        .fontSize(12)
        .fontColor('#1890ff')
        .fontWeight(FontWeight.Medium)
        .width(60)

      Text(explanation)
        .fontSize(12)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  buildComplexityAnalysis() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('复杂度分析')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Text('时间复杂度')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
          }
          .alignSelf(ItemAlign.Start)

          Text('O(n)')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')
            .alignSelf(ItemAlign.Start)

          Text('需要遍历一次数组')
            .fontSize(12)
            .fontColor('#666666')
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#f6ffed')
        .borderRadius(8)
        .border({ width: 1, color: '#b7eb8f' })
        .alignItems(HorizontalAlign.Start)

        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Text('空间复杂度')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
          }
          .alignSelf(ItemAlign.Start)

          Text('O(1)')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1890ff')
            .alignSelf(ItemAlign.Start)

          Text('只使用常数级额外空间')
            .fontSize(12)
            .fontColor('#666666')
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#e6f7ff')
        .borderRadius(8)
        .border({ width: 1, color: '#91d5ff' })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildRelatedProblems() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text('相关题目')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignSelf(ItemAlign.Start)

      Column({ space: 8 }) {
        if (this.relatedProblems.length > 0) {
          ForEach(this.relatedProblems, (problem: ProblemModel) => {
            this.buildRelatedProblemItem(problem.title, problem.getDifficultyText(), problem.getDifficultyColor())
          }, (problem: ProblemModel) => problem.id.toString())
        } else {
          Text('暂无相关题目')
            .fontSize(14)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(40)
        }
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildRelatedProblemItem(title: string, difficulty: string, color: string) {
    Row({ space: 12 }) {

      Text(title)
        .fontSize(14)
        .fontColor('#333333')
        .layoutWeight(1)

      Text(difficulty)
        .fontSize(12)
        .fontColor(Color.White)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(color)
        .borderRadius(12)
    }
    .width('100%')
    .height(40)
    .padding({ left: 12, right: 12 })
    .backgroundColor('#fafafa')
    .borderRadius(8)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.navigateToRelatedProblem(title);
    })
  }

  private getDefaultSolutionCode(): string {
    return `public class Solution {
    public int[] twoSum(int[] nums, int target) {
        // 使用哈希表存储数值和索引的映射
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            
            // 检查补数是否存在于哈希表中
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            
            // 将当前数值和索引存入哈希表
            map.put(nums[i], i);
        }
        
        // 如果没有找到解，返回空数组
        return new int[0];
    }
}`;
  }

  private copyCode(): void {
    try {
      // 获取要复制的代码内容
      const codeContent = this.userCode || this.getDefaultSolutionCode();
      
      // 创建剪贴板数据
      const pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, codeContent);
      
      // 获取系统剪贴板
      const systemPasteboard = pasteboard.getSystemPasteboard();
      
      // 将数据写入剪贴板
      systemPasteboard.setData(pasteData).then(() => {
        // 显示成功提示
        promptAction.showToast({
          message: '代码已复制到剪贴板',
          duration: 2000
        });
        console.info('Code copied to clipboard successfully');
      }).catch((error: Error) => {
        // 显示错误提示
        promptAction.showToast({
          message: '复制失败，请重试',
          duration: 2000
        });
        console.error('Failed to copy code to clipboard:', error);
      });
    } catch (error) {
      // 显示错误提示
      promptAction.showToast({
        message: '复制失败，请重试',
        duration: 2000
      });
      console.error('Error in copyCode:', error);
    }
  }

  private navigateToRelatedProblem(title: string): void {
    try {
      // 获取所有题目
      const allProblems = ProblemMockData.getAllProblems();
      
      // 根据标题查找题目
      const targetProblem = allProblems.find(problem => problem.title === title);
      
      if (targetProblem) {
        // 检查是否是当前题目
        if (targetProblem.id === this.problemId) {
          AlertDialog.show({
            title: '提示',
            message: '这就是当前题目',
            confirm: {
              value: '确定',
              action: () => {
                console.info('Already viewing this problem');
              }
            }
          });
          return;
        }
        
        // 导航到相关题目
        router.pushUrl({
          url: 'pages/ProblemDetailPage',
          params: {
            problemId: targetProblem.id
          }
        }).then(() => {
          console.info('Successfully navigated to related problem:', title, 'ID:', targetProblem.id);
        }).catch((error: Error) => {
          console.error('Failed to navigate to related problem:', error);
          AlertDialog.show({
            title: '错误',
            message: '导航失败，请重试',
            confirm: {
              value: '确定',
              action: () => {}
            }
          });
        });
      } else {
        // 题目不存在，显示提示
        AlertDialog.show({
          title: '提示',
          message: `题目"${title}"暂未收录`,
          confirm: {
            value: '确定',
            action: () => {
              console.info('Related problem not found:', title);
            }
          }
        });
      }
    } catch (error) {
      console.error('Error in navigateToRelatedProblem:', error);
      AlertDialog.show({
        title: '错误',
        message: '操作失败，请重试',
        confirm: {
          value: '确定',
          action: () => {}
        }
      });
    }
  }



  @Builder
  buildBottomActions() {
    Row({ space: 12 }) {
      Button('上一题')
        .layoutWeight(1)
        .height(44)
        .backgroundColor('#ffffff')
        .fontColor('#666666')
        .border({ width: 1, color: '#d9d9d9' })
        .borderRadius(8)
        .onClick(() => {
          this.navigateToPrevious();
        })

      Button('下一题')
        .layoutWeight(1)
        .height(44)
        .backgroundColor('#F34F40')
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          this.navigateToNext();
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .border({ width: { top: 1 }, color: '#f0f0f0' })
  }

  private async loadProblemDetail(problemId: number): Promise<void> {
    try {
      this.isLoading = true;
      this.problemId = problemId;
      
      if (this.problemId > 0) {
        // 优先从mockData加载题目详情
        this.problem = ProblemMockData.getProblemById(this.problemId);
        
        // 如果mockData中没有，则从数据库加载
        if (!this.problem) {
          this.problem = ProblemMockData.getProblemById(this.problemId);
        }
        
        if (this.problem) {
          // 加载用户进度
          this.userProgress = await this.userProgressDao.getUserProgress(this.problemId);
          
          // 如果没有进度记录，创建一个新的
          if (!this.userProgress) {
            this.userProgress = new UserProgressModel();
            this.userProgress.problemId = this.problemId;
          }
          
          // 更新收藏状态
          this.isFavorite = this.userProgress.isFavorite;
          
          // 更新是否练过状态（如果状态不是未尝试，则认为已练过）
          this.isPracticed = this.userProgress.status !== ProblemStatus.NOT_ATTEMPTED;
          
          // 加载用户笔记
          try {
            const userNote = await this.userNoteDao.getNoteByProblemId(this.problemId);
            this.noteContent = userNote ? userNote.content : '';
          } catch (error) {
            console.error('Failed to load user note:', error);
            this.noteContent = '';
          }
          
          // 加载相关题目
          this.loadRelatedProblems();
          
          console.info('Problem loaded successfully:', this.problem.title);
        } else {
          console.error('Problem not found with id:', this.problemId);
        }
      }
    } catch (error) {
      console.error('Failed to load problem detail:', error);
    } finally {
      this.isLoading = false;
    }
  }

  private async saveNote(): Promise<void> {
    try {
      // 创建或更新笔记
      const userNote = new UserNoteModel();
      userNote.problemId = this.problemId;
      userNote.updateContent(this.noteContent);
      
      // 保存到数据库
      await this.userNoteDao.saveNote(userNote);
      
      this.isEditingNote = false;
      
      // 显示保存成功提示
      promptAction.showToast({
        message: '笔记保存成功',
        duration: 2000
      });
      
      console.info('Note saved successfully for problem:', this.problemId);
    } catch (error) {
      console.error('Failed to save note:', error);
      promptAction.showToast({
        message: '保存失败，请重试',
        duration: 2000
      });
    }
  }

  private selectOption(optionId: string, isSelected: boolean): void {
    if (!this.problem) return;

    if (this.problem.type === ProblemType.MULTIPLE_CHOICE) {
      // 多选题：切换选择状态
      if (isSelected) {
        if (!this.userAnswer.includes(optionId)) {
          this.userAnswer.push(optionId);
        }
      } else {
        const index = this.userAnswer.indexOf(optionId);
        if (index > -1) {
          this.userAnswer.splice(index, 1);
        }
      }
    } else {
      // 单选题：替换答案
      if (isSelected) {
        this.userAnswer = [optionId];
      } else {
        this.userAnswer = [];
      }
    }
  }

  private async submitAnswer(): Promise<void> {
    try {
      if (!this.problem || this.problemId <= 0) {
        return;
      }

      // 检查答案是否正确
      const isCorrect = this.problem.checkAnswer(this.userAnswer);
      this.isCorrect = isCorrect;
      
      // 更新用户进度
      const status = isCorrect ? ProblemStatus.COMPLETED : ProblemStatus.WRONG;
      await this.userProgressDao.updateProblemStatus(this.problemId, status, isCorrect);
      
      // 重新加载用户进度
      this.userProgress = await this.userProgressDao.getUserProgress(this.problemId);
      
      this.isSubmitted = true;
      
      // 显示答题结果对话框
      this.showResultDialog = true;
      
      console.info('Answer submitted:', this.userAnswer, 'Correct:', isCorrect);
    } catch (error) {
      console.error('Failed to submit answer:', error);
    }
  }

  private async toggleFavorite(): Promise<void> {
    try {
      if (this.problemId > 0) {
        // 先更新界面状态，提供即时反馈
        this.isFavorite = !this.isFavorite;
        
        // 然后更新数据库
        const newFavoriteStatus = await this.userProgressDao.toggleFavorite(this.problemId);
        
        // 确保界面状态与数据库状态一致
        this.isFavorite = newFavoriteStatus;
        
        // 重新加载用户进度以确保界面状态同步
        this.userProgress = await this.userProgressDao.getUserProgress(this.problemId);
        
        console.info('Favorite status toggled:', this.isFavorite);
      }
    } catch (error) {
      console.error('Failed to toggle favorite:', error);
      // 如果出错，回滚界面状态
      this.isFavorite = !this.isFavorite;
    }
  }

  private shareProblem(): void {
    try {
      if (this.problem) {
        const shareText = `分享题目：${this.problem.title}\n难度：${this.problem.difficulty}\n分类：${this.problem.category}`;
        console.info('Share problem:', shareText);
        // 这里可以调用系统分享API，目前先显示分享内容
        AlertDialog.show({
          title: '分享题目',
          message: shareText,
          confirm: {
            value: '确定',
            action: () => {
              console.info('Share confirmed');
            }
          }
        });
      }
    } catch (error) {
      console.error('Failed to share problem:', error);
    }
  }

  private navigateToPrevious(): void {
    try {
      if (this.problemId <= 1) {
        // 已经是第一题，显示提示
        AlertDialog.show({
          title: '提示',
          message: '已经是第一题了',
          confirm: {
            value: '确定',
            action: () => {
              console.info('Already at first problem');
            }
          }
        });
        return;
      }

      const previousProblemId = this.problemId - 1;
      const previousProblem = ProblemMockData.getProblemById(previousProblemId);
      
      if (previousProblem) {
        // 导航到上一题
        router.replaceUrl({
          url: 'pages/ProblemDetailPage',
          params: {
            problemId: previousProblemId
          }
        }).then(() => {
          console.info('Successfully navigated to previous problem:', previousProblemId);
        }).catch((error: Error) => {
          console.error('Failed to navigate to previous problem:', error);
          AlertDialog.show({
            title: '错误',
            message: '导航失败，请重试',
            confirm: {
              value: '确定',
              action: () => {}
            }
          });
        });
      } else {
        // 上一题不存在
        AlertDialog.show({
          title: '提示',
          message: '上一题不存在',
          confirm: {
            value: '确定',
            action: () => {}
          }
        });
      }
    } catch (error) {
      console.error('Error in navigateToPrevious:', error);
      AlertDialog.show({
        title: '错误',
        message: '操作失败，请重试',
        confirm: {
          value: '确定',
          action: () => {}
        }
      });
    }
  }

  private navigateToNext(): void {
    try {
      const nextProblemId = this.problemId + 1;
      const nextProblem = ProblemMockData.getProblemById(nextProblemId);
      
      if (nextProblem) {
        // 导航到下一题
        router.replaceUrl({
          url: 'pages/ProblemDetailPage',
          params: {
            problemId: nextProblemId
          }
        }).then(() => {
          console.info('Successfully navigated to next problem:', nextProblemId);
        }).catch((error: Error) => {
          console.error('Failed to navigate to next problem:', error);
          AlertDialog.show({
            title: '错误',
            message: '导航失败，请重试',
            confirm: {
              value: '确定',
              action: () => {}
            }
          });
        });
      } else {
        // 已经是最后一题，显示提示
        AlertDialog.show({
          title: '提示',
          message: '已经是最后一题了',
          confirm: {
            value: '确定',
            action: () => {
              console.info('Already at last problem');
            }
          }
        });
      }
    } catch (error) {
      console.error('Error in navigateToNext:', error);
      AlertDialog.show({
        title: '错误',
        message: '操作失败，请重试',
        confirm: {
          value: '确定',
          action: () => {}
        }
      });
    }
  }

  /**
   * 加载相关题目：从相同类型的题目中随机抽取3个
   */
  private loadRelatedProblems(): void {
    if (!this.problem) return;

    try {
      // 获取相同类型的所有题目
      const sameCategoryProblems = ProblemMockData.getProblemsByCategory(this.problem.category);
      
      // 过滤掉当前题目
      const filteredProblems = sameCategoryProblems.filter(p => p.id !== this.problem!.id);
      
      // 随机抽取3个题目
      this.relatedProblems = this.getRandomProblems(filteredProblems, 3);
      
      console.info('Loaded related problems:', this.relatedProblems.length);
    } catch (error) {
      console.error('Failed to load related problems:', error);
      this.relatedProblems = [];
    }
  }

  /**
   * 从题目数组中随机抽取指定数量的题目
   */
  private getRandomProblems(problems: ProblemModel[], count: number): ProblemModel[] {
    if (problems.length <= count) {
      return problems;
    }

    const result: ProblemModel[] = [];
    const usedIndices: Set<number> = new Set();

    while (result.length < count && usedIndices.size < problems.length) {
      const randomIndex = Math.floor(Math.random() * problems.length);
      if (!usedIndices.has(randomIndex)) {
        usedIndices.add(randomIndex);
        result.push(problems[randomIndex]);
      }
    }

    return result;
  }
}