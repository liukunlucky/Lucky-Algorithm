import { ExamMode, ExamRecordModel } from '../model/ExamRecordModel';
import { ProblemModel, ProblemDifficulty, ProblemCategory, TestCase, ProblemType, ChoiceOption } from '../model/ProblemModel';

enum DifficultyLevel {
  EASY = 'easy',
  MEDIUM = 'medium',
  HARD = 'hard',
  MIXED = 'mixed'
}

interface ChoiceOptionsResult {
  options: ChoiceOption[];
  explanation: string;
}

export class ExamService {
  private static instance: ExamService;

  private constructor() {}

  public static getInstance(): ExamService {
    if (!ExamService.instance) {
      ExamService.instance = new ExamService();
    }
    return ExamService.instance;
  }

  /**
   * 根据考核模式和难度选择题目
   */
  public async selectProblemsForExam(mode: ExamMode, difficulty: DifficultyLevel = DifficultyLevel.MIXED): Promise<ProblemModel[]> {
    try {
      // 获取所有题目
      const allProblems = await this.getAllProblems();
      
      // 根据难度过滤题目
      const filteredProblems = this.filterProblemsByDifficulty(allProblems, difficulty);
      
      // 根据模式配置选择题目
      const config = this.getModeConfig(mode);
      const selectedProblems = this.selectProblemsByMode(filteredProblems, config);
      
      // 随机打乱题目顺序
      return this.shuffleArray(selectedProblems);
    } catch (error) {
      console.error('Failed to select problems for exam:', error);
      return [];
    }
  }

  /**
   * 获取模式配置
   */
  private getModeConfig(mode: ExamMode): ExamModeConfig {
    switch (mode) {
      case ExamMode.QUICK:
        const quickDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        quickDistribution[ProblemDifficulty.EASY] = 3;
        quickDistribution[ProblemDifficulty.MEDIUM] = 2;
        quickDistribution[ProblemDifficulty.HARD] = 0;
        return {
          problemCount: 5,
          timeLimit: 15 * 60, // 15分钟
          difficultyDistribution: quickDistribution
        };
      case ExamMode.STANDARD:
        const standardDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        standardDistribution[ProblemDifficulty.EASY] = 4;
        standardDistribution[ProblemDifficulty.MEDIUM] = 4;
        standardDistribution[ProblemDifficulty.HARD] = 2;
        return {
          problemCount: 10,
          timeLimit: 45 * 60, // 45分钟
          difficultyDistribution: standardDistribution
        };
      case ExamMode.HARD:
        const hardDistribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        hardDistribution[ProblemDifficulty.EASY] = 2;
        hardDistribution[ProblemDifficulty.MEDIUM] = 6;
        hardDistribution[ProblemDifficulty.HARD] = 7;
        return {
          problemCount: 15,
          timeLimit: 90 * 60, // 90分钟
          difficultyDistribution: hardDistribution
        };
      default:
        const distribution: Record<ProblemDifficulty, number> = {} as Record<ProblemDifficulty, number>;
        distribution[ProblemDifficulty.EASY] = 3;
        distribution[ProblemDifficulty.MEDIUM] = 2;
        distribution[ProblemDifficulty.HARD] = 0;
        return {
          problemCount: 5,
          timeLimit: 15 * 60,
          difficultyDistribution: distribution
        };
    }
  }

  /**
   * 根据模式配置选择题目
   */
  private selectProblemsByMode(allProblems: ProblemModel[], config: ExamModeConfig): ProblemModel[] {
    const selectedProblems: ProblemModel[] = [];
    
    // 按难度分组
    const problemsByDifficulty = this.groupProblemsByDifficulty(allProblems);
    
    // 按配置的难度分布选择题目
    const difficulties = [ProblemDifficulty.EASY, ProblemDifficulty.MEDIUM, ProblemDifficulty.HARD];
    for (const difficulty of difficulties) {
      const count = config.difficultyDistribution[difficulty];
      const problems = problemsByDifficulty[difficulty] || [];
      
      if (problems.length > 0) {
        const shuffled = this.shuffleArray([...problems]);
        const selected = shuffled.slice(0, Math.min(count, shuffled.length));
        selectedProblems.push(...selected);
      }
    }
    
    // 如果选择的题目不够，从剩余题目中随机补充
    if (selectedProblems.length < config.problemCount) {
      const remaining = allProblems.filter(p => !selectedProblems.includes(p));
      const shuffled = this.shuffleArray(remaining);
      const needed = config.problemCount - selectedProblems.length;
      selectedProblems.push(...shuffled.slice(0, needed));
    }
    
    return selectedProblems.slice(0, config.problemCount);
  }

