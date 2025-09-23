// 题目难度枚举
export enum ProblemDifficulty {
  EASY = 0,
  MEDIUM = 1,
  HARD = 2
}

// 题目分类枚举
export enum ProblemCategory {
  ARRAY = 'array',
  STRING = 'string',
  LINKED_LIST = 'linked_list',
  BINARY_TREE = 'binary_tree',
  TWO_POINTERS = 'two_pointers',
  BINARY_SEARCH = 'binary_search',
  MATH = 'math',
  DYNAMIC_PROGRAMMING = 'dynamic_programming',
  STACK = 'stack',
  HASH_TABLE = 'hash_table',
  BACKTRACKING = 'backtracking',
  GREEDY = 'greedy',
  BIT_MANIPULATION = 'bit_manipulation',
  DESIGN = 'design',
  DIVIDE_CONQUER = 'divide_conquer',
  SLIDING_WINDOW = 'sliding_window',
  PREFIX_SUM = 'prefix_sum',
  MONOTONIC_STACK = 'monotonic_stack',
  TRIE = 'trie',
  GRAPH = 'graph',
  SORT = 'sort'
}

// 题目类型枚举
export enum ProblemType {
  SINGLE_CHOICE = 'single_choice',  // 单选题
  MULTIPLE_CHOICE = 'multiple_choice'  // 多选题
}

// 选择题选项接口
export interface ChoiceOption {
  id: string;  // 选项ID，如 'A', 'B', 'C', 'D'
  text: string;  // 选项内容
  isCorrect: boolean;  // 是否为正确答案
}

// 测试用例接口（保留用于代码题，现在主要用于选择题的解释）
export interface TestCase {
  input: string;
  expectedOutput: string;
  description?: string;
}

// 编程语言枚举
export enum ProgrammingLanguage {
  JAVA = 'java',
  PYTHON = 'python',
  CPP = 'cpp'
}

// 多语言代码接口
export interface MultiLanguageCode {
  java: string;
  python: string;
  cpp: string;
}

// 题目模型
export class ProblemModel {
  id: number = 0;
  title: string = '';
  description: string = '';
  difficulty: ProblemDifficulty = ProblemDifficulty.EASY;
  category: ProblemCategory = ProblemCategory.ARRAY;
  type: ProblemType = ProblemType.SINGLE_CHOICE;  // 题目类型
  choices: ChoiceOption[] = [];  // 选择题选项
  explanation: string = '';  // 答案解析
  constraints: string = '';
  hint: string = '';
  solutionCode: string = '';
  multiLanguageCode: MultiLanguageCode = {
    java: '',
    python: '',
    cpp: ''
  };
  testCases: TestCase[] = [];

  constructor() {}

  // 获取难度文本
  getDifficultyText(): string {
    switch (this.difficulty) {
      case ProblemDifficulty.EASY:
        return '简单';
      case ProblemDifficulty.MEDIUM:
        return '中等';
      case ProblemDifficulty.HARD:
        return '困难';
      default:
        return '未知';
    }
  }

  // 获取难度颜色
  getDifficultyColor(): string {
    switch (this.difficulty) {
      case ProblemDifficulty.EASY:
        return '#52c41a';
      case ProblemDifficulty.MEDIUM:
        return '#fa8c16';
      case ProblemDifficulty.HARD:
        return '#f5222d';
      default:
        return '#666666';
    }
  }

  // 获取分类文本
  getCategoryText(): string {
    switch (this.category) {
      case ProblemCategory.ARRAY:
        return '数组';
      case ProblemCategory.STRING:
        return '字符串';
      case ProblemCategory.LINKED_LIST:
        return '链表';
      case ProblemCategory.BINARY_TREE:
        return '二叉树';
      case ProblemCategory.TWO_POINTERS:
        return '双指针';
      case ProblemCategory.BINARY_SEARCH:
        return '二分查找';
      case ProblemCategory.MATH:
        return '数学';
      case ProblemCategory.DYNAMIC_PROGRAMMING:
        return '动态规划';
      case ProblemCategory.STACK:
        return '栈';
      case ProblemCategory.HASH_TABLE:
        return '哈希表';
      case ProblemCategory.BACKTRACKING:
        return '回溯';
      case ProblemCategory.GREEDY:
        return '贪心';
      case ProblemCategory.BIT_MANIPULATION:
        return '位运算';
      case ProblemCategory.DESIGN:
        return '设计';
      case ProblemCategory.DIVIDE_CONQUER:
        return '分治';
      case ProblemCategory.SLIDING_WINDOW:
        return '滑动窗口';
      case ProblemCategory.PREFIX_SUM:
        return '前缀和';
      case ProblemCategory.MONOTONIC_STACK:
        return '单调栈';
      case ProblemCategory.TRIE:
        return '字典树';
      case ProblemCategory.GRAPH:
        return '图';
      case ProblemCategory.SORT:
        return '排序';
      default:
        return '未知';
    }
  }

