import router from '@ohos.router';
import { CompanyProblemModel, ProgrammingLanguage, CodeSolution } from '../model/CompanyProblemModel';
import { CompanyProblemMockData } from '../mock/CompanyProblemMockData';
import { promptAction } from '@kit.ArkUI';
import { pasteboard } from '@kit.BasicServicesKit';

@Entry
@Component
struct CompanyProblemDetailPage {
  @State private problem: CompanyProblemModel | null = null;
  @State private selectedLanguage: ProgrammingLanguage = ProgrammingLanguage.JAVA;
  @State private currentSolution: CodeSolution | null = null;
  @State private showHints: boolean = false;
  @State private isLoading: boolean = true;
  private problemId: number = 0;

  aboutToAppear() {
    const params = router.getParams() as Record<string, object>;
    console.log('lucky CompanyProblemDetailPage params = ' + JSON.stringify(params));
    if (params && params.problemId && typeof params.problemId === 'number') {
      this.problemId = params.problemId;
      this.loadProblem();
    }
  }

  private loadProblem() {
    this.isLoading = true;
    // 模拟异步加载
    setTimeout(() => {
      const problems = CompanyProblemMockData.getProblems();
      this.problem = problems.find(p => p.id === this.problemId) || null;
      if (this.problem && this.problem.solutions.length > 0) {
        this.selectedLanguage = this.problem.solutions[0].language;
        this.updateCurrentSolution();
      }
      this.isLoading = false;
    }, 300);
  }

  private updateCurrentSolution() {
    if (this.problem) {
      this.currentSolution = this.problem.getSolutionByLanguage(this.selectedLanguage);
    }
  }

