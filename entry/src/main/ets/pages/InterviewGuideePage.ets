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
struct InterviewGuideePage {
  @State questions: InterviewQuestion[] = [];
  @State currentQuestion: InterviewQuestion | null = null;
  @State showAnswer: boolean = false;
  @State currentIndex: number = 0;

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
      if (this.questions.length > 0) {
        this.getRandomQuestion();
      }
    } catch (error) {
      console.error('Failed to load interview questions:', error);
      // 使用mock数据作为备选
      this.questions = this.getMockQuestions();
      if (this.questions.length > 0) {
        this.getRandomQuestion();
      }
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
      title: 'Java的面向对象三大特性是什么？',
      answer: '封装、继承、多态。封装指隐藏对象内部实现细节，仅通过公共接口交互；继承指子类继承父类属性和方法，实现代码复用；多态指同一方法在不同对象上有不同实现，通过重写和重载实现。',
      category: 0,
      difficulty: 0
    };
    mockQuestions.push(question1);

    const question2: InterviewQuestion = {
      id: 2,
      title: 'String为什么是不可变的？',
      answer: 'String类被final修饰，其内部存储字符的char数组也是final的。不可变的好处包括：线程安全、可作为HashMap的key、字符串常量池复用节省内存。',
      category: 0,
      difficulty: 1
    };
    mockQuestions.push(question2);

    const question3: InterviewQuestion = {
      id: 3,
      title: 'ArrayList和LinkedList的区别？',
      answer: '底层结构：ArrayList基于动态数组，LinkedList基于双向链表。性能：ArrayList随机访问快（O(1)），增删首尾元素慢（需移动元素）；LinkedList随机访问慢（O(n)），增删首尾元素快（O(1)）。',
      category: 1,
      difficulty: 1
    };
    mockQuestions.push(question3);

    return mockQuestions;
  }

  getRandomQuestion() {
    if (this.questions.length === 0) return;
    
    const randomIndex = Math.floor(Math.random() * this.questions.length);
    this.currentQuestion = this.questions[randomIndex];
    this.currentIndex = randomIndex;
    this.showAnswer = false;
  }

  getNextQuestion() {
    if (this.questions.length === 0) return;
    
    this.currentIndex = (this.currentIndex + 1) % this.questions.length;
    this.currentQuestion = this.questions[this.currentIndex];
    this.showAnswer = false;
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

      Text('面试宝典')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Image($r('app.media.icon_fresh'))
        .width(24)
        .height(24)
        .onClick(() => {
          this.getRandomQuestion();
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  buildQuestionCard() {
    if (!this.currentQuestion) {
      Column() {
        Text('暂无题目')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin(16)
    } else {

    Column({ space: 16 }) {
      // 题目信息
      Row() {
        Text(`第 ${this.currentIndex + 1} 题`)
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Text(this.getCategoryName(this.currentQuestion.category))
            .fontSize(12)
            .fontColor('#4A90E2')
            .backgroundColor('#E3F2FD')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)

          Text(this.getDifficultyName(this.currentQuestion.difficulty))
            .fontSize(12)
            .fontColor(this.getDifficultyColor(this.currentQuestion.difficulty))
            .backgroundColor(this.getDifficultyBgColor(this.currentQuestion.difficulty))
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(12)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 题目内容
      Text(this.currentQuestion.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .lineHeight(28)
        .width('100%')

      // 答案区域
      if (this.showAnswer) {
        Column({ space: 12 }) {
          Row() {
            Text('参考答案')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4A90E2')
          }
          .width('100%')

          Text(this.currentQuestion.answer)
            .fontSize(14)
            .lineHeight(22)
            .fontColor('#333333')
            .width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F8F9FA')
        .borderRadius(8)
      }

      // 操作按钮
      Row({ space: 12 }) {
        Button(this.showAnswer ? '隐藏答案' : '查看答案')
          .fontSize(16)
          .backgroundColor(this.showAnswer ? '#FF6B6B' : '#4A90E2')
          .fontColor(Color.White)
          .borderRadius(8)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.showAnswer = !this.showAnswer;
          })

        Button('随机一题')
          .fontSize(16)
          .backgroundColor('#28A745')
          .fontColor(Color.White)
          .borderRadius(8)
          .layoutWeight(1)
          .height(44)
          .onClick(() => {
            this.getNextQuestion();
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin(16)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    }
  }

  @Builder
  buildStatistics() {
    Row({ space: 20 }) {
      Column() {
        Text(this.questions.length.toString())
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A90E2')
        Text('题目总数')
          .fontSize(12)
          .fontColor('#666666')
      }

      Column() {
        Text((this.currentIndex + 1).toString())
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#28A745')
        Text('当前题目')
          .fontSize(12)
          .fontColor('#666666')
      }

      Column() {
        Text(this.currentQuestion ? this.getCategoryName(this.currentQuestion.category) : '-')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B6B')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text('当前分类')
          .fontSize(12)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({ left: 16, right: 16, bottom: 16 })
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
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

  build() {
    Column() {
      this.buildHeader()

      Scroll() {
        Column() {
          this.buildStatistics()
          this.buildQuestionCard()
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}