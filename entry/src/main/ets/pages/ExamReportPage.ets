import router from '@ohos.router';
import { ExamRecordModel, ExamProblemResult, ExamMode } from '../model/ExamRecordModel';
import { ProblemModel, ChoiceOption } from '../model/ProblemModel';

interface ExamReportParams {
  examRecord: ExamRecordModel;
}

interface ExamRecordData {
  id: number;
  date: string;
  mode: ExamMode;
  score: number;
  duration: number;
  problemResults: ExamProblemResult[];
  totalProblems: number;
  correctCount: number;
  timeUsed: number;
  startTime: string;
  endTime: string;
}

@Entry
@Component
struct ExamReportPage {
  @State examRecord: ExamRecordModel | null = null;

  aboutToAppear() {
    try {
      const params = router.getParams() as Record<string, object>;
      console.log('lucky exam report params = ' + JSON.stringify(params));

      if (params && params.examRecord) {
        // 将JSON对象转换为ExamRecordModel实例
        const recordData = params.examRecord as ExamRecordData;
        const examRecord = new ExamRecordModel();

        // 安全地复制所有属性
        examRecord.id = recordData.id || 0;
        examRecord.date = recordData.date || '';
        examRecord.mode = recordData.mode || ExamMode.QUICK;
        examRecord.score = recordData.score || 0;
        examRecord.duration = recordData.duration || 0;
        examRecord.problemResults = recordData.problemResults || [];
        examRecord.totalProblems = recordData.totalProblems || 0;
        examRecord.correctCount = recordData.correctCount || 0;
        examRecord.timeUsed = recordData.timeUsed || 0;

        // 安全地处理日期转换
        if (recordData.startTime) {
          try {
            examRecord.startTime = new Date(recordData.startTime);
          } catch (e) {
            examRecord.startTime = new Date();
          }
        } else {
          examRecord.startTime = new Date();
        }

        if (recordData.endTime) {
          try {
            examRecord.endTime = new Date(recordData.endTime);
          } catch (e) {
            examRecord.endTime = new Date();
          }
        } else {
          examRecord.endTime = new Date();
        }

        this.examRecord = examRecord;
        console.info(`ExamReportPage: Loaded examRecord with score=${this.examRecord.score}, accuracy=${this.examRecord.getAccuracyRate()}%`);
      } else {
        console.error('ExamReportPage: No examRecord found in params');
      }
    } catch (error) {
      console.error('ExamReportPage: Error loading examRecord:', error);
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
            .padding({
              left: 16,
              right: 16,
              top: 16,
              bottom: 16
            })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#f5f5f5')

        // 题目详情对话框已移除，点击直接跳转到题目详情页面
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildHeader() {
    Row() {
      Button() {
        Image($r('app.media.icon_back'))
          .width(24)
          .height(24)
      }
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Text('考核报告')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)


      Blank().width(20)
    }
    .width('100%')
    .padding({
      left: 16,
      right: 16,
      top: 12,
      bottom: 12
    })
    .backgroundColor('#ffffff')
    .shadow({
      radius: 2,
      color: '#00000010',
      offsetX: 0,
      offsetY: 1
    })
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
          .padding({
            left: 12,
            right: 12,
            top: 6,
            bottom: 6
          })
          .borderRadius(16)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // 模式信息
      Row({ space: 8 }) {
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
    .shadow({
      radius: 4,
      color: '#00000010',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  buildDetailedStats() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
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
    .shadow({
      radius: 4,
      color: '#00000010',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  buildStatCard(title: string, value: string, color: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(title)
        .fontSize(12)
        .fontColor('#666666')
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor('#f8f9fa') // 统一使用浅灰色背景
    .borderRadius(8)
    .border({ width: 1, color: color + '60' }) // 加深边框颜色，提高可见度
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildProblemResults() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
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
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.PARENT_FIRST
      }) // 优化嵌套滚动
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: '#00000010',
      offsetX: 0,
      offsetY: 2
    })
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

      // 右箭头图标
      Text('>')
        .fontSize(16)
        .fontColor('#cccccc')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#fafbfc')
    .borderRadius(8)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      console.info('点击题目卡片，跳转到题目详情页面:', problem.problemId);
      this.navigateToProblemDetail(problem.problemId);
    })
  }

  @Builder
  buildActions() {
    Column({ space: 12 }) {
      Button('再来一次')
        .width('100%')
        .height(44)
        .backgroundColor('#F34F40')
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          this.retakeExam();
        })

      Button('返回首页')
        .width('100%')
        .height(44)
        .backgroundColor('#fafafa')
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
    .shadow({
      radius: 4,
      color: '#00000010',
      offsetX: 0,
      offsetY: 2
    })
  }

  /**
   * 跳转到题目详情页面
   */
  private navigateToProblemDetail(problemId: number): void {
    router.pushUrl({
      url: 'pages/ProblemDetailPage',
      params: { problemId: problemId }
    }).catch((error: Error) => {
      console.error('Failed to navigate to problem detail:', error);
    });
  }

  private getScoreColor(): string {
    const score = this.examRecord!.score;
    if (score >= 90) {
      return '#52c41a';
    }
    if (score >= 80) {
      return '#1890ff';
    }
    if (score >= 60) {
      return '#fa8c16';
    }
    return '#ff7875'; // 不及格颜色调整为更柔和的红色
  }

  private getModeIcon(): Resource {
    switch (this.examRecord!.mode) {
      case 'quick':
        return $r('app.media.star_icon');
      case 'standard':
        return $r('app.media.note_icon');
      case 'hard':
        return $r('app.media.star_icon');
      default:
        return $r('app.media.note_icon');
    }
  }

  private formatDate(): string {
    const date = new Date(this.examRecord!.date);
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const seconds = date.getSeconds().toString().padStart(2, '0');
    return `${month}月${day}日 ${hours}:${minutes}:${seconds}`;
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
    if (!this.hasAnswer(problem)) {
      return '⭕';
    }
    return problem.isCorrect ? '✅' : '❌';
  }

  private getProblemStatusText(problem: ExamProblemResult): string {
    if (!this.hasAnswer(problem)) {
      return '未答';
    }
    return problem.isCorrect ? '正确' : '错误';
  }

  private getProblemStatusColor(problem: ExamProblemResult): string {
    if (!this.hasAnswer(problem)) {
      return '#999999';
    }
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

}