  private copyCode(): void {
    try {
      // 获取要复制的代码内容
      if (!this.currentSolution || !this.currentSolution.code) {
        promptAction.showToast({
          message: '暂无代码可复制',
          duration: 2000
        });
        return;
      }

      const codeContent = this.currentSolution.code;
      
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

  build() {
    Column() {
      // 标题栏
      this.buildHeader()

      if (this.isLoading) {
        this.buildLoadingState()
      } else if (this.problem) {
        // 内容区域
        Scroll() {
          Column({ space: 16 }) {
            // 题目信息
            this.buildProblemInfo()

            // 题目描述
            this.buildProblemDescription()

            // 语言选择
            this.buildLanguageSelector()

            // 代码解答
            this.buildCodeSolution()

            // 提示
            this.buildHintsSection()
          }
          .width('100%')
          .padding(16)
        }
        .layoutWeight(1)
        .backgroundColor('#F8F9FA')
      } else {
        this.buildErrorState()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
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
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        router.back();
      })

      Text(this.problem ? this.problem.title : '题目详情')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 占位，保持标题居中
      Row().width(40).height(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      Text('加载中...')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildErrorState() {
    Column({ space: 16 }) {
      Image($r('app.media.icon_error'))
        .width(80)
        .height(80)
        .fillColor('#CCCCCC')

      Text('题目不存在')
        .fontSize(16)
        .fontColor('#666666')

      Button('返回')
        .type(ButtonType.Normal)
        .backgroundColor('#F34F40')
        .fontColor('#FFFFFF')
        .onClick(() => {
          router.back();
        })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildProblemInfo() {
    if (this.problem) {
      Column({ space: 12 }) {
      // 标题
      Text(this.problem.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')

      // 基本信息
      Row({ space: 12 }) {
        Text(this.problem.getDifficultyText())
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor(this.problem.getDifficultyColor())
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)

        Text(this.problem.getCompanyName())
          .fontSize(12)
          .fontColor('#666666')
          .backgroundColor('#F5F5F5')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)

        Text(this.problem.year + '年')
          .fontSize(12)
          .fontColor('#666666')
          .backgroundColor('#F5F5F5')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)

        Blank()

        Text(this.problem.getFrequencyStars())
          .fontSize(14)
          .fontColor('#FA8C16')
      }
      .width('100%')

      // 岗位和标签
      Row() {
        Text('岗位: ' + this.problem.position)
          .fontSize(14)
          .fontColor('#666666')
          .layoutWeight(1)
      }
      .width('100%')

      // 标签
      if (this.problem.tags.length > 0) {
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Start }) {
          ForEach(this.problem.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontColor('#F34F40')
              .backgroundColor('#FFF2F0')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(6)
              .margin({ right: 8, bottom: 8 })
          }, (tag: string) => tag)
        }
        .width('100%')
      }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
  }

  @Builder
  buildProblemDescription() {
    if (this.problem) {
      Column({ space: 12 }) {
      Text('题目描述')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .width('100%')

      Text(this.problem.description)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20)
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  buildLanguageSelector() {
    if (this.problem && this.problem.solutions.length > 0) {
      Column({ space: 12 }) {
      Text('代码解答')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .width('100%')

      Row({ space: 8 }) {
        ForEach(this.problem.solutions, (solution: CodeSolution) => {
          this.buildLanguageTab(solution.language)
        }, (solution: CodeSolution) => solution.language)
      }
      .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  buildLanguageTab(language: ProgrammingLanguage) {
    Button(this.getLanguageName(language))
      .type(ButtonType.Normal)
      .backgroundColor(this.selectedLanguage === language ? '#F34F40' : '#F2F2F7')
      .fontColor(this.selectedLanguage === language ? '#FFFFFF' : '#3C3C43')
      .fontSize(14)
      .fontWeight(this.selectedLanguage === language ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(8)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .onClick(() => {
        this.selectedLanguage = language;
        this.updateCurrentSolution();
      })
  }

  @Builder
  buildCodeSolution() {
    if (this.currentSolution) {
      Column({ space: 16 }) {
      // 代码
      Column({ space: 8 }) {
        Row() {
          Text('代码实现')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Blank()

          Button('复制')
            .type(ButtonType.Normal)
            .backgroundColor('#F5F5F5')
            .fontColor('#666666')
            .fontSize(12)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .borderRadius(6)
            .onClick(() => {
              this.copyCode();
              console.info('复制代码');
            })
        }
        .width('100%')

        Text(this.currentSolution.code)
          .fontSize(12)
          .fontColor('#333333')
          .backgroundColor('#F8F8F8')
          .padding(12)
          .borderRadius(8)
          .width('100%')
          .fontFamily('monospace')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 解题思路
      Column({ space: 8 }) {
        Text('解题思路')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .width('100%')

        Text(this.currentSolution.explanation)
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(20)
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 复杂度分析
      Column({ space: 8 }) {
        Text('复杂度分析')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .width('100%')

        Row() {
          Text('时间复杂度: ')
            .fontSize(14)
            .fontColor('#666666')

          Text(this.currentSolution.timeComplexity)
            .fontSize(14)
            .fontColor('#F34F40')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')

        Row() {
          Text('空间复杂度: ')
            .fontSize(14)
            .fontColor('#666666')

          Text(this.currentSolution.spaceComplexity)
            .fontSize(14)
            .fontColor('#F34F40')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Start)
    }
  }

  @Builder
  buildHintsSection() {
    if (this.problem && this.problem.hints.length > 0) {
      Column({ space: 12 }) {
      Row() {
        Text('解题提示')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Blank()

        Button(this.showHints ? '隐藏提示' : '显示提示')
          .type(ButtonType.Normal)
          .backgroundColor('#F5F5F5')
          .fontColor('#F34F40')
          .fontSize(12)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(6)
          .onClick(() => {
            this.showHints = !this.showHints;
          })
      }
      .width('100%')

      if (this.showHints) {
        Column({ space: 8 }) {
          ForEach(this.problem.hints, (hint: string, index: number) => {
            Row({ space: 8 }) {
              Text((index + 1) + '.')
                .fontSize(14)
                .fontColor('#F34F40')
                .fontWeight(FontWeight.Medium)

              Text(hint)
                .fontSize(14)
                .fontColor('#666666')
                .lineHeight(20)
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }, (hint: string, index: number) => index.toString())
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .alignItems(HorizontalAlign.Start)
    }
  }

  private getLanguageName(language: ProgrammingLanguage): string {
    switch (language) {
      case ProgrammingLanguage.JAVA: return 'Java';
      case ProgrammingLanguage.PYTHON: return 'Python';
      case ProgrammingLanguage.CPP: return 'C++';
      default: return language;
    }
  }
}