  /**
   * 根据难度过滤题目
   */
  private filterProblemsByDifficulty(problems: ProblemModel[], difficulty: DifficultyLevel): ProblemModel[] {
    if (difficulty === DifficultyLevel.MIXED) {
      return problems; // 混合难度返回所有题目
    }
    
    let targetDifficulty: ProblemDifficulty;
    switch (difficulty) {
      case DifficultyLevel.EASY:
        targetDifficulty = ProblemDifficulty.EASY;
        break;
      case DifficultyLevel.MEDIUM:
        targetDifficulty = ProblemDifficulty.MEDIUM;
        break;
      case DifficultyLevel.HARD:
        targetDifficulty = ProblemDifficulty.HARD;
        break;
      default:
        return problems;
    }
    
    return problems.filter(problem => problem.difficulty === targetDifficulty);
  }

  /**
   * 按难度分组题目
   */
  private groupProblemsByDifficulty(problems: ProblemModel[]): Record<ProblemDifficulty, ProblemModel[]> {
    const groups: Record<ProblemDifficulty, ProblemModel[]> = {} as Record<ProblemDifficulty, ProblemModel[]>;
    groups[ProblemDifficulty.EASY] = [];
    groups[ProblemDifficulty.MEDIUM] = [];
    groups[ProblemDifficulty.HARD] = [];
    
    problems.forEach(problem => {
      groups[problem.difficulty].push(problem);
    });
    
    return groups;
  }

