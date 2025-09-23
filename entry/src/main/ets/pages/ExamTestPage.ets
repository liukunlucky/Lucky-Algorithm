import { ProblemModel, ChoiceOption } from '../model/ProblemModel';
import { ExamService } from '../service/ExamService';
import { ExamMode } from '../model/ExamRecordModel';

@Entry
@Component
struct ExamTestPage {
  @State problems: ProblemModel[] = [];
  @State currentIndex: number = 0;
  @State isLoading: boolean = true;

  async aboutToAppear() {
    console.info('ExamTestPage: Loading problems for testing...');
    try {
      const examService = ExamService.getInstance();
      this.problems = await examService.selectProblemsForExam(ExamMode.QUICK);
      console.info(`ExamTestPage: Loaded ${this.problems.length} problems`);
      
      // 打印前3个题目的选项信息
      this.problems.slice(0, 3).forEach((problem, index) => {
        console.info(`ExamTestPage: Problem ${index + 1} - ${problem.title}`);
        console.info(`ExamTestPage: Problem ${index + 1} has ${problem.choices?.length || 0} choices:`);
        problem.choices?.forEach((choice, choiceIndex) => {
          console.info(`  ${choice.id}: ${choice.text} (correct: ${choice.isCorrect})`);
        });
      });
      
      this.isLoading = false;
    } catch (error) {
      console.error('ExamTestPage: Failed to load problems:', error);
      this.isLoading = false;
    }
  }

  build() {
    Column({ space: 16 }) {
      // 标题
      Text('考核功能测试')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ top: 20 })

      if (this.isLoading) {
        Text('加载中...')
          .fontSize(16)
          .fontColor('#666666')
      } else if (this.problems.length === 0) {
        Text('没有找到题目')
          .fontSize(16)
          .fontColor('#666666')
      } else {
        // 题目导航
        Row({ space: 8 }) {
          Button('上一题')
            .enabled(this.currentIndex > 0)
            .onClick(() => {
              if (this.currentIndex > 0) {
                this.currentIndex--;
              }
            })

          Text(`${this.currentIndex + 1} / ${this.problems.length}`)
            .fontSize(16)
            .fontColor('#333333')

          Button('下一题')
            .enabled(this.currentIndex < this.problems.length - 1)
            .onClick(() => {
              if (this.currentIndex < this.problems.length - 1) {
                this.currentIndex++;
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 当前题目
        if (this.currentIndex < this.problems.length) {
          this.buildProblemView(this.problems[this.currentIndex])
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#f5f5f5')
  }

  @Builder
  buildProblemView(problem: ProblemModel) {
    Column({ space: 16 }) {
      // 题目标题
      Text(problem.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 题目描述
      Text(problem.description)
        .fontSize(16)
        .fontColor('#666666')
        .lineHeight(24)

      // 选项列表
      Column({ space: 12 }) {
        Text('选项:')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        ForEach(problem.choices || [], (option: ChoiceOption, index: number) => {
          this.buildOptionView(option, index)
        }, (option: ChoiceOption) => option.id)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .shadow({ radius: 4, color: '#00000010' })
  }

  @Builder
  buildOptionView(option: ChoiceOption, index: number) {
    Row({ space: 12 }) {
      Text(option.id)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(option.isCorrect ? '#52c41a' : '#333333')
        .width(30)

      Text(option.text)
        .fontSize(14)
        .fontColor('#333333')
        .layoutWeight(1)
        .lineHeight(20)

      if (option.isCorrect) {
        Text('✓')
          .fontSize(16)
          .fontColor('#52c41a')
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor(option.isCorrect ? '#f6ffed' : '#fafafa')
    .borderRadius(6)
    .border({ 
      width: 1, 
      color: option.isCorrect ? '#b7eb8f' : '#d9d9d9' 
    })
  }
}