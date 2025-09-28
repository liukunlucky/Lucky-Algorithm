import router from '@ohos.router';
import { CompanyProblemModel, Company, CompanyProblemDifficulty, ProgrammingLanguage,
  CodeSolution } from '../model/CompanyProblemModel';
import { CompanyProblemMockData } from '../mock/CompanyProblemMockData';

@Entry
@Component
export struct BigCompanyPage {
  @State private problems: CompanyProblemModel[] = [];
  @State private filteredProblems: CompanyProblemModel[] = [];
  @State private selectedCompany: Company | null = null;
  @State private selectedDifficulty: CompanyProblemDifficulty | null = null;
  @State private searchText: string = '';
  @State private isLoading: boolean = true;

  aboutToAppear() {
    this.loadProblems();
  }

  private loadProblems() {
    this.isLoading = true;
    // 模拟异步加载
    setTimeout(() => {
      this.problems = CompanyProblemMockData.getProblems();
      this.filterProblems();
      this.isLoading = false;
    }, 500);
  }

  private filterProblems() {
    let filtered = this.problems;

    // 按公司筛选
    if (this.selectedCompany) {
      filtered = filtered.filter(p => p.company === this.selectedCompany);
    }

    // 按难度筛选
    if (this.selectedDifficulty) {
      filtered = filtered.filter(p => p.difficulty === this.selectedDifficulty);
    }

    // 按搜索文本筛选
    if (this.searchText.trim()) {
      const searchLower = this.searchText.toLowerCase();
      filtered = filtered.filter(p => 
        p.title.toLowerCase().includes(searchLower) ||
        p.description.toLowerCase().includes(searchLower) ||
        p.tags.some(tag => tag.toLowerCase().includes(searchLower))
      );
    }

    this.filteredProblems = filtered;
  }

  build() {
    Column() {
      // 标题栏
      this.buildHeader()

      // 筛选栏
      this.buildFilterSection()

      // 内容区域
      if (this.isLoading) {
        this.buildLoadingState()
      } else {
        this.buildProblemsList()
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
      .width(40)
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        router.back();
      })

      Text('大厂真题')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 占位，保持标题居中
      Row().width(40).height(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  buildFilterSection() {
    Column({ space: 12 }) {
      // 搜索框
      this.buildSearchBar()

      // 公司筛选
      this.buildCompanyFilter()

      // 难度筛选
      this.buildDifficultyFilter()
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .margin({ bottom: 8 })
  }

  @Builder
  buildSearchBar() {
    Row() {
      Image($r('app.media.icon_search'))
        .width(20)
        .height(20)
        .fillColor('#999999')
        .margin({ left: 12, right: 8 })

      TextInput({ placeholder: '搜索题目、标签...' })
        .layoutWeight(1)
        .placeholderColor('#D5DBDB')
        .backgroundColor(Color.Transparent)
        .border({ width: 0 })
        .onChange((value: string) => {
          this.searchText = value;
          this.filterProblems();
        })
    }
    .width('100%')
    .height(40)
    .backgroundColor('#F5F5F5')
    .borderRadius(20)
  }

  @Builder
  buildCompanyFilter() {
    Column({ space: 8 }) {
      Row() {
        Text('公司筛选')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.selectedCompany) {
          Button('清除')
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .fontColor('#F34F40')
            .fontSize(12)
            .padding(0)
            .onClick(() => {
              this.selectedCompany = null;
              this.filterProblems();
            })
        }
      }
      .width('100%')

      Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Start }) {
        ForEach(Object.values(Company), (company: Company) => {
          this.buildCompanyChip(company)
        }, (company: Company) => company)
      }
      .width('100%')
    }
  }

  @Builder
  buildCompanyChip(company: Company) {
    Button(this.getCompanyName(company))
      .type(ButtonType.Normal)
      .backgroundColor(this.selectedCompany === company ? '#F34F40' : '#F2F2F7')
      .fontColor(this.selectedCompany === company ? '#FFFFFF' : '#3C3C43')
      .fontSize(12)
      .fontWeight(this.selectedCompany === company ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(12)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .margin({ right: 8, bottom: 8 })
      .onClick(() => {
        this.selectedCompany = this.selectedCompany === company ? null : company;
        this.filterProblems();
      })
  }

  @Builder
  buildDifficultyFilter() {
    Column({ space: 8 }) {
      Row() {
        Text('难度筛选')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.selectedDifficulty) {
          Button('清除')
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .fontColor('#F34F40')
            .fontSize(12)
            .padding(0)
            .onClick(() => {
              this.selectedDifficulty = null;
              this.filterProblems();
            })
        }
      }
      .width('100%')

      Row({ space: 8 }) {
        ForEach(Object.values(CompanyProblemDifficulty), (difficulty: CompanyProblemDifficulty) => {
          this.buildDifficultyChip(difficulty)
        }, (difficulty: CompanyProblemDifficulty) => difficulty)
      }
      .width('100%')
    }
  }

