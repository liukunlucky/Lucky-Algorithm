// 编程语言枚举
export enum ProgrammingLanguage {
  JAVA = 'java',
  PYTHON = 'python',
  CPP = 'cpp'
}

// 公司枚举
export enum Company {
  ALIBABA = 'alibaba',
  TENCENT = 'tencent',
  BYTEDANCE = 'bytedance',
  BAIDU = 'baidu',
  MEITUAN = 'meituan',
  JD = 'jd',
  NETEASE = 'netease',
  XIAOMI = 'xiaomi',
  HUAWEI = 'huawei',
  DIDI = 'didi',
  KUAISHOU = 'kuaishou',
  PINDUODUO = 'pinduoduo'
}

// 题目难度枚举
export enum CompanyProblemDifficulty {
  EASY = 'easy',
  MEDIUM = 'medium',
  HARD = 'hard'
}

// 代码解答
export interface CodeSolution {
  language: ProgrammingLanguage;
  code: string;
  explanation: string;
  timeComplexity: string;
  spaceComplexity: string;
}

// 大厂真题模型
export class CompanyProblemModel {
  id: number = 0;
  title: string = '';
  description: string = '';
  company: Company = Company.ALIBABA;
  difficulty: CompanyProblemDifficulty = CompanyProblemDifficulty.MEDIUM;
  tags: string[] = [];
  year: number = 2024;
  position: string = ''; // 面试岗位
  solutions: CodeSolution[] = [];
  hints: string[] = [];
  relatedProblems: number[] = []; // 相关题目ID
  frequency: number = 1; // 出现频率 1-5
  
  constructor() {}
  
  // 获取难度显示文本
  getDifficultyText(): string {
    switch (this.difficulty) {
      case CompanyProblemDifficulty.EASY:
        return '简单';
      case CompanyProblemDifficulty.MEDIUM:
        return '中等';
      case CompanyProblemDifficulty.HARD:
        return '困难';
      default:
        return '中等';
    }
  }
  
  // 获取难度颜色
  getDifficultyColor(): string {
    switch (this.difficulty) {
      case CompanyProblemDifficulty.EASY:
        return '#52C41A';
      case CompanyProblemDifficulty.MEDIUM:
        return '#FA8C16';
      case CompanyProblemDifficulty.HARD:
        return '#F5222D';
      default:
        return '#FA8C16';
    }
  }
  
  // 获取公司显示名称
  getCompanyName(): string {
    switch (this.company) {
      case Company.ALIBABA:
        return '阿里巴巴';
      case Company.TENCENT:
        return '腾讯';
      case Company.BYTEDANCE:
        return '字节跳动';
      case Company.BAIDU:
        return '百度';
      case Company.MEITUAN:
        return '美团';
      case Company.JD:
        return '京东';
      case Company.NETEASE:
        return '网易';
      case Company.XIAOMI:
        return '小米';
      case Company.HUAWEI:
        return '华为';
      case Company.DIDI:
        return '滴滴';
      case Company.KUAISHOU:
        return '快手';
      case Company.PINDUODUO:
        return '拼多多';
      default:
        return '未知公司';
    }
  }
  
  // 获取语言解答
  getSolutionByLanguage(language: ProgrammingLanguage): CodeSolution | null {
    const solution = this.solutions.find(s => s.language === language);
    return solution || null;
  }
  
  // 获取频率星级显示
  getFrequencyStars(): string {
    // 确保频率值在1-5范围内
    const normalizedFrequency = Math.max(1, Math.min(5, this.frequency));
    return '★'.repeat(normalizedFrequency) + '☆'.repeat(5 - normalizedFrequency);
  }
}