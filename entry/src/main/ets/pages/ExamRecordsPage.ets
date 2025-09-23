import { ExamRecordModel } from '../model/ExamRecordModel';
import { ExamService } from '../service/ExamService';
import router from '@ohos.router';

@Entry
@Component
struct ExamRecordsPage {
  @State examRecords: ExamRecordModel[] = [];
  @State isLoading: boolean = true;
  @State selectedFilter: string = 'all'; // all, quick, standard, hard

  aboutToAppear() {
    this.loadExamRecords();
  }

  build() {
    Column() {
      // 页面头部
      this.buildHeader()

      // 筛选器
      this.buildFilter()

      // 记录列表
      this.buildRecordsList()
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
      }
      .backgroundColor('transparent')
      .onClick(() => {
        router.back();
      })


      Text('考核记录')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1).textAlign(TextAlign.Center)

      Blank().width(20)

    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#ffffff')
    .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
  }

  @Builder
  buildFilter() {
    Row({ space: 12 }) {
      this.buildFilterButton('all', '全部')
      this.buildFilterButton('quick', '快速')
      this.buildFilterButton('standard', '标准')
      this.buildFilterButton('hard', '地狱')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 8 })
  }

  @Builder
  buildFilterButton(filter: string, text: string) {
    Text(text)
      .fontSize(14)
      .fontColor(this.selectedFilter === filter ? '#ffffff' : '#666666')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.selectedFilter === filter ? '#F34F40' : '#ffffff')
      .borderRadius(20)
      .border({
        width: 1,
        color: this.selectedFilter === filter ? '#F34F40' : '#e0e0e0'
      })
      .onClick(() => {
        this.selectedFilter = filter;
      })
  }

  @Builder
  buildRecordsList() {
    if (this.isLoading) {
      Column() {
        Text('加载中...')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
    } else if (this.getFilteredRecords().length === 0) {
      Column({ space: 8 }) {
        Image($r('app.media.icon_empty'))
          .width(173)
          .height(128)

        Text('暂无考核记录')
          .fontSize(16)
          .fontColor('#999999')

        Text('完成第一次考核后会显示记录')
          .fontSize(14)
          .fontColor('#cccccc')
      }
      .width('100%')
      .height('90%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else {
      List({ space: 12 }) {
        ForEach(this.getFilteredRecords(), (record: ExamRecordModel) => {
          ListItem() {
            this.buildRecordCard(record)
          }
        }, (record: ExamRecordModel) => record.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 8, bottom: 16 })
    }
  }

  @Builder
  buildRecordCard(record: ExamRecordModel) {
    Column({ space: 12 }) {
      // 头部信息
      Row() {
        Column({ space: 4 }) {
          Text(record.getModeText())
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          Text(this.formatDate(new Date(record.date).getTime()))
            .fontSize(14)
            .fontColor('#999999')
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 4 }) {
          Text(record.getGradeText())
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getGradeColor(record.getGradeText()))

          Text(record.score + '分')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')

      // 统计信息
      Row({ space: 16 }) {
        this.buildStatItem('正确率', record.getAccuracyRate() + '%', '#52c41a')
        this.buildStatItem('用时', record.getDurationText(), '#1890ff')
        this.buildStatItem('题目数', record.totalProblems.toString(), '#fa8c16')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#ffffff')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000010', offsetX: 0, offsetY: 2 })
    .onClick(() => {
      this.showRecordDetail(record);
    })
  }

  @Builder
  buildStatItem(label: string, value: string, color: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)

      Text(label)
        .fontSize(12)
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Center)
  }

  private async loadExamRecords(): Promise<void> {
    try {
      this.isLoading = true;
      this.examRecords = await ExamService.getInstance().getExamRecords();
      
      // 按时间排序，最新的在前面
      this.examRecords.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
      
      console.info('Loaded exam records:', this.examRecords.length);
    } catch (error) {
      console.error('Failed to load exam records:', error);
      this.examRecords = [];
    } finally {
      this.isLoading = false;
    }
  }

  private getFilteredRecords(): ExamRecordModel[] {
    if (this.selectedFilter === 'all') {
      return this.examRecords;
    }
    
    return this.examRecords.filter(record => {
      switch (this.selectedFilter) {
        case 'quick':
          return record.mode.toString() === 'quick';
        case 'standard':
          return record.mode.toString() === 'standard';
        case 'hard':
          return record.mode.toString() === 'hard';
        default:
          return true;
      }
    });
  }

  private formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const now = new Date();
    const diffDays = Math.floor((now.getTime() - date.getTime()) / (1000 * 60 * 60 * 24));
    
    if (diffDays === 0) {
      return '今天 ' + date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    } else if (diffDays === 1) {
      return '昨天 ' + date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
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

  private showRecordDetail(record: ExamRecordModel): void {
    try {
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
}