  /**
   * 随机打乱数组
   */
  private shuffleArray<T>(array: T[]): T[] {
    const shuffled = [...array];
    for (let i = shuffled.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      const temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    return shuffled;
  }

  /**
   * 获取所有题目（模拟数据）
   */
  private async getAllProblems(): Promise<ProblemModel[]> {
    // TODO: 从数据库或API获取题目数据
    // 这里返回模拟数据
    return this.getMockProblems();
  }

  /**
   * 创建选择题选项
   */
  private createChoiceOptions(correctAnswers: string[], wrongAnswers: string[]): ChoiceOption[] {
    const options: ChoiceOption[] = [];
    
    // 添加正确答案
    correctAnswers.forEach((answer, index) => {
      const option: ChoiceOption = {
        id: String.fromCharCode(65 + options.length), // A, B, C, D...
        text: answer,
        isCorrect: true
      };
      options.push(option);
    });
    
    // 添加错误答案
    wrongAnswers.forEach((answer, index) => {
      const option: ChoiceOption = {
        id: String.fromCharCode(65 + options.length), // A, B, C, D...
        text: answer,
        isCorrect: false
      };
      options.push(option);
    });
    
    // 随机打乱选项顺序
    return this.shuffleArray(options);
  }

  /**
   * 为特定题目生成选择题选项
   */
  private generateChoiceOptionsForProblem(data: ProblemData): ChoiceOptionsResult {
    let correctAnswers: string[] = [];
    let wrongAnswers: string[] = [];
    let explanation = '';

    // 根据题目类别和标题生成不同的选择题
    switch (data.category) {
      case ProblemCategory.ARRAY:
        if (data.title.includes('两数之和')) {
          correctAnswers = ['O(n) 时间复杂度，使用哈希表'];
          wrongAnswers = ['O(n²) 暴力解法是最优的', 'O(log n) 二分查找', 'O(n log n) 排序后双指针'];
          explanation = '使用哈希表可以在一次遍历中找到两数之和，时间复杂度为O(n)，空间复杂度为O(n)。';
        } else if (data.title.includes('最大子数组')) {
          correctAnswers = ['动态规划，O(n) 时间复杂度'];
          wrongAnswers = ['分治算法，O(n log n)', '暴力枚举，O(n³)', '贪心算法，O(n²)'];
          explanation = 'Kadane算法使用动态规划思想，维护当前最大和，时间复杂度O(n)。';
        } else {
          correctAnswers = ['O(n) 线性时间复杂度'];
          wrongAnswers = ['O(n²) 平方时间复杂度', 'O(log n) 对数时间复杂度', 'O(n log n) 线性对数复杂度'];
          explanation = '大多数数组问题可以通过一次或两次遍历解决，时间复杂度为O(n)。';
        }
        break;
      
      case ProblemCategory.STRING:
        if (data.title.includes('回文')) {
          correctAnswers = ['双指针从两端向中间移动'];
          wrongAnswers = ['反转字符串后比较', '递归检查每个字符', '使用栈结构验证'];
          explanation = '双指针法是检查回文最高效的方法，时间复杂度O(n)，空间复杂度O(1)。';
        } else {
          correctAnswers = ['O(n) 时间复杂度'];
          wrongAnswers = ['O(n²) 时间复杂度', 'O(log n) 时间复杂度', 'O(n³) 时间复杂度'];
          explanation = '字符串问题通常可以通过一次遍历解决。';
        }
        break;
      
      case ProblemCategory.LINKED_LIST:
        if (data.title.includes('反转')) {
          correctAnswers = ['迭代法，使用三个指针'];
          wrongAnswers = ['递归法是唯一解法', '使用额外数组存储', '双向链表才能反转'];
          explanation = '迭代法使用prev、curr、next三个指针，时间复杂度O(n)，空间复杂度O(1)。';
        } else {
          correctAnswers = ['O(n) 时间复杂度'];
          wrongAnswers = ['O(n²) 时间复杂度', 'O(log n) 时间复杂度', 'O(n log n) 时间复杂度'];
          explanation = '链表问题通常需要遍历一次，时间复杂度为O(n)。';
        }
        break;
      
      case ProblemCategory.BINARY_TREE:
        if (data.title.includes('深度')) {
          correctAnswers = ['递归计算左右子树深度的最大值'];
          wrongAnswers = ['层序遍历计算层数', '中序遍历统计节点', '前序遍历记录路径'];
          explanation = '递归计算：depth = 1 + max(leftDepth, rightDepth)，时间复杂度O(n)。';
        } else {
          correctAnswers = ['O(n) 时间复杂度'];
          wrongAnswers = ['O(n²) 时间复杂度', 'O(log n) 时间复杂度', 'O(n log n) 时间复杂度'];
          explanation = '二叉树问题通常需要访问每个节点一次。';
        }
        break;
      
      default:
        correctAnswers = ['O(n) 时间复杂度'];
        wrongAnswers = ['O(n²) 时间复杂度', 'O(log n) 时间复杂度', 'O(n log n) 时间复杂度'];
        explanation = '根据算法特点分析时间复杂度。';
        break;
    }

    const options = this.createChoiceOptions(correctAnswers, wrongAnswers);
    const result: ChoiceOptionsResult = {
      options: options,
      explanation: explanation
    };
    return result;
  }

  /**
   * 获取模拟题目数据
   */
  private getMockProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];
    
