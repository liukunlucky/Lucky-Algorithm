import router from '@ohos.router';
import { ExamRecordModel, ExamProblemResult } from '../model/ExamRecordModel';
import { ProblemModel, ChoiceOption } from '../model/ProblemModel';

interface ExamReportParams {
  examRecord: ExamRecordModel;
}

@Entry
@Component
struct ExamReportPage {
  @State examRecord: ExamRecordModel | null = null;
  @State showProblemDetail: boolean = false;
  @State selectedProblem: ExamProblemResult | null = null;

  aboutToAppear() {
    const params = router.getParams() as ExamReportParams;
    if (params && params.examRecord) {
      this.examRecord = params.examRecord;
      console.info(`ExamReportPage: Loaded examRecord with score=${this.examRecord.score}, accuracy=${this.examRecord.getAccuracyRate()}%`);
    }
  }

  build() {
    Stack() {
      if (!this.examRecord) {
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
        // 顶部导航栏
        this.buildHeader()

        Scroll() {
          Column({ space: 16 }) {
            // 成绩概览卡片
            this.buildScoreOverview()

            // 详细统计卡片
            this.buildDetailedStats()

            // 题目结果列表
            this.buildProblemResults()

            // 操作按钮
            this.buildActions()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')

      // 题目详情对话框
      if (this.showProblemDetail && this.selectedProblem) {
        this.buildProblemDetailDialog()
      }
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildHeader() {
    Row() {
      Button() {
        Image($r('app.media.arrow_left_icon'))
          .width(20)
          .height(20)
          .fillColor('#1890ff')
      }
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Blank()

      Text('考核报告')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Blank()

      Button('分享')
        .fontSize(16)
        .fontColor('#1890ff')
        .backgroundColor('transparent')
        .onClick(() => {
          this.shareReport();
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
  }

  @Builder
  buildScoreOverview() {
    Column({ space: 16 }) {
      // 成绩展示
      Column({ space: 8 }) {
        Text(this.examRecord!.score.toString())
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getScoreColor())

        Text('分')
          .fontSize(18)
          .fontColor('#666666')

        Text(this.examRecord!.getGradeText())
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.getScoreColor())
          .backgroundColor(this.getScoreColor() + '20')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(16)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // 模式信息
      Row({ space: 8 }) {
        Image(this.getModeIcon())
          .width(20)
          .height(20)
          .fillColor('#333333')

        Text(this.examRecord!.getModeText())
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Blank()

        Text(this.formatDate())
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildDetailedStats() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Image($r('app.media.chart_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('详细统计')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      Row({ space: 12 }) {
        // 正确率
        this.buildStatCard('正确率', this.examRecord!.getAccuracyRate() + '%', '#52c41a')

        // 用时
        this.buildStatCard('用时', this.examRecord!.getDurationText(), '#1890ff')

        // 题目数
        this.buildStatCard('题目数', this.examRecord!.problemResults.length.toString(), '#fa8c16')
      }
      .width('100%')

      // 答题情况分布
      Row({ space: 8 }) {
        Text('答题情况:')
          .fontSize(14)
          .fontColor('#666666')

        Text(`正确 ${this.getCorrectCount()}`)
          .fontSize(14)
          .fontColor('#52c41a')

        Text(`错误 ${this.getWrongCount()}`)
          .fontSize(14)
          .fontColor('#f5222d')

        Text(`未答 ${this.getUnansweredCount()}`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildStatCard(title: string, value: string, color: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(color + '10')
    .borderRadius(8)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildProblemResults() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Image($r('app.media.note_icon'))
            .width(16)
            .height(16)
            .fillColor('#333333')
          Text('题目详情')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      List({ space: 8 }) {
        ForEach(this.examRecord!.problemResults, (problem: ExamProblemResult, index: number) => {
          ListItem() {
            this.buildProblemResultCard(problem, index)
          }
        }, (problem: ExamProblemResult) => problem.problemId.toString())
      }
      .width('100%')
      .height(300)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildProblemResultCard(problem: ExamProblemResult, index: number) {
    Row({ space: 12 }) {
      // 题目序号和状态
      Column({ space: 4 }) {
        Text((index + 1).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Text(this.getProblemStatusIcon(problem))
          .fontSize(16)
      }
      .width(40)
      .alignItems(HorizontalAlign.Center)

      // 题目信息
      Column({ space: 4 }) {
        Text(problem.problemTitle)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .alignSelf(ItemAlign.Start)

        Row({ space: 8 }) {
          Text(this.getProblemStatusText(problem))
            .fontSize(12)
            .fontColor(this.getProblemStatusColor(problem))

          Text(`用时: ${this.formatTime(problem.timeSpent)}`)
            .fontSize(12)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 查看按钮
      Button('查看')
        .fontSize(12)
        .fontColor('#1890ff')
        .backgroundColor('#1890ff20')
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .onClick(() => {
          this.selectedProblem = problem;
          this.showProblemDetail = true;
        })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#f8f9fa')
    .borderRadius(8)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildActions() {
    Column({ space: 12 }) {
      Button('再来一次')
        .width('100%')
        .height(44)
        .backgroundColor('#1890ff')
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          this.retakeExam();
        })

      Button('返回首页')
        .width('100%')
        .height(44)
        .backgroundColor('#f5f5f5')
        .fontColor('#666666')
        .borderRadius(8)
        .onClick(() => {
          router.clear();
          router.pushUrl({ url: 'pages/Index' });
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildProblemDetailDialog() {
    if (this.selectedProblem) {
      Column() {
      // 遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#00000080')
        .onClick(() => {
          this.showProblemDetail = false;
          this.selectedProblem = null;
        })

      // 对话框内容
      Column({ space: 16 }) {
        // 标题
        Row() {
          Text('题目详情')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          Button('✕')
            .fontSize(16)
            .fontColor('#666666')
            .backgroundColor('transparent')
            .onClick(() => {
              this.showProblemDetail = false;
              this.selectedProblem = null;
            })
        }
        .width('100%')

        // 题目信息
        Column({ space: 8 }) {
          Text(this.selectedProblem.problemTitle)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Row({ space: 8 }) {
            Text(this.getProblemStatusText(this.selectedProblem))
              .fontSize(12)
              .fontColor('#ffffff')
              .backgroundColor(this.getProblemStatusColor(this.selectedProblem))
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)

            Text(`用时: ${this.formatTime(this.selectedProblem.timeSpent)}`)
              .fontSize(12)
              .fontColor('#666666')
          }
          .justifyContent(FlexAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)

        // 答案对比
        Column({ space: 12 }) {
          Row({ space: 8 }) {
            Image($r('app.media.note_icon'))
              .width(14)
              .height(14)
              .fillColor('#333333')
            Text('答案对比')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
          }
          .alignSelf(ItemAlign.Start)

          // 用户答案
          Column({ space: 6 }) {
            Text('你的答案:')
              .fontSize(12)
              .fontColor('#666666')
              .alignSelf(ItemAlign.Start)

            Text(this.formatUserAnswer(this.selectedProblem))
              .fontSize(14)
              .fontColor(this.selectedProblem.isCorrect ? '#52c41a' : '#f5222d')
              .backgroundColor('#f8f9fa')
              .padding(8)
              .borderRadius(6)
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)

          // 正确答案
          Column({ space: 6 }) {
            Text('正确答案:')
              .fontSize(12)
              .fontColor('#666666')
              .alignSelf(ItemAlign.Start)

            Text(this.formatCorrectAnswer(this.selectedProblem))
              .fontSize(14)
              .fontColor('#52c41a')
              .backgroundColor('#f6ffed')
              .padding(8)
              .borderRadius(6)
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)

        // 操作按钮
        Row({ space: 12 }) {
          Button('重新练习')
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#1890ff')
            .fontColor('#ffffff')
            .borderRadius(6)
            .onClick(() => {
              this.practiceAgain();
            })

          Button('查看解析')
            .layoutWeight(1)
            .height(40)
            .backgroundColor('#52c41a')
            .fontColor('#ffffff')
            .borderRadius(6)
            .onClick(() => {
              this.viewSolution();
            })
        }
        .width('100%')
      }
      .width('90%')
      .width('90%')
      .height('80%')
      .padding(20)
      .backgroundColor('#ffffff')
      .borderRadius(12)
      .shadow({ radius: 20, color: '#00000020', offsetX: 0, offsetY: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    }
  }

  private getScoreColor(): string {
    const score = this.examRecord!.score;
    if (score >= 90) return '#52c41a';
    if (score >= 80) return '#1890ff';
    if (score >= 60) return '#fa8c16';
    return '#f5222d';
  }

  private getModeIcon(): Resource {
    switch (this.examRecord!.mode) {
      case 'quick': return $r('app.media.star_icon');
      case 'standard': return $r('app.media.note_icon');
      case 'hard': return $r('app.media.star_icon');
      default: return $r('app.media.note_icon');
    }
  }

  private formatDate(): string {
    const date = new Date(this.examRecord!.date);
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return `${month}月${day}日 ${hours}:${minutes}`;
  }

  private getCorrectCount(): number {
    return this.examRecord!.problemResults.filter(p => p.isCorrect).length;
  }

  private getWrongCount(): number {
    return this.examRecord!.problemResults.filter(p => !p.isCorrect && this.hasAnswer(p)).length;
  }

  private getUnansweredCount(): number {
    return this.examRecord!.problemResults.filter(p => !this.hasAnswer(p)).length;
  }

  private hasAnswer(problem: ExamProblemResult): boolean {
    // 检查是否有答案（支持选择题和代码题）
    if (problem.userAnswer && problem.userAnswer.length > 0) {
      return true; // 选择题有选择
    }
    if (problem.userCode && problem.userCode.trim().length > 0) {
      return true; // 代码题有代码
    }
    return false;
  }

  private getProblemStatusIcon(problem: ExamProblemResult): string {
    if (!this.hasAnswer(problem)) return '⭕';
    return problem.isCorrect ? '✅' : '❌';
  }

  private getProblemStatusText(problem: ExamProblemResult): string {
    if (!this.hasAnswer(problem)) return '未答';
    return problem.isCorrect ? '正确' : '错误';
  }

  private getProblemStatusColor(problem: ExamProblemResult): string {
    if (!this.hasAnswer(problem)) return '#999999';
    return problem.isCorrect ? '#52c41a' : '#f5222d';
  }

  private formatTime(seconds: number): string {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}分${secs}秒`;
  }

  private formatUserAnswer(problem: ExamProblemResult): string {
    if (problem.userAnswer && problem.userAnswer.length > 0) {
      return problem.userAnswer.join(', ');
    }
    if (problem.userCode && problem.userCode.trim().length > 0) {
      return problem.userCode;
    }
    return '未作答';
  }

  private formatCorrectAnswer(problem: ExamProblemResult): string {
    if (problem.correctAnswer && problem.correctAnswer.length > 0) {
      return problem.correctAnswer.join(', ');
    }
    return '暂无正确答案';
  }

  private shareReport(): void {
    // TODO: 实现分享功能
    console.info('Share report');
  }

  private retakeExam(): void {
    // 返回考核页面，重新开始相同模式的考核
    router.back();
  }

  private practiceAgain(): void {
    if (!this.selectedProblem) return;
    
    // TODO: 跳转到题目详情页面重新练习
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: { problemId: this.selectedProblem.problemId }
    });
  }

  private viewSolution(): void {
    if (!this.selectedProblem) return;
    
    // TODO: 显示题目解析
    console.info('View solution for problem:', this.selectedProblem.problemId);
  }
}