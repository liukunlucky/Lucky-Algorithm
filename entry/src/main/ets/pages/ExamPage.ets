import { ExamMode, ExamRecordModel } from '../model/ExamRecordModel';
import { ExamService } from '../service/ExamService';
import router from '@ohos.router';

interface ExamModeConfig {
  mode: ExamMode;
  title: string;
  description: string;
  icon: Resource;
  duration: number; // 分钟
  problemCount: number;
  color: string;
  features: string[];
}

enum DifficultyLevel {
  EASY = 'easy',
  MEDIUM = 'medium',
  HARD = 'hard',
  MIXED = 'mixed'
}

interface DifficultyConfig {
  level: DifficultyLevel;
  name: string;
  description: string;
  color: string;
  icon: Resource;
}

@Component
export struct ExamPage {
  @State examModes: ExamModeConfig[] = [];
  @State recentRecords: ExamRecordModel[] = [];
  @State selectedMode: ExamModeConfig | null = null;
  @State showStartDialog: boolean = false;
  @State difficultyConfigs: DifficultyConfig[] = [];
  @State selectedDifficulty: DifficultyLevel = DifficultyLevel.MIXED;
  
  @StorageLink('examDataRefreshTrigger') @Watch('onRefreshTriggerChange') refreshTrigger: number = 0;

  aboutToAppear() {
    this.initExamModes();
    this.initDifficultyConfigs();
    this.loadRecentRecords();
  }

  aboutToDisappear() {
    // AppStorage会自动管理，无需手动取消订阅
  }

  onRefreshTriggerChange() {
    if (this.refreshTrigger > 0) {
      this.loadRecentRecords();
    }
  }