    // 数组类题目
    const arrayProblems: ProblemData[] = [];
    const array1: ProblemData = { id: 1, title: '两数之和', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.ARRAY };
    const array2: ProblemData = { id: 2, title: '三数之和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.ARRAY };
    const array3: ProblemData = { id: 3, title: '四数之和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.ARRAY };
    const array4: ProblemData = { id: 4, title: '最大子数组和', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.ARRAY };
    const array5: ProblemData = { id: 5, title: '合并两个有序数组', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.ARRAY };
    arrayProblems.push(array1, array2, array3, array4, array5);
    
    // 字符串类题目
    const stringProblems: ProblemData[] = [];
    const string1: ProblemData = { id: 6, title: '有效的括号', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STRING };
    const string2: ProblemData = { id: 7, title: '最长公共前缀', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STRING };
    const string3: ProblemData = { id: 8, title: '回文字符串', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STRING };
    const string4: ProblemData = { id: 9, title: '字符串转整数', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.STRING };
    const string5: ProblemData = { id: 10, title: '最长回文子串', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.STRING };
    stringProblems.push(string1, string2, string3, string4, string5);
    
    // 链表类题目
    const linkedListProblems: ProblemData[] = [];
    const linked1: ProblemData = { id: 11, title: '反转链表', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.LINKED_LIST };
    const linked2: ProblemData = { id: 12, title: '合并两个有序链表', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.LINKED_LIST };
    const linked3: ProblemData = { id: 13, title: '环形链表', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.LINKED_LIST };
    const linked4: ProblemData = { id: 14, title: '删除链表的倒数第N个节点', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.LINKED_LIST };
    const linked5: ProblemData = { id: 15, title: '链表相交', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.LINKED_LIST };
    linkedListProblems.push(linked1, linked2, linked3, linked4, linked5);
    
    // 二叉树类题目
    const treeProblems: ProblemData[] = [];
    const tree1: ProblemData = { id: 16, title: '二叉树的最大深度', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BINARY_TREE };
    const tree2: ProblemData = { id: 17, title: '对称二叉树', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BINARY_TREE };
    const tree3: ProblemData = { id: 18, title: '二叉树的层序遍历', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_TREE };
    const tree4: ProblemData = { id: 19, title: '验证二叉搜索树', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_TREE };
    const tree5: ProblemData = { id: 20, title: '二叉树的最近公共祖先', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_TREE };
    treeProblems.push(tree1, tree2, tree3, tree4, tree5);
    
    // 动态规划类题目
    const dpProblems: ProblemData[] = [];
    const dp1: ProblemData = { id: 21, title: '爬楼梯', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp2: ProblemData = { id: 22, title: '最大子序和', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp3: ProblemData = { id: 23, title: '打家劫舍', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp4: ProblemData = { id: 24, title: '零钱兑换', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp5: ProblemData = { id: 25, title: '最长递增子序列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp6: ProblemData = { id: 26, title: '编辑距离', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp7: ProblemData = { id: 27, title: '正则表达式匹配', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    const dp8: ProblemData = { id: 28, title: '最长有效括号', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.DYNAMIC_PROGRAMMING };
    dpProblems.push(dp1, dp2, dp3, dp4, dp5, dp6, dp7, dp8);
    
    // 排序类题目
    const sortProblems: ProblemData[] = [];
    const sort1: ProblemData = { id: 37, title: '冒泡排序', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.SORT };
    const sort2: ProblemData = { id: 38, title: '选择排序', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.SORT };
    const sort3: ProblemData = { id: 39, title: '插入排序', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.SORT };
    const sort4: ProblemData = { id: 40, title: '快速排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SORT };
    const sort5: ProblemData = { id: 41, title: '归并排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SORT };
    const sort6: ProblemData = { id: 42, title: '堆排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SORT };
    const sort7: ProblemData = { id: 43, title: '计数排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SORT };
    const sort8: ProblemData = { id: 44, title: '基数排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SORT };
    sortProblems.push(sort1, sort2, sort3, sort4, sort5, sort6, sort7, sort8);
    
    // 搜索类题目
    const searchProblems: ProblemData[] = [];
    const search1: ProblemData = { id: 45, title: '线性搜索', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BINARY_SEARCH };
    const search2: ProblemData = { id: 46, title: '二分搜索', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BINARY_SEARCH };
    const search3: ProblemData = { id: 47, title: '搜索插入位置', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BINARY_SEARCH };
    const search4: ProblemData = { id: 48, title: '搜索旋转排序数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_SEARCH };
    const search5: ProblemData = { id: 49, title: '寻找峰值', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_SEARCH };
    const search6: ProblemData = { id: 50, title: '搜索二维矩阵', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_SEARCH };
    const search7: ProblemData = { id: 51, title: '寻找两个正序数组的中位数', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.BINARY_SEARCH };
    const search8: ProblemData = { id: 52, title: '寻找重复数', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BINARY_SEARCH };
    searchProblems.push(search1, search2, search3, search4, search5, search6, search7, search8);
    
    // 图论类题目
    const graphProblems: ProblemData[] = [];
    const graph1: ProblemData = { id: 45, title: '岛屿数量', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GRAPH };
    const graph2: ProblemData = { id: 46, title: '课程表', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GRAPH };
    const graph3: ProblemData = { id: 47, title: '克隆图', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GRAPH };
    const graph4: ProblemData = { id: 48, title: '单词接龙', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.GRAPH };
    const graph5: ProblemData = { id: 49, title: '最短路径', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.GRAPH };
    const graph6: ProblemData = { id: 50, title: '最小生成树', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.GRAPH };
    const graph7: ProblemData = { id: 51, title: '拓扑排序', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GRAPH };
    const graph8: ProblemData = { id: 52, title: '并查集', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GRAPH };
    graphProblems.push(graph1, graph2, graph3, graph4, graph5, graph6, graph7, graph8);
    
    // 栈和队列类题目
    const stackQueueProblems: ProblemData[] = [];
    const sq1: ProblemData = { id: 53, title: '有效的括号', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STACK };
    const sq2: ProblemData = { id: 54, title: '最小栈', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STACK };
    const sq3: ProblemData = { id: 55, title: '用栈实现队列', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STACK };
    const sq4: ProblemData = { id: 56, title: '用队列实现栈', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.STACK };
    const sq5: ProblemData = { id: 57, title: '逆波兰表达式求值', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.STACK };
    const sq6: ProblemData = { id: 58, title: '每日温度', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.STACK };
    const sq7: ProblemData = { id: 59, title: '柱状图中最大的矩形', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.STACK };
    const sq8: ProblemData = { id: 60, title: '滑动窗口最大值', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.STACK };
    stackQueueProblems.push(sq1, sq2, sq3, sq4, sq5, sq6, sq7, sq8);
    
    // 哈希表类题目
    const hashProblems: ProblemData[] = [];
    const hash1: ProblemData = { id: 61, title: '两数之和', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.HASH_TABLE };
    const hash2: ProblemData = { id: 62, title: '字母异位词分组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.HASH_TABLE };
    const hash3: ProblemData = { id: 63, title: '最长连续序列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.HASH_TABLE };
    const hash4: ProblemData = { id: 64, title: '无重复字符的最长子串', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.HASH_TABLE };
    const hash5: ProblemData = { id: 65, title: '和为K的子数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.HASH_TABLE };
    const hash6: ProblemData = { id: 66, title: '最小覆盖子串', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.HASH_TABLE };
    const hash7: ProblemData = { id: 67, title: '串联所有单词的子串', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.HASH_TABLE };
    const hash8: ProblemData = { id: 68, title: '最长无重复子串', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.HASH_TABLE };
    hashProblems.push(hash1, hash2, hash3, hash4, hash5, hash6, hash7, hash8);
    
    // 双指针类题目
    const twoPointerProblems: ProblemData[] = [];
    const tp1: ProblemData = { id: 69, title: '移除元素', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.TWO_POINTERS };
    const tp2: ProblemData = { id: 70, title: '删除有序数组中的重复项', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.TWO_POINTERS };
    const tp3: ProblemData = { id: 71, title: '合并两个有序数组', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.TWO_POINTERS };
    const tp4: ProblemData = { id: 72, title: '三数之和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TWO_POINTERS };
    const tp5: ProblemData = { id: 73, title: '最接近的三数之和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TWO_POINTERS };
    const tp6: ProblemData = { id: 74, title: '四数之和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TWO_POINTERS };
    const tp7: ProblemData = { id: 75, title: '盛最多水的容器', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TWO_POINTERS };
    const tp8: ProblemData = { id: 76, title: '接雨水', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.TWO_POINTERS };
    twoPointerProblems.push(tp1, tp2, tp3, tp4, tp5, tp6, tp7, tp8);
    
    // 回溯算法类题目
    const backtrackProblems: ProblemData[] = [];
    const bt1: ProblemData = { id: 77, title: '全排列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt2: ProblemData = { id: 78, title: '全排列II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt3: ProblemData = { id: 79, title: '组合', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt4: ProblemData = { id: 80, title: '组合总和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt5: ProblemData = { id: 81, title: '子集', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt6: ProblemData = { id: 82, title: '单词搜索', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BACKTRACKING };
    const bt7: ProblemData = { id: 83, title: 'N皇后', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.BACKTRACKING };
    const bt8: ProblemData = { id: 84, title: '解数独', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.BACKTRACKING };
    backtrackProblems.push(bt1, bt2, bt3, bt4, bt5, bt6, bt7, bt8);
    
    // 贪心算法类题目
    const greedyProblems: ProblemData[] = [];
    const gr1: ProblemData = { id: 85, title: '买卖股票的最佳时机', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.GREEDY };
    const gr2: ProblemData = { id: 86, title: '买卖股票的最佳时机II', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.GREEDY };
    const gr3: ProblemData = { id: 87, title: '跳跃游戏', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GREEDY };
    const gr4: ProblemData = { id: 88, title: '跳跃游戏II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GREEDY };
    const gr5: ProblemData = { id: 89, title: '加油站', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GREEDY };
    const gr6: ProblemData = { id: 90, title: '分发糖果', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.GREEDY };
    const gr7: ProblemData = { id: 91, title: '无重叠区间', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GREEDY };
    const gr8: ProblemData = { id: 92, title: '用最少数量的箭引爆气球', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.GREEDY };
    greedyProblems.push(gr1, gr2, gr3, gr4, gr5, gr6, gr7, gr8);
    
    // 数学类题目
    const mathProblems: ProblemData[] = [];
    const math1: ProblemData = { id: 93, title: '回文数', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    const math2: ProblemData = { id: 94, title: '整数反转', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    const math3: ProblemData = { id: 95, title: '罗马数字转整数', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    const math4: ProblemData = { id: 96, title: '整数转罗马数字', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MATH };
    const math5: ProblemData = { id: 97, title: '字符串相乘', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MATH };
    const math6: ProblemData = { id: 98, title: '快乐数', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    const math7: ProblemData = { id: 99, title: '阶乘后的零', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    const math8: ProblemData = { id: 100, title: '计算右移', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MATH };
    mathProblems.push(math1, math2, math3, math4, math5, math6, math7, math8);
    
    // 位运算类题目
    const bitProblems: ProblemData[] = [];
    const bit1: ProblemData = { id: 101, title: '位1的个数', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BIT_MANIPULATION };
    const bit2: ProblemData = { id: 102, title: '颠倒二进制位', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BIT_MANIPULATION };
    const bit3: ProblemData = { id: 103, title: '只出现一次的数字', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BIT_MANIPULATION };
    const bit4: ProblemData = { id: 104, title: '只出现一次的数字II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BIT_MANIPULATION };
    const bit5: ProblemData = { id: 105, title: '只出现一次的数字III', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BIT_MANIPULATION };
    const bit6: ProblemData = { id: 106, title: '比特位计数', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BIT_MANIPULATION };
    const bit7: ProblemData = { id: 107, title: '汉明距离', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.BIT_MANIPULATION };
    const bit8: ProblemData = { id: 108, title: '最大单词长度乘积', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.BIT_MANIPULATION };
    bitProblems.push(bit1, bit2, bit3, bit4, bit5, bit6, bit7, bit8);
    
    // 设计类题目
    const designProblems: ProblemData[] = [];
    const design1: ProblemData = { id: 109, title: 'LRU缓存机制', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DESIGN };
    const design2: ProblemData = { id: 110, title: 'LFU缓存', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.DESIGN };
    const design3: ProblemData = { id: 111, title: '设计推特', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DESIGN };
    const design4: ProblemData = { id: 112, title: '设计哈希映射', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DESIGN };
    const design5: ProblemData = { id: 113, title: '设计哈希集合', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DESIGN };
    const design6: ProblemData = { id: 114, title: '设计循环队列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DESIGN };
    const design7: ProblemData = { id: 115, title: '设计循环双端队列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DESIGN };
    const design8: ProblemData = { id: 116, title: '设计停车系统', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DESIGN };
    designProblems.push(design1, design2, design3, design4, design5, design6, design7, design8);
    
    // 分治算法类题目
    const divideConquerProblems: ProblemData[] = [];
    const dc1: ProblemData = { id: 117, title: '最大子序和', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DIVIDE_CONQUER };
    const dc2: ProblemData = { id: 118, title: '多数元素', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DIVIDE_CONQUER };
    const dc3: ProblemData = { id: 119, title: '为运算表达式设计优先级', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DIVIDE_CONQUER };
    const dc4: ProblemData = { id: 120, title: '不同的二叉搜索树II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DIVIDE_CONQUER };
    const dc5: ProblemData = { id: 121, title: '验证二叉搜索树', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DIVIDE_CONQUER };
    const dc6: ProblemData = { id: 122, title: '将有序数组转换为二叉搜索树', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.DIVIDE_CONQUER };
    const dc7: ProblemData = { id: 123, title: '有序链表转换二叉搜索树', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.DIVIDE_CONQUER };
    const dc8: ProblemData = { id: 124, title: '二叉树的最大路径和', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.DIVIDE_CONQUER };
    divideConquerProblems.push(dc1, dc2, dc3, dc4, dc5, dc6, dc7, dc8);
    
    // 滑动窗口类题目
    const slidingWindowProblems: ProblemData[] = [];
    const sw1: ProblemData = { id: 125, title: '无重复字符的最长子串', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw2: ProblemData = { id: 126, title: '最小覆盖子串', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.SLIDING_WINDOW };
    const sw3: ProblemData = { id: 127, title: '字符串的排列', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw4: ProblemData = { id: 128, title: '找到字符串中所有字母异位词', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw5: ProblemData = { id: 129, title: '长度最小的子数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw6: ProblemData = { id: 130, title: '水果成篮', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw7: ProblemData = { id: 131, title: '替换后的最长重复字符', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    const sw8: ProblemData = { id: 132, title: '最大连续1的个数III', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.SLIDING_WINDOW };
    slidingWindowProblems.push(sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8);
    
    // 前缀和类题目
    const prefixSumProblems: ProblemData[] = [];
    const ps1: ProblemData = { id: 133, title: '区域和检索-数组不可变', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.PREFIX_SUM };
    const ps2: ProblemData = { id: 134, title: '二维区域和检索-矩阵不可变', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    const ps3: ProblemData = { id: 135, title: '和为K的子数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    const ps4: ProblemData = { id: 136, title: '连续的子数组和', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    const ps5: ProblemData = { id: 137, title: '和可被K整除的子数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    const ps6: ProblemData = { id: 138, title: '最短无序连续子数组', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    const ps7: ProblemData = { id: 139, title: '子数组和排序后的区间和', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.PREFIX_SUM };
    const ps8: ProblemData = { id: 140, title: '统计「优美子数组」', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.PREFIX_SUM };
    prefixSumProblems.push(ps1, ps2, ps3, ps4, ps5, ps6, ps7, ps8);
    
    // 单调栈类题目
    const monotonicStackProblems: ProblemData[] = [];
    const ms1: ProblemData = { id: 141, title: '每日温度', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MONOTONIC_STACK };
    const ms2: ProblemData = { id: 142, title: '下一个更大元素I', difficulty: ProblemDifficulty.EASY, category: ProblemCategory.MONOTONIC_STACK };
    const ms3: ProblemData = { id: 143, title: '下一个更大元素II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MONOTONIC_STACK };
    const ms4: ProblemData = { id: 144, title: '柱状图中最大的矩形', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.MONOTONIC_STACK };
    const ms5: ProblemData = { id: 145, title: '最大矩形', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.MONOTONIC_STACK };
    const ms6: ProblemData = { id: 146, title: '去除重复字母', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MONOTONIC_STACK };
    const ms7: ProblemData = { id: 147, title: '移掉K位数字', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MONOTONIC_STACK };
    const ms8: ProblemData = { id: 148, title: '132模式', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.MONOTONIC_STACK };
    monotonicStackProblems.push(ms1, ms2, ms3, ms4, ms5, ms6, ms7, ms8);
    
    // 字典树类题目
    const trieProblems: ProblemData[] = [];
    const trie1: ProblemData = { id: 149, title: '实现Trie(前缀树)', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TRIE };
    const trie2: ProblemData = { id: 150, title: '添加与搜索单词', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TRIE };
    const trie3: ProblemData = { id: 151, title: '单词搜索II', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.TRIE };
    const trie4: ProblemData = { id: 152, title: '替换单词', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TRIE };
    const trie5: ProblemData = { id: 153, title: '键值映射', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TRIE };
    const trie6: ProblemData = { id: 154, title: '最短唯一前缀', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.TRIE };
    const trie7: ProblemData = { id: 155, title: '单词方块', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.TRIE };
    const trie8: ProblemData = { id: 156, title: '设计搜索自动补全系统', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.TRIE };
    trieProblems.push(trie1, trie2, trie3, trie4, trie5, trie6, trie7, trie8);
    
    // 困难题目
    const hardProblems: ProblemData[] = [];
    const hard1: ProblemData = { id: 157, title: '合并K个升序链表', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.LINKED_LIST };
    const hard2: ProblemData = { id: 158, title: '二叉树的序列化与反序列化', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.BINARY_TREE };
    const hard3: ProblemData = { id: 159, title: '基本计算器', difficulty: ProblemDifficulty.HARD, category: ProblemCategory.STACK };
    const hard4: ProblemData = { id: 160, title: '基本计算器II', difficulty: ProblemDifficulty.MEDIUM, category: ProblemCategory.STACK };
    hardProblems.push(hard1, hard2, hard3, hard4);
    
    // 创建题目对象
    const allProblemData = arrayProblems.concat(
      stringProblems, 
      linkedListProblems, 
      treeProblems, 
      dpProblems, 
      sortProblems, 
      searchProblems, 
      graphProblems,
      stackQueueProblems,
      hashProblems,
      twoPointerProblems,
      backtrackProblems,
      greedyProblems,
      mathProblems,
      bitProblems,
      designProblems,
      divideConquerProblems,
      slidingWindowProblems,
      prefixSumProblems,
      monotonicStackProblems,
      trieProblems,
      hardProblems
    );
    allProblemData.forEach((data: ProblemData) => {
      const problem = new ProblemModel();
      problem.id = data.id;
      problem.title = data.title;
      problem.difficulty = data.difficulty;
      problem.category = data.category;
      problem.description = `这是${data.title}的题目描述。请选择正确的算法思路或时间复杂度。`;
      problem.constraints = '1 <= n <= 1000';
      problem.hint = '提示：仔细分析算法的时间和空间复杂度';
      
      // 设置为选择题类型
      problem.type = ProblemType.SINGLE_CHOICE;
      
      // 根据题目生成选择题选项
      const choiceData = this.generateChoiceOptionsForProblem(data);
      problem.choices = choiceData.options;
      problem.explanation = choiceData.explanation;
      
      // 添加测试用例（保留原有结构）
      const testCase: TestCase = {
        input: '[1,2,3]',
        expectedOutput: '[3,2,1]',
        description: '示例 1'
      };
      problem.testCases = [testCase];
      problems.push(problem);
    });
    
    return problems;
  }

  /**
   * 保存考核记录
   */
  public async saveExamRecord(record: ExamRecordModel): Promise<boolean> {
    try {
      // 这里应该保存到数据库，目前先保存到本地存储
      const records = await this.getExamRecords();
      records.push(record);
      
      // 保存到本地存储
      const recordsJson = JSON.stringify(records);
      // 注意：这里需要使用HarmonyOS的存储API，暂时用模拟实现
      console.info('Saving exam record:', recordsJson);
      
      return true;
    } catch (error) {
      console.error('Failed to save exam record:', error);
      return false;
    }
  }

  /**
   * 获取考核记录列表
   */
  public async getExamRecords(): Promise<ExamRecordModel[]> {
    try {
      // 这里应该从数据库读取，目前返回模拟数据
      const records: ExamRecordModel[] = [];
      
      // 模拟一些历史记录
      const record1 = new ExamRecordModel();
      record1.id = 1;
      record1.mode = ExamMode.QUICK;
      record1.score = 85;
      record1.totalProblems = 5;
      record1.correctCount = 4;
      record1.timeUsed = 12 * 60; // 12分钟
      record1.startTime = new Date(Date.now() - 24 * 60 * 60 * 1000); // 昨天
      record1.endTime = new Date(Date.now() - 24 * 60 * 60 * 1000 + 12 * 60 * 1000);
      
      const record2 = new ExamRecordModel();
      record2.id = 2;
      record2.mode = ExamMode.STANDARD;
      record2.score = 92;
      record2.totalProblems = 10;
      record2.correctCount = 9;
      record2.timeUsed = 25 * 60; // 25分钟
      record2.startTime = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000); // 一周前
      record2.endTime = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000 + 25 * 60 * 1000);
      
      records.push(record1, record2);
      return records;
    } catch (error) {
      console.error('Failed to get exam records:', error);
      return [];
    }
  }

  /**
   * 根据ID获取考核记录
   */
  public async getExamRecordById(id: number): Promise<ExamRecordModel | null> {
    try {
      const records = await this.getExamRecords();
      const record = records.find(r => r.id === id);
      return record || null;
    } catch (error) {
      console.error('Failed to get exam record by id:', error);
      return null;
    }
  }
}

// 考核模式配置接口
interface ExamModeConfig {
  problemCount: number;
  timeLimit: number;
  difficultyDistribution: Record<ProblemDifficulty, number>;
}

// 题目数据接口
interface ProblemData {
  id: number;
  title: string;
  difficulty: ProblemDifficulty;
  category: ProblemCategory;
}