  @Builder
  buildDifficultyChip(difficulty: CompanyProblemDifficulty) {
    Button(this.getDifficultyText(difficulty))
      .type(ButtonType.Normal)
      .backgroundColor(this.selectedDifficulty === difficulty ? '#F34F40' : '#F2F2F7')
      .fontColor(this.selectedDifficulty === difficulty ? '#FFFFFF' : '#3C3C43')
      .fontSize(12)
      .fontWeight(this.selectedDifficulty === difficulty ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(12)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.selectedDifficulty = this.selectedDifficulty === difficulty ? null : difficulty;
        this.filterProblems();
      })
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
  buildProblemsList() {
    if (this.filteredProblems.length === 0) {
      Column({ space: 16 }) {
        Image($r('app.media.icon_empty'))
          .width(58)
          .height(42)

        Text('暂无题目')
          .fontSize(16)
          .fontColor('#666666')

        Text('试试调整筛选条件')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else {
      List({ space: 12 }) {
        ForEach(this.filteredProblems, (problem: CompanyProblemModel) => {
          ListItem() {
            this.buildProblemItem(problem)
          }
        }, (problem: CompanyProblemModel) => problem.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
    }
  }

  @Builder
  buildProblemItem(problem: CompanyProblemModel) {
    Column({ space: 12 }) {
      // 标题和公司
      Row() {
        Text(problem.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)

        Text(problem.getCompanyName())
          .fontSize(12)
          .fontColor('#666666')
          .backgroundColor('#F5F5F5')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(8)
      }
      .width('100%')

      // 难度、年份、岗位
      Row({ space: 12 }) {
        Text(problem.getDifficultyText())
          .fontSize(12)
          .fontColor('#ffffff')
          .backgroundColor(problem.getDifficultyColor())
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)

        Text(problem.year + '年')
          .fontSize(12)
          .fontColor('#666666')

        Text(problem.position)
          .fontSize(12)
          .fontColor('#666666')

        Blank()

        Text(problem.getFrequencyStars())
          .fontSize(12)
          .fontColor('#FA8C16')
      }
      .width('100%')

      // 标签
      if (problem.tags.length > 0) {
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Start }) {
          ForEach(problem.tags, (tag: string) => {
            Text(tag)
              .fontSize(10)
              .fontColor('#666666')
              .backgroundColor('#F0F0F0')
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .borderRadius(4)
              .margin({ right: 4, bottom: 4 })
          }, (tag: string) => tag)
        }
        .width('100%')
      }

      // 支持的语言
      Row({ space: 8 }) {
        Text('支持语言:')
          .fontSize(12)
          .fontColor('#666666')

        ForEach(problem.solutions, (solution: CodeSolution) => {
          Row({ space: 4 }) {
            Text('•')
              .fontSize(12)
              .fontColor('#1890ff')
            Text(this.getLanguageName(solution.language))
              .fontSize(12)
              .fontColor('#666666')
          }
        }, (solution: CodeSolution) => solution.language)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/CompanyProblemDetailPage',
        params: { problemId: problem.id }
      }).catch((error: Error) => {
        console.error('Failed to navigate:', error);
      });
    })
  }

  private getCompanyName(company: Company): string {
    switch (company) {
      case Company.ALIBABA: return '阿里巴巴';
      case Company.TENCENT: return '腾讯';
      case Company.BYTEDANCE: return '字节跳动';
      case Company.BAIDU: return '百度';
      case Company.MEITUAN: return '美团';
      case Company.JD: return '京东';
      case Company.NETEASE: return '网易';
      case Company.XIAOMI: return '小米';
      case Company.HUAWEI: return '华为';
      case Company.DIDI: return '滴滴';
      case Company.KUAISHOU: return '快手';
      case Company.PINDUODUO: return '拼多多';
      default: return '未知公司';
    }
  }

  private getDifficultyText(difficulty: CompanyProblemDifficulty): string {
    switch (difficulty) {
      case CompanyProblemDifficulty.EASY: return '简单';
      case CompanyProblemDifficulty.MEDIUM: return '中等';
      case CompanyProblemDifficulty.HARD: return '困难';
      default: return '中等';
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