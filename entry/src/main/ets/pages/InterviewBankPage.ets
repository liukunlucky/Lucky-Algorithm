import router from '@ohos.router';
import util from '@ohos.util';

interface InterviewQuestion {
  id: number;
  title: string;
  answer: string;
  category: number;
  difficulty: number;
}

@Entry
@Component
struct InterviewBankPage {
  @State questions: InterviewQuestion[] = [];
  @State filteredQuestions: InterviewQuestion[] = [];
  @State selectedCategory: string = '全部';
  @State selectedDifficulty: string = '所有难度';
  @State searchKeyword: string = '';
  @State showDetailDialog: boolean = false;
  @State selectedQuestion: InterviewQuestion | null = null;

  aboutToAppear() {
    this.loadInterviewQuestions();
  }

  async loadInterviewQuestions() {
    try {
      const resourceManager = getContext(this).resourceManager;
      const fileData = await resourceManager.getRawFileContent('mianshi.json');
      const decoder = new util.TextDecoder('utf-8');
      const jsonString = decoder.decodeWithStream(new Uint8Array(fileData.buffer));
      const data = JSON.parse(jsonString) as InterviewQuestion[];
      
      this.questions = data || [];
      this.filteredQuestions = this.questions;
    } catch (error) {
      console.error('Failed to load interview questions:', error);
      // 使用mock数据作为备选
      this.questions = this.getMockQuestions();
      this.filteredQuestions = this.questions;
    }
  }

  // 分类映射
  getCategoryName(category: number): string {
    const categoryMap: Record<number, string> = {
      0: 'Java基础',
      1: '集合框架',
      2: '并发编程',
      3: 'JVM原理',
      4: '异常处理',
      5: '注解反射',
      6: '新特性'
    };
    return categoryMap[category] || '其他';
  }

  // 难度映射
  getDifficultyName(difficulty: number): string {
    const difficultyMap: Record<number, string> = {
      0: '简单',
      1: '中等',
      2: '困难'
    };
    return difficultyMap[difficulty] || '未知';
  }

  getMockQuestions(): InterviewQuestion[] {
    const mockQuestions: InterviewQuestion[] = [];
    
    const question1: InterviewQuestion = {
      id: 1,
      title: 'JavaScript中的闭包是什么？',
      answer: '闭包是指有权访问另一个函数作用域中变量的函数。闭包在JavaScript中非常重要，它允许函数访问并操作函数外部的变量。',
      category: 0,
      difficulty: 1
    };
    mockQuestions.push(question1);

    const question2: InterviewQuestion = {
      id: 2,
      title: 'Java中的多态是什么？',
      answer: '多态是面向对象编程的重要特性，指同一个接口可以有多种不同的实现方式。在Java中，多态主要通过继承和接口实现。',
      category: 0,
      difficulty: 0
    };
    mockQuestions.push(question2);

    const question3: InterviewQuestion = {
      id: 3,
      title: '什么是RESTful API？',
      answer: 'RESTful API是一种基于REST架构风格的Web API设计规范，使用HTTP方法（GET、POST、PUT、DELETE）来操作资源。',
      category: 0,
      difficulty: 1
    };
    mockQuestions.push(question3);

    return mockQuestions;
  }

  filterQuestions(): void {
    this.filteredQuestions = this.questions.filter((question: InterviewQuestion): boolean => {
      const categoryMatch = this.selectedCategory === '全部' || this.getCategoryName(question.category) === this.selectedCategory;
      const difficultyMatch = this.selectedDifficulty === '所有难度' || this.getDifficultyName(question.difficulty) === this.selectedDifficulty;
      const keywordMatch = this.searchKeyword === '' || 
        question.title.includes(this.searchKeyword) || 
        question.answer.includes(this.searchKeyword);
      
      return categoryMatch && difficultyMatch && keywordMatch;
    });
  }