  // 获取分类图标
  getCategoryIcon(): Resource {
    switch (this.category) {
      case ProblemCategory.ARRAY:
        return $r('app.media.chart_icon');
      case ProblemCategory.STRING:
        return $r('app.media.note_icon');
      case ProblemCategory.LINKED_LIST:
        return $r('app.media.book_icon');
      case ProblemCategory.BINARY_TREE:
        return $r('app.media.book_icon');
      case ProblemCategory.TWO_POINTERS:
        return $r('app.media.target_icon');
      case ProblemCategory.BINARY_SEARCH:
        return $r('app.media.search_icon');
      case ProblemCategory.MATH:
        return $r('app.media.computer_icon');
      case ProblemCategory.DYNAMIC_PROGRAMMING:
        return $r('app.media.star_icon');
      case ProblemCategory.STACK:
        return $r('app.media.book_icon');
      case ProblemCategory.HASH_TABLE:
        return $r('app.media.computer_icon');
      case ProblemCategory.BACKTRACKING:
        return $r('app.media.star_icon');
      case ProblemCategory.GREEDY:
        return $r('app.media.target_icon');
      case ProblemCategory.BIT_MANIPULATION:
        return $r('app.media.computer_icon');
      case ProblemCategory.DESIGN:
        return $r('app.media.computer_icon');
      case ProblemCategory.DIVIDE_CONQUER:
        return $r('app.media.star_icon');
      case ProblemCategory.SLIDING_WINDOW:
        return $r('app.media.chart_icon');
      case ProblemCategory.PREFIX_SUM:
        return $r('app.media.chart_icon');
      case ProblemCategory.MONOTONIC_STACK:
        return $r('app.media.chart_icon');
      case ProblemCategory.TRIE:
        return $r('app.media.book_icon');
      case ProblemCategory.GRAPH:
        return $r('app.media.computer_icon');
      case ProblemCategory.SORT:
        return $r('app.media.star_icon');
      default:
        return $r('app.media.search_icon');
    }
  }

  // 获取题目类型文本
  getTypeText(): string {
    switch (this.type) {
      case ProblemType.SINGLE_CHOICE:
        return '单选题';
      case ProblemType.MULTIPLE_CHOICE:
        return '多选题';
      default:
        return '未知';
    }
  }

  // 获取正确答案选项
  getCorrectOptions(): ChoiceOption[] {
    if (!this.choices || !Array.isArray(this.choices)) {
      console.error('Problem choices is not a valid array:', this.choices);
      return [];
    }
    return this.choices.filter((option: ChoiceOption) => option && option.isCorrect);
  }

  // 检查用户答案是否正确
  checkAnswer(selectedOptionIds: string[]): boolean {
    const correctOptions = this.getCorrectOptions();
    const correctIds = correctOptions.map((option: ChoiceOption) => option.id);
    
    if (selectedOptionIds.length !== correctIds.length) {
      return false;
    }
    
    for (let i = 0; i < selectedOptionIds.length; i++) {
      if (!correctIds.includes(selectedOptionIds[i])) {
        return false;
      }
    }
    
    return true;
  }

  // 获取正确答案文本
  getCorrectAnswerText(): string {
    const correctOptions = this.getCorrectOptions();
    return correctOptions.map((option: ChoiceOption) => option.id).join(', ');
  }

  // 获取指定语言的代码
  getCodeByLanguage(language: ProgrammingLanguage): string {
    switch (language) {
      case ProgrammingLanguage.JAVA:
        return this.multiLanguageCode.java || this.solutionCode;
      case ProgrammingLanguage.PYTHON:
        return this.multiLanguageCode.python;
      case ProgrammingLanguage.CPP:
        return this.multiLanguageCode.cpp;
      default:
        return this.solutionCode;
    }
  }

  // 获取语言显示名称
  static getLanguageDisplayName(language: ProgrammingLanguage): string {
    switch (language) {
      case ProgrammingLanguage.JAVA:
        return 'Java';
      case ProgrammingLanguage.PYTHON:
        return 'Python';
      case ProgrammingLanguage.CPP:
        return 'C++';
      default:
        return 'Java';
    }
  }
}