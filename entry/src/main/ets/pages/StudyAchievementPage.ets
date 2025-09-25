import router from '@ohos.router';
import { AchievementModel } from '../model/AchievementModel';
import { AchievementService } from '../service/AchievementService';

@Entry
@Component
struct StudyAchievementPage {
  @State private achievements: AchievementModel[] = [];
  @State private isLoading: boolean = false;
  @State private completionRate: number = 0;
  private achievementService: AchievementService = new AchievementService();

  aboutToAppear(): void {
    this.loadAchievements();
  }

  // 加载成就数据
  private async loadAchievements(): Promise<void> {
    try {
      this.isLoading = true;
      this.achievements = await this.achievementService.getAllAchievements();
      this.completionRate = await this.achievementService.getAchievementCompletionRate();
    } catch (error) {
      console.error('Failed to load achievements:', error);
    } finally {
      this.isLoading = false;
    }
  }

  // 构建成就卡片
  @Builder
  private buildAchievementCard(achievement: AchievementModel): void {
    Column({ space: 16 }) {
      // 成就图标
      Text(achievement.icon)
        .fontSize(32)
        .opacity(achievement.isCompleted ? 1.0 : 0.5)

      // 成就标题
      Text(achievement.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(achievement.isCompleted ? '#1890ff' : '#666666')
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 成就描述
      Text(achievement.description)
        .fontSize(12)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .lineHeight(16)

      // 进度条
      Column({ space: 8 }) {
        // 进度条背景
        Stack({ alignContent: Alignment.Start }) {
          // 背景条
          Row()
            .width('100%')
            .height(6)
            .backgroundColor('#f5f5f5')
            .borderRadius(3)

          // 进度条
          Row()
            .width(`${achievement.getProgressPercentage()}%`)
            .height(6)
            .backgroundColor(achievement.isCompleted ? '#1890ff' : '#52c41a')
            .borderRadius(3)
        }
        .width('100%')

        // 进度文本
        Text(achievement.getProgressText())
          .fontSize(12)
          .fontColor(achievement.isCompleted ? '#1890ff' : '#666666')
          .textAlign(TextAlign.Center)
      }
      .width('100%')

      // 完成标识
      if (achievement.isCompleted) {
        Row({ space: 8 }) {
          Text('✓')
            .fontSize(12)
            .fontColor('#ffffff')
          
          Text('已完成')
            .fontSize(12)
            .fontColor('#ffffff')
        }
        .padding({
          top: 8,
          bottom: 8,
          left: 16,
          right: 16
        })
        .backgroundColor('#1890ff')
        .borderRadius(4)
      }
    }
    .width('100%')
    .height(200)
    .padding(24)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 6,
      color: '#00000015',
      offsetX: 0,
      offsetY: 3
    })
    .border({
      width: achievement.isCompleted ? 2 : 1,
      color: achievement.isCompleted ? '#1890ff' : '#e0e0e0'
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
  }

  // 构建统计信息
  @Builder
  private buildStatistics(): void {
    Column({ space: 16 }) {
      Text('成就统计')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')

      Row({ space: 24 }) {
        // 完成率
        Column({ space: 8 }) {
          Text(`${this.completionRate}%`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1890ff')

          Text('完成率')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // 已完成数量
        Column({ space: 8 }) {
          Text(`${this.achievements.filter(a => a.isCompleted).length}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('已完成')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // 总数量
        Column({ space: 8 }) {
          Text(`${this.achievements.length}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Text('总成就')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
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

  // 构建成就网格
  @Builder
  private buildAchievementGrid(): void {
    Column({ space: 16 }) {
      Text('我的成就')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .alignSelf(ItemAlign.Start)

      // 3行2列的网格布局
      Grid() {
        ForEach(this.achievements, (achievement: AchievementModel) => {
          GridItem() {
            this.buildAchievementCard(achievement)
          }
        }, (achievement: AchievementModel) => achievement.type)
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .height(640) // 3行 * 200px + 2个间距 * 16px
    }
    .width('100%')
  }

  build() {
    Column() {
      // 顶部导航栏
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

        Text('学习成就')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 刷新按钮
        Button() {
          Image($r('app.media.icon_fresh'))
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.loadAchievements();
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#ffffff')

      // 内容区域
      if (this.isLoading) {
        Column() {
          Column({ space: 16 }) {
            LoadingProgress()
              .width(40)
              .height(40)
              .color('#1890ff')

            Text('加载成就数据...')
              .fontSize(14)
              .fontColor('#666666')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
      } else {
        Scroll() {
          Column({ space: 24 }) {
            // 统计信息
            this.buildStatistics()

            // 成就网格
            this.buildAchievementGrid()
          }
          .width('100%')
          .padding(24)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}