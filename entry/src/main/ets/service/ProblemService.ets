import { ProblemModel, ProblemCategory } from '../model/ProblemModel';
import { ProblemDao } from '../dao/ProblemDao';
import { ProblemMockData } from '../mock/ProblemMockData';

export class ProblemService {
  private problemDao: ProblemDao = new ProblemDao();

  constructor() {}

  // 获取所有题目分类
  async getCategories(): Promise<string[]> {
    try {
      // 从模拟数据中获取所有分类
      const allProblems = ProblemMockData.getAllProblems();
      const categories = new Set<ProblemCategory>();
      
      for (const problem of allProblems) {
        categories.add(problem.category);
      }
      
      // 将英文枚举值转换为中文分类名
      const chineseCategories: string[] = [];
      for (const category of Array.from(categories)) {
        const chineseName = this.getCategoryChineseName(category);
        if (chineseName) {
          chineseCategories.push(chineseName);
        }
      }
      
      return chineseCategories;
    } catch (error) {
      console.error('Failed to get categories:', error);
      return ['数组', '字符串', '链表', '二叉树', '动态规划'];
    }
  }

  // 根据分类获取题目
  async getProblemsByCategory(categoryName: string): Promise<ProblemModel[]> {
    try {
      // 将分类名称转换为枚举值
      const category = this.getCategoryByName(categoryName);
      if (!category) {
        return [];
      }

      // 从模拟数据中获取该分类的题目
      const allProblems = ProblemMockData.getAllProblems();
      return allProblems.filter(problem => problem.category === category);
    } catch (error) {
      console.error('Failed to get problems by category:', error);
      return [];
    }
  }

  // 根据分类名称获取分类枚举
  private getCategoryByName(categoryName: string): ProblemCategory | null {
    switch (categoryName) {
      case '数组':
        return ProblemCategory.ARRAY;
      case '字符串':
        return ProblemCategory.STRING;
      case '链表':
        return ProblemCategory.LINKED_LIST;
      case '二叉树':
        return ProblemCategory.BINARY_TREE;
      case '双指针':
        return ProblemCategory.TWO_POINTERS;
      case '二分查找':
        return ProblemCategory.BINARY_SEARCH;
      case '数学':
        return ProblemCategory.MATH;
      case '动态规划':
        return ProblemCategory.DYNAMIC_PROGRAMMING;
      case '栈':
        return ProblemCategory.STACK;
      case '哈希表':
        return ProblemCategory.HASH_TABLE;
      case '回溯':
        return ProblemCategory.BACKTRACKING;
      case '贪心':
        return ProblemCategory.GREEDY;
      case '位运算':
        return ProblemCategory.BIT_MANIPULATION;
      case '设计':
        return ProblemCategory.DESIGN;
      case '分治':
        return ProblemCategory.DIVIDE_CONQUER;
      case '滑动窗口':
        return ProblemCategory.SLIDING_WINDOW;
      case '前缀和':
        return ProblemCategory.PREFIX_SUM;
      case '单调栈':
        return ProblemCategory.MONOTONIC_STACK;
      case '字典树':
        return ProblemCategory.TRIE;
      case '图':
        return ProblemCategory.GRAPH;
      case '排序':
        return ProblemCategory.SORT;
      case '递归':
        return ProblemCategory.RECURSION;
      case '堆':
        return ProblemCategory.HEAP;
      default:
        return null;
    }
  }

  // 根据分类枚举获取中文分类名
  private getCategoryChineseName(category: ProblemCategory): string | null {
    switch (category) {
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
      case ProblemCategory.RECURSION:
        return '递归';
      case ProblemCategory.HEAP:
        return '堆';
      case ProblemCategory.QUEUE:
        return '队列';
      default:
        return null;
    }
  }

  // 获取题目详情
  async getProblemById(id: number): Promise<ProblemModel | null> {
    try {
      return ProblemMockData.getProblemById(id);
    } catch (error) {
      console.error('Failed to get problem by id:', error);
      return null;
    }
  }

  // 获取所有题目
  async getAllProblems(): Promise<ProblemModel[]> {
    try {
      return ProblemMockData.getAllProblems();
    } catch (error) {
      console.error('Failed to get all problems:', error);
      return [];
    }
  }
}