  build() {
    Stack() {
      Scroll() {
        Column({ space: 16 }) {
          // 页面标题
          // this.buildHeader()

          // 考核模式选择
          this.buildExamModes()

          // 最近考核记录
          this.buildRecentRecords()

          // 底部间距
          Column()
            .height(20)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f5f5f5')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.showStartDialog, this.buildStartDialog(), {
      height: 530,
      showClose: false,
      dragBar: false,
      preferType:SheetType.CENTER,
      onDisappear: () => {
        this.showStartDialog = false;
        this.selectedMode = null;
      }
    })
  }

  @Builder
  buildHeader() {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Image($r('app.media.test_tube_icon'))
          .width(24)
          .height(24)
          .fillColor('#333333')
        Text('模拟考核')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')

      Text('检验学习成果，提升解题能力')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  buildExamModes() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
          Text('选择考核模式')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }
        .alignSelf(ItemAlign.Start)

      ForEach(this.examModes, (mode: ExamModeConfig) => {
        this.buildExamModeCard(mode)
      }, (mode: ExamModeConfig) => mode.mode.toString())
    }
    .width('100%')
  }

  @Builder
  buildExamModeCard(mode: ExamModeConfig) {
    Column({ space: 12 }) {
      // 卡片头部
      Row({ space: 12 }) {

        Column({ space: 4 }) {
          Text(mode.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          Text(mode.description)
            .fontSize(14)
            .fontColor('#666666')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 4 }) {
          Text(mode.duration + '分钟')
            .fontSize(12)
            .fontColor('#ffffff')
            .backgroundColor(mode.color)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .borderRadius(10)

          Text(mode.problemCount + '题')
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      // 特性列表
      Column({ space: 6 }) {
        ForEach(mode.features, (feature: string) => {
          Row({ space: 8 }) {
            Image($r('app.media.check_icon'))
              .width(14)
              .height(14)
              .fillColor('#52c41a')

            Text(feature)
              .fontSize(14)
              .fontColor('#333333')
              .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }, (feature: string, index: number) => index.toString())
      }
      .alignItems(HorizontalAlign.Start)

      // 开始按钮
      Button('开始' + mode.title)
        .width('100%')
        .height(40)
        .backgroundColor(mode.color)
        .fontColor('#ffffff')
        .borderRadius(8)
        .onClick(() => {
          this.selectedMode = mode;
          this.showStartDialog = true;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
  }

  @Builder
  buildStartDialog() {
    Column({ space: 20 }) {
        // 标题
        Text('开始' + (this.selectedMode?.title || ''))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        // 模式信息
        if (this.selectedMode) {
          Column({ space: 12 }) {

            Text(this.selectedMode.description)
              .fontSize(14)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
              .maxLines(3)

            // 难度选择
            Column({ space: 8 }) {
              Text('选择难度')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)

              Row({ space: 8 }) {
                ForEach(this.difficultyConfigs, (config: DifficultyConfig) => {
                  Column({ space: 4 }) {
                    Text(config.icon)
                      .fontSize(16)

                    Text(config.name)
                      .fontSize(12)
                      .fontColor(this.selectedDifficulty === config.level ? '#ffffff' : '#333333')
                  }
                  .width(60)
                  .height(50)
                  .justifyContent(FlexAlign.Center)
                  .backgroundColor(this.selectedDifficulty === config.level ? config.color : '#f5f5f5')
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedDifficulty = config.level;
                  })
                }, (config: DifficultyConfig) => config.level)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceAround)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#f8f9fa')
            .borderRadius(8)

            // 考核规则
            Column({ space: 8 }) {
              Text('考核规则')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)

              Column({ space: 4 }) {
                ForEach(this.selectedMode.features, (feature: string) => {
                  Row({ space: 8 }) {
                    Text('✓')
                      .fontSize(14)
                      .fontColor('#52c41a')

                    Text(feature)
                      .fontSize(14)
                      .fontColor('#333333')
                      .layoutWeight(1)
                  }
                  .width('100%')
                  .alignItems(VerticalAlign.Center)
                }, (feature: string, index: number) => index.toString())
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#f8f9fa')
            .borderRadius(8)
          }
        }

        // 按钮组
        Row({ space: 12 }) {
          Button('取消')
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#FFFFFF')
            .fontColor('#666666')
            .borderRadius(8)
            .onClick(() => {
              this.showStartDialog = false;
              this.selectedMode = null;
            })

          Button('开始考核')
            .layoutWeight(1)
            .height(44)
            .backgroundColor(this.selectedMode?.color || '#F34F40')
            .fontColor('#ffffff')
            .borderRadius(8)
            .onClick(() => {
              this.startExam();
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(24)
  }

  @Builder
  buildRecentRecords() {
    Column({ space: 12 }) {
      Row() {
        Row({ space: 8 }) {
          Text('最近考核记录')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
        }

        Blank()

        Text('查看全部')
          .fontSize(14)
          .fontColor('#F34F40')
          .onClick(() => {
            this.showAllRecords();
          })
      }
      .width('100%')

      if (this.recentRecords.length === 0) {
        Column({ space: 8 }) {
          Image($r('app.media.icon_empty'))
              .width(58)
              .height(42)

          Text('暂无考核记录')
            .fontSize(14)
            .fontColor('#999999')

          Text('完成第一次考核后会显示记录')
            .fontSize(12)
            .fontColor('#cccccc')
        }
        .width('100%')
        .height(120)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ffffff')
        .borderRadius(12)
      } else {
        List({ space: 8 }) {
          ForEach(this.recentRecords, (record: ExamRecordModel) => {
            ListItem() {
              this.buildRecordCard(record)
            }
          }, (record: ExamRecordModel) => record.id.toString())
        }
        .width('100%')
        .height(200)
      }
    }
    .width('100%')
  }

  @Builder
  buildRecordCard(record: ExamRecordModel) {
    Row({ space: 12 }) {
      Column({ space: 4 }) {
        Text(record.getModeText())
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Row({ space: 8 }) {
          Text('正确率: ' + record.getAccuracyRate() + '%')
            .fontSize(12)
            .fontColor('#666666')

          Text('用时: ' + record.getDurationText())
            .fontSize(12)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Start)

        Text(this.formatDate(new Date(record.date).getTime()))
          .fontSize(12)
          .fontColor('#999999')
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: 4 }) {
        Text(record.getGradeText())
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getGradeColor(record.getGradeText()))

        Text(record.score + '分')
          .fontSize(12)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#ffffff')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#00000008', offsetX: 0, offsetY: 1 })
    .onClick(() => {
      this.showRecordDetail(record);
    })
  }

  private initExamModes(): void {
    this.examModes = [
      {
        mode: ExamMode.QUICK,
        title: '快速测试',
        description: '5道题目快速检验基础掌握情况，适合日常练习后的自我检测',
        icon: $r('app.media.lightning_icon'),
        duration: 15,
        problemCount: 5,
        color: '#52c41a',
        features: [
          '随机选择5道不同难度题目',
          '15分钟限时完成',
          '即时查看答案和解析',
          '快速了解薄弱环节'
        ]
      },
      {
        mode: ExamMode.STANDARD,
        title: '标准模考',
        description: '10道题目全面考核算法能力，模拟真实面试场景',
        icon: $r('app.media.note_icon'),
        duration: 45,
        problemCount: 10,
        color: '#1890ff',
        features: [
          '涵盖多个算法分类',
          '45分钟标准考试时长',
          '详细的错题分析报告',
          '能力评估和建议'
        ]
      },
      {
        mode: ExamMode.HARD,
        title: '地狱模考',
        description: '15道高难度题目，挑战算法极限，适合进阶学习者',
        icon: $r('app.media.star_icon'),
        duration: 90,
        problemCount: 15,
        color: '#f5222d',
        features: [
          '高难度算法题目',
          '90分钟充分思考时间',
          '深度解题思路分析',
          '算法优化建议'
        ]
      },
      {
        mode: ExamMode.QUICK,
        title: '专项突破',
        description: '针对特定算法类型的专项训练，深度掌握单一领域',
        icon: $r('app.media.target_icon'),
        duration: 30,
        problemCount: 8,
        color: '#722ed1',
        features: [
          '专注单一算法分类',
          '8道同类型进阶题目',
          '30分钟专项训练',
          '深度掌握解题套路'
        ]
      },
      {
        mode: ExamMode.STANDARD,
        title: '面试模拟',
        description: '模拟真实技术面试场景，包含代码实现和思路讲解',
        icon: $r('app.media.laptop_icon'),
        duration: 60,
        problemCount: 6,
        color: '#fa8c16',
        features: [
          '真实面试题目选择',
          '60分钟面试时长',
          '代码质量评估',
          '面试技巧指导'
        ]
      },
      {
        mode: ExamMode.HARD,
        title: '竞赛训练',
        description: '高强度算法竞赛题目，提升编程竞赛能力',
        icon: $r('app.media.trophy_icon'),
        duration: 120,
        problemCount: 12,
        color: '#eb2f96',
        features: [
          '竞赛级别难度题目',
          '120分钟充分思考',
          '多种解法对比分析',
          '时间复杂度优化'
        ]
      },
      {
        mode: ExamMode.QUICK,
        title: '错题重练',
        description: '针对历史错题进行重新练习，巩固薄弱知识点',
        icon: $r('app.media.refresh_icon'),
        duration: 25,
        problemCount: 6,
        color: '#13c2c2',
        features: [
          '基于错题历史智能推荐',
          '25分钟巩固练习',
          '错误原因深度分析',
          '知识点查漏补缺'
        ]
      },
      {
        mode: ExamMode.STANDARD,
        title: '每日挑战',
        description: '每日精选题目挑战，保持算法思维活跃度',
        icon: $r('app.media.calendar_icon'),
        duration: 20,
        problemCount: 3,
        color: '#a0d911',
        features: [
          '每日更新精选题目',
          '20分钟轻松挑战',
          '连续打卡奖励机制',
          '算法思维保持训练'
        ]
      }
    ];
  }

  private initDifficultyConfigs(): void {
    this.difficultyConfigs = [
      {
        level: DifficultyLevel.EASY,
        name: '简单',
        description: '基础算法题目，适合初学者',
        color: '#52c41a',
        icon: $r('app.media.star_icon')
      },
      {
        level: DifficultyLevel.MEDIUM,
        name: '中等',
        description: '中等难度题目，考验算法理解',
        color: '#fa8c16',
        icon: $r('app.media.target_icon')
      },
      {
        level: DifficultyLevel.HARD,
        name: '困难',
        description: '高难度题目，挑战算法极限',
        color: '#f5222d',
        icon: $r('app.media.fire_icon')
      },
      {
        level: DifficultyLevel.MIXED,
        name: '混合',
        description: '各种难度混合，全面考核',
        color: '#1890ff',
        icon: $r('app.media.dice_icon')
      }
    ];
  }

  private async loadRecentRecords(): Promise<void> {
    try {
      // 从ExamService加载最近的考核记录
      this.recentRecords = await ExamService.getInstance().getRecentExamRecords(5);
        
      console.info('Loaded recent records:', this.recentRecords.length);
    } catch (error) {
      console.error('Failed to load recent records:', error);
      this.recentRecords = [];
    }
  }

  private formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const now = new Date();
    const diffDays = Math.floor((now.getTime() - date.getTime()) / (1000 * 60 * 60 * 24));
    
    if (diffDays === 0) {
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      const seconds = date.getSeconds().toString().padStart(2, '0');
      return `今天 ${hours}:${minutes}:${seconds}`;
    } else if (diffDays === 1) {
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      const seconds = date.getSeconds().toString().padStart(2, '0');
      return `昨天 ${hours}:${minutes}:${seconds}`;
    } else if (diffDays < 7) {
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      const seconds = date.getSeconds().toString().padStart(2, '0');
      return `${diffDays}天前 ${hours}:${minutes}:${seconds}`;
    } else {
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      const seconds = date.getSeconds().toString().padStart(2, '0');
      return `${month}月${day}日 ${hours}:${minutes}:${seconds}`;
    }
  }

  private getGradeColor(grade: string): string {
    switch (grade) {
      case '优秀':
        return '#52c41a';
      case '良好':
        return '#1890ff';
      case '及格':
        return '#fa8c16';
      case '不及格':
        return '#f5222d';
      default:
        return '#666666';
    }
  }

  private showAllRecords(): void {
    try {
      // 跳转到考核记录列表页面
      router.pushUrl({
        url: 'pages/ExamRecordsPage'
      }).catch((error: Error) => {
        console.error('Failed to navigate to exam records page:', error);
      });
    } catch (error) {
      console.error('Failed to show all records:', error);
    }
  }

  private showRecordDetail(record: ExamRecordModel): void {
    try {
      // 跳转到考核报告页面显示详情
      router.pushUrl({
        url: 'pages/ExamReportPage',
        params: { 
          examRecord: record,
          fromHistory: true 
        }
      }).catch((error: Error) => {
        console.error('Failed to navigate to exam report:', error);
      });
    } catch (error) {
      console.error('Failed to show record detail:', error);
    }
  }

  /**
   * 开始考核
   */
  private async startExam(): Promise<void> {
    try {
      if (!this.selectedMode) {
        console.error('No exam mode selected');
        return;
      }
      
      // 选择题目
      const problems = await ExamService.getInstance().selectProblemsForExam(this.selectedMode.mode, this.selectedDifficulty);
      
      if (problems.length === 0) {
        console.error('No problems available for exam');
        return;
      }
      
      // 跳转到考核进行页面
      router.pushUrl({
        url: 'pages/ExamConductPage',
        params: {
          mode: this.selectedMode.mode,
          difficulty: this.selectedDifficulty,
          problems: problems,
          timeLimit: this.selectedMode.duration * 60, // 转换为秒
          startTime: Date.now()
        }
      }).catch((error: Error) => {
        console.error('Failed to navigate to exam conduct page:', error);
      });
      
      this.showStartDialog = false;
    } catch (error) {
      console.error('Failed to start exam:', error);
      this.showStartDialog = false;
    }
  }
}