  @Builder
  buildHeader() {
    Row() {
      Image($r('app.media.icon_back'))
        .width(24)
        .height(24)
        .onClick(() => {
          router.back();
        })

      Text('面试题库')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row().width(24)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildFilterBar() {
    Column({ space: 12 }) {
      // 搜索框
      TextInput({ placeholder: '搜索题目或答案...' })
        .width('100%')
        .height(40)
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
        .onChange((value: string) => {
          this.searchKeyword = value;
          this.filterQuestions();
        })

      // 筛选条件
      Row({ space: 12 }) {
        // 分类筛选
        Button(this.selectedCategory)
          .fontSize(14)
          .backgroundColor(this.selectedCategory === '全部' ? '#4A90E2' : '#F0F0F0')
          .fontColor(this.selectedCategory === '全部' ? Color.White : '#666666')
          .borderRadius(16)
          .height(32)
          .onClick(() => {
            // 这里可以添加分类选择弹窗
          })

        // 难度筛选
        Button(this.selectedDifficulty)
          .fontSize(14)
          .backgroundColor(this.selectedDifficulty === '所有难度' ? '#4A90E2' : '#F0F0F0')
          .fontColor(this.selectedDifficulty === '所有难度' ? Color.White : '#666666')
          .borderRadius(16)
          .height(32)
          .onClick(() => {
            // 这里可以添加难度选择弹窗
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
  }

  @Builder
  buildQuestionItem(question: InterviewQuestion) {
    Column({ space: 8 }) {
      // 题目标题
      Row() {
        Text(question.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Row({ space: 4 }) {
          Text(this.getCategoryName(question.category))
            .fontSize(12)
            .fontColor('#4A90E2')
            .backgroundColor('#E3F2FD')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)

          Text(this.getDifficultyName(question.difficulty))
            .fontSize(12)
            .fontColor(this.getDifficultyColor(question.difficulty))
            .backgroundColor(this.getDifficultyBgColor(question.difficulty))
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 答案预览
      Text(question.answer)
        .fontSize(14)
        .fontColor('#666666')
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
    .onClick(() => {
      // 显示题目详情弹窗
      this.selectedQuestion = question;
      this.showDetailDialog = true;
    })
  }

  getDifficultyColor(difficulty: number): string {
    switch (difficulty) {
      case 0: // 简单
        return '#4CAF50';
      case 1: // 中等
        return '#FF9800';
      case 2: // 困难
        return '#F44336';
      default:
        return '#666666';
    }
  }

  getDifficultyBgColor(difficulty: number): string {
    switch (difficulty) {
      case 0: // 简单
        return '#E8F5E8';
      case 1: // 中等
        return '#FFF3E0';
      case 2: // 困难
        return '#FFEBEE';
      default:
        return '#F0F0F0';
    }
  }

  @Builder
  buildDetailDialog() {
    // 遮罩层
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .onClick(() => {
        this.showDetailDialog = false;
        this.selectedQuestion = null;
      })

    // 弹窗内容
    Column({ space: 20 }) {
      // 标题栏
      Row() {
        Text('题目详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Image($r('app.media.close_icon'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.showDetailDialog = false;
            this.selectedQuestion = null;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 题目信息
      if (this.selectedQuestion) {
        Column({ space: 16 }) {
          // 分类和难度标签
          Row({ space: 8 }) {
            Text(this.getCategoryName(this.selectedQuestion.category))
              .fontSize(12)
              .fontColor('#4A90E2')
              .backgroundColor('#E3F2FD')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(12)

            Text(this.getDifficultyName(this.selectedQuestion.difficulty))
              .fontSize(12)
              .fontColor(this.getDifficultyColor(this.selectedQuestion.difficulty))
              .backgroundColor(this.getDifficultyBgColor(this.selectedQuestion.difficulty))
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(12)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          // 题目标题
          Text(this.selectedQuestion.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 答案
          Column({ space: 8 }) {
            Text('参考答案')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .textAlign(TextAlign.Start)

            Text(this.selectedQuestion.answer)
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)
              .width('100%')
              .textAlign(TextAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('90%')
    .height('80%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 4 })
    .position({ x: '5%', y: '10%' })
  }

  build() {
    Stack() {
      // 主要内容
      Column() {
        this.buildHeader()
        
        this.buildFilterBar()

        List({ space: 12 }) {
          ForEach(this.filteredQuestions, (question: InterviewQuestion) => {
            ListItem() {
              this.buildQuestionItem(question)
            }
          }, (question: InterviewQuestion) => question.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 16 })
        .backgroundColor('#F8F8F8')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // 题目详情弹窗
      if (this.showDetailDialog && this.selectedQuestion) {
        this.buildDetailDialog()
      }
    }
    .width('100%')
    .height('100%')
  }
}