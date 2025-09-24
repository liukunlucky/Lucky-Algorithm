import { router } from '@kit.ArkUI';
import promptAction from '@ohos.promptAction';
import { UserProgressDao } from '../dao/UserProgressDao';

interface StudyDayInfo {
  date: Date;
  dayOfMonth: number;
  isStudied: boolean;
  studyCount: number;
  isToday: boolean;
  isCurrentMonth: boolean;
}

@Entry
@Component
struct ContinuousStudyPage {
  @State currentDate: Date = new Date();
  @State studyDays: StudyDayInfo[] = [];
  @State continuousDays: number = 0;
  @State totalStudyDays: number = 0;
  @State isLoading: boolean = true;
  @State currentYear: number = new Date().getFullYear();
  @State currentMonth: number = new Date().getMonth();
  @State studyDataMap: Map<string, number> = new Map(); // 存储学习数据
  
  private userProgressDao: UserProgressDao = new UserProgressDao();

  aboutToAppear(): void {
    this.loadStudyCalendar();
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildHeader()

      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        // 内容区域
        Column({ space: 16 }) {
          // 统计卡片
          this.buildStatsCard()

          // 月份导航
          this.buildMonthNavigation()

          // 日历
          this.buildCalendar()

          // 打卡说明
          this.buildLegend()
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
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
      .width(32)
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })

      Text('连续学习')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank().width(32)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#ffffff')
    .shadow({
      radius: 2,
      color: '#00000010',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildLoadingState() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#F34F40')

      Text('正在加载学习记录...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildStatsCard() {
    Column({ space: 16 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.continuousDays.toString())
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F34F40')

          Text('连续学习天数')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Divider()
          .vertical(true)
          .height(40)
          .strokeWidth(1)
          .color('#E5E7EB')

        Column({ space: 4 }) {
          Text(this.totalStudyDays.toString())
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#52c41a')

          Text('累计学习天数')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')

      Text('坚持每日学习，养成良好习惯！')
        .fontSize(12)
        .fontColor('#999999')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({
      radius: 2,
      color: '#00000008',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  buildMonthNavigation() {
    Row() {
      Button() {
        Image($r('app.media.icon_left_arrow'))
          .width(16)
          .height(16)
          .fillColor('#666666')
      }
      .backgroundColor('transparent')
      .width(40)
      .height(40)
      .onClick(() => {
        this.changeMonth(-1);
      })

      Text(`${this.currentYear}年${this.currentMonth + 1}月`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button() {
        Image($r('app.media.icon_right_arrow'))
          .width(16)
          .height(16)
          .fillColor('#666666')
      }
      .backgroundColor('transparent')
      .width(40)
      .height(40)
      .onClick(() => {
        this.changeMonth(1);
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  buildCalendar() {
    Column({ space: 8 }) {
      // 星期标题
      Row() {
        ForEach(['日', '一', '二', '三', '四', '五', '六'], (dayName: string) => {
          Text(dayName)
            .fontSize(12)
            .fontColor('#999999')
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        })
      }
      .width('100%')

      // 日历网格
      this.buildCalendarGrid()
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
  }

  @Builder
  buildCalendarGrid() {
    Grid() {
      ForEach(this.studyDays, (dayInfo: StudyDayInfo, index: number) => {
        GridItem() {
          this.buildDayItem(dayInfo)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
    .rowsGap(8)
    .columnsGap(8)
    .width('100%')
  }

  @Builder
  buildDayItem(dayInfo: StudyDayInfo) {
    Stack() {
      Circle()
        .width(36)
        .height(36)
        .fill(this.getDayBackgroundColor(dayInfo))

      Text(dayInfo.dayOfMonth.toString())
        .fontSize(14)
        .fontColor(this.getDayTextColor(dayInfo))
        .fontWeight(dayInfo.isToday ? FontWeight.Bold : FontWeight.Normal)

      if (dayInfo.isStudied && dayInfo.studyCount > 0) {
        Circle()
          .width(6)
          .height(6)
          .fill('#52c41a')
          .position({ x: 26, y: 8 })
      }
    }
    .width(40)
    .height(40)
    .onClick(() => {
      if (dayInfo.isStudied && dayInfo.studyCount > 0) {
        this.showDayDetail(dayInfo);
      }
    })
  }

  @Builder
  buildLegend() {
    Column({ space: 12 }) {
      Text('打卡说明')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')

      Row({ space: 20 }) {
        Row({ space: 8 }) {
          Circle()
            .width(16)
            .height(16)
            .fill('#52c41a')

          Text('已学习')
            .fontSize(12)
            .fontColor('#666666')
        }

        Row({ space: 8 }) {
          Circle()
            .width(16)
            .height(16)
            .fill('#F34F40')

          Text('今天')
            .fontSize(12)
            .fontColor('#666666')
        }

        Row({ space: 8 }) {
          Circle()
            .width(16)
            .height(16)
            .fill('#E5E7EB')

          Text('未学习')
            .fontSize(12)
            .fontColor('#666666')
        }
      }
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
  }

  // 加载学习日历数据
  private async loadStudyCalendar(): Promise<void> {
    try {
      this.isLoading = true;
      console.info('📅 开始加载学习日历数据');

      // 获取连续学习天数
      this.continuousDays = await this.userProgressDao.getContinuousDays();

      // 获取总学习天数
      this.totalStudyDays = await this.userProgressDao.getTotalStudyDays();

      // 获取当前月份的学习数据
      this.studyDataMap = await this.userProgressDao.getStudyCalendarData(this.currentYear, this.currentMonth);

      // 生成当前月份的日历数据
      this.generateCalendarData();

      console.info('✅ 学习日历数据加载完成');
    } catch (error) {
      console.error('❌ 加载学习日历数据失败:', error);
      promptAction.showToast({
        message: '加载数据失败，请重试',
        duration: 2000
      });
    } finally {
      this.isLoading = false;
    }
  }

  // 生成日历数据
  private generateCalendarData(): void {
    const year = this.currentYear;
    const month = this.currentMonth;
    
    // 使用本地时间，避免时区问题
    const today = new Date();
    today.setHours(0, 0, 0, 0); // 重置时间为当天0点
    
    console.log(`生成日历数据: ${year}年${month + 1}月, 今天: ${today.getFullYear()}-${today.getMonth() + 1}-${today.getDate()}`);
    
    // 获取当月第一天和最后一天
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    
    // 获取第一天是星期几（0=星期日）
    const firstDayOfWeek = firstDay.getDay();
    
    // 获取当月天数
    const daysInMonth = lastDay.getDate();

    const studyDays: StudyDayInfo[] = [];

    // 添加上个月的日期填充
    const prevMonth = new Date(year, month - 1, 0);
    for (let i = firstDayOfWeek - 1; i >= 0; i--) {
      const date = new Date(year, month - 1, prevMonth.getDate() - i);
      date.setHours(0, 0, 0, 0); // 确保时间为0点
      studyDays.push({
        date: date,
        dayOfMonth: date.getDate(),
        isStudied: false,
        studyCount: 0,
        isToday: false,
        isCurrentMonth: false
      });
    }

    // 添加当月的日期
    for (let day = 1; day <= daysInMonth; day++) {
      const date = new Date(year, month, day);
      date.setHours(0, 0, 0, 0); // 确保时间为0点
      
      const isToday = this.isSameDay(date, today);
      const isStudied = this.checkIfStudiedOnDate(date);
      const studyCount = this.getStudyCountOnDate(date);

      console.log(`日期 ${year}-${month + 1}-${day}: isToday=${isToday}, isStudied=${isStudied}, studyCount=${studyCount}`);

      studyDays.push({
        date: date,
        dayOfMonth: day,
        isStudied: isStudied,
        studyCount: studyCount,
        isToday: isToday,
        isCurrentMonth: true
      });
    }

    // 添加下个月的日期填充（确保6行42个格子）
    const totalCells = 42;
    const remainingCells = totalCells - studyDays.length;
    for (let day = 1; day <= remainingCells; day++) {
      const date = new Date(year, month + 1, day);
      date.setHours(0, 0, 0, 0); // 确保时间为0点
      studyDays.push({
        date: date,
        dayOfMonth: day,
        isStudied: false,
        studyCount: 0,
        isToday: false,
        isCurrentMonth: false
      });
    }

    this.studyDays = studyDays;
    console.log('lucky 学习日历数据是 ' + JSON.stringify(studyDays))
  }

  // 切换月份
  private async changeMonth(delta: number): Promise<void> {
    const newDate = new Date(this.currentYear, this.currentMonth + delta);
    this.currentYear = newDate.getFullYear();
    this.currentMonth = newDate.getMonth();
    
    // 重新加载该月的数据
    this.studyDataMap = await this.userProgressDao.getStudyCalendarData(this.currentYear, this.currentMonth);
    this.generateCalendarData();
  }

  // 检查日期是否相同
  private isSameDay(date1: Date, date2: Date): boolean {
    // 确保两个日期都重置为0点进行比较
    const d1 = new Date(date1);
    d1.setHours(0, 0, 0, 0);
    const d2 = new Date(date2);
    d2.setHours(0, 0, 0, 0);
    
    const isSame = d1.getFullYear() === d2.getFullYear() &&
           d1.getMonth() === d2.getMonth() &&
           d1.getDate() === d2.getDate();
    
    console.log(`比较日期: ${d1.getFullYear()}-${d1.getMonth() + 1}-${d1.getDate()} vs ${d2.getFullYear()}-${d2.getMonth() + 1}-${d2.getDate()}, 结果: ${isSame}`);
    
    return isSame;
  }

  // 检查指定日期是否学习了
  private checkIfStudiedOnDate(date: Date): boolean {
    // 使用本地时间格式，避免时区问题
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const dateStr = `${year}-${month}-${day}`; // YYYY-MM-DD格式
    
    const hasData = this.studyDataMap.has(dateStr);
    const count = this.studyDataMap.get(dateStr) || 0;
    const isStudied = hasData && count > 0;
    
    console.log(`检查学习状态 ${dateStr}: hasData=${hasData}, count=${count}, isStudied=${isStudied}`);
    
    return isStudied;
  }

  // 获取指定日期的学习题目数
  private getStudyCountOnDate(date: Date): number {
    // 使用本地时间格式，避免时区问题
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const dateStr = `${year}-${month}-${day}`; // YYYY-MM-DD格式
    
    return this.studyDataMap.get(dateStr) || 0;
  }

  // 获取日期背景颜色
  private getDayBackgroundColor(dayInfo: StudyDayInfo): string {
    if (!dayInfo.isCurrentMonth) {
      return 'transparent';
    }
    
    if (dayInfo.isToday) {
      return '#F34F40';
    }
    
    if (dayInfo.isStudied) {
      return '#52c41a';
    }
    
    return '#E5E7EB';
  }

  // 获取日期文字颜色
  private getDayTextColor(dayInfo: StudyDayInfo): string {
    if (!dayInfo.isCurrentMonth) {
      return '#D1D5DB';
    }
    
    if (dayInfo.isToday || dayInfo.isStudied) {
      return '#ffffff';
    }
    
    return '#374151';
  }

  // 显示日期详情
  private showDayDetail(dayInfo: StudyDayInfo): void {
    const dateStr = `${dayInfo.date.getMonth() + 1}月${dayInfo.date.getDate()}日`;
    promptAction.showToast({
      message: `${dateStr} 完成了 ${dayInfo.studyCount} 道题目`,
      duration: 2000
    });
  }
}