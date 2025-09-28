import { ProblemModel, ProblemDifficulty, ProblemCategory, ChoiceOption, ProblemSource } from '../model/ProblemModel';

/**
 * 题目Mock数据
 * 包含各种算法题目的完整数据，包括题目描述、选择题选项、答案解析等
 */
export class ProblemMockData {
  /**
   * 获取所有题目数据
   */
  static getAllProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 数组类题目 (20道)
    problems.push(...ProblemMockData.getArrayProblems());

    // 字符串类题目 (20道)
    problems.push(...ProblemMockData.getStringProblems());

    // 链表类题目 (20道)
    problems.push(...ProblemMockData.getLinkedListProblems());

    // 二叉树类题目 (20道)
    problems.push(...ProblemMockData.getBinaryTreeProblems());

    // 动态规划类题目 (20道)
    problems.push(...ProblemMockData.getDynamicProgrammingProblems());

    // 双指针类题目 (20道)
    problems.push(...ProblemMockData.getTwoPointersProblems());

    // 二分查找类题目 (20道)
    problems.push(...ProblemMockData.getBinarySearchProblems());

    // 栈类题目 (20道)
    problems.push(...ProblemMockData.getStackProblems());

    // 数学算法题目 (20道)
    problems.push(...ProblemMockData.getMathProblems());

    // 哈希表类题目 (15道)
    problems.push(...ProblemMockData.getHashTableProblems());

    // 回溯算法类题目 (15道)
    problems.push(...ProblemMockData.getBacktrackingProblems());

    // 贪心算法类题目 (15道)
    problems.push(...ProblemMockData.getGreedyProblems());

    // 位运算类题目 (12道)
    problems.push(...ProblemMockData.getBitManipulationProblems());

    // 设计题类题目 (10道)
    problems.push(...ProblemMockData.getDesignProblems());

    // 分治算法类题目 (10道)
    problems.push(...ProblemMockData.getDivideConquerProblems());

    // 滑动窗口类题目 (12道)
    problems.push(...ProblemMockData.getSlidingWindowProblems());

    // 前缀和类题目 (10道)
    problems.push(...ProblemMockData.getPrefixSumProblems());

    // 单调栈类题目 (10道)
    problems.push(...ProblemMockData.getMonotonicStackProblems());

    // 字典树类题目 (10道)
    problems.push(...ProblemMockData.getTrieProblems());

    // 图类题目 (10道)
    problems.push(...ProblemMockData.getGraphProblems());

    // 排序类题目 (10道)
    problems.push(...ProblemMockData.getSortProblems());

    return problems;
  }

  /**
   * 根据ID获取题目
   */
  static getProblemById(id: number): ProblemModel | null {
    const allProblems = ProblemMockData.getAllProblems();
    const problem = allProblems.find(p => p.id === id);
    return problem || null;
  }

  /**
   * 根据分类获取题目
   */
  static getProblemsByCategory(category: ProblemCategory): ProblemModel[] {
    const allProblems = ProblemMockData.getAllProblems();
    return allProblems.filter(p => p.category === category);
  }

  /**
   * 数组类题目
   */
  private static getArrayProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 两数之和
    const twoSum = new ProblemModel();
    twoSum.id = 1;
    twoSum.title = '两数之和';
    twoSum.description =
      '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。\n\n你可以按任意顺序返回答案。';
    twoSum.difficulty = ProblemDifficulty.EASY;
    twoSum.category = ProblemCategory.ARRAY;
    twoSum.source = ProblemSource.INTERVIEW; // 设置为面试题
    twoSum.choices = [
      { id: 'A', text: '使用两层循环遍历数组，时间复杂度O(n²)', isCorrect: false },
      { id: 'B', text: '先排序再使用双指针，时间复杂度O(nlogn)', isCorrect: false },
      { id: 'C', text: '使用哈希表存储数组值和索引，一次遍历完成，时间复杂度O(n)', isCorrect: true },
      { id: 'D', text: '使用递归分治算法，时间复杂度O(nlogn)', isCorrect: false }
    ];
    twoSum.explanation =
      '最优解法是使用哈希表。遍历数组时，对于每个元素nums[i]，计算target - nums[i]，然后在哈希表中查找这个值。如果找到，返回两个索引；如果没找到，将当前元素和索引存入哈希表。这样只需要一次遍历，时间复杂度为O(n)，空间复杂度为O(n)。';
    twoSum.hint = '考虑使用哈希表来存储已经遍历过的元素及其索引';

    // 添加多语言代码
    twoSum.multiLanguageCode = {
      java: `public int[] twoSum(int[] nums, int target) {
    // 使用哈希表存储数组值和索引
    Map<Integer, Integer> map = new HashMap<>();
    
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement)) {
            return new int[]{map.get(complement), i};
        }
        map.put(nums[i], i);
    }
    
    return new int[0];
}

// 时间复杂度: O(n)
// 空间复杂度: O(n)`,
      python: `def two_sum(nums, target):
    """
    给定一个整数数组 nums 和一个整数目标值 target，
    请你在该数组中找出和为目标值 target 的那两个整数，
    并返回它们的数组下标。
    """
    # 使用哈希表存储数组值和索引
    num_map = {}
    
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_map:
            return [num_map[complement], i]
        num_map[num] = i
    
    return []

# 时间复杂度: O(n)
# 空间复杂度: O(n)`,
      cpp: `#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        // 使用哈希表存储数组值和索引
        unordered_map<int, int> numMap;
        
        for (int i = 0; i < nums.size(); i++) {
            int complement = target - nums[i];
            if (numMap.find(complement) != numMap.end()) {
                return {numMap[complement], i};
            }
            numMap[nums[i]] = i;
        }
        
        return {};
    }
};

// 时间复杂度: O(n)
// 空间复杂度: O(n)`
    };

    problems.push(twoSum);

    // 三数之和
    const threeSum = new ProblemModel();
    threeSum.id = 2;
    threeSum.title = '三数之和';
    threeSum.description =
      '给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。\n\n注意：答案中不可以包含重复的三元组。';
    threeSum.difficulty = ProblemDifficulty.MEDIUM;
    threeSum.category = ProblemCategory.ARRAY;
    threeSum.source = ProblemSource.INTERVIEW; // 设置为面试题
    threeSum.choices = [
      { id: 'A', text: '使用三层循环暴力求解，时间复杂度O(n³)', isCorrect: false },
      { id: 'B', text: '使用哈希表存储所有两数之和，时间复杂度O(n²)', isCorrect: false },
      { id: 'C', text: '使用递归回溯算法，时间复杂度O(2^n)', isCorrect: false },
      { id: 'D', text: '先排序，然后固定一个数，用双指针找另外两个数，时间复杂度O(n²)', isCorrect: true }
    ];
    threeSum.explanation =
      '最优解法是排序+双指针。首先对数组排序，然后遍历数组，对于每个元素nums[i]，使用双指针在剩余数组中寻找两个数使得三数之和为0。排序后可以很容易跳过重复元素，避免重复的三元组。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSum.hint = '先排序，然后固定一个数，用双指针技巧找另外两个数';
    problems.push(threeSum);

    // 最大子数组和
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 3;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description =
      '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。\n\n子数组是数组中的一个连续部分。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.ARRAY;
    maxSubArray.source = ProblemSource.INTERVIEW; // 设置为面试题
    maxSubArray.choices = [
      { id: 'A', text: '使用动态规划（Kadane算法），时间复杂度O(n)', isCorrect: true },
      { id: 'B', text: '使用两层循环枚举所有子数组，时间复杂度O(n²)', isCorrect: false },
      { id: 'C', text: '使用分治算法，时间复杂度O(nlogn)', isCorrect: false },
      { id: 'D', text: '使用贪心算法，时间复杂度O(nlogn)', isCorrect: false }
    ];
    maxSubArray.explanation =
      'Kadane算法是最优解法。维护两个变量：当前子数组的最大和(currentSum)和全局最大和(maxSum)。遍历数组，对于每个元素，选择是加入当前子数组还是重新开始一个新的子数组。状态转移方程：currentSum = max(nums[i], currentSum + nums[i])。时间复杂度O(n)，空间复杂度O(1)。';
    maxSubArray.hint = '考虑动态规划，当前位置的最大子数组和只依赖于前一个位置';

    // 添加多语言代码
    maxSubArray.multiLanguageCode = {
      java: `public int maxSubArray(int[] nums) {
    // Kadane算法 - 动态规划
    int maxSum = nums[0];
    int currentSum = nums[0];
    
    for (int i = 1; i < nums.length; i++) {
        // 选择是加入当前子数组还是重新开始
        currentSum = Math.max(nums[i], currentSum + nums[i]);
        maxSum = Math.max(maxSum, currentSum);
    }
    
    return maxSum;
}

// 时间复杂度: O(n)
// 空间复杂度: O(1)`,
      python: `def max_sub_array(nums):
    """
    使用Kadane算法找到最大子数组和
    """
    # 初始化最大和和当前和
    max_sum = nums[0]
    current_sum = nums[0]
    
    for i in range(1, len(nums)):
        # 选择是加入当前子数组还是重新开始
        current_sum = max(nums[i], current_sum + nums[i])
        max_sum = max(max_sum, current_sum)
    
    return max_sum

# 时间复杂度: O(n)
# 空间复杂度: O(1)`,
      cpp: `#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        // Kadane算法 - 动态规划
        int maxSum = nums[0];
        int currentSum = nums[0];
        
        for (int i = 1; i < nums.size(); i++) {
            // 选择是加入当前子数组还是重新开始
            currentSum = max(nums[i], currentSum + nums[i]);
            maxSum = max(maxSum, currentSum);
        }
        
        return maxSum;
    }
};

// 时间复杂度: O(n)
// 空间复杂度: O(1)`
    };

    problems.push(maxSubArray);

    // 合并两个有序数组
    const mergeSortedArray = new ProblemModel();
    mergeSortedArray.id = 21;
    mergeSortedArray.title = '合并两个有序数组';
    mergeSortedArray.description =
      '给你两个按非递减顺序排列的整数数组nums1和nums2，另有两个整数m和n，分别表示nums1和nums2中元素的数目。请你合并nums2到nums1中，使合并后的数组同样按非递减顺序排列。';
    mergeSortedArray.difficulty = ProblemDifficulty.EASY;
    mergeSortedArray.category = ProblemCategory.ARRAY;
    mergeSortedArray.choices = [
      { id: 'A', text: '从前往后合并，需要额外空间', isCorrect: false },
      { id: 'B', text: '先合并再排序', isCorrect: false },
      { id: 'C', text: '从后往前合并，利用nums1的额外空间', isCorrect: true },
      { id: 'D', text: '使用归并排序算法', isCorrect: false }
    ];
    mergeSortedArray.explanation =
      '从后往前合并是最优解法。由于nums1有足够的空间，从两个数组的末尾开始比较，将较大的元素放到nums1的末尾。这样避免了覆盖nums1中未处理的元素。时间复杂度O(m+n)，空间复杂度O(1)。';
    mergeSortedArray.hint = '从后往前合并，避免覆盖未处理的元素';
    mergeSortedArray.multiLanguageCode = {
      java: `class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        // 从后往前合并，避免覆盖未处理的元素
        int i = m - 1;  // nums1的最后一个有效元素
        int j = n - 1;  // nums2的最后一个元素
        int k = m + n - 1;  // 合并后数组的最后位置
        
        // 从后往前比较并放置元素
        while (i >= 0 && j >= 0) {
            if (nums1[i] > nums2[j]) {
                nums1[k] = nums1[i];
                i--;
            } else {
                nums1[k] = nums2[j];
                j--;
            }
            k--;
        }
        
        // 如果nums2还有剩余元素，复制到nums1
        while (j >= 0) {
            nums1[k] = nums2[j];
            j--;
            k--;
        }
        // nums1的剩余元素已经在正确位置，无需处理
    }
}

// 时间复杂度: O(m + n)
// 空间复杂度: O(1)`,
      python: `def merge(nums1, m, nums2, n):
    """
    从后往前合并两个有序数组
    """
    # 三个指针：i指向nums1有效元素末尾，j指向nums2末尾，k指向合并位置
    i, j, k = m - 1, n - 1, m + n - 1
    
    # 从后往前比较并放置元素
    while i >= 0 and j >= 0:
        if nums1[i] > nums2[j]:
            nums1[k] = nums1[i]
            i -= 1
        else:
            nums1[k] = nums2[j]
            j -= 1
        k -= 1
    
    # 如果nums2还有剩余元素，复制到nums1
    while j >= 0:
        nums1[k] = nums2[j]
        j -= 1
        k -= 1

# 时间复杂度: O(m + n)
# 空间复杂度: O(1)`,
      cpp: `#include <vector>
using namespace std;

class Solution {
public:
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        // 从后往前合并，避免覆盖
        int i = m - 1;  // nums1的最后一个有效元素
        int j = n - 1;  // nums2的最后一个元素
        int k = m + n - 1;  // 合并后数组的最后位置
        
        // 从后往前比较并放置元素
        while (i >= 0 && j >= 0) {
            if (nums1[i] > nums2[j]) {
                nums1[k] = nums1[i];
                i--;
            } else {
                nums1[k] = nums2[j];
                j--;
            }
            k--;
        }
        
        // 如果nums2还有剩余元素，复制到nums1
        while (j >= 0) {
            nums1[k] = nums2[j];
            j--;
            k--;
        }
    }
};

// 时间复杂度: O(m + n)
// 空间复杂度: O(1)`
    };
    problems.push(mergeSortedArray);

    // 移除元素
    const removeElement = new ProblemModel();
    removeElement.id = 22;
    removeElement.title = '移除元素';
    removeElement.description =
      '给你一个数组nums和一个值val，你需要原地移除所有数值等于val的元素，并返回移除后数组的新长度。';
    removeElement.difficulty = ProblemDifficulty.EASY;
    removeElement.category = ProblemCategory.ARRAY;
    removeElement.choices = [
      { id: 'A', text: '创建新数组存储不等于val的元素', isCorrect: false },
      { id: 'B', text: '使用额外的标记数组', isCorrect: false },
      { id: 'C', text: '从后往前遍历并删除元素', isCorrect: false },
      { id: 'D', text: '使用双指针，快指针遍历，慢指针记录有效位置', isCorrect: true }
    ];
    removeElement.explanation =
      '双指针是最优解法。使用快慢指针，快指针遍历数组，当快指针指向的元素不等于val时，将其复制到慢指针位置，然后慢指针前进。最终慢指针的位置就是新数组的长度。时间复杂度O(n)，空间复杂度O(1)。';
    removeElement.hint = '使用双指针技巧，原地修改数组';
    problems.push(removeElement);

    // 搜索插入位置
    const searchInsert = new ProblemModel();
    searchInsert.id = 23;
    searchInsert.title = '搜索插入位置';
    searchInsert.description =
      '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。';
    searchInsert.difficulty = ProblemDifficulty.EASY;
    searchInsert.category = ProblemCategory.ARRAY;
    searchInsert.choices = [
      { id: 'A', text: '线性搜索，时间复杂度O(n)', isCorrect: false },
      { id: 'B', text: '从后往前搜索', isCorrect: false },
      { id: 'C', text: '二分搜索，时间复杂度O(logn)', isCorrect: true },
      { id: 'D', text: '使用哈希表存储索引', isCorrect: false }
    ];
    searchInsert.explanation =
      '由于数组已排序，使用二分搜索是最优解法。如果找到目标值，返回其索引；如果没找到，left指针的位置就是插入位置。时间复杂度O(logn)，空间复杂度O(1)。';
    searchInsert.hint = '利用数组已排序的特性，使用二分搜索';
    searchInsert.multiLanguageCode = {
      java: `class Solution {
    public int searchInsert(int[] nums, int target) {
        // 二分搜索找到插入位置
        int left = 0;
        int right = nums.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) {
                return mid;  // 找到目标值，返回索引
            } else if (nums[mid] < target) {
                left = mid + 1;  // 目标值在右半部分
            } else {
                right = mid - 1;  // 目标值在左半部分
            }
        }
        
        // 没找到目标值，left就是插入位置
        return left;
    }
}

// 时间复杂度: O(log n)
// 空间复杂度: O(1)`,
      python: `def search_insert(nums, target):
    """
    使用二分搜索找到目标值或插入位置
    """
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid  # 找到目标值
        elif nums[mid] < target:
            left = mid + 1  # 目标值在右半部分
        else:
            right = mid - 1  # 目标值在左半部分
    
    # 没找到目标值，left就是插入位置
    return left

# 时间复杂度: O(log n)
# 空间复杂度: O(1)`,
      cpp: `#include <vector>
using namespace std;

class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        // 二分搜索
        int left = 0;
        int right = nums.size() - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) {
                return mid;  // 找到目标值
            } else if (nums[mid] < target) {
                left = mid + 1;  // 目标值在右半部分
            } else {
                right = mid - 1;  // 目标值在左半部分
            }
        }
        
        // 没找到目标值，left就是插入位置
        return left;
    }
};

// 时间复杂度: O(log n)
// 空间复杂度: O(1)`
    };
    problems.push(searchInsert);

    // 加一
    const plusOne = new ProblemModel();
    plusOne.id = 24;
    plusOne.title = '加一';
    plusOne.description =
      '给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。最高位数字存放在数组的首位，数组中每个元素只存储单个数字。';
    plusOne.difficulty = ProblemDifficulty.EASY;
    plusOne.category = ProblemCategory.ARRAY;
    plusOne.choices = [
      { id: 'A', text: '转换为整数加一再转回数组', isCorrect: false },
      { id: 'B', text: '从后往前处理进位，特殊处理全9的情况', isCorrect: true },
      { id: 'C', text: '使用字符串处理', isCorrect: false },
      { id: 'D', text: '递归处理每一位', isCorrect: false }
    ];
    plusOne.explanation =
      '从数组末尾开始处理进位。如果当前位小于9，直接加一返回；如果等于9，设为0继续处理前一位。如果所有位都是9，需要创建新数组，首位为1，其余为0。时间复杂度O(n)，空间复杂度O(1)或O(n)。';
    plusOne.hint = '从后往前处理，注意进位和全9的特殊情况';
    problems.push(plusOne);

    // 两数之和II
    const twoSumII = new ProblemModel();
    twoSumII.id = 25;
    twoSumII.title = '两数之和II - 输入有序数组';
    twoSumII.description =
      '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。';
    twoSumII.difficulty = ProblemDifficulty.MEDIUM;
    twoSumII.category = ProblemCategory.ARRAY;
    twoSumII.choices = [
      { id: 'A', text: '使用双指针，时间复杂度O(n)', isCorrect: true },
      { id: 'B', text: '使用哈希表，时间复杂度O(n)', isCorrect: false },
      { id: 'C', text: '二重循环暴力搜索', isCorrect: false },
      { id: 'D', text: '二分搜索每个元素的补数', isCorrect: false }
    ];
    twoSumII.explanation =
      '由于数组已排序，使用双指针是最优解法。左指针指向开头，右指针指向末尾。如果两数之和等于目标值，返回索引；如果小于目标值，左指针右移；如果大于目标值，右指针左移。时间复杂度O(n)，空间复杂度O(1)。';
    twoSumII.hint = '利用数组有序的特性，使用双指针技巧';
    problems.push(twoSumII);

    // 旋转数组
    const rotateArray = new ProblemModel();
    rotateArray.id = 26;
    rotateArray.title = '旋转数组';
    rotateArray.description = '给定一个数组，将数组中的元素向右移动k个位置，其中k是非负数。';
    rotateArray.difficulty = ProblemDifficulty.MEDIUM;
    rotateArray.category = ProblemCategory.ARRAY;
    rotateArray.choices = [
      { id: 'A', text: '使用额外数组存储结果', isCorrect: false },
      { id: 'B', text: '逐个移动元素k次', isCorrect: false },
      { id: 'C', text: '使用环形替换', isCorrect: false },
      { id: 'D', text: '三次反转：整体反转，前k个反转，后n-k个反转', isCorrect: true }
    ];
    rotateArray.explanation =
      '三次反转是最优的原地算法。首先反转整个数组，然后反转前k个元素，最后反转后n-k个元素。这样就完成了向右旋转k位。时间复杂度O(n)，空间复杂度O(1)。';
    rotateArray.hint = '考虑三次反转的技巧：整体反转，然后分段反转';
    problems.push(rotateArray);

    // 存在重复元素
    const containsDuplicate = new ProblemModel();
    containsDuplicate.id = 27;
    containsDuplicate.title = '存在重复元素';
    containsDuplicate.description =
      '给你一个整数数组nums。如果任一值在数组中出现至少两次，返回true；如果数组中每个元素都不相同，则返回false。';
    containsDuplicate.difficulty = ProblemDifficulty.EASY;
    containsDuplicate.category = ProblemCategory.ARRAY;
    containsDuplicate.choices = [
      { id: 'A', text: '先排序再检查相邻元素', isCorrect: false },
      { id: 'B', text: '双重循环比较所有元素对', isCorrect: false },
      { id: 'C', text: '使用哈希表记录出现过的元素', isCorrect: true },
      { id: 'D', text: '使用位运算标记', isCorrect: false }
    ];
    containsDuplicate.explanation =
      '使用哈希表是最直接的解法。遍历数组，如果元素已在哈希表中，返回true；否则将元素加入哈希表。时间复杂度O(n)，空间复杂度O(n)。排序方法时间复杂度为O(nlogn)，但空间复杂度为O(1)。';
    containsDuplicate.hint = '使用哈希表快速检查元素是否已出现';
    problems.push(containsDuplicate);

    // 只出现一次的数字
    const singleNumber = new ProblemModel();
    singleNumber.id = 28;
    singleNumber.title = '只出现一次的数字';
    singleNumber.description =
      '给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。';
    singleNumber.difficulty = ProblemDifficulty.EASY;
    singleNumber.category = ProblemCategory.ARRAY;
    singleNumber.choices = [
      { id: 'A', text: '使用哈希表统计每个元素的出现次数', isCorrect: false },
      { id: 'B', text: '先排序再查找单独的元素', isCorrect: false },
      { id: 'C', text: '使用集合存储，重复则删除', isCorrect: false },
      { id: 'D', text: '使用异或运算，相同数字异或为0', isCorrect: true }
    ];
    singleNumber.explanation =
      '异或运算是最优解法。利用异或运算的性质：a⊕a=0，a⊕0=a，以及异或运算满足交换律和结合律。将所有数字进行异或运算，相同的数字会相互抵消，最终结果就是只出现一次的数字。时间复杂度O(n)，空间复杂度O(1)。';
    singleNumber.hint = '利用异或运算的性质：相同数字异或为0';
    problems.push(singleNumber);

    // 移动零
    const moveZeroes = new ProblemModel();
    moveZeroes.id = 29;
    moveZeroes.title = '移动零';
    moveZeroes.description =
      '给定一个数组nums，编写一个函数将所有0移动到数组的末尾，同时保持非零元素的相对顺序。请注意，必须在不复制数组的情况下原地对数组进行操作。';
    moveZeroes.difficulty = ProblemDifficulty.EASY;
    moveZeroes.category = ProblemCategory.ARRAY;
    moveZeroes.choices = [
      { id: 'A', text: '创建新数组，先放非零元素再放零', isCorrect: false },
      { id: 'B', text: '使用双指针，一个记录非零元素位置，一个遍历数组', isCorrect: true },
      { id: 'C', text: '从后往前遍历，遇到零就删除并在末尾添加', isCorrect: false },
      { id: 'D', text: '使用冒泡排序将零移到末尾', isCorrect: false }
    ];
    moveZeroes.explanation =
      '双指针是最优解法。使用慢指针记录下一个非零元素应该放置的位置，快指针遍历数组。当快指针遇到非零元素时，将其移动到慢指针位置，然后慢指针前进。最后将慢指针后面的位置都设为0。时间复杂度O(n)，空间复杂度O(1)。';
    moveZeroes.hint = '使用双指针，保持非零元素的相对顺序';
    problems.push(moveZeroes);

    // 买卖股票的最佳时机
    const maxProfit = new ProblemModel();
    maxProfit.id = 30;
    maxProfit.title = '买卖股票的最佳时机';
    maxProfit.description =
      '给定一个数组prices，它的第i个元素prices[i]表示一支给定股票第i天的价格。你只能选择某一天买入这只股票，并选择在未来的某一天卖出该股票。设计一个算法来计算你所能获取的最大利润。';
    maxProfit.difficulty = ProblemDifficulty.EASY;
    maxProfit.category = ProblemCategory.ARRAY;
    maxProfit.choices = [
      { id: 'A', text: '双重循环枚举所有买卖组合', isCorrect: false },
      { id: 'B', text: '使用动态规划，状态表示持有/不持有股票', isCorrect: false },
      { id: 'C', text: '一次遍历，记录最低价格和最大利润', isCorrect: true },
      { id: 'D', text: '先找到最低点和最高点', isCorrect: false }
    ];
    maxProfit.explanation =
      '一次遍历是最优解法。维护两个变量：到目前为止的最低价格和最大利润。遍历价格数组，更新最低价格，并计算当前价格减去最低价格的利润，更新最大利润。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfit.hint = '记录历史最低价格，计算当前价格的最大利润';
    problems.push(maxProfit);

    // 多数元素
    const majorityElement = new ProblemModel();
    majorityElement.id = 31;
    majorityElement.title = '多数元素';
    majorityElement.description =
      '给定一个大小为n的数组nums，返回其中的多数元素。多数元素是指在数组中出现次数大于⌊n/2⌋的元素。';
    majorityElement.difficulty = ProblemDifficulty.EASY;
    majorityElement.category = ProblemCategory.ARRAY;
    majorityElement.choices = [
      { id: 'A', text: '使用Boyer-Moore投票算法', isCorrect: true },
      { id: 'B', text: '使用哈希表统计每个元素的出现次数', isCorrect: false },
      { id: 'C', text: '先排序，中间元素就是多数元素', isCorrect: false },
      { id: 'D', text: '随机选择元素并验证', isCorrect: false }
    ];
    majorityElement.explanation =
      'Boyer-Moore投票算法是最优解法。维护一个候选元素和计数器，遍历数组时，如果当前元素等于候选元素则计数器加1，否则减1。当计数器为0时，更换候选元素。由于多数元素出现次数超过一半，最终的候选元素就是多数元素。时间复杂度O(n)，空间复杂度O(1)。';
    majorityElement.hint = '使用投票算法，多数元素的票数会超过其他所有元素';
    problems.push(majorityElement);

    // 缺失数字
    const missingNumber = new ProblemModel();
    missingNumber.id = 32;
    missingNumber.title = '缺失数字';
    missingNumber.description = '给定一个包含[0,n]中n个数的数组nums，找出[0,n]这个范围内没有出现在数组中的那个数。';
    missingNumber.difficulty = ProblemDifficulty.EASY;
    missingNumber.category = ProblemCategory.ARRAY;
    missingNumber.choices = [
      { id: 'A', text: '使用哈希表记录出现的数字', isCorrect: false },
      { id: 'B', text: '使用数学公式：期望和减去实际和', isCorrect: true },
      { id: 'C', text: '先排序再查找缺失位置', isCorrect: false },
      { id: 'D', text: '使用异或运算', isCorrect: false }
    ];
    missingNumber.explanation =
      '数学方法是最直观的解法。计算0到n的期望和：n*(n+1)/2，然后减去数组中所有元素的和，差值就是缺失的数字。时间复杂度O(n)，空间复杂度O(1)。异或方法也可以，但数学方法更容易理解。';
    missingNumber.hint = '计算期望和与实际和的差值';
    problems.push(missingNumber);

    // 第三大的数
    const thirdMax = new ProblemModel();
    thirdMax.id = 33;
    thirdMax.title = '第三大的数';
    thirdMax.description = '给你一个非空数组，返回此数组中第三大的数。如果不存在，则返回数组中最大的数。';
    thirdMax.difficulty = ProblemDifficulty.EASY;
    thirdMax.category = ProblemCategory.ARRAY;
    thirdMax.choices = [
      { id: 'A', text: '先排序再取第三大的数', isCorrect: false },
      { id: 'B', text: '维护三个变量记录前三大的数', isCorrect: true },
      { id: 'C', text: '使用堆排序找第三大', isCorrect: false },
      { id: 'D', text: '使用集合去重再排序', isCorrect: false }
    ];
    thirdMax.explanation =
      '维护三个变量是最优解法。遍历数组，维护first（最大）、second（第二大）、third（第三大）三个变量。遇到更大的数时更新这些变量。注意处理重复数字和边界情况。时间复杂度O(n)，空间复杂度O(1)。';
    thirdMax.hint = '维护三个变量记录最大、第二大、第三大的数';
    problems.push(thirdMax);

    // 找到所有数组中消失的数字
    const findDisappearedNumbers = new ProblemModel();
    findDisappearedNumbers.id = 34;
    findDisappearedNumbers.title = '找到所有数组中消失的数字';
    findDisappearedNumbers.description =
      '给你一个含n个整数的数组nums，其中nums[i]在区间[1,n]内。请你找出所有在[1,n]范围内但没有出现在nums中的数字，并以数组的形式返回结果。';
    findDisappearedNumbers.difficulty = ProblemDifficulty.EASY;
    findDisappearedNumbers.category = ProblemCategory.ARRAY;
    findDisappearedNumbers.choices = [
      { id: 'A', text: '使用哈希表记录出现的数字', isCorrect: false },
      { id: 'B', text: '原地修改：将nums[i]-1位置的数字标记为负数', isCorrect: true },
      { id: 'C', text: '使用额外数组标记', isCorrect: false },
      { id: 'D', text: '先排序再查找缺失数字', isCorrect: false }
    ];
    findDisappearedNumbers.explanation =
      '原地修改是最优解法。遍历数组，对于每个数字nums[i]，将nums[|nums[i]|-1]标记为负数（如果还不是负数的话）。第二次遍历时，如果nums[i]是正数，说明i+1这个数字缺失。时间复杂度O(n)，空间复杂度O(1)。';
    findDisappearedNumbers.hint = '利用数组索引，原地标记出现过的数字';
    problems.push(findDisappearedNumbers);

    // 最大连续1的个数
    const findMaxConsecutiveOnes = new ProblemModel();
    findMaxConsecutiveOnes.id = 35;
    findMaxConsecutiveOnes.title = '最大连续1的个数';
    findMaxConsecutiveOnes.description = '给定一个二进制数组nums，计算其中最大连续1的个数。';
    findMaxConsecutiveOnes.difficulty = ProblemDifficulty.EASY;
    findMaxConsecutiveOnes.category = ProblemCategory.ARRAY;
    findMaxConsecutiveOnes.choices = [
      { id: 'A', text: '一次遍历，维护当前连续1的长度和最大长度', isCorrect: true },
      { id: 'B', text: '使用双指针找每段连续的1', isCorrect: false },
      { id: 'C', text: '转换为字符串，按0分割后找最长段', isCorrect: false },
      { id: 'D', text: '使用递归分治', isCorrect: false }
    ];
    findMaxConsecutiveOnes.explanation =
      '一次遍历是最直接的解法。维护两个变量：当前连续1的长度和历史最大长度。遇到1时增加当前长度，遇到0时重置当前长度为0，同时更新最大长度。时间复杂度O(n)，空间复杂度O(1)。';
    findMaxConsecutiveOnes.hint = '遍历数组，记录当前连续1的长度和历史最大值';
    problems.push(findMaxConsecutiveOnes);

    // 数组的度
    const findShortestSubArray = new ProblemModel();
    findShortestSubArray.id = 36;
    findShortestSubArray.title = '数组的度';
    findShortestSubArray.description =
      '给定一个非空且只包含非负数字的数组nums，数组的度的定义是指数组里任一元素出现频数的最大值。你的任务是在nums中找到与nums拥有相同大小的度的最短连续子数组，返回其长度。';
    findShortestSubArray.difficulty = ProblemDifficulty.EASY;
    findShortestSubArray.category = ProblemCategory.ARRAY;
    findShortestSubArray.choices = [
      { id: 'A', text: '使用哈希表记录每个元素的出现次数、首次和最后出现位置', isCorrect: true },
      { id: 'B', text: '枚举所有子数组，计算每个的度', isCorrect: false },
      { id: 'C', text: '先找到度，再用滑动窗口找最短子数组', isCorrect: false },
      { id: 'D', text: '使用双指针扩展窗口', isCorrect: false }
    ];
    findShortestSubArray.explanation =
      '使用哈希表是最优解法。遍历数组，记录每个元素的出现次数、首次出现位置和最后出现位置。然后找出出现次数最多的元素（可能有多个），计算它们对应的子数组长度（最后位置-首次位置+1），返回最小长度。时间复杂度O(n)，空间复杂度O(n)。';
    findShortestSubArray.hint = '记录每个元素的频次和首末位置，找出度最大且长度最短的子数组';
    problems.push(findShortestSubArray);

    // 托普利茨矩阵
    const isToeplitzMatrix = new ProblemModel();
    isToeplitzMatrix.id = 37;
    isToeplitzMatrix.title = '托普利茨矩阵';
    isToeplitzMatrix.description =
      '给你一个m x n的矩阵matrix。如果这个矩阵是托普利茨矩阵，返回true；否则，返回false。如果矩阵上每一条由左上到右下的对角线上的元素都相同，那么这个矩阵是托普利茨矩阵。';
    isToeplitzMatrix.difficulty = ProblemDifficulty.EASY;
    isToeplitzMatrix.category = ProblemCategory.ARRAY;
    isToeplitzMatrix.choices = [
      { id: 'A', text: '检查每个元素是否等于其左上角的元素', isCorrect: true },
      { id: 'B', text: '遍历每条对角线，检查元素是否相同', isCorrect: false },
      { id: 'C', text: '使用哈希表记录每条对角线的元素', isCorrect: false },
      { id: 'D', text: '转置矩阵后检查', isCorrect: false }
    ];
    isToeplitzMatrix.explanation =
      '检查相邻元素是最简单的方法。对于每个元素matrix[i][j]（除了第一行和第一列），检查它是否等于matrix[i-1][j-1]。如果所有这样的元素都相等，则矩阵是托普利茨矩阵。时间复杂度O(mn)，空间复杂度O(1)。';
    isToeplitzMatrix.hint = '检查每个元素是否等于其左上角的元素';
    problems.push(isToeplitzMatrix);

    // 重塑矩阵
    const matrixReshape = new ProblemModel();
    matrixReshape.id = 38;
    matrixReshape.title = '重塑矩阵';
    matrixReshape.description =
      '在MATLAB中，有一个非常有用的函数reshape，它可以将一个m x n矩阵重塑为另一个大小不同（r x c）的新矩阵，但保留其原始数据。给你一个由二维数组mat表示的m x n矩阵，以及两个正整数r和c，分别表示想要的重构的矩阵的行数和列数。';
    matrixReshape.difficulty = ProblemDifficulty.EASY;
    matrixReshape.category = ProblemCategory.ARRAY;
    matrixReshape.choices = [
      { id: 'A', text: '先检查元素总数是否匹配，然后按行优先顺序重新排列', isCorrect: true },
      { id: 'B', text: '使用数学公式直接计算新位置', isCorrect: false },
      { id: 'C', text: '先转换为一维数组，再重新构造二维数组', isCorrect: false },
      { id: 'D', text: '使用递归分治重塑', isCorrect: false }
    ];
    matrixReshape.explanation =
      '按行优先顺序重排是标准做法。首先检查m*n是否等于r*c，如果不等则返回原矩阵。然后创建新矩阵，按行优先顺序遍历原矩阵，将元素依次填入新矩阵。可以使用一个计数器或者数学公式来计算新位置。时间复杂度O(mn)，空间复杂度O(rc)。';
    matrixReshape.hint = '检查元素总数，按行优先顺序重新排列元素';
    problems.push(matrixReshape);

    // 杨辉三角
    const generate = new ProblemModel();
    generate.id = 39;
    generate.title = '杨辉三角';
    generate.description =
      '给定一个非负整数numRows，生成杨辉三角的前numRows行。在杨辉三角中，每个数是它左上方和右上方的数的和。';
    generate.difficulty = ProblemDifficulty.EASY;
    generate.category = ProblemCategory.ARRAY;
    generate.choices = [
      { id: 'A', text: '逐行生成，每行首尾为1，中间元素为上一行相邻两元素之和', isCorrect: true },
      { id: 'B', text: '使用组合数公式C(n,k)直接计算每个位置', isCorrect: false },
      { id: 'C', text: '使用递归生成每一行', isCorrect: false },
      { id: 'D', text: '使用动态规划自底向上构建', isCorrect: false }
    ];
    generate.explanation =
      '逐行生成是最直观的方法。第一行只有一个1，从第二行开始，每行的首尾都是1，中间的元素等于上一行对应位置和前一个位置的元素之和。时间复杂度O(numRows²)，空间复杂度O(1)（不计算结果数组）。';
    generate.hint = '每行首尾为1，中间元素等于上一行相邻两元素之和';
    problems.push(generate);

    // 有效的数独
    const isValidSudoku = new ProblemModel();
    isValidSudoku.id = 40;
    isValidSudoku.title = '有效的数独';
    isValidSudoku.description =
      '请你判断一个9x9的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。数字1-9在每一行只能出现一次。数字1-9在每一列只能出现一次。数字1-9在每一个以粗实线分隔的3x3宫内只能出现一次。';
    isValidSudoku.difficulty = ProblemDifficulty.MEDIUM;
    isValidSudoku.category = ProblemCategory.ARRAY;
    isValidSudoku.choices = [
      { id: 'A', text: '使用三个哈希表分别记录行、列、3x3宫格中出现的数字', isCorrect: true },
      { id: 'B', text: '对每个数字，检查其所在行、列、宫格是否有重复', isCorrect: false },
      { id: 'C', text: '使用位运算标记每行、列、宫格的数字状态', isCorrect: false },
      { id: 'D', text: '递归验证每个位置的合法性', isCorrect: false }
    ];
    isValidSudoku.explanation =
      '使用哈希表是最清晰的解法。创建三个哈希表数组，分别记录9行、9列、9个3x3宫格中出现的数字。遍历数独，对于每个非空格子，检查该数字是否已在对应的行、列、宫格中出现过。宫格索引可以用(i/3)*3+j/3计算。时间复杂度O(1)，空间复杂度O(1)。';
    isValidSudoku.hint = '分别检查行、列、3x3宫格中是否有重复数字';
    problems.push(isValidSudoku);

    return problems;
  }

  /**
   * 字符串类题目
   */
  private static getStringProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 有效的括号
    const validParentheses = new ProblemModel();
    validParentheses.id = 4;
    validParentheses.title = '有效的括号';
    validParentheses.description =
      '给定一个只包括 \'(\'，\')\'，\'[\'，\']\'，\'{\'，\'}\' 的字符串 s ，判断字符串是否有效。\n\n有效字符串需满足：\n1. 左括号必须用相同类型的右括号闭合。\n2. 左括号必须以正确的顺序闭合。';
    validParentheses.difficulty = ProblemDifficulty.EASY;
    validParentheses.category = ProblemCategory.STRING;
    validParentheses.source = ProblemSource.INTERVIEW; // 设置为面试题
    validParentheses.choices = [
      { id: 'A', text: '使用栈数据结构，遇到左括号入栈，遇到右括号出栈匹配', isCorrect: true },
      { id: 'B', text: '使用计数器分别统计各种括号的数量', isCorrect: false },
      { id: 'C', text: '使用递归算法逐个匹配括号', isCorrect: false },
      { id: 'D', text: '使用双指针从两端向中间匹配', isCorrect: false }
    ];
    validParentheses.explanation =
      '使用栈是最直观的解法。遍历字符串，遇到左括号就入栈，遇到右括号就检查栈顶是否为对应的左括号，如果是则出栈，否则返回false。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validParentheses.hint = '考虑使用栈来匹配括号的配对关系';
    problems.push(validParentheses);

    // 最长回文子串
    const longestPalindrome = new ProblemModel();
    longestPalindrome.id = 5;
    longestPalindrome.title = '最长回文子串';
    longestPalindrome.description =
      '给你一个字符串 s，找到 s 中最长的回文子串。\n\n回文字符串是正着读和倒着读都一样的字符串。';
    longestPalindrome.difficulty = ProblemDifficulty.MEDIUM;
    longestPalindrome.category = ProblemCategory.STRING;
    longestPalindrome.source = ProblemSource.INTERVIEW; // 设置为面试题
    longestPalindrome.choices = [
      { id: 'A', text: '暴力法：枚举所有子串并检查是否为回文，时间复杂度O(n³)', isCorrect: false },
      { id: 'B', text: '中心扩展法：以每个字符为中心向两边扩展，时间复杂度O(n²)', isCorrect: true },
      { id: 'C', text: 'Manacher算法：线性时间复杂度O(n)', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i][j]表示s[i:j]是否为回文，时间复杂度O(n²)', isCorrect: false }
    ];
    longestPalindrome.explanation =
      '中心扩展法是较优的解法。对于每个可能的回文中心（包括字符和字符间的位置），向两边扩展直到不能构成回文为止。需要考虑奇数长度和偶数长度的回文。时间复杂度O(n²)，空间复杂度O(1)。虽然Manacher算法可以达到O(n)，但实现复杂度较高。';
    longestPalindrome.hint = '考虑以每个位置为中心，向两边扩展寻找回文';
    problems.push(longestPalindrome);

    // 最长公共前缀
    const longestCommonPrefix = new ProblemModel();
    longestCommonPrefix.id = 61;
    longestCommonPrefix.title = '最长公共前缀';
    longestCommonPrefix.description = '编写一个函数来查找字符串数组中的最长公共前缀。如果不存在公共前缀，返回空字符串""。';
    longestCommonPrefix.difficulty = ProblemDifficulty.EASY;
    longestCommonPrefix.category = ProblemCategory.STRING;
    longestCommonPrefix.choices = [
      { id: 'A', text: '垂直扫描：逐个字符比较所有字符串', isCorrect: true },
      { id: 'B', text: '水平扫描：两两比较字符串的公共前缀', isCorrect: false },
      { id: 'C', text: '分治法：递归处理子数组', isCorrect: false },
      { id: 'D', text: '二分查找：在可能的前缀长度上二分', isCorrect: false }
    ];
    longestCommonPrefix.explanation =
      '垂直扫描是最直观的方法。从第一个字符开始，逐个字符比较所有字符串的对应位置。一旦发现不匹配或某个字符串结束，就返回当前的公共前缀。时间复杂度O(S)，其中S是所有字符串的字符总数。';
    longestCommonPrefix.hint = '垂直扫描，逐个字符比较所有字符串';
    problems.push(longestCommonPrefix);

    // 反转字符串
    const reverseString = new ProblemModel();
    reverseString.id = 62;
    reverseString.title = '反转字符串';
    reverseString.description =
      '编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组char[]的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用O(1)的额外空间解决这一问题。';
    reverseString.difficulty = ProblemDifficulty.EASY;
    reverseString.category = ProblemCategory.STRING;
    reverseString.choices = [
      { id: 'A', text: '使用双指针，头尾交换字符', isCorrect: true },
      { id: 'B', text: '使用递归反转', isCorrect: false },
      { id: 'C', text: '创建新数组存储反转结果', isCorrect: false },
      { id: 'D', text: '使用栈结构', isCorrect: false }
    ];
    reverseString.explanation =
      '双指针是最优解法。使用左右两个指针，分别指向数组的开头和结尾，交换两个指针指向的字符，然后左指针右移，右指针左移，直到两指针相遇。时间复杂度O(n)，空间复杂度O(1)。';
    reverseString.hint = '使用双指针从两端向中间交换字符';
    problems.push(reverseString);

    // 字符串中的第一个唯一字符
    const firstUniqChar = new ProblemModel();
    firstUniqChar.id = 63;
    firstUniqChar.title = '字符串中的第一个唯一字符';
    firstUniqChar.description = '给定一个字符串s，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回-1。';
    firstUniqChar.difficulty = ProblemDifficulty.EASY;
    firstUniqChar.category = ProblemCategory.STRING;
    firstUniqChar.choices = [
      { id: 'A', text: '使用哈希表统计字符频次，再遍历找第一个频次为1的字符', isCorrect: true },
      { id: 'B', text: '对每个字符，检查它在字符串中的出现次数', isCorrect: false },
      { id: 'C', text: '使用双重循环比较所有字符', isCorrect: false },
      { id: 'D', text: '先排序再查找', isCorrect: false }
    ];
    firstUniqChar.explanation =
      '哈希表是最优解法。第一次遍历字符串，使用哈希表统计每个字符的出现次数。第二次遍历字符串，找到第一个在哈希表中频次为1的字符，返回其索引。时间复杂度O(n)，空间复杂度O(1)（字符集大小固定）。';
    firstUniqChar.hint = '两次遍历：先统计频次，再找第一个唯一字符';
    problems.push(firstUniqChar);

    // 有效的字母异位词
    const isAnagram = new ProblemModel();
    isAnagram.id = 64;
    isAnagram.title = '有效的字母异位词';
    isAnagram.description =
      '给定两个字符串s和t，编写一个函数来判断t是否是s的字母异位词。注意：若s和t中每个字符出现的次数都相同，则称s和t互为字母异位词。';
    isAnagram.difficulty = ProblemDifficulty.EASY;
    isAnagram.category = ProblemCategory.STRING;
    isAnagram.choices = [
      { id: 'A', text: '排序两个字符串，比较是否相等', isCorrect: false },
      { id: 'B', text: '使用哈希表统计字符频次，比较两个字符串的字符频次', isCorrect: true },
      { id: 'C', text: '使用数组统计26个字母的出现次数', isCorrect: false },
      { id: 'D', text: '逐个字符比较', isCorrect: false }
    ];
    isAnagram.explanation =
      '哈希表统计是最通用的解法。分别统计两个字符串中每个字符的出现次数，然后比较两个哈希表是否相等。如果只包含小写字母，也可以使用长度为26的数组。时间复杂度O(n)，空间复杂度O(1)。';
    isAnagram.hint = '统计两个字符串的字符频次，比较是否相同';
    problems.push(isAnagram);

    // 验证回文串
    const isPalindrome = new ProblemModel();
    isPalindrome.id = 65;
    isPalindrome.title = '验证回文串';
    isPalindrome.description =
      '如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样。则可以认为该短语是一个回文串。给你一个字符串s，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。';
    isPalindrome.difficulty = ProblemDifficulty.EASY;
    isPalindrome.category = ProblemCategory.STRING;
    isPalindrome.choices = [
      { id: 'A', text: '预处理字符串，然后使用双指针验证', isCorrect: false },
      { id: 'B', text: '使用双指针，跳过非字母数字字符，比较字符', isCorrect: true },
      { id: 'C', text: '反转字符串后比较', isCorrect: false },
      { id: 'D', text: '使用递归验证', isCorrect: false }
    ];
    isPalindrome.explanation =
      '双指针是最优解法。使用左右两个指针，跳过非字母数字字符，将字符转换为小写后比较。如果所有对应字符都相等，则是回文串。时间复杂度O(n)，空间复杂度O(1)。';
    isPalindrome.hint = '使用双指针，跳过非字母数字字符进行比较';
    problems.push(isPalindrome);

    // 字符串转换整数
    const myAtoi = new ProblemModel();
    myAtoi.id = 66;
    myAtoi.title = '字符串转换整数(atoi)';
    myAtoi.description =
      '请你来实现一个myAtoi(string s)函数，使其能将字符串转换成一个32位有符号整数（类似C/C++中的atoi函数）。';
    myAtoi.difficulty = ProblemDifficulty.MEDIUM;
    myAtoi.category = ProblemCategory.STRING;
    myAtoi.choices = [
      { id: 'A', text: '按步骤处理：去空格、判断符号、转换数字、处理溢出', isCorrect: true },
      { id: 'B', text: '使用正则表达式匹配数字', isCorrect: false },
      { id: 'C', text: '直接使用内置转换函数', isCorrect: false },
      { id: 'D', text: '逐字符处理，不考虑边界情况', isCorrect: false }
    ];
    myAtoi.explanation =
      '按步骤处理是标准做法。1)跳过前导空格；2)检查正负号；3)逐个字符转换数字，遇到非数字字符停止；4)检查整数溢出，超出范围则返回边界值。时间复杂度O(n)，空间复杂度O(1)。';
    myAtoi.hint = '按步骤处理：空格、符号、数字转换、溢出检查';
    problems.push(myAtoi);

    // 实现strStr()
    const strStr = new ProblemModel();
    strStr.id = 67;
    strStr.title = '实现strStr()';
    strStr.description =
      '实现strStr()函数。给你两个字符串haystack和needle，请你在haystack字符串中找出needle字符串出现的第一个位置（下标从0开始）。如果不存在，则返回-1。';
    strStr.difficulty = ProblemDifficulty.EASY;
    strStr.category = ProblemCategory.STRING;
    strStr.choices = [
      { id: 'A', text: '暴力匹配，双重循环', isCorrect: false },
      { id: 'B', text: 'KMP算法，构建部分匹配表', isCorrect: true },
      { id: 'C', text: 'Boyer-Moore算法', isCorrect: false },
      { id: 'D', text: 'Rabin-Karp算法，使用哈希', isCorrect: false }
    ];
    strStr.explanation =
      'KMP算法是最优解法。构建needle的部分匹配表（前缀函数），然后在haystack中进行匹配。当匹配失败时，利用部分匹配表跳过一些不必要的比较。时间复杂度O(m+n)，空间复杂度O(m)。暴力方法时间复杂度为O(mn)。';
    strStr.hint = '使用KMP算法，构建部分匹配表优化匹配过程';
    problems.push(strStr);

    // 外观数列
    const countAndSay = new ProblemModel();
    countAndSay.id = 68;
    countAndSay.title = '外观数列';
    countAndSay.description =
      '给定一个正整数n，输出外观数列的第n项。外观数列是一个整数序列，从数字1开始，序列中的每一项都是对前一项的描述。';
    countAndSay.difficulty = ProblemDifficulty.MEDIUM;
    countAndSay.category = ProblemCategory.STRING;
    countAndSay.choices = [
      { id: 'A', text: '递归生成每一项', isCorrect: false },
      { id: 'B', text: '迭代生成，逐个字符统计连续相同字符的个数', isCorrect: true },
      { id: 'C', text: '使用动态规划存储中间结果', isCorrect: false },
      { id: 'D', text: '使用正则表达式匹配模式', isCorrect: false }
    ];
    countAndSay.explanation =
      '迭代生成是最直接的方法。从"1"开始，对于每一项，遍历字符串统计连续相同字符的个数，然后构造下一项的描述。重复这个过程n-1次得到第n项。时间复杂度O(n*m)，其中m是字符串的平均长度。';
    countAndSay.hint = '迭代生成，统计连续相同字符的个数';
    problems.push(countAndSay);

    // 无重复字符的最长子串
    const lengthOfLongestSubstring = new ProblemModel();
    lengthOfLongestSubstring.id = 69;
    lengthOfLongestSubstring.title = '无重复字符的最长子串';
    lengthOfLongestSubstring.description = '给定一个字符串s，请你找出其中不含有重复字符的最长子串的长度。';
    lengthOfLongestSubstring.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLongestSubstring.category = ProblemCategory.STRING;
    lengthOfLongestSubstring.choices = [
      { id: 'A', text: '暴力法：枚举所有子串，检查是否有重复字符', isCorrect: false },
      { id: 'B', text: '滑动窗口：使用双指针和哈希表', isCorrect: true },
      { id: 'C', text: '动态规划', isCorrect: false },
      { id: 'D', text: '分治法', isCorrect: false }
    ];
    lengthOfLongestSubstring.explanation =
      '滑动窗口是最优解法。使用左右两个指针维护一个窗口，用哈希表记录字符的最新位置。当遇到重复字符时，将左指针移动到重复字符的下一个位置。时间复杂度O(n)，空间复杂度O(min(m,n))，其中m是字符集大小。';
    lengthOfLongestSubstring.hint = '使用滑动窗口和哈希表记录字符位置';
    problems.push(lengthOfLongestSubstring);

    // 字符串的排列
    const checkInclusion = new ProblemModel();
    checkInclusion.id = 70;
    checkInclusion.title = '字符串的排列';
    checkInclusion.description =
      '给你两个字符串s1和s2，写一个函数来判断s2是否包含s1的排列。换句话说，s1的排列之一是s2的子串。';
    checkInclusion.difficulty = ProblemDifficulty.MEDIUM;
    checkInclusion.category = ProblemCategory.STRING;
    checkInclusion.choices = [
      { id: 'A', text: '生成s1的所有排列，检查是否在s2中', isCorrect: false },
      { id: 'B', text: '滑动窗口：维护固定长度窗口，比较字符频次', isCorrect: true },
      { id: 'C', text: '使用哈希表记录s1的字符，遍历s2检查', isCorrect: false },
      { id: 'D', text: '排序s1，然后在s2中查找所有长度相等的子串', isCorrect: false }
    ];
    checkInclusion.explanation =
      '滑动窗口是最优解法。维护一个长度为s1.length的滑动窗口，统计窗口内字符的频次。如果窗口内字符频次与s1的字符频次完全相同，则找到了s1的排列。时间复杂度O(n)，空间复杂度O(1)。';
    checkInclusion.hint = '使用固定长度的滑动窗口，比较字符频次';
    problems.push(checkInclusion);

    // 找到字符串中所有字母异位词
    const findAnagrams = new ProblemModel();
    findAnagrams.id = 71;
    findAnagrams.title = '找到字符串中所有字母异位词';
    findAnagrams.description =
      '给定两个字符串s和p，找到s中所有p的异位词的子串，返回这些子串的起始索引。不考虑答案输出的顺序。';
    findAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    findAnagrams.category = ProblemCategory.STRING;
    findAnagrams.choices = [
      { id: 'A', text: '对每个长度为p.length的子串，检查是否为p的异位词', isCorrect: false },
      { id: 'B', text: '滑动窗口：维护固定长度窗口，比较字符频次', isCorrect: true },
      { id: 'C', text: '使用哈希表存储p的所有异位词', isCorrect: false },
      { id: 'D', text: '排序p，然后查找所有排序后相等的子串', isCorrect: false }
    ];
    findAnagrams.explanation =
      '滑动窗口是最优解法。类似于"字符串的排列"问题，维护一个长度为p.length的滑动窗口，统计窗口内字符频次。当窗口内字符频次与p的字符频次相同时，记录起始索引。时间复杂度O(n)，空间复杂度O(1)。';
    findAnagrams.hint = '使用滑动窗口，记录所有字符频次匹配的起始位置';
    problems.push(findAnagrams);

    // 最小覆盖子串
    const minWindow = new ProblemModel();
    minWindow.id = 72;
    minWindow.title = '最小覆盖子串';
    minWindow.description =
      '给你一个字符串s、一个字符串t。返回s中涵盖t所有字符的最小子串。如果s中不存在涵盖t所有字符的子串，则返回空字符串""。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.STRING;
    minWindow.choices = [
      { id: 'A', text: '暴力法：枚举所有子串，检查是否包含t的所有字符', isCorrect: false },
      { id: 'B', text: '滑动窗口：扩展右边界直到包含所有字符，然后收缩左边界', isCorrect: true },
      { id: 'C', text: '双指针：固定左边界，移动右边界', isCorrect: false },
      { id: 'D', text: '分治法：递归处理子问题', isCorrect: false }
    ];
    minWindow.explanation =
      '滑动窗口是最优解法。使用双指针维护窗口，先扩展右边界直到窗口包含t的所有字符，然后收缩左边界直到不再满足条件，记录最小窗口。重复这个过程直到右边界到达末尾。时间复杂度O(m+n)，空间复杂度O(m+n)。';
    minWindow.hint = '使用滑动窗口，先扩展再收缩，记录最小覆盖窗口';
    problems.push(minWindow);

    // 分割回文串
    const partition = new ProblemModel();
    partition.id = 73;
    partition.title = '分割回文串';
    partition.description = '给你一个字符串s，请你将s分割成一些子串，使得每个子串都是回文串。返回s所有可能的分割方案。';
    partition.difficulty = ProblemDifficulty.MEDIUM;
    partition.category = ProblemCategory.STRING;
    partition.choices = [
      { id: 'A', text: '回溯法：递归尝试所有可能的分割点', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示s[0:i]的所有分割方案', isCorrect: false },
      { id: 'C', text: '贪心法：优先选择最长的回文子串', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有可能的分割组合', isCorrect: false }
    ];
    partition.explanation =
      '回溯法是标准解法。对于每个位置，尝试以该位置为结尾的所有回文子串，然后递归处理剩余部分。可以预处理回文判断结果优化性能。时间复杂度O(n*2^n)，空间复杂度O(n²)。';
    partition.hint = '使用回溯法，递归尝试所有可能的回文分割';
    problems.push(partition);

    // 单词拆分
    const wordBreak = new ProblemModel();
    wordBreak.id = 74;
    wordBreak.title = '单词拆分';
    wordBreak.description =
      '给你一个字符串s和一个字符串列表wordDict，判断是否可以利用字典中出现的单词拼接出s。注意：不要求字典中出现的单词全部都使用，并且字典中的单词可以重复使用。';
    wordBreak.difficulty = ProblemDifficulty.MEDIUM;
    wordBreak.category = ProblemCategory.STRING;
    wordBreak.choices = [
      { id: 'A', text: '回溯法：递归尝试所有可能的单词组合', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i]表示s[0:i]是否可以被拆分', isCorrect: true },
      { id: 'C', text: 'BFS：将字符串看作图，寻找路径', isCorrect: false },
      { id: 'D', text: '贪心法：优先选择最长的匹配单词', isCorrect: false }
    ];
    wordBreak.explanation =
      '动态规划是最优解法。dp[i]表示字符串s[0:i]是否可以被字典中的单词拆分。对于每个位置i，检查所有可能的单词结尾位置j，如果s[j:i]在字典中且dp[j]为true，则dp[i]为true。时间复杂度O(n²)，空间复杂度O(n)。';
    wordBreak.hint = '使用动态规划，dp[i]表示前i个字符是否可以被拆分';
    problems.push(wordBreak);

    // 编辑距离
    const minDistance = new ProblemModel();
    minDistance.id = 75;
    minDistance.title = '编辑距离';
    minDistance.description =
      '给你两个单词word1和word2，请返回将word1转换成word2所使用的最少操作数。你可以对一个单词进行如下三种操作：插入一个字符、删除一个字符、替换一个字符。';
    minDistance.difficulty = ProblemDifficulty.HARD;
    minDistance.category = ProblemCategory.STRING;
    minDistance.choices = [
      { id: 'A', text: '回溯法：递归尝试所有可能的操作序列', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示word1[0:i]转换为word2[0:j]的最少操作数', isCorrect: true },
      { id: 'C', text: '贪心法：优先进行代价最小的操作', isCorrect: false },
      { id: 'D', text: 'BFS：将字符串转换看作图搜索', isCorrect: false }
    ];
    minDistance.explanation =
      '动态规划是经典解法。dp[i][j]表示word1的前i个字符转换为word2的前j个字符所需的最少操作数。状态转移：如果字符相同则dp[i][j]=dp[i-1][j-1]，否则取插入、删除、替换三种操作的最小值加1。时间复杂度O(mn)，空间复杂度O(mn)。';
    minDistance.hint = '使用二维动态规划，考虑插入、删除、替换三种操作';
    problems.push(minDistance);

    // 正则表达式匹配
    const isMatch = new ProblemModel();
    isMatch.id = 76;
    isMatch.title = '正则表达式匹配';
    isMatch.description =
      '给你一个字符串s和一个字符规律p，请你来实现一个支持"."和"*"的正则表达式匹配。"."匹配任意单个字符，"*"匹配零个或多个前面的那一个元素。';
    isMatch.difficulty = ProblemDifficulty.HARD;
    isMatch.category = ProblemCategory.STRING;
    isMatch.choices = [
      { id: 'A', text: '递归：分情况讨论字符和*的匹配', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]和p[0:j]是否匹配', isCorrect: true },
      { id: 'C', text: '有限状态自动机', isCorrect: false },
      { id: 'D', text: '回溯法：尝试所有可能的匹配方式', isCorrect: false }
    ];
    isMatch.explanation =
      '动态规划是最清晰的解法。dp[i][j]表示s的前i个字符和p的前j个字符是否匹配。需要分情况讨论：普通字符匹配、.匹配、*匹配0次、*匹配多次等。时间复杂度O(mn)，空间复杂度O(mn)。';
    isMatch.hint = '使用动态规划，分情况讨论字符、.和*的匹配规则';
    problems.push(isMatch);

    // 通配符匹配
    const isMatchWildcard = new ProblemModel();
    isMatchWildcard.id = 77;
    isMatchWildcard.title = '通配符匹配';
    isMatchWildcard.description =
      '给定一个字符串(s)和一个字符模式(p)，实现一个支持"?"和"*"的通配符匹配。"?"可以匹配任何单个字符，"*"可以匹配任意字符串（包括空字符串）。';
    isMatchWildcard.difficulty = ProblemDifficulty.HARD;
    isMatchWildcard.category = ProblemCategory.STRING;
    isMatchWildcard.choices = [
      { id: 'A', text: '递归：分情况讨论字符和通配符的匹配', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]和p[0:j]是否匹配', isCorrect: true },
      { id: 'C', text: '贪心法：*尽可能匹配更多字符', isCorrect: false },
      { id: 'D', text: '双指针：记录*的位置进行回溯', isCorrect: false }
    ];
    isMatchWildcard.explanation =
      '动态规划是标准解法。dp[i][j]表示s的前i个字符和p的前j个字符是否匹配。状态转移：普通字符和?需要精确匹配，*可以匹配0个或多个字符。时间复杂度O(mn)，空间复杂度O(mn)。';
    isMatchWildcard.hint = '使用动态规划，处理?和*的不同匹配规则';
    problems.push(isMatchWildcard);

    // 最长有效括号
    const longestValidParentheses = new ProblemModel();
    longestValidParentheses.id = 78;
    longestValidParentheses.title = '最长有效括号';
    longestValidParentheses.description = '给你一个只包含"("和")"的字符串，找出最长有效（格式正确且连续）括号子串的长度。';
    longestValidParentheses.difficulty = ProblemDifficulty.HARD;
    longestValidParentheses.category = ProblemCategory.STRING;
    longestValidParentheses.choices = [
      { id: 'A', text: '暴力法：枚举所有子串，检查是否为有效括号', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i]表示以i结尾的最长有效括号长度', isCorrect: true },
      { id: 'C', text: '栈：记录括号的索引', isCorrect: false },
      { id: 'D', text: '双指针：分别从左右两个方向扫描', isCorrect: false }
    ];
    longestValidParentheses.explanation =
      '动态规划是最优解法。dp[i]表示以索引i结尾的最长有效括号子串长度。当s[i]为")"时，如果s[i-1]为"("，则dp[i]=dp[i-2]+2；如果s[i-1]为")"且s[i-dp[i-1]-1]为"("，则dp[i]=dp[i-1]+2+dp[i-dp[i-1]-2]。时间复杂度O(n)，空间复杂度O(n)。';
    longestValidParentheses.hint = '使用动态规划，dp[i]表示以i结尾的最长有效括号长度';
    problems.push(longestValidParentheses);

    // 不同的子序列
    const numDistinct = new ProblemModel();
    numDistinct.id = 79;
    numDistinct.title = '不同的子序列';
    numDistinct.description =
      '给定一个字符串s和一个字符串t，计算在s的子序列中t出现的个数。字符串的一个子序列是指，通过删除一些（也可以不删除）字符且不干扰剩余字符相对位置所组成的新字符串。';
    numDistinct.difficulty = ProblemDifficulty.HARD;
    numDistinct.category = ProblemCategory.STRING;
    numDistinct.choices = [
      { id: 'A', text: '回溯法：递归枚举所有可能的子序列', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]中t[0:j]的出现次数', isCorrect: true },
      { id: 'C', text: '贪心法：优先匹配靠前的字符', isCorrect: false },
      { id: 'D', text: '双指针：同时遍历两个字符串', isCorrect: false }
    ];
    numDistinct.explanation =
      '动态规划是标准解法。dp[i][j]表示s的前i个字符中包含t的前j个字符的子序列个数。状态转移：如果s[i-1]==t[j-1]，则dp[i][j]=dp[i-1][j-1]+dp[i-1][j]；否则dp[i][j]=dp[i-1][j]。时间复杂度O(mn)，空间复杂度O(mn)。';
    numDistinct.hint = '使用动态规划，考虑字符匹配和不匹配两种情况';
    problems.push(numDistinct);

    // 交错字符串
    const isInterleave = new ProblemModel();
    isInterleave.id = 80;
    isInterleave.title = '交错字符串';
    isInterleave.description =
      '给定三个字符串s1、s2、s3，请你帮忙验证s3是否是由s1和s2交错组成的。两个字符串s和t交错的定义与过程如下，其中每个字符串都会被分割成若干非空子字符串。';
    isInterleave.difficulty = ProblemDifficulty.MEDIUM;
    isInterleave.category = ProblemCategory.STRING;
    isInterleave.choices = [
      { id: 'A', text: '回溯法：递归尝试从s1或s2中选择字符', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s1[0:i]和s2[0:j]能否交错组成s3[0:i+j]', isCorrect: true },
      { id: 'C', text: 'BFS：将问题看作图搜索', isCorrect: false },
      { id: 'D', text: '贪心法：优先选择匹配的字符串', isCorrect: false }
    ];
    isInterleave.explanation =
      '动态规划是最优解法。dp[i][j]表示s1的前i个字符和s2的前j个字符能否交错组成s3的前i+j个字符。状态转移：dp[i][j]为true当且仅当(dp[i-1][j]且s1[i-1]==s3[i+j-1])或(dp[i][j-1]且s2[j-1]==s3[i+j-1])。时间复杂度O(mn)，空间复杂度O(mn)。';
    isInterleave.hint = '使用动态规划，考虑从s1或s2中选择字符的两种情况';
    problems.push(isInterleave);

    return problems;
  }

  /**
   * 链表类题目
   */
  private static getLinkedListProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 反转链表
    const reverseList = new ProblemModel();
    reverseList.id = 6;
    reverseList.title = '反转链表';
    reverseList.description = '给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。';
    reverseList.difficulty = ProblemDifficulty.EASY;
    reverseList.category = ProblemCategory.LINKED_LIST;
    reverseList.source = ProblemSource.INTERVIEW; // 设置为面试题
    reverseList.choices = [
      { id: 'A', text: '使用迭代方法，维护三个指针prev、curr、next', isCorrect: true },
      { id: 'B', text: '使用递归方法，先反转子链表再处理当前节点', isCorrect: false },
      { id: 'C', text: '使用栈存储所有节点，然后重新连接', isCorrect: false },
      { id: 'D', text: '使用数组存储所有节点值，然后重新创建链表', isCorrect: false }
    ];
    reverseList.explanation =
      '迭代方法是最直观且高效的解法。使用三个指针：prev（前一个节点）、curr（当前节点）、next（下一个节点）。遍历链表，将当前节点的next指向prev，然后移动三个指针。时间复杂度O(n)，空间复杂度O(1)。递归方法虽然代码简洁，但空间复杂度为O(n)。';
    reverseList.hint = '使用三个指针来改变链表的指向关系';
    problems.push(reverseList);

    // 环形链表
    const hasCycle = new ProblemModel();
    hasCycle.id = 7;
    hasCycle.title = '环形链表';
    hasCycle.description =
      '给你一个链表的头节点 head ，判断链表中是否有环。\n\n如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。';
    hasCycle.difficulty = ProblemDifficulty.EASY;
    hasCycle.category = ProblemCategory.LINKED_LIST;
    hasCycle.source = ProblemSource.INTERVIEW; // 设置为面试题
    hasCycle.choices = [
      { id: 'A', text: '使用哈希表存储访问过的节点', isCorrect: false },
      { id: 'B', text: '使用快慢指针（Floyd判圈算法）', isCorrect: true },
      { id: 'C', text: '遍历链表并设置访问标记', isCorrect: false },
      { id: 'D', text: '限制遍历次数，超过阈值则认为有环', isCorrect: false }
    ];
    hasCycle.explanation =
      '快慢指针（Floyd判圈算法）是最优解法。使用两个指针，快指针每次移动两步，慢指针每次移动一步。如果链表有环，快指针最终会追上慢指针；如果没有环，快指针会先到达链表末尾。时间复杂度O(n)，空间复杂度O(1)。';
    hasCycle.hint = '考虑使用快慢指针，如果有环，快指针会追上慢指针';
    problems.push(hasCycle);

    // 合并两个有序链表
    const mergeTwoLists = new ProblemModel();
    mergeTwoLists.id = 81;
    mergeTwoLists.title = '合并两个有序链表';
    mergeTwoLists.description =
      '将两个升序链表合并为一个新的升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。';
    mergeTwoLists.difficulty = ProblemDifficulty.EASY;
    mergeTwoLists.category = ProblemCategory.LINKED_LIST;
    mergeTwoLists.choices = [
      { id: 'A', text: '使用递归方法比较节点值', isCorrect: true },
      { id: 'B', text: '使用迭代方法和虚拟头节点', isCorrect: false },
      { id: 'C', text: '先将所有节点存入数组排序', isCorrect: false },
      { id: 'D', text: '使用栈来处理节点顺序', isCorrect: false }
    ];
    mergeTwoLists.explanation =
      '可以使用递归或迭代方法。递归方法：比较两个链表头节点，选择较小的作为结果，递归处理剩余部分。迭代方法：使用虚拟头节点，依次比较并连接较小的节点。时间复杂度O(m+n)，空间复杂度递归O(m+n)，迭代O(1)。';
    mergeTwoLists.hint = '比较两个链表的头节点，选择较小的连接到结果链表';
    problems.push(mergeTwoLists);

    // 删除链表的倒数第N个节点
    const removeNthFromEnd = new ProblemModel();
    removeNthFromEnd.id = 82;
    removeNthFromEnd.title = '删除链表的倒数第N个节点';
    removeNthFromEnd.description = '给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。';
    removeNthFromEnd.difficulty = ProblemDifficulty.MEDIUM;
    removeNthFromEnd.category = ProblemCategory.LINKED_LIST;
    removeNthFromEnd.choices = [
      { id: 'A', text: '先遍历计算长度，再删除第(length-n+1)个节点', isCorrect: false },
      { id: 'B', text: '使用双指针，快指针先走n步', isCorrect: true },
      { id: 'C', text: '使用栈存储所有节点', isCorrect: false },
      { id: 'D', text: '使用递归计算倒数位置', isCorrect: false }
    ];
    removeNthFromEnd.explanation =
      '使用双指针技巧。让快指针先走n步，然后快慢指针同时移动，当快指针到达末尾时，慢指针指向要删除节点的前一个节点。使用虚拟头节点可以简化边界情况处理。时间复杂度O(n)，空间复杂度O(1)。';
    removeNthFromEnd.hint = '使用双指针，让快指针先走n步';
    problems.push(removeNthFromEnd);

    // 链表的中间节点
    const middleNode = new ProblemModel();
    middleNode.id = 83;
    middleNode.title = '链表的中间节点';
    middleNode.description =
      '给定一个头结点为 head 的非空单链表，返回链表的中间结点。如果有两个中间结点，则返回第二个中间结点。';
    middleNode.difficulty = ProblemDifficulty.EASY;
    middleNode.category = ProblemCategory.LINKED_LIST;
    middleNode.choices = [
      { id: 'A', text: '先遍历计算长度，再找到中间位置', isCorrect: false },
      { id: 'B', text: '使用快慢指针，快指针走两步慢指针走一步', isCorrect: true },
      { id: 'C', text: '使用数组存储所有节点', isCorrect: false },
      { id: 'D', text: '使用递归计算中间位置', isCorrect: false }
    ];
    middleNode.explanation =
      '使用快慢指针技巧。快指针每次移动两步，慢指针每次移动一步。当快指针到达链表末尾时，慢指针正好在中间位置。这种方法只需要一次遍历，时间复杂度O(n)，空间复杂度O(1)。';
    middleNode.hint = '使用快慢指针，当快指针到达末尾时慢指针在中间';
    problems.push(middleNode);

    // 回文链表
    const isPalindromeList = new ProblemModel();
    isPalindromeList.id = 84;
    isPalindromeList.title = '回文链表';
    isPalindromeList.description =
      '给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。';
    isPalindromeList.difficulty = ProblemDifficulty.EASY;
    isPalindromeList.category = ProblemCategory.LINKED_LIST;
    isPalindromeList.choices = [
      { id: 'A', text: '将链表值复制到数组中，然后检查数组是否回文', isCorrect: false },
      { id: 'B', text: '找到中点，反转后半部分，然后比较', isCorrect: true },
      { id: 'C', text: '使用递归比较首尾节点', isCorrect: false },
      { id: 'D', text: '使用栈存储前半部分节点', isCorrect: false }
    ];
    isPalindromeList.explanation =
      '最优解法：1.使用快慢指针找到链表中点；2.反转后半部分链表；3.比较前半部分和反转后的后半部分；4.恢复链表结构。时间复杂度O(n)，空间复杂度O(1)。数组方法简单但空间复杂度O(n)。';
    isPalindromeList.hint = '找到中点后反转后半部分链表进行比较';
    problems.push(isPalindromeList);

    // 相交链表
    const getIntersectionNode = new ProblemModel();
    getIntersectionNode.id = 85;
    getIntersectionNode.title = '相交链表';
    getIntersectionNode.description =
      '给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。';
    getIntersectionNode.difficulty = ProblemDifficulty.EASY;
    getIntersectionNode.category = ProblemCategory.LINKED_LIST;
    getIntersectionNode.choices = [
      { id: 'A', text: '使用哈希表存储一个链表的所有节点', isCorrect: false },
      { id: 'B', text: '双指针法，两个指针分别遍历两个链表', isCorrect: true },
      { id: 'C', text: '先计算两个链表的长度差', isCorrect: false },
      { id: 'D', text: '使用栈同时存储两个链表', isCorrect: false }
    ];
    getIntersectionNode.explanation =
      '双指针法：两个指针分别从两个链表头开始遍历，当到达末尾时跳转到另一个链表头继续遍历。如果有相交点，两个指针会在相交点相遇；如果没有相交点，两个指针会同时到达null。时间复杂度O(m+n)，空间复杂度O(1)。';
    getIntersectionNode.hint = '两个指针分别遍历两个链表，到达末尾时跳转到另一个链表';
    problems.push(getIntersectionNode);

    // 删除排序链表中的重复元素
    const deleteDuplicates = new ProblemModel();
    deleteDuplicates.id = 86;
    deleteDuplicates.title = '删除排序链表中的重复元素';
    deleteDuplicates.description =
      '给定一个已排序的链表的头 head ， 删除所有重复的元素，使每个元素只出现一次 。返回已排序的链表 。';
    deleteDuplicates.difficulty = ProblemDifficulty.EASY;
    deleteDuplicates.category = ProblemCategory.LINKED_LIST;
    deleteDuplicates.choices = [
      { id: 'A', text: '使用哈希表记录出现过的值', isCorrect: false },
      { id: 'B', text: '一次遍历，比较相邻节点值', isCorrect: true },
      { id: 'C', text: '使用递归删除重复节点', isCorrect: false },
      { id: 'D', text: '先转换为数组去重再重建链表', isCorrect: false }
    ];
    deleteDuplicates.explanation =
      '由于链表已排序，重复元素必定相邻。一次遍历链表，比较当前节点和下一个节点的值，如果相同则删除下一个节点，否则移动到下一个节点。时间复杂度O(n)，空间复杂度O(1)。';
    deleteDuplicates.hint = '利用链表已排序的特性，比较相邻节点';
    problems.push(deleteDuplicates);

    // 两数相加
    const addTwoNumbers = new ProblemModel();
    addTwoNumbers.id = 87;
    addTwoNumbers.title = '两数相加';
    addTwoNumbers.description =
      '给你两个非空的链表，表示两个非负的整数。它们每位数字都是按照逆序的方式存储的，并且每个节点只能存储一位数字。请你将两个数相加，并以相同形式返回一个表示和的链表。';
    addTwoNumbers.difficulty = ProblemDifficulty.MEDIUM;
    addTwoNumbers.category = ProblemCategory.LINKED_LIST;
    addTwoNumbers.choices = [
      { id: 'A', text: '同时遍历两个链表，处理进位', isCorrect: true },
      { id: 'B', text: '先转换为整数相加再转回链表', isCorrect: false },
      { id: 'C', text: '使用栈处理进位问题', isCorrect: false },
      { id: 'D', text: '递归处理每一位的相加', isCorrect: false }
    ];
    addTwoNumbers.explanation =
      '模拟加法运算。同时遍历两个链表，将对应位置的数字相加，注意处理进位。使用虚拟头节点简化代码。需要考虑链表长度不同和最后的进位情况。时间复杂度O(max(m,n))，空间复杂度O(max(m,n))。';
    addTwoNumbers.hint = '模拟加法运算，注意处理进位';
    problems.push(addTwoNumbers);

    // 旋转链表
    const rotateRight = new ProblemModel();
    rotateRight.id = 88;
    rotateRight.title = '旋转链表';
    rotateRight.description = '给你一个链表的头节点 head ，旋转链表，将链表每个节点向右移动 k 个位置。';
    rotateRight.difficulty = ProblemDifficulty.MEDIUM;
    rotateRight.category = ProblemCategory.LINKED_LIST;
    rotateRight.choices = [
      { id: 'A', text: '先形成环，再在合适位置断开', isCorrect: true },
      { id: 'B', text: '使用数组存储所有节点再重新连接', isCorrect: false },
      { id: 'C', text: '递归移动每个节点', isCorrect: false },
      { id: 'D', text: '使用栈临时存储节点', isCorrect: false }
    ];
    rotateRight.explanation =
      '1.计算链表长度并形成环；2.计算实际旋转步数k%length；3.找到新的尾节点（第length-k个节点）；4.断开环形成新链表。时间复杂度O(n)，空间复杂度O(1)。';
    rotateRight.hint = '先形成环，然后在合适的位置断开';
    problems.push(rotateRight);

    // 分隔链表
    const partition = new ProblemModel();
    partition.id = 89;
    partition.title = '分隔链表';
    partition.description =
      '给你一个链表的头节点 head 和一个特定值 x ，请你对链表进行分隔，使得所有小于 x 的节点都出现在大于或等于 x 的节点之前。';
    partition.difficulty = ProblemDifficulty.MEDIUM;
    partition.category = ProblemCategory.LINKED_LIST;
    partition.choices = [
      { id: 'A', text: '使用两个虚拟头节点分别存储小于和大于等于x的节点', isCorrect: true },
      { id: 'B', text: '在原链表上直接移动节点', isCorrect: false },
      { id: 'C', text: '使用数组存储节点再重新排列', isCorrect: false },
      { id: 'D', text: '使用递归分别处理两部分', isCorrect: false }
    ];
    partition.explanation =
      '使用两个虚拟头节点分别构建两个链表：一个存储小于x的节点，另一个存储大于等于x的节点。遍历原链表，根据节点值将节点添加到对应链表。最后将两个链表连接。时间复杂度O(n)，空间复杂度O(1)。';
    partition.hint = '使用两个链表分别存储小于和大于等于x的节点';
    problems.push(partition);

    // 复制带随机指针的链表
    const copyRandomList = new ProblemModel();
    copyRandomList.id = 90;
    copyRandomList.title = '复制带随机指针的链表';
    copyRandomList.description =
      '给你一个长度为 n 的链表，每个节点包含一个额外增加的随机指针 random ，该指针可以指向链表中的任何节点或空节点。';
    copyRandomList.difficulty = ProblemDifficulty.MEDIUM;
    copyRandomList.category = ProblemCategory.LINKED_LIST;
    copyRandomList.choices = [
      { id: 'A', text: '使用哈希表建立原节点和新节点的映射关系', isCorrect: true },
      { id: 'B', text: '在原链表中插入新节点再分离', isCorrect: false },
      { id: 'C', text: '先复制next指针再处理random指针', isCorrect: false },
      { id: 'D', text: '使用递归复制每个节点', isCorrect: false }
    ];
    copyRandomList.explanation =
      '方法1：使用哈希表。第一次遍历创建所有新节点并建立映射，第二次遍历设置next和random指针。方法2：在原链表中插入新节点，设置random指针后再分离。时间复杂度O(n)，空间复杂度哈希表O(n)，插入法O(1)。';
    copyRandomList.hint = '使用哈希表建立原节点和新节点的映射关系';
    problems.push(copyRandomList);

    // 重排链表
    const reorderList = new ProblemModel();
    reorderList.id = 91;
    reorderList.title = '重排链表';
    reorderList.description =
      '给定一个单链表 L 的头节点 head ，单链表 L 表示为：L0 → L1 → … → Ln - 1 → Ln。请将其重新排列后变为：L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …';
    reorderList.difficulty = ProblemDifficulty.MEDIUM;
    reorderList.category = ProblemCategory.LINKED_LIST;
    reorderList.choices = [
      { id: 'A', text: '找到中点，反转后半部分，然后交替合并', isCorrect: true },
      { id: 'B', text: '使用数组存储所有节点再重新连接', isCorrect: false },
      { id: 'C', text: '使用栈存储后半部分节点', isCorrect: false },
      { id: 'D', text: '使用递归处理重排逻辑', isCorrect: false }
    ];
    reorderList.explanation =
      '1.使用快慢指针找到链表中点；2.反转后半部分链表；3.交替合并前半部分和反转后的后半部分。这种方法时间复杂度O(n)，空间复杂度O(1)，是最优解法。';
    reorderList.hint = '分三步：找中点、反转后半部分、交替合并';
    problems.push(reorderList);

    // 排序链表
    const sortList = new ProblemModel();
    sortList.id = 92;
    sortList.title = '排序链表';
    sortList.description = '给你链表的头结点 head ，请将其按升序排列并返回排序后的链表。';
    sortList.difficulty = ProblemDifficulty.MEDIUM;
    sortList.category = ProblemCategory.LINKED_LIST;
    sortList.choices = [
      { id: 'A', text: '使用归并排序，递归分割链表', isCorrect: true },
      { id: 'B', text: '转换为数组排序后重建链表', isCorrect: false },
      { id: 'C', text: '使用快速排序算法', isCorrect: false },
      { id: 'D', text: '使用插入排序算法', isCorrect: false }
    ];
    sortList.explanation =
      '使用归并排序。1.使用快慢指针找到中点分割链表；2.递归排序左右两部分；3.合并两个有序链表。时间复杂度O(nlogn)，空间复杂度O(logn)（递归栈）。这是链表排序的最优解法。';
    sortList.hint = '使用归并排序，分割链表后递归排序再合并';
    problems.push(sortList);

    // 环形链表II
    const detectCycle = new ProblemModel();
    detectCycle.id = 93;
    detectCycle.title = '环形链表II';
    detectCycle.description = '给定一个链表的头节点 head ，返回链表开始入环的第一个节点。如果链表无环，则返回 null。';
    detectCycle.difficulty = ProblemDifficulty.MEDIUM;
    detectCycle.category = ProblemCategory.LINKED_LIST;
    detectCycle.choices = [
      { id: 'A', text: '使用哈希表记录访问过的节点', isCorrect: false },
      { id: 'B', text: '使用Floyd算法找到相遇点，再找入环点', isCorrect: true },
      { id: 'C', text: '遍历链表并标记访问过的节点', isCorrect: false },
      { id: 'D', text: '使用两个指针分别从头和尾开始', isCorrect: false }
    ];
    detectCycle.explanation =
      'Floyd算法：1.快慢指针找到相遇点；2.一个指针从头开始，一个从相遇点开始，每次都走一步；3.两指针相遇的地方就是入环点。数学原理：设头到入环点距离a，入环点到相遇点距离b，相遇点到入环点距离c，则a=c。';
    detectCycle.hint = '先用快慢指针找相遇点，再用数学关系找入环点';
    problems.push(detectCycle);

    // 合并K个升序链表
    const mergeKLists = new ProblemModel();
    mergeKLists.id = 94;
    mergeKLists.title = '合并K个升序链表';
    mergeKLists.description =
      '给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。';
    mergeKLists.difficulty = ProblemDifficulty.HARD;
    mergeKLists.category = ProblemCategory.LINKED_LIST;
    mergeKLists.choices = [
      { id: 'A', text: '逐一合并链表', isCorrect: false },
      { id: 'B', text: '使用分治法两两合并', isCorrect: true },
      { id: 'C', text: '使用优先队列（最小堆）', isCorrect: false },
      { id: 'D', text: '将所有节点放入数组排序后重建', isCorrect: false }
    ];
    mergeKLists.explanation =
      '分治法是最优解：1.将k个链表两两配对合并；2.重复此过程直到只剩一个链表。时间复杂度O(Nlogk)，N是所有节点总数。优先队列法也可行但常数较大。逐一合并时间复杂度O(Nk)较差。';
    mergeKLists.hint = '使用分治法，将k个链表两两合并';
    problems.push(mergeKLists);

    // 反转链表II
    const reverseBetween = new ProblemModel();
    reverseBetween.id = 95;
    reverseBetween.title = '反转链表II';
    reverseBetween.description =
      '给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回反转后的链表 。';
    reverseBetween.difficulty = ProblemDifficulty.MEDIUM;
    reverseBetween.category = ProblemCategory.LINKED_LIST;
    reverseBetween.choices = [
      { id: 'A', text: '找到反转区间，使用迭代法反转', isCorrect: true },
      { id: 'B', text: '使用递归反转指定区间', isCorrect: false },
      { id: 'C', text: '使用栈存储区间内的节点', isCorrect: false },
      { id: 'D', text: '转换为数组处理后重建链表', isCorrect: false }
    ];
    reverseBetween.explanation =
      '1.使用虚拟头节点简化边界处理；2.找到反转区间的前一个节点；3.在区间内使用迭代法反转链表；4.连接反转后的部分。关键是正确处理指针的连接关系。时间复杂度O(n)，空间复杂度O(1)。';
    reverseBetween.hint = '找到反转区间，使用迭代法局部反转';
    problems.push(reverseBetween);

    // 删除排序链表中的重复元素II
    const deleteDuplicatesII = new ProblemModel();
    deleteDuplicatesII.id = 96;
    deleteDuplicatesII.title = '删除排序链表中的重复元素II';
    deleteDuplicatesII.description =
      '给定一个已排序的链表的头 head ， 删除原始链表中所有重复数字的节点，只留下不同数字的节点 。返回已排序的链表 。';
    deleteDuplicatesII.difficulty = ProblemDifficulty.MEDIUM;
    deleteDuplicatesII.category = ProblemCategory.LINKED_LIST;
    deleteDuplicatesII.choices = [
      { id: 'A', text: '使用虚拟头节点，跳过所有重复的节点', isCorrect: true },
      { id: 'B', text: '使用哈希表记录节点出现次数', isCorrect: false },
      { id: 'C', text: '使用递归删除重复节点', isCorrect: false },
      { id: 'D', text: '先标记重复节点再删除', isCorrect: false }
    ];
    deleteDuplicatesII.explanation =
      '使用虚拟头节点和双指针。prev指向当前确定保留的最后一个节点，curr用于探测重复。当发现重复时，跳过所有相同值的节点。关键是正确判断重复区间的开始和结束。时间复杂度O(n)，空间复杂度O(1)。';
    deleteDuplicatesII.hint = '使用虚拟头节点，跳过所有重复值的节点';
    problems.push(deleteDuplicatesII);

    // 奇偶链表
    const oddEvenList = new ProblemModel();
    oddEvenList.id = 97;
    oddEvenList.title = '奇偶链表';
    oddEvenList.description =
      '给定单链表的头节点 head ，将所有索引为奇数的节点和索引为偶数的节点分别组合在一起，然后返回重新排序的列表。';
    oddEvenList.difficulty = ProblemDifficulty.MEDIUM;
    oddEvenList.category = ProblemCategory.LINKED_LIST;
    oddEvenList.choices = [
      { id: 'A', text: '使用两个指针分别处理奇偶位置的节点', isCorrect: true },
      { id: 'B', text: '使用数组存储奇偶位置的节点', isCorrect: false },
      { id: 'C', text: '使用递归分别处理奇偶节点', isCorrect: false },
      { id: 'D', text: '创建两个新链表分别存储奇偶节点', isCorrect: false }
    ];
    oddEvenList.explanation =
      '使用两个指针odd和even分别指向奇偶位置的节点，同时移动这两个指针，将奇数位置的节点连在一起，偶数位置的节点连在一起，最后将奇数链表的尾部连接到偶数链表的头部。时间复杂度O(n)，空间复杂度O(1)。';
    oddEvenList.hint = '使用两个指针分别连接奇偶位置的节点';
    problems.push(oddEvenList);

    // 两两交换链表中的节点
    const swapPairs = new ProblemModel();
    swapPairs.id = 98;
    swapPairs.title = '两两交换链表中的节点';
    swapPairs.description =
      '给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改链表节点值的情况下完成本题（即，只能进行节点交换）。';
    swapPairs.difficulty = ProblemDifficulty.MEDIUM;
    swapPairs.category = ProblemCategory.LINKED_LIST;
    swapPairs.choices = [
      { id: 'A', text: '使用递归交换每一对节点', isCorrect: false },
      { id: 'B', text: '使用迭代法和虚拟头节点', isCorrect: true },
      { id: 'C', text: '使用栈存储节点对', isCorrect: false },
      { id: 'D', text: '直接交换节点的值', isCorrect: false }
    ];
    swapPairs.explanation =
      '使用迭代法：1.创建虚拟头节点；2.使用prev指针指向每对节点的前一个节点；3.交换当前对节点的指针关系；4.更新prev指针到下一对。需要仔细处理指针的连接顺序。时间复杂度O(n)，空间复杂度O(1)。';
    swapPairs.hint = '使用虚拟头节点，迭代交换每一对相邻节点';
    problems.push(swapPairs);

    // K个一组翻转链表
    const reverseKGroup = new ProblemModel();
    reverseKGroup.id = 99;
    reverseKGroup.title = 'K个一组翻转链表';
    reverseKGroup.description =
      '给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。';
    reverseKGroup.difficulty = ProblemDifficulty.HARD;
    reverseKGroup.category = ProblemCategory.LINKED_LIST;
    reverseKGroup.choices = [
      { id: 'A', text: '先检查是否有k个节点，然后反转这k个节点', isCorrect: true },
      { id: 'B', text: '使用递归处理每k个节点', isCorrect: false },
      { id: 'C', text: '使用栈存储k个节点再重新连接', isCorrect: false },
      { id: 'D', text: '转换为数组处理后重建链表', isCorrect: false }
    ];
    reverseKGroup.explanation =
      '1.先遍历检查是否有k个节点；2.如果有，反转这k个节点；3.递归处理剩余部分；4.连接反转后的部分和剩余部分。关键是正确处理反转后的连接关系和边界情况。时间复杂度O(n)，空间复杂度O(1)。';
    reverseKGroup.hint = '先检查节点数量，然后分组反转并正确连接';
    problems.push(reverseKGroup);

    // 扁平化多级双向链表
    const flatten = new ProblemModel();
    flatten.id = 100;
    flatten.title = '扁平化多级双向链表';
    flatten.description =
      '你会得到一个双向链表，除了下一个和前一个指针之外，它还有一个子指针，可能指向单独的双向链表。这些子列表也可能会有一个或多个自己的子项，依此类推，生成多级数据结构。给你位于列表第一级的头节点，请扁平化列表，使所有结点出现在单级双链表中。';
    flatten.difficulty = ProblemDifficulty.MEDIUM;
    flatten.category = ProblemCategory.LINKED_LIST;
    flatten.choices = [
      { id: 'A', text: '使用深度优先搜索遍历所有节点', isCorrect: true },
      { id: 'B', text: '使用栈存储分支节点', isCorrect: false },
      { id: 'C', text: '使用队列进行广度优先搜索', isCorrect: false },
      { id: 'D', text: '使用递归处理每个子链表', isCorrect: false }
    ];
    flatten.explanation =
      '使用DFS：遍历链表，当遇到有子节点的节点时，将当前节点的next保存，然后将子链表插入到当前位置，继续遍历子链表，处理完子链表后再处理之前保存的next部分。需要正确维护双向指针关系。';
    flatten.hint = '使用深度优先搜索，遇到子节点时先处理子链表';
    problems.push(flatten);

    return problems;
  }

  /**
   * 二叉树类题目
   */
  private static getBinaryTreeProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 二叉树的最大深度
    const maxDepth = new ProblemModel();
    maxDepth.id = 8;
    maxDepth.title = '二叉树的最大深度';
    maxDepth.description = '给定一个二叉树，找出其最大深度。\n\n二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。';
    maxDepth.difficulty = ProblemDifficulty.EASY;
    maxDepth.category = ProblemCategory.BINARY_TREE;
    maxDepth.source = ProblemSource.INTERVIEW; // 设置为面试题
    maxDepth.choices = [
      { id: 'A', text: '使用递归：深度 = 1 + max(左子树深度, 右子树深度)', isCorrect: true },
      { id: 'B', text: '使用层序遍历（BFS），统计层数', isCorrect: false },
      { id: 'C', text: '使用前序遍历，维护当前深度的最大值', isCorrect: false },
      { id: 'D', text: '使用后序遍历，自底向上计算深度', isCorrect: false }
    ];
    maxDepth.explanation =
      '递归是最直观的解法。二叉树的最大深度等于左右子树最大深度的较大值加1。递归终止条件是节点为空时返回0。时间复杂度O(n)，空间复杂度O(h)，其中h是树的高度。层序遍历也可以解决，但代码相对复杂。';
    maxDepth.hint = '考虑递归：当前树的深度 = 1 + 左右子树深度的最大值';
    problems.push(maxDepth);

    // 对称二叉树
    const isSymmetric = new ProblemModel();
    isSymmetric.id = 9;
    isSymmetric.title = '对称二叉树';
    isSymmetric.description = '给你一个二叉树的根节点 root ， 检查它是否轴对称。';
    isSymmetric.difficulty = ProblemDifficulty.EASY;
    isSymmetric.category = ProblemCategory.BINARY_TREE;
    isSymmetric.source = ProblemSource.INTERVIEW; // 设置为面试题
    isSymmetric.choices = [
      { id: 'A', text: '使用递归比较左右子树是否镜像对称', isCorrect: true },
      { id: 'B', text: '使用层序遍历，检查每层是否回文', isCorrect: false },
      { id: 'C', text: '使用中序遍历，检查结果是否回文', isCorrect: false },
      { id: 'D', text: '使用前序遍历和后序遍历比较', isCorrect: false }
    ];
    isSymmetric.explanation =
      '递归比较是最优解法。定义一个辅助函数比较两个子树是否镜像：左子树的左节点与右子树的右节点相等，左子树的右节点与右子树的左节点相等。时间复杂度O(n)，空间复杂度O(h)。';
    isSymmetric.hint = '递归比较左右子树是否互为镜像';
    problems.push(isSymmetric);

    // 二叉树的中序遍历
    const inorderTraversal = new ProblemModel();
    inorderTraversal.id = 101;
    inorderTraversal.title = '二叉树的中序遍历';
    inorderTraversal.description = '给定一个二叉树的根节点 root ，返回它的中序遍历。';
    inorderTraversal.difficulty = ProblemDifficulty.EASY;
    inorderTraversal.category = ProblemCategory.BINARY_TREE;
    inorderTraversal.choices = [
      { id: 'A', text: '使用递归：左子树 -> 根节点 -> 右子树', isCorrect: true },
      { id: 'B', text: '使用栈模拟递归过程', isCorrect: false },
      { id: 'C', text: '使用Morris遍历算法', isCorrect: false },
      { id: 'D', text: '使用层序遍历', isCorrect: false }
    ];
    inorderTraversal.explanation =
      '中序遍历顺序：左子树 -> 根节点 -> 右子树。递归实现最简单，迭代实现使用栈，Morris遍历可以实现O(1)空间复杂度。对于二叉搜索树，中序遍历结果是有序的。';
    inorderTraversal.hint = '递归遍历：先左子树，再根节点，最后右子树';
    problems.push(inorderTraversal);

    // 相同的树
    const isSameTree = new ProblemModel();
    isSameTree.id = 102;
    isSameTree.title = '相同的树';
    isSameTree.description =
      '给你两棵二叉树的根节点 p 和 q ，编写一个函数来检验这两棵树是否相同。如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。';
    isSameTree.difficulty = ProblemDifficulty.EASY;
    isSameTree.category = ProblemCategory.BINARY_TREE;
    isSameTree.choices = [
      { id: 'A', text: '递归比较两个树的每个节点', isCorrect: true },
      { id: 'B', text: '分别遍历两个树，比较遍历结果', isCorrect: false },
      { id: 'C', text: '使用层序遍历同时比较', isCorrect: false },
      { id: 'D', text: '比较树的高度和节点数', isCorrect: false }
    ];
    isSameTree.explanation =
      '递归比较：如果两个节点都为空则相同；如果一个为空另一个不为空则不同；如果值不同则不同；否则递归比较左右子树。时间复杂度O(min(m,n))，空间复杂度O(min(m,n))。';
    isSameTree.hint = '递归比较每个对应位置的节点值和结构';
    problems.push(isSameTree);

    // 二叉树的层序遍历
    const levelOrder = new ProblemModel();
    levelOrder.id = 103;
    levelOrder.title = '二叉树的层序遍历';
    levelOrder.description = '给你二叉树的根节点 root ，返回其节点值的层序遍历。（即逐层地，从左到右访问所有节点）。';
    levelOrder.difficulty = ProblemDifficulty.MEDIUM;
    levelOrder.category = ProblemCategory.BINARY_TREE;
    levelOrder.choices = [
      { id: 'A', text: '使用队列进行广度优先搜索', isCorrect: true },
      { id: 'B', text: '使用递归，传递层数参数', isCorrect: false },
      { id: 'C', text: '使用两个栈交替存储', isCorrect: false },
      { id: 'D', text: '使用深度优先搜索', isCorrect: false }
    ];
    levelOrder.explanation =
      '使用队列实现BFS。初始时将根节点入队，然后循环：记录当前层节点数，依次出队并将子节点入队。每层的节点值组成一个数组。时间复杂度O(n)，空间复杂度O(n)。';
    levelOrder.hint = '使用队列进行广度优先搜索，逐层处理节点';
    problems.push(levelOrder);

    // 二叉树的最小深度
    const minDepth = new ProblemModel();
    minDepth.id = 104;
    minDepth.title = '二叉树的最小深度';
    minDepth.description = '给定一个二叉树，找出其最小深度。最小深度是从根节点到最近叶子节点的最短路径上的节点数量。';
    minDepth.difficulty = ProblemDifficulty.EASY;
    minDepth.category = ProblemCategory.BINARY_TREE;
    minDepth.choices = [
      { id: 'A', text: '使用递归，注意处理只有一个子树的情况', isCorrect: true },
      { id: 'B', text: '使用层序遍历，找到第一个叶子节点', isCorrect: false },
      { id: 'C', text: '使用深度优先搜索，记录最小深度', isCorrect: false },
      { id: 'D', text: '先计算最大深度再推导最小深度', isCorrect: false }
    ];
    minDepth.explanation =
      '递归解法需要注意：如果一个节点只有一个子树，最小深度不是1+0=1，而是1+另一个子树的最小深度。只有当节点是叶子节点时，深度才是1。层序遍历也可以，遇到第一个叶子节点就返回。';
    minDepth.hint = '注意只有一个子树的节点，最小深度不是1';
    problems.push(minDepth);

    // 路径总和
    const hasPathSum = new ProblemModel();
    hasPathSum.id = 105;
    hasPathSum.title = '路径总和';
    hasPathSum.description =
      '给你二叉树的根节点 root 和一个表示目标和的整数 targetSum 。判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和 targetSum 。';
    hasPathSum.difficulty = ProblemDifficulty.EASY;
    hasPathSum.category = ProblemCategory.BINARY_TREE;
    hasPathSum.choices = [
      { id: 'A', text: '递归遍历，每次减去当前节点值', isCorrect: true },
      { id: 'B', text: '使用深度优先搜索，维护路径和', isCorrect: false },
      { id: 'C', text: '使用广度优先搜索，同时记录路径和', isCorrect: false },
      { id: 'D', text: '先遍历所有路径，再检查和', isCorrect: false }
    ];
    hasPathSum.explanation =
      '递归解法：每次递归时将目标和减去当前节点值，当到达叶子节点时检查剩余目标和是否为0。时间复杂度O(n)，空间复杂度O(h)。注意叶子节点的定义：左右子树都为空。';
    hasPathSum.hint = '递归时减去当前节点值，叶子节点时检查是否为0';
    problems.push(hasPathSum);

    // 从前序与中序遍历序列构造二叉树
    const buildTree = new ProblemModel();
    buildTree.id = 106;
    buildTree.title = '从前序与中序遍历序列构造二叉树';
    buildTree.description =
      '给定两个整数数组 preorder 和 inorder ，其中 preorder 是二叉树的前序遍历， inorder 是同一棵树的中序遍历，请构造二叉树并返回其根节点。';
    buildTree.difficulty = ProblemDifficulty.MEDIUM;
    buildTree.category = ProblemCategory.BINARY_TREE;
    buildTree.choices = [
      { id: 'A', text: '前序确定根节点，中序确定左右子树范围', isCorrect: true },
      { id: 'B', text: '同时遍历两个数组构建树', isCorrect: false },
      { id: 'C', text: '使用栈模拟构建过程', isCorrect: false },
      { id: 'D', text: '先构建所有节点再连接', isCorrect: false }
    ];
    buildTree.explanation =
      '递归构建：前序遍历的第一个元素是根节点，在中序遍历中找到根节点位置，左边是左子树，右边是右子树。递归构建左右子树。使用哈希表优化中序遍历中根节点的查找。时间复杂度O(n)，空间复杂度O(n)。';
    buildTree.hint = '前序确定根，中序确定左右子树边界';
    problems.push(buildTree);

    // 二叉树的锯齿形层序遍历
    const zigzagLevelOrder = new ProblemModel();
    zigzagLevelOrder.id = 107;
    zigzagLevelOrder.title = '二叉树的锯齿形层序遍历';
    zigzagLevelOrder.description =
      '给你二叉树的根节点 root ，返回其节点值的锯齿形层序遍历。（即先从左往右，再从右往左进行下一层遍历，以此类推，层与层之间交替进行）。';
    zigzagLevelOrder.difficulty = ProblemDifficulty.MEDIUM;
    zigzagLevelOrder.category = ProblemCategory.BINARY_TREE;
    zigzagLevelOrder.choices = [
      { id: 'A', text: '层序遍历，奇数层反转结果', isCorrect: true },
      { id: 'B', text: '使用两个栈交替存储', isCorrect: false },
      { id: 'C', text: '使用双端队列', isCorrect: false },
      { id: 'D', text: '递归遍历，根据层数决定顺序', isCorrect: false }
    ];
    zigzagLevelOrder.explanation =
      '在普通层序遍历基础上，根据层数奇偶性决定是否反转当前层结果。也可以使用双端队列或两个栈实现。时间复杂度O(n)，空间复杂度O(n)。';
    zigzagLevelOrder.hint = '层序遍历基础上，奇数层反转结果';
    problems.push(zigzagLevelOrder);

    // 验证二叉搜索树
    const isValidBST = new ProblemModel();
    isValidBST.id = 108;
    isValidBST.title = '验证二叉搜索树';
    isValidBST.description = '给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。';
    isValidBST.difficulty = ProblemDifficulty.MEDIUM;
    isValidBST.category = ProblemCategory.BINARY_TREE;
    isValidBST.choices = [
      { id: 'A', text: '递归验证，传递上下界限制', isCorrect: true },
      { id: 'B', text: '中序遍历，检查是否严格递增', isCorrect: false },
      { id: 'C', text: '比较每个节点与左右子树的最值', isCorrect: false },
      { id: 'D', text: '层序遍历，检查每层的顺序', isCorrect: false }
    ];
    isValidBST.explanation =
      '递归验证时需要传递上下界。对于每个节点，其值必须在(min, max)范围内，左子树的上界是当前节点值，右子树的下界是当前节点值。中序遍历也可以，但需要注意相等值的处理。';
    isValidBST.hint = '递归时传递上下界限制，不只是比较父子节点';
    problems.push(isValidBST);

    // 二叉树的右视图
    const rightSideView = new ProblemModel();
    rightSideView.id = 109;
    rightSideView.title = '二叉树的右视图';
    rightSideView.description =
      '给定一个二叉树的根节点 root，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。';
    rightSideView.difficulty = ProblemDifficulty.MEDIUM;
    rightSideView.category = ProblemCategory.BINARY_TREE;
    rightSideView.choices = [
      { id: 'A', text: '层序遍历，取每层最后一个节点', isCorrect: true },
      { id: 'B', text: '深度优先搜索，优先遍历右子树', isCorrect: false },
      { id: 'C', text: '前序遍历，记录每层第一次访问的节点', isCorrect: false },
      { id: 'D', text: '中序遍历，找到最右边的节点', isCorrect: false }
    ];
    rightSideView.explanation =
      '层序遍历每层最后一个节点就是右视图。也可以用DFS，优先遍历右子树，每层第一次访问的节点就是右视图节点。时间复杂度O(n)，空间复杂度O(n)。';
    rightSideView.hint = '层序遍历，每层的最后一个节点就是右视图';
    problems.push(rightSideView);

    // 二叉树展开为链表
    const flatten = new ProblemModel();
    flatten.id = 110;
    flatten.title = '二叉树展开为链表';
    flatten.description =
      '给你二叉树的根结点 root ，请你将它展开为一个单链表：展开后的单链表应该同样使用 TreeNode ，其中 right 子指针指向链表中下一个结点，而左子指针始终为 null 。';
    flatten.difficulty = ProblemDifficulty.MEDIUM;
    flatten.category = ProblemCategory.BINARY_TREE;
    flatten.choices = [
      { id: 'A', text: '前序遍历，重新连接节点', isCorrect: false },
      { id: 'B', text: '后序遍历，自底向上处理', isCorrect: true },
      { id: 'C', text: '使用栈存储节点', isCorrect: false },
      { id: 'D', text: 'Morris遍历算法', isCorrect: false }
    ];
    flatten.explanation =
      '后序遍历是最优解法：先处理右子树和左子树，然后将左子树插入到根节点和右子树之间。具体：将左子树的最右节点连接到右子树，然后将左子树移到右边，左指针置空。';
    flatten.hint = '后序遍历，将左子树插入到根节点和右子树之间';
    problems.push(flatten);

    // 路径总和II
    const pathSum = new ProblemModel();
    pathSum.id = 111;
    pathSum.title = '路径总和II';
    pathSum.description =
      '给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有从根节点到叶子节点路径总和等于给定目标和的路径。';
    pathSum.difficulty = ProblemDifficulty.MEDIUM;
    pathSum.category = ProblemCategory.BINARY_TREE;
    pathSum.choices = [
      { id: 'A', text: '深度优先搜索，回溯记录路径', isCorrect: true },
      { id: 'B', text: '广度优先搜索，记录路径和节点', isCorrect: false },
      { id: 'C', text: '先找到所有路径，再筛选符合条件的', isCorrect: false },
      { id: 'D', text: '使用动态规划记录路径', isCorrect: false }
    ];
    pathSum.explanation =
      'DFS+回溯：遍历过程中维护当前路径和剩余目标和，到达叶子节点时检查目标和是否为0。回溯时需要移除当前节点。时间复杂度O(n²)，空间复杂度O(n)。';
    pathSum.hint = '深度优先搜索配合回溯，维护当前路径';
    problems.push(pathSum);

    // 二叉搜索树中第K小的元素
    const kthSmallest = new ProblemModel();
    kthSmallest.id = 112;
    kthSmallest.title = '二叉搜索树中第K小的元素';
    kthSmallest.description =
      '给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小的元素（从 1 开始计数）。';
    kthSmallest.difficulty = ProblemDifficulty.MEDIUM;
    kthSmallest.category = ProblemCategory.BINARY_TREE;
    kthSmallest.choices = [
      { id: 'A', text: '中序遍历，计数到第k个元素', isCorrect: true },
      { id: 'B', text: '层序遍历，使用优先队列', isCorrect: false },
      { id: 'C', text: '前序遍历，排序后取第k个', isCorrect: false },
      { id: 'D', text: '后序遍历，从小到大计数', isCorrect: false }
    ];
    kthSmallest.explanation =
      '利用BST的性质：中序遍历结果是有序的。进行中序遍历，计数到第k个元素时返回。可以用递归或迭代实现，迭代版本可以提前终止。时间复杂度O(H+k)，空间复杂度O(H)。';
    kthSmallest.hint = '利用BST中序遍历有序的特性';
    problems.push(kthSmallest);

    // 二叉树的最近公共祖先
    const lowestCommonAncestor = new ProblemModel();
    lowestCommonAncestor.id = 113;
    lowestCommonAncestor.title = '二叉树的最近公共祖先';
    lowestCommonAncestor.description = '给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。';
    lowestCommonAncestor.difficulty = ProblemDifficulty.MEDIUM;
    lowestCommonAncestor.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestor.choices = [
      { id: 'A', text: '递归查找，如果左右子树都找到目标节点则当前节点是LCA', isCorrect: true },
      { id: 'B', text: '先找到两个节点的路径，再找路径的分叉点', isCorrect: false },
      { id: 'C', text: '使用父指针，从一个节点向上找到另一个节点', isCorrect: false },
      { id: 'D', text: '层序遍历，记录每个节点的父节点', isCorrect: false }
    ];
    lowestCommonAncestor.explanation =
      '递归解法：如果当前节点是目标节点之一，返回当前节点；否则递归查找左右子树。如果左右子树都返回非空，说明两个目标节点分别在左右子树，当前节点是LCA；如果只有一边返回非空，返回非空的那一边。';
    lowestCommonAncestor.hint = '递归查找，左右子树都有目标节点时当前节点就是LCA';
    problems.push(lowestCommonAncestor);

    // 二叉搜索树的最近公共祖先
    const lowestCommonAncestorBST = new ProblemModel();
    lowestCommonAncestorBST.id = 114;
    lowestCommonAncestorBST.title = '二叉搜索树的最近公共祖先';
    lowestCommonAncestorBST.description = '给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。';
    lowestCommonAncestorBST.difficulty = ProblemDifficulty.EASY;
    lowestCommonAncestorBST.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestorBST.choices = [
      { id: 'A', text: '利用BST性质，比较节点值大小', isCorrect: true },
      { id: 'B', text: '使用普通二叉树的LCA算法', isCorrect: false },
      { id: 'C', text: '中序遍历找到两个节点的位置', isCorrect: false },
      { id: 'D', text: '层序遍历，记录路径', isCorrect: false }
    ];
    lowestCommonAncestorBST.explanation =
      '利用BST性质：如果两个节点值都小于当前节点，LCA在左子树；如果都大于当前节点，LCA在右子树；否则当前节点就是LCA。可以用递归或迭代实现。时间复杂度O(h)，空间复杂度O(1)。';
    lowestCommonAncestorBST.hint = '利用BST性质，比较节点值确定搜索方向';
    problems.push(lowestCommonAncestorBST);

    // 二叉树的序列化与反序列化
    const serialize = new ProblemModel();
    serialize.id = 115;
    serialize.title = '二叉树的序列化与反序列化';
    serialize.description =
      '序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。';
    serialize.difficulty = ProblemDifficulty.HARD;
    serialize.category = ProblemCategory.BINARY_TREE;
    serialize.choices = [
      { id: 'A', text: '使用前序遍历，空节点用特殊符号表示', isCorrect: true },
      { id: 'B', text: '使用层序遍历，记录每层的节点', isCorrect: false },
      { id: 'C', text: '使用中序和前序遍历结合', isCorrect: false },
      { id: 'D', text: '使用后序遍历，自底向上构建', isCorrect: false }
    ];
    serialize.explanation =
      '前序遍历序列化：遍历时将节点值和空节点（用null表示）都记录下来。反序列化时按前序顺序重建树。也可以用层序遍历，但需要处理更多细节。关键是选择合适的遍历方式和空节点表示。';
    serialize.hint = '前序遍历序列化，空节点用特殊符号表示';
    problems.push(serialize);

    // 完全二叉树的节点个数
    const countNodes = new ProblemModel();
    countNodes.id = 116;
    countNodes.title = '完全二叉树的节点个数';
    countNodes.description = '给你一棵完全二叉树的根节点 root ，求出该树的节点个数。';
    countNodes.difficulty = ProblemDifficulty.MEDIUM;
    countNodes.category = ProblemCategory.BINARY_TREE;
    countNodes.choices = [
      { id: 'A', text: '利用完全二叉树性质，递归计算', isCorrect: true },
      { id: 'B', text: '直接遍历所有节点计数', isCorrect: false },
      { id: 'C', text: '层序遍历，统计每层节点数', isCorrect: false },
      { id: 'D', text: '计算树的高度，推导节点数', isCorrect: false }
    ];
    countNodes.explanation =
      '利用完全二叉树性质：比较左右子树高度，如果相等则左子树是满二叉树，节点数=2^h-1+1+右子树节点数；如果不等则右子树是满二叉树。时间复杂度O(log²n)，优于直接遍历的O(n)。';
    countNodes.hint = '利用完全二叉树性质，比较左右子树高度';
    problems.push(countNodes);

    // 翻转二叉树
    const invertTree = new ProblemModel();
    invertTree.id = 117;
    invertTree.title = '翻转二叉树';
    invertTree.description = '给你一棵二叉树的根节点 root ，翻转这棵二叉树，并返回其根节点。';
    invertTree.difficulty = ProblemDifficulty.EASY;
    invertTree.category = ProblemCategory.BINARY_TREE;
    invertTree.choices = [
      { id: 'A', text: '递归交换每个节点的左右子树', isCorrect: true },
      { id: 'B', text: '使用栈进行迭代交换', isCorrect: false },
      { id: 'C', text: '使用队列进行层序遍历交换', isCorrect: false },
      { id: 'D', text: '先遍历记录结构，再重新构建', isCorrect: false }
    ];
    invertTree.explanation =
      '递归解法最简洁：交换当前节点的左右子树，然后递归翻转左右子树。也可以用迭代方法，使用栈或队列存储待处理的节点。时间复杂度O(n)，空间复杂度O(h)。';
    invertTree.hint = '递归交换每个节点的左右子树';
    problems.push(invertTree);

    // 二叉搜索树中的插入操作
    const insertIntoBST = new ProblemModel();
    insertIntoBST.id = 118;
    insertIntoBST.title = '二叉搜索树中的插入操作';
    insertIntoBST.description =
      '给定二叉搜索树（BST）的根节点 root 和要插入树中的值 value ，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。';
    insertIntoBST.difficulty = ProblemDifficulty.MEDIUM;
    insertIntoBST.category = ProblemCategory.BINARY_TREE;
    insertIntoBST.choices = [
      { id: 'A', text: '递归查找插入位置，在叶子节点插入', isCorrect: true },
      { id: 'B', text: '先找到插入位置，再调整树结构', isCorrect: false },
      { id: 'C', text: '插入后进行平衡调整', isCorrect: false },
      { id: 'D', text: '转换为数组插入后重建树', isCorrect: false }
    ];
    insertIntoBST.explanation =
      '利用BST性质递归查找：如果值小于当前节点值，插入左子树；如果大于，插入右子树；如果当前节点为空，创建新节点。插入操作不会破坏BST性质，且总是在叶子位置插入。时间复杂度O(h)。';
    insertIntoBST.hint = '利用BST性质递归查找插入位置';
    problems.push(insertIntoBST);

    // 删除二叉搜索树中的节点
    const deleteNode = new ProblemModel();
    deleteNode.id = 119;
    deleteNode.title = '删除二叉搜索树中的节点';
    deleteNode.description =
      '给定一个二叉搜索树的根节点 root 和一个值 key，删除二叉搜索树中的 key 对应的节点，并保证二叉搜索树的性质不变。返回二叉搜索树（有可能被更新）的根节点的引用。';
    deleteNode.difficulty = ProblemDifficulty.MEDIUM;
    deleteNode.category = ProblemCategory.BINARY_TREE;
    deleteNode.choices = [
      { id: 'A', text: '分情况处理：叶子节点、只有一个子树、有两个子树', isCorrect: true },
      { id: 'B', text: '先找到节点，再用中序遍历重建树', isCorrect: false },
      { id: 'C', text: '转换为数组删除后重建树', isCorrect: false },
      { id: 'D', text: '标记删除，不实际移除节点', isCorrect: false }
    ];
    deleteNode.explanation =
      '分三种情况：1.叶子节点直接删除；2.只有一个子树，用子树替换；3.有两个子树，用中序后继（右子树最小值）或中序前驱（左子树最大值）替换，然后递归删除后继/前驱节点。';
    deleteNode.hint = '分情况处理，有两个子树时用中序后继替换';
    problems.push(deleteNode);

    // 把二叉搜索树转换为累加树
    const convertBST = new ProblemModel();
    convertBST.id = 120;
    convertBST.title = '把二叉搜索树转换为累加树';
    convertBST.description =
      '给出二叉搜索树的根节点，该树的节点值各不相同，请你将其转换为累加树（Greater Sum Tree），使每个节点 node 的新值等于原树中大于或等于 node.val 的值之和。';
    convertBST.difficulty = ProblemDifficulty.MEDIUM;
    convertBST.category = ProblemCategory.BINARY_TREE;
    convertBST.choices = [
      { id: 'A', text: '反向中序遍历（右-根-左），累加节点值', isCorrect: true },
      { id: 'B', text: '先中序遍历得到有序数组，再计算累加和', isCorrect: false },
      { id: 'C', text: '层序遍历，计算每个节点的累加值', isCorrect: false },
      { id: 'D', text: '前序遍历，递归计算累加和', isCorrect: false }
    ];
    convertBST.explanation =
      '反向中序遍历（右-根-左）可以按从大到小的顺序访问节点。维护一个累加和变量，每访问一个节点就将其值加到累加和中，然后用累加和更新节点值。时间复杂度O(n)，空间复杂度O(h)。';
    convertBST.hint = '反向中序遍历，从大到小累加节点值';
    problems.push(convertBST);

    return problems;
  }

  /**
   * 动态规划类题目
   */
  private static getDynamicProgrammingProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 爬楼梯
    const climbStairs = new ProblemModel();
    climbStairs.id = 10;
    climbStairs.title = '爬楼梯';
    climbStairs.description =
      '假设你正在爬楼梯。需要 n 阶你才能到达楼顶。\n\n每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？';
    climbStairs.difficulty = ProblemDifficulty.EASY;
    climbStairs.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    climbStairs.choices = [
      { id: 'A', text: '使用递归：f(n) = f(n-1) + f(n-2)', isCorrect: false },
      { id: 'B', text: '使用动态规划：dp[i] = dp[i-1] + dp[i-2]', isCorrect: true },
      { id: 'C', text: '使用数学公式直接计算', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有可能', isCorrect: false }
    ];
    climbStairs.explanation =
      '这是经典的斐波那契数列问题。到达第n阶的方法数等于到达第n-1阶和第n-2阶的方法数之和。使用动态规划避免重复计算，时间复杂度O(n)，空间复杂度可以优化到O(1)。直接递归会导致大量重复计算，时间复杂度为O(2^n)。';
    climbStairs.hint = '这是斐波那契数列问题，考虑动态规划避免重复计算';
    problems.push(climbStairs);

    // 最大子数组和
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 141;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description =
      '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxSubArray.choices = [
      { id: 'A', text: '使用Kadane算法，动态规划', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '分治算法', isCorrect: false },
      { id: 'D', text: '前缀和优化', isCorrect: false }
    ];
    maxSubArray.explanation =
      'Kadane算法：dp[i]表示以第i个元素结尾的最大子数组和。状态转移：dp[i] = max(nums[i], dp[i-1] + nums[i])。可以优化空间复杂度到O(1)。时间复杂度O(n)，是最优解法。';
    maxSubArray.hint = '使用Kadane算法，考虑当前元素是重新开始还是继续累加';
    problems.push(maxSubArray);

    // 打家劫舍
    const rob = new ProblemModel();
    rob.id = 142;
    rob.title = '打家劫舍';
    rob.description =
      '你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。';
    rob.difficulty = ProblemDifficulty.MEDIUM;
    rob.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    rob.choices = [
      { id: 'A', text: '动态规划：dp[i] = max(dp[i-1], dp[i-2] + nums[i])', isCorrect: true },
      { id: 'B', text: '贪心算法：总是选择最大值', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有可能', isCorrect: false },
      { id: 'D', text: '分治算法：分别考虑偷和不偷', isCorrect: false }
    ];
    rob.explanation =
      '经典动态规划问题。dp[i]表示前i间房屋能偷到的最大金额。对于第i间房屋，可以选择偷（dp[i-2] + nums[i]）或不偷（dp[i-1]），取最大值。时间复杂度O(n)，空间复杂度可优化到O(1)。';
    rob.hint = '对于每间房屋，考虑偷与不偷两种情况的最大收益';
    problems.push(rob);

    // 最长递增子序列
    const lengthOfLIS = new ProblemModel();
    lengthOfLIS.id = 143;
    lengthOfLIS.title = '最长递增子序列';
    lengthOfLIS.description = '给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。';
    lengthOfLIS.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLIS.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    lengthOfLIS.choices = [
      { id: 'A', text: '动态规划：dp[i]表示以第i个元素结尾的最长递增子序列长度', isCorrect: true },
      { id: 'B', text: '贪心+二分查找：维护一个递增数组', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有子序列', isCorrect: false },
      { id: 'D', text: '分治算法：分别处理左右两部分', isCorrect: false }
    ];
    lengthOfLIS.explanation =
      'DP解法：dp[i]表示以nums[i]结尾的最长递增子序列长度。对于每个i，遍历前面所有j，如果nums[j] < nums[i]，则dp[i] = max(dp[i], dp[j] + 1)。时间复杂度O(n²)。贪心+二分可优化到O(nlogn)。';
    lengthOfLIS.hint = '考虑以每个元素结尾的最长递增子序列';
    problems.push(lengthOfLIS);

    // 零钱兑换
    const coinChange = new ProblemModel();
    coinChange.id = 144;
    coinChange.title = '零钱兑换';
    coinChange.description =
      '给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。计算并返回可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1 。';
    coinChange.difficulty = ProblemDifficulty.MEDIUM;
    coinChange.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    coinChange.choices = [
      { id: 'A', text: '动态规划：dp[i]表示凑成金额i所需的最少硬币数', isCorrect: true },
      { id: 'B', text: '贪心算法：优先使用大面额硬币', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有组合', isCorrect: false },
      { id: 'D', text: 'BFS：层序遍历所有可能', isCorrect: false }
    ];
    coinChange.explanation =
      '完全背包问题变种。dp[i]表示凑成金额i的最少硬币数。状态转移：dp[i] = min(dp[i], dp[i-coin] + 1)，遍历所有硬币面额。初始化dp[0] = 0，其他为无穷大。时间复杂度O(amount * coins.length)。';
    coinChange.hint = '完全背包问题，考虑每种硬币可以使用多次';
    problems.push(coinChange);

    // 最长公共子序列
    const longestCommonSubsequence = new ProblemModel();
    longestCommonSubsequence.id = 145;
    longestCommonSubsequence.title = '最长公共子序列';
    longestCommonSubsequence.description =
      '给定两个字符串 text1 和 text2，返回这两个字符串的最长公共子序列的长度。如果不存在公共子序列，返回 0 。';
    longestCommonSubsequence.difficulty = ProblemDifficulty.MEDIUM;
    longestCommonSubsequence.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    longestCommonSubsequence.choices = [
      { id: 'A', text: '二维DP：dp[i][j]表示text1前i个字符和text2前j个字符的LCS长度', isCorrect: false },
      { id: 'B', text: '递归+记忆化搜索', isCorrect: true },
      { id: 'C', text: '贪心算法：逐个匹配字符', isCorrect: false },
      { id: 'D', text: '双指针：同时遍历两个字符串', isCorrect: false }
    ];
    longestCommonSubsequence.explanation =
      '经典二维DP问题。如果text1[i-1] == text2[j-1]，则dp[i][j] = dp[i-1][j-1] + 1；否则dp[i][j] = max(dp[i-1][j], dp[i][j-1])。时间复杂度O(m*n)，空间复杂度可优化到O(min(m,n))。';
    longestCommonSubsequence.hint = '二维DP，考虑字符相等和不等两种情况';
    problems.push(longestCommonSubsequence);

    // 编辑距离
    const minDistance = new ProblemModel();
    minDistance.id = 146;
    minDistance.title = '编辑距离';
    minDistance.description =
      '给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数。你可以对一个单词进行如下三种操作：插入一个字符、删除一个字符、替换一个字符。';
    minDistance.difficulty = ProblemDifficulty.HARD;
    minDistance.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    minDistance.choices = [
      { id: 'A', text: '二维DP：考虑插入、删除、替换三种操作', isCorrect: false },
      { id: 'B', text: '贪心算法：优先进行代价最小的操作', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有操作序列', isCorrect: true },
      { id: 'D', text: 'BFS：层序遍历所有可能的状态', isCorrect: false }
    ];
    minDistance.explanation =
      'Levenshtein距离问题。dp[i][j]表示word1前i个字符转换为word2前j个字符的最少操作数。如果字符相等，dp[i][j] = dp[i-1][j-1]；否则考虑三种操作的最小值加1。时间复杂度O(m*n)。';
    minDistance.hint = '考虑插入、删除、替换三种操作，取最小值';
    problems.push(minDistance);

    // 不同路径
    const uniquePaths = new ProblemModel();
    uniquePaths.id = 147;
    uniquePaths.title = '不同路径';
    uniquePaths.description =
      '一个机器人位于一个 m x n 网格的左上角。机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角。问总共有多少条不同的路径？';
    uniquePaths.difficulty = ProblemDifficulty.MEDIUM;
    uniquePaths.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    uniquePaths.choices = [
      { id: 'A', text: '动态规划：dp[i][j] = dp[i-1][j] + dp[i][j-1]', isCorrect: false },
      { id: 'B', text: '数学公式：组合数C(m+n-2, m-1)', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有路径', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索', isCorrect: true }
    ];
    uniquePaths.explanation =
      '经典路径计数问题。到达位置(i,j)的路径数等于到达(i-1,j)和(i,j-1)的路径数之和。边界条件：第一行和第一列都是1。时间复杂度O(m*n)，空间复杂度可优化到O(min(m,n))。也可用组合数学公式直接计算。';
    uniquePaths.hint = '到达某点的路径数等于其上方和左方路径数之和';
    problems.push(uniquePaths);

    // 最小路径和
    const minPathSum = new ProblemModel();
    minPathSum.id = 148;
    minPathSum.title = '最小路径和';
    minPathSum.description =
      '给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。说明：每次只能向下或者向右移动一步。';
    minPathSum.difficulty = ProblemDifficulty.MEDIUM;
    minPathSum.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    minPathSum.choices = [
      { id: 'A', text: '动态规划：dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]', isCorrect: false },
      { id: 'B', text: '贪心算法：每次选择较小的相邻值', isCorrect: true },
      { id: 'C', text: 'Dijkstra算法：最短路径算法', isCorrect: false },
      { id: 'D', text: 'A*算法：启发式搜索', isCorrect: false }
    ];
    minPathSum.explanation =
      '路径优化问题。dp[i][j]表示到达位置(i,j)的最小路径和。状态转移：从上方或左方选择较小值加上当前格子值。边界条件需要特殊处理。时间复杂度O(m*n)，可以原地修改节省空间。';
    minPathSum.hint = '选择上方和左方路径和的较小值，加上当前位置的值';
    problems.push(minPathSum);

    // 买卖股票的最佳时机
    const maxProfit = new ProblemModel();
    maxProfit.id = 149;
    maxProfit.title = '买卖股票的最佳时机';
    maxProfit.description =
      '给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。你只能选择某一天买入这只股票，并选择在未来的某一天卖出该股票。设计一个算法来计算你所能获取的最大利润。';
    maxProfit.difficulty = ProblemDifficulty.EASY;
    maxProfit.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProfit.choices = [
      { id: 'A', text: '一次遍历：记录最低价格，计算最大利润', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i]表示第i天的最大利润', isCorrect: false },
      { id: 'C', text: '暴力枚举：所有买卖组合', isCorrect: false },
      { id: 'D', text: '分治算法：分别处理左右两部分', isCorrect: true }
    ];
    maxProfit.explanation =
      '贪心思想：维护到目前为止的最低价格，计算当前价格卖出的利润。一次遍历即可解决，时间复杂度O(n)，空间复杂度O(1)。也可以用DP思想：维护持有和不持有股票的最大利润。';
    maxProfit.hint = '记录历史最低价格，计算当前卖出的最大利润';
    problems.push(maxProfit);

    // 买卖股票的最佳时机II
    const maxProfitII = new ProblemModel();
    maxProfitII.id = 150;
    maxProfitII.title = '买卖股票的最佳时机II';
    maxProfitII.description =
      '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候最多只能持有一股股票。你也可以先购买，然后在同一天出售。';
    maxProfitII.difficulty = ProblemDifficulty.MEDIUM;
    maxProfitII.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProfitII.choices = [
      { id: 'A', text: '贪心算法：累加所有正收益', isCorrect: false },
      { id: 'B', text: '动态规划：维护持有和不持有股票的状态', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有买卖策略', isCorrect: true },
      { id: 'D', text: '分治算法：分别处理不同时间段', isCorrect: false }
    ];
    maxProfitII.explanation =
      '贪心策略：只要第二天价格比今天高就买入并在第二天卖出，累加所有正收益。等价于累加所有相邻上升的差值。时间复杂度O(n)，空间复杂度O(1)。DP解法也可以，但贪心更简洁。';
    maxProfitII.hint = '累加所有相邻天数的正收益';
    problems.push(maxProfitII);

    // 最长回文子序列
    const longestPalindromeSubseq = new ProblemModel();
    longestPalindromeSubseq.id = 151;
    longestPalindromeSubseq.title = '最长回文子序列';
    longestPalindromeSubseq.description = '给你一个字符串 s ，找出其中最长的回文子序列，并返回该序列的长度。';
    longestPalindromeSubseq.difficulty = ProblemDifficulty.MEDIUM;
    longestPalindromeSubseq.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    longestPalindromeSubseq.choices = [
      { id: 'A', text: '区间DP：dp[i][j]表示s[i..j]的最长回文子序列长度', isCorrect: false },
      { id: 'B', text: '中心扩展：以每个字符为中心扩展', isCorrect: false },
      { id: 'C', text: '递归+记忆化：从两端向中间递归', isCorrect: false },
      { id: 'D', text: '转换为LCS：s与reverse(s)的最长公共子序列', isCorrect: true }
    ];
    longestPalindromeSubseq.explanation =
      '区间DP问题。如果s[i] == s[j]，则dp[i][j] = dp[i+1][j-1] + 2；否则dp[i][j] = max(dp[i+1][j], dp[i][j-1])。注意遍历顺序：按区间长度从小到大。时间复杂度O(n²)，空间复杂度O(n²)。';
    longestPalindromeSubseq.hint = '区间DP，考虑两端字符相等和不等的情况';
    problems.push(longestPalindromeSubseq);

    // 分割等和子集
    const canPartition = new ProblemModel();
    canPartition.id = 152;
    canPartition.title = '分割等和子集';
    canPartition.description =
      '给你一个只包含正整数的非空数组 nums 。请你判断是否可以将这个数组分割成两个子集，使得两个子集的元素和相等。';
    canPartition.difficulty = ProblemDifficulty.MEDIUM;
    canPartition.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    canPartition.choices = [
      { id: 'A', text: '0-1背包问题：目标是数组和的一半', isCorrect: false },
      { id: 'B', text: '回溯算法：枚举所有子集', isCorrect: true },
      { id: 'C', text: '贪心算法：优先选择大的数字', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索所有可能', isCorrect: false }
    ];
    canPartition.explanation =
      '转换为0-1背包问题：能否用数组中的数字凑成总和的一半。dp[i]表示是否能凑成和为i。状态转移：dp[i] = dp[i] || dp[i-num]。优化：从后往前遍历避免重复使用。时间复杂度O(n*sum)。';
    canPartition.hint = '转换为背包问题，目标是凑成总和的一半';
    problems.push(canPartition);

    // 目标和
    const findTargetSumWays = new ProblemModel();
    findTargetSumWays.id = 153;
    findTargetSumWays.title = '目标和';
    findTargetSumWays.description =
      '给你一个整数数组 nums 和一个整数 target 。向数组中的每个整数前添加 + 或 - ，然后串联起所有整数，可以构造一个表达式。返回可以通过上述方法构造的、运算结果等于 target 的不同表达式的数目。';
    findTargetSumWays.difficulty = ProblemDifficulty.MEDIUM;
    findTargetSumWays.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    findTargetSumWays.choices = [
      { id: 'A', text: '转换为0-1背包：找到和为(sum+target)/2的子集个数', isCorrect: false },
      { id: 'B', text: '回溯算法：枚举每个数字的正负号', isCorrect: false },
      { id: 'C', text: 'DFS+记忆化：递归搜索所有可能', isCorrect: true },
      { id: 'D', text: '动态规划：dp[i][j]表示前i个数字和为j的方案数', isCorrect: false }
    ];
    findTargetSumWays.explanation =
      '数学转换：设正数和为P，负数和为N，则P-N=target，P+N=sum，解得P=(sum+target)/2。问题转换为：有多少种方法选择数字使和为P。这是经典的0-1背包计数问题。';
    findTargetSumWays.hint = '转换为背包计数问题，目标是(sum+target)/2';
    problems.push(findTargetSumWays);

    // 完全平方数
    const numSquares = new ProblemModel();
    numSquares.id = 154;
    numSquares.title = '完全平方数';
    numSquares.description =
      '给你一个整数 n ，返回和为 n 的完全平方数的最少数量。完全平方数是一个整数，其值等于另一个整数的平方；换句话说，其值等于一个整数自乘的积。';
    numSquares.difficulty = ProblemDifficulty.MEDIUM;
    numSquares.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    numSquares.choices = [
      { id: 'A', text: '动态规划：dp[i] = min(dp[i], dp[i-j*j] + 1)', isCorrect: false },
      { id: 'B', text: 'BFS：层序遍历找到最短路径', isCorrect: false },
      { id: 'C', text: '数学定理：四平方和定理', isCorrect: false },
      { id: 'D', text: '贪心算法：优先使用大的完全平方数', isCorrect: true }
    ];
    numSquares.explanation =
      '完全背包问题变种。dp[i]表示和为i的完全平方数的最少数量。对于每个i，尝试所有可能的完全平方数j²，状态转移：dp[i] = min(dp[i], dp[i-j²] + 1)。时间复杂度O(n*√n)。';
    numSquares.hint = '完全背包问题，每个完全平方数可以使用多次';
    problems.push(numSquares);

    // 单词拆分
    const wordBreak = new ProblemModel();
    wordBreak.id = 155;
    wordBreak.title = '单词拆分';
    wordBreak.description =
      '给你一个字符串 s 和一个字符串列表 wordDict 作为字典。请你判断是否可以利用字典中出现的单词拼接出 s 。注意：不要求字典中出现的单词全部都使用，并且字典中的单词可以重复使用。';
    wordBreak.difficulty = ProblemDifficulty.MEDIUM;
    wordBreak.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    wordBreak.choices = [
      { id: 'A', text: '动态规划：dp[i]表示前i个字符是否可以拆分', isCorrect: false },
      { id: 'B', text: '回溯算法：尝试所有可能的拆分', isCorrect: true },
      { id: 'C', text: 'DFS+记忆化：递归搜索', isCorrect: false },
      { id: 'D', text: '贪心算法：优先匹配长单词', isCorrect: false }
    ];
    wordBreak.explanation =
      'DP问题。dp[i]表示字符串前i个字符是否可以被拆分。状态转移：对于每个位置i，检查所有可能的单词结尾位置j，如果dp[j]为true且s[j:i]在字典中，则dp[i] = true。时间复杂度O(n²)。';
    wordBreak.hint = '检查每个位置是否可以作为某个字典单词的结尾';
    problems.push(wordBreak);

    // 乘积最大子数组
    const maxProduct = new ProblemModel();
    maxProduct.id = 156;
    maxProduct.title = '乘积最大子数组';
    maxProduct.description =
      '给你一个整数数组 nums ，请你找出数组中乘积最大的非空连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。';
    maxProduct.difficulty = ProblemDifficulty.MEDIUM;
    maxProduct.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProduct.choices = [
      { id: 'A', text: '同时维护最大值和最小值：负数可能变成最大值', isCorrect: true },
      { id: 'B', text: '只维护最大值，类似最大子数组和', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'D', text: '分治算法：处理正负数分布', isCorrect: false }
    ];
    maxProduct.explanation =
      '需要同时维护最大值和最小值，因为负数乘以最小值可能得到最大值。maxDP[i] = max(nums[i], maxDP[i-1]*nums[i], minDP[i-1]*nums[i])，minDP类似。时间复杂度O(n)，空间复杂度O(1)。';
    maxProduct.hint = '同时维护最大值和最小值，负数会改变大小关系';
    problems.push(maxProduct);

    // 解码方法
    const numDecodings = new ProblemModel();
    numDecodings.id = 157;
    numDecodings.title = '解码方法';
    numDecodings.description =
      '一条包含字母 A-Z 的消息通过以下映射进行了编码：A->1, B->2, ..., Z->26。要解码已编码的消息，所有数字必须基于上述映射的方法，反向映射回字母（可能有多种方法）。给你一个只含数字的非空字符串 s ，请计算并返回解码方法的总数。';
    numDecodings.difficulty = ProblemDifficulty.MEDIUM;
    numDecodings.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    numDecodings.choices = [
      { id: 'A', text: '动态规划：dp[i] = dp[i-1] + dp[i-2]（满足条件时）', isCorrect: true },
      { id: 'B', text: '回溯算法：枚举所有可能的解码方式', isCorrect: false },
      { id: 'C', text: '贪心算法：优先选择较大的数字', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索所有路径', isCorrect: false }
    ];
    numDecodings.explanation =
      '类似爬楼梯问题。dp[i]表示前i个字符的解码方法数。如果当前字符不为0，dp[i] += dp[i-1]；如果前两个字符组成的数字在10-26之间，dp[i] += dp[i-2]。需要特别处理0的情况。';
    numDecodings.hint = '类似斐波那契，考虑单个字符和两个字符的解码';
    problems.push(numDecodings);

    // 跳跃游戏
    const canJump = new ProblemModel();
    canJump.id = 158;
    canJump.title = '跳跃游戏';
    canJump.description =
      '给定一个非负整数数组 nums ，你最初位于数组的第一个下标。数组中的每个元素代表你在该位置可以跳跃的最大长度。判断你是否能够到达最后一个下标。';
    canJump.difficulty = ProblemDifficulty.MEDIUM;
    canJump.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    canJump.choices = [
      { id: 'A', text: '贪心算法：维护能到达的最远位置', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示是否能到达位置i', isCorrect: false },
      { id: 'C', text: '回溯算法：尝试所有可能的跳跃', isCorrect: false },
      { id: 'D', text: 'BFS：层序遍历所有可达位置', isCorrect: false }
    ];
    canJump.explanation =
      '贪心策略：维护当前能到达的最远位置。遍历数组，如果当前位置在可达范围内，更新最远位置为max(最远位置, i + nums[i])。如果最远位置≥数组长度-1，返回true。时间复杂度O(n)。';
    canJump.hint = '贪心维护能到达的最远位置';
    problems.push(canJump);

    // 跳跃游戏II
    const jump = new ProblemModel();
    jump.id = 159;
    jump.title = '跳跃游戏II';
    jump.description =
      '给定一个长度为 n 的 0 索引整数数组 nums。初始位置为 nums[0]。每个元素 nums[i] 表示从索引 i 向前跳转的最大长度。换句话说，如果你在 nums[i] 处，你可以跳转到任意 nums[i + j] 处。返回到达 nums[n - 1] 的最小跳跃次数。';
    jump.difficulty = ProblemDifficulty.MEDIUM;
    jump.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    jump.choices = [
      { id: 'A', text: '贪心算法：在当前跳跃范围内选择能跳得最远的位置', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示到达位置i的最少跳跃次数', isCorrect: false },
      { id: 'C', text: 'BFS：层序遍历，每层表示跳跃次数', isCorrect: false },
      { id: 'D', text: '回溯算法：尝试所有可能的跳跃路径', isCorrect: false }
    ];
    jump.explanation =
      '贪心策略：在当前跳跃能到达的范围内，选择下一跳能到达最远位置的点。维护当前跳跃的边界，当到达边界时跳跃次数+1，更新新的边界。时间复杂度O(n)，空间复杂度O(1)。';
    jump.hint = '在当前跳跃范围内选择下一跳能到达最远的位置';
    problems.push(jump);

    return problems;
  }

  /**
   * 双指针类题目
   */
  private static getTwoPointersProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 两数之和 II - 输入有序数组
    const twoSumII = new ProblemModel();
    twoSumII.id = 161;
    twoSumII.title = '两数之和 II - 输入有序数组';
    twoSumII.description =
      '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。';
    twoSumII.difficulty = ProblemDifficulty.MEDIUM;
    twoSumII.category = ProblemCategory.TWO_POINTERS;
    twoSumII.choices = [
      { id: 'A', text: '使用双指针，左右两端向中间移动', isCorrect: true },
      { id: 'B', text: '使用哈希表存储数值和索引', isCorrect: false },
      { id: 'C', text: '使用二分查找', isCorrect: false },
      { id: 'D', text: '暴力枚举所有组合', isCorrect: false }
    ];
    twoSumII.explanation =
      '由于数组已排序，使用双指针是最优解法。左指针指向数组开头，右指针指向数组末尾。如果两数之和等于目标值，返回结果；如果小于目标值，左指针右移；如果大于目标值，右指针左移。时间复杂度O(n)，空间复杂度O(1)。';
    twoSumII.hint = '利用数组已排序的特性，使用双指针从两端向中间移动';
    problems.push(twoSumII);

    // 三数之和
    const threeSum = new ProblemModel();
    threeSum.id = 162;
    threeSum.title = '三数之和';
    threeSum.description =
      '给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。';
    threeSum.difficulty = ProblemDifficulty.MEDIUM;
    threeSum.category = ProblemCategory.TWO_POINTERS;
    threeSum.choices = [
      { id: 'A', text: '排序后固定一个数，对剩余数组使用双指针', isCorrect: true },
      { id: 'B', text: '使用三重循环暴力枚举', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有可能的组合', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有三元组', isCorrect: false }
    ];
    threeSum.explanation =
      '先排序数组，然后固定第一个数，对剩余数组使用双指针寻找两数之和等于目标值的组合。需要注意去重：跳过重复的第一个数，以及双指针移动时跳过重复值。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSum.hint = '排序后固定一个数，剩余问题转化为两数之和';
    problems.push(threeSum);

    // 盛最多水的容器
    const maxArea = new ProblemModel();
    maxArea.id = 163;
    maxArea.title = '盛最多水的容器';
    maxArea.description =
      '给定一个长度为 n 的整数数组 height 。有 n 条垂线，第 i 条线的两个端点是 (i, 0) 和 (i, height[i]) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。';
    maxArea.difficulty = ProblemDifficulty.MEDIUM;
    maxArea.category = ProblemCategory.TWO_POINTERS;
    maxArea.choices = [
      { id: 'A', text: '双指针从两端开始，每次移动较短的那一端', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的两条线组合', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最大面积', isCorrect: false },
      { id: 'D', text: '使用单调栈维护递增序列', isCorrect: false }
    ];
    maxArea.explanation =
      '双指针策略：从数组两端开始，计算当前面积，然后移动较短的那一端。因为移动较长的一端不可能得到更大的面积（宽度减小，高度受限于较短的一端）。时间复杂度O(n)，空间复杂度O(1)。';
    maxArea.hint = '双指针从两端开始，总是移动较短的那一端';
    problems.push(maxArea);

    // 移除元素
    const removeElement = new ProblemModel();
    removeElement.id = 164;
    removeElement.title = '移除元素';
    removeElement.description =
      '给你一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，并返回移除后数组的新长度。不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并原地修改输入数组。';
    removeElement.difficulty = ProblemDifficulty.EASY;
    removeElement.category = ProblemCategory.TWO_POINTERS;
    removeElement.choices = [
      { id: 'A', text: '使用快慢双指针，快指针遍历，慢指针记录有效位置', isCorrect: true },
      { id: 'B', text: '从后往前遍历，遇到目标值就删除', isCorrect: false },
      { id: 'C', text: '使用额外数组存储非目标值元素', isCorrect: false },
      { id: 'D', text: '使用哈希表记录要删除的位置', isCorrect: false }
    ];
    removeElement.explanation =
      '快慢双指针：快指针遍历数组，慢指针指向下一个有效位置。当快指针指向的元素不等于val时，将其复制到慢指针位置，然后慢指针前进。最终慢指针的值就是新数组的长度。时间复杂度O(n)，空间复杂度O(1)。';
    removeElement.hint = '使用快慢双指针，保留不等于目标值的元素';
    problems.push(removeElement);

    // 删除有序数组中的重复项
    const removeDuplicates = new ProblemModel();
    removeDuplicates.id = 165;
    removeDuplicates.title = '删除有序数组中的重复项';
    removeDuplicates.description =
      '给你一个升序排列的数组 nums ，请你原地删除重复出现的元素，使每个元素只出现一次，返回删除后数组的新长度。元素的相对顺序应该保持一致。';
    removeDuplicates.difficulty = ProblemDifficulty.EASY;
    removeDuplicates.category = ProblemCategory.TWO_POINTERS;
    removeDuplicates.choices = [
      { id: 'A', text: '使用快慢双指针，快指针寻找不重复元素', isCorrect: true },
      { id: 'B', text: '使用哈希表记录已出现的元素', isCorrect: false },
      { id: 'C', text: '从后往前遍历删除重复元素', isCorrect: false },
      { id: 'D', text: '使用额外数组存储唯一元素', isCorrect: false }
    ];
    removeDuplicates.explanation =
      '由于数组已排序，重复元素必定相邻。使用快慢双指针：慢指针指向当前唯一元素的末尾，快指针寻找下一个不同的元素。当找到时，将其复制到慢指针的下一位置。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicates.hint = '利用数组有序的特性，重复元素必定相邻';
    problems.push(removeDuplicates);

    // 反转字符串
    const reverseString = new ProblemModel();
    reverseString.id = 166;
    reverseString.title = '反转字符串';
    reverseString.description =
      '编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。';
    reverseString.difficulty = ProblemDifficulty.EASY;
    reverseString.category = ProblemCategory.TWO_POINTERS;
    reverseString.choices = [
      { id: 'A', text: '使用双指针从两端向中间交换字符', isCorrect: true },
      { id: 'B', text: '使用递归反转字符串', isCorrect: false },
      { id: 'C', text: '使用栈存储字符然后弹出', isCorrect: false },
      { id: 'D', text: '使用额外数组存储反转结果', isCorrect: false }
    ];
    reverseString.explanation =
      '经典双指针应用：左指针指向字符串开头，右指针指向字符串末尾，交换两个位置的字符，然后向中间移动，直到两指针相遇。时间复杂度O(n)，空间复杂度O(1)。';
    reverseString.hint = '双指针从两端向中间移动，交换对应位置的字符';
    problems.push(reverseString);

    // 验证回文串
    const isPalindrome = new ProblemModel();
    isPalindrome.id = 167;
    isPalindrome.title = '验证回文串';
    isPalindrome.description =
      '如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样。则可以认为该短语是一个回文串。给你一个字符串 s，如果它是回文串，返回 true ；否则，返回 false 。';
    isPalindrome.difficulty = ProblemDifficulty.EASY;
    isPalindrome.category = ProblemCategory.TWO_POINTERS;
    isPalindrome.choices = [
      { id: 'A', text: '双指针从两端向中间移动，跳过非字母数字字符', isCorrect: true },
      { id: 'B', text: '先预处理字符串，然后反转比较', isCorrect: false },
      { id: 'C', text: '使用栈存储前半部分字符', isCorrect: false },
      { id: 'D', text: '使用递归检查回文性质', isCorrect: false }
    ];
    isPalindrome.explanation =
      '双指针策略：左右指针分别从字符串两端开始，跳过非字母数字字符，比较对应位置的字符（转换为小写）。如果不相等则不是回文串，如果指针相遇则是回文串。时间复杂度O(n)，空间复杂度O(1)。';
    isPalindrome.hint = '双指针跳过非字母数字字符，比较对应位置的字符';
    problems.push(isPalindrome);

    // 长度最小的子数组
    const minSubArrayLen = new ProblemModel();
    minSubArrayLen.id = 168;
    minSubArrayLen.title = '长度最小的子数组';
    minSubArrayLen.description =
      '给定一个含有 n 个正整数的数组和一个正整数 target 。找出该数组中满足其和 ≥ target 的长度最小的连续子数组，并返回其长度。如果不存在符合条件的子数组，返回 0 。';
    minSubArrayLen.difficulty = ProblemDifficulty.MEDIUM;
    minSubArrayLen.category = ProblemCategory.TWO_POINTERS;
    minSubArrayLen.choices = [
      { id: 'A', text: '使用滑动窗口（双指针），动态调整窗口大小', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的子数组', isCorrect: false },
      { id: 'C', text: '使用前缀和加二分查找', isCorrect: false },
      { id: 'D', text: '使用动态规划记录最小长度', isCorrect: false }
    ];
    minSubArrayLen.explanation =
      '滑动窗口技巧：使用左右双指针维护一个窗口。右指针不断扩展窗口直到和≥target，然后尝试收缩左指针以找到最小长度。重复这个过程直到右指针到达数组末尾。时间复杂度O(n)，空间复杂度O(1)。';
    minSubArrayLen.hint = '使用滑动窗口，右指针扩展，左指针收缩';
    problems.push(minSubArrayLen);

    // 四数之和
    const fourSum = new ProblemModel();
    fourSum.id = 169;
    fourSum.title = '四数之和';
    fourSum.description =
      '给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件的、不重复的四元组。';
    fourSum.difficulty = ProblemDifficulty.MEDIUM;
    fourSum.category = ProblemCategory.TWO_POINTERS;
    fourSum.choices = [
      { id: 'A', text: '排序后固定两个数，对剩余数组使用双指针', isCorrect: true },
      { id: 'B', text: '使用四重循环暴力枚举', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有可能的组合', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有四元组', isCorrect: false }
    ];
    fourSum.explanation =
      '在三数之和的基础上再固定一个数。排序后使用两层循环固定前两个数，然后对剩余数组使用双指针寻找两数之和等于目标值的组合。同样需要注意去重。时间复杂度O(n³)，空间复杂度O(1)。';
    fourSum.hint = '在三数之和基础上再固定一个数，使用双指针处理剩余两个数';
    problems.push(fourSum);

    // 最接近的三数之和
    const threeSumClosest = new ProblemModel();
    threeSumClosest.id = 170;
    threeSumClosest.title = '最接近的三数之和';
    threeSumClosest.description =
      '给你一个长度为 n 的整数数组 nums 和 一个目标值 target。请你从 nums 中选出三个整数，使它们的和与 target 最接近。返回这三个数的和。';
    threeSumClosest.difficulty = ProblemDifficulty.MEDIUM;
    threeSumClosest.category = ProblemCategory.TWO_POINTERS;
    threeSumClosest.choices = [
      { id: 'A', text: '排序后固定一个数，双指针寻找最接近的组合', isCorrect: true },
      { id: 'B', text: '暴力枚举所有三元组', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最接近的和', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有可能的和', isCorrect: false }
    ];
    threeSumClosest.explanation =
      '类似三数之和，但目标是找到最接近target的和。排序后固定第一个数，使用双指针在剩余数组中寻找。每次计算当前三数之和与target的差值，更新最接近的结果。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSumClosest.hint = '在三数之和基础上，维护与目标值最接近的和';
    problems.push(threeSumClosest);

    // 颜色分类
    const sortColors = new ProblemModel();
    sortColors.id = 171;
    sortColors.title = '颜色分类';
    sortColors.description =
      '给定一个包含红色、白色和蓝色、共 n 个元素的数组 nums ，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。我们使用整数 0、1 和 2 分别表示红色、白色和蓝色。';
    sortColors.difficulty = ProblemDifficulty.MEDIUM;
    sortColors.category = ProblemCategory.TWO_POINTERS;
    sortColors.choices = [
      { id: 'A', text: '使用三指针：左指针处理0，右指针处理2，中间指针遍历', isCorrect: true },
      { id: 'B', text: '先统计各颜色数量，再重新填充数组', isCorrect: false },
      { id: 'C', text: '使用快速排序算法', isCorrect: false },
      { id: 'D', text: '使用归并排序算法', isCorrect: false }
    ];
    sortColors.explanation =
      '荷兰国旗问题：使用三指针。left指向0的边界，right指向2的边界，current遍历数组。遇到0与left交换并移动left和current，遇到2与right交换并移动right（current不动，因为交换来的元素未处理），遇到1只移动current。';
    sortColors.hint = '三指针分别处理0、1、2三种颜色的边界';
    problems.push(sortColors);

    // 合并两个有序数组
    const merge = new ProblemModel();
    merge.id = 172;
    merge.title = '合并两个有序数组';
    merge.description =
      '给你两个按非递减顺序排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中元素的数量。请你合并 nums2 到 nums1 中，使合并后的数组同样按非递减顺序排列。';
    merge.difficulty = ProblemDifficulty.EASY;
    merge.category = ProblemCategory.TWO_POINTERS;
    merge.choices = [
      { id: 'A', text: '从后往前合并，使用三个指针', isCorrect: true },
      { id: 'B', text: '先合并再排序', isCorrect: false },
      { id: 'C', text: '使用额外空间存储合并结果', isCorrect: false },
      { id: 'D', text: '从前往后合并，需要移动元素', isCorrect: false }
    ];
    merge.explanation =
      '从后往前合并避免覆盖未处理的元素。使用三个指针：p1指向nums1的有效元素末尾，p2指向nums2末尾，p指向nums1的实际末尾。比较nums1[p1]和nums2[p2]，将较大者放到nums1[p]位置。时间复杂度O(m+n)，空间复杂度O(1)。';
    merge.hint = '从后往前合并，避免覆盖未处理的元素';
    problems.push(merge);

    // 环形链表II
    const detectCycle = new ProblemModel();
    detectCycle.id = 173;
    detectCycle.title = '环形链表II';
    detectCycle.description = '给定一个链表的头节点 head ，返回链表开始入环的第一个节点。如果链表无环，则返回 null。';
    detectCycle.difficulty = ProblemDifficulty.MEDIUM;
    detectCycle.category = ProblemCategory.TWO_POINTERS;
    detectCycle.choices = [
      { id: 'A', text: '快慢指针找到相遇点，然后一个指针从头开始', isCorrect: true },
      { id: 'B', text: '使用哈希表记录访问过的节点', isCorrect: false },
      { id: 'C', text: '遍历链表并标记访问过的节点', isCorrect: false },
      { id: 'D', text: '使用递归检查每个节点', isCorrect: false }
    ];
    detectCycle.explanation =
      'Floyd判圈算法：快慢指针相遇后，将一个指针重置到头节点，两指针以相同速度移动，再次相遇的点就是环的入口。数学原理：设环外长度为a，环内长度为b，相遇点距入口为c，则有2(a+c) = a+b+c，解得a = b-c。';
    detectCycle.hint = '快慢指针相遇后，重置一个指针到头节点，同速移动找入口';
    problems.push(detectCycle);

    // 删除有序数组中的重复项II
    const removeDuplicatesII = new ProblemModel();
    removeDuplicatesII.id = 174;
    removeDuplicatesII.title = '删除有序数组中的重复项II';
    removeDuplicatesII.description =
      '给你一个有序数组 nums ，请你原地删除重复出现的元素，使得出现次数超过两次的元素只出现两次，返回删除后数组的新长度。';
    removeDuplicatesII.difficulty = ProblemDifficulty.MEDIUM;
    removeDuplicatesII.category = ProblemCategory.TWO_POINTERS;
    removeDuplicatesII.choices = [
      { id: 'A', text: '使用快慢双指针，慢指针维护结果数组', isCorrect: true },
      { id: 'B', text: '使用哈希表统计元素出现次数', isCorrect: false },
      { id: 'C', text: '从后往前遍历删除多余元素', isCorrect: false },
      { id: 'D', text: '使用额外数组存储结果', isCorrect: false }
    ];
    removeDuplicatesII.explanation =
      '快慢双指针：慢指针维护结果数组，快指针遍历原数组。关键观察：如果当前元素与慢指针前两个位置的元素相同，说明已经有两个相同元素了，跳过当前元素。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicatesII.hint = '比较当前元素与结果数组中前两个位置的元素';
    problems.push(removeDuplicatesII);

    // 字符串的排列
    const checkInclusion = new ProblemModel();
    checkInclusion.id = 175;
    checkInclusion.title = '字符串的排列';
    checkInclusion.description =
      '给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。如果是，返回 true ；否则，返回 false 。';
    checkInclusion.difficulty = ProblemDifficulty.MEDIUM;
    checkInclusion.category = ProblemCategory.TWO_POINTERS;
    checkInclusion.choices = [
      { id: 'A', text: '使用滑动窗口，维护固定长度的窗口', isCorrect: true },
      { id: 'B', text: '生成s1的所有排列，逐一检查', isCorrect: false },
      { id: 'C', text: '使用动态规划记录匹配状态', isCorrect: false },
      { id: 'D', text: '使用KMP算法进行字符串匹配', isCorrect: false }
    ];
    checkInclusion.explanation =
      '滑动窗口：维护一个长度为s1.length的窗口在s2上滑动。使用字符频次数组比较窗口内字符分布是否与s1相同。每次移动窗口时，移除左边字符，添加右边字符，更新频次。时间复杂度O(n)，空间复杂度O(1)。';
    checkInclusion.hint = '固定长度的滑动窗口，比较字符频次分布';
    problems.push(checkInclusion);

    // 找到字符串中所有字母异位词
    const findAnagrams = new ProblemModel();
    findAnagrams.id = 176;
    findAnagrams.title = '找到字符串中所有字母异位词';
    findAnagrams.description =
      '给定两个字符串 s 和 p，找到 s 中所有 p 的异位词的子串，返回这些子串的起始索引。不考虑答案输出的顺序。';
    findAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    findAnagrams.category = ProblemCategory.TWO_POINTERS;
    findAnagrams.choices = [
      { id: 'A', text: '使用滑动窗口，比较字符频次', isCorrect: true },
      { id: 'B', text: '对每个子串排序后与p比较', isCorrect: false },
      { id: 'C', text: '使用哈希表存储p的所有排列', isCorrect: false },
      { id: 'D', text: '使用动态规划记录匹配状态', isCorrect: false }
    ];
    findAnagrams.explanation =
      '滑动窗口变种：维护长度为p.length的窗口，使用字符频次数组。当窗口内字符频次与p相同时，记录起始位置。优化：使用一个变量记录匹配的字符种类数，避免每次都比较整个频次数组。时间复杂度O(n)。';
    findAnagrams.hint = '滑动窗口比较字符频次，记录匹配的起始位置';
    problems.push(findAnagrams);

    // 最小覆盖子串
    const minWindow = new ProblemModel();
    minWindow.id = 177;
    minWindow.title = '最小覆盖子串';
    minWindow.description =
      '给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.TWO_POINTERS;
    minWindow.choices = [
      { id: 'A', text: '使用滑动窗口，右指针扩展，左指针收缩', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的子串', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最小长度', isCorrect: false },
      { id: 'D', text: '使用回溯算法寻找最小子串', isCorrect: false }
    ];
    minWindow.explanation =
      '滑动窗口：右指针扩展窗口直到包含t的所有字符，然后左指针收缩窗口寻找最小长度。使用哈希表记录t中字符的需求量和窗口中的字符数量。维护一个变量记录已满足的字符种类数。时间复杂度O(|s|+|t|)。';
    minWindow.hint = '滑动窗口，右指针扩展到满足条件，左指针收缩寻找最小';
    problems.push(minWindow);

    // 无重复字符的最长子串
    const lengthOfLongestSubstring = new ProblemModel();
    lengthOfLongestSubstring.id = 178;
    lengthOfLongestSubstring.title = '无重复字符的最长子串';
    lengthOfLongestSubstring.description = '给定一个字符串 s ，请你找出其中不含有重复字符的最长子串的长度。';
    lengthOfLongestSubstring.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLongestSubstring.category = ProblemCategory.TWO_POINTERS;
    lengthOfLongestSubstring.choices = [
      { id: 'A', text: '使用滑动窗口，哈希表记录字符位置', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子串', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最长长度', isCorrect: false },
      { id: 'D', text: '使用栈存储不重复字符', isCorrect: false }
    ];
    lengthOfLongestSubstring.explanation =
      '滑动窗口：使用左右指针维护一个无重复字符的窗口。右指针不断扩展，当遇到重复字符时，左指针移动到重复字符的下一位置。使用哈希表记录字符的最新位置。时间复杂度O(n)，空间复杂度O(min(m,n))。';
    lengthOfLongestSubstring.hint = '滑动窗口维护无重复字符的子串，遇到重复字符时调整左边界';
    problems.push(lengthOfLongestSubstring);

    // 接雨水
    const trap = new ProblemModel();
    trap.id = 179;
    trap.title = '接雨水';
    trap.description = '给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能够接多少雨水。';
    trap.difficulty = ProblemDifficulty.HARD;
    trap.category = ProblemCategory.TWO_POINTERS;
    trap.choices = [
      { id: 'A', text: '双指针从两端向中间移动，维护左右最大高度', isCorrect: true },
      { id: 'B', text: '使用栈存储递减的柱子索引', isCorrect: false },
      { id: 'C', text: '动态规划预计算左右最大高度', isCorrect: false },
      { id: 'D', text: '暴力计算每个位置的积水量', isCorrect: false }
    ];
    trap.explanation =
      '双指针优化：从两端开始，维护leftMax和rightMax。如果left对应的高度小于right，说明左边的积水量由leftMax决定，计算积水并移动left指针；反之移动right指针。关键洞察：较小一侧的积水量只由该侧的最大值决定。时间复杂度O(n)，空间复杂度O(1)。';
    trap.hint = '双指针维护左右最大高度，较小一侧的积水量确定';
    problems.push(trap);

    // 回文子串
    const countSubstrings = new ProblemModel();
    countSubstrings.id = 180;
    countSubstrings.title = '回文子串';
    countSubstrings.description = '给你一个字符串 s ，请你统计并返回这个字符串中回文子串的数目。';
    countSubstrings.difficulty = ProblemDifficulty.MEDIUM;
    countSubstrings.category = ProblemCategory.TWO_POINTERS;
    countSubstrings.choices = [
      { id: 'A', text: '中心扩展法：以每个字符和字符间隙为中心扩展', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i][j]表示s[i..j]是否为回文', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子串并检查', isCorrect: false },
      { id: 'D', text: 'Manacher算法：线性时间找所有回文', isCorrect: false }
    ];
    countSubstrings.explanation =
      '中心扩展法：对于每个可能的回文中心（字符或字符间隙），向两边扩展直到不再是回文。需要考虑奇数长度（以字符为中心）和偶数长度（以字符间隙为中心）两种情况。时间复杂度O(n²)，空间复杂度O(1)。';
    countSubstrings.hint = '以每个位置为中心向两边扩展，统计回文子串数量';
    problems.push(countSubstrings);

    return problems;
  }

  /**
   * 二分查找类题目
   */
  private static getBinarySearchProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 二分查找
    const binarySearch = new ProblemModel();
    binarySearch.id = 121;
    binarySearch.title = '二分查找';
    binarySearch.description =
      '给定一个n个元素有序的（升序）整型数组nums和一个目标值target，写一个函数搜索nums中的target，如果目标值存在返回下标，否则返回-1。';
    binarySearch.difficulty = ProblemDifficulty.EASY;
    binarySearch.category = ProblemCategory.BINARY_SEARCH;
    binarySearch.choices = [
      { id: 'A', text: '使用二分查找，每次排除一半元素', isCorrect: true },
      { id: 'B', text: '从头到尾线性搜索', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有元素', isCorrect: false },
      { id: 'D', text: '使用递归分治', isCorrect: false }
    ];
    binarySearch.explanation =
      '二分查找是在有序数组中查找元素的经典算法。每次比较中间元素与目标值，如果相等则返回索引；如果目标值较小，在左半部分继续查找；如果目标值较大，在右半部分继续查找。时间复杂度O(log n)，空间复杂度O(1)。';
    binarySearch.hint = '利用数组有序的特性，每次排除一半的搜索空间';
    problems.push(binarySearch);

    // 搜索插入位置
    const searchInsert = new ProblemModel();
    searchInsert.id = 181;
    searchInsert.title = '搜索插入位置';
    searchInsert.description =
      '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。';
    searchInsert.difficulty = ProblemDifficulty.EASY;
    searchInsert.category = ProblemCategory.BINARY_SEARCH;
    searchInsert.choices = [
      { id: 'A', text: '使用二分查找，找到第一个大于等于目标值的位置', isCorrect: true },
      { id: 'B', text: '线性搜索找到插入位置', isCorrect: false },
      { id: 'C', text: '先查找目标值，不存在时再找插入位置', isCorrect: false },
      { id: 'D', text: '使用哈希表记录所有位置', isCorrect: false }
    ];
    searchInsert.explanation =
      '这是二分查找的变形。当目标值存在时返回其位置；当不存在时，二分查找结束时left指针指向的就是插入位置。关键是理解二分查找的边界条件。时间复杂度O(log n)，空间复杂度O(1)。';
    searchInsert.hint = '二分查找结束时，left指针指向插入位置';
    problems.push(searchInsert);

    // 在排序数组中查找元素的第一个和最后一个位置
    const searchRange = new ProblemModel();
    searchRange.id = 182;
    searchRange.title = '在排序数组中查找元素的第一个和最后一个位置';
    searchRange.description =
      '给定一个按照升序排列的整数数组nums，和一个目标值target。找出给定目标值在数组中的开始位置和结束位置。如果数组中不存在目标值target，返回[-1, -1]。';
    searchRange.difficulty = ProblemDifficulty.MEDIUM;
    searchRange.category = ProblemCategory.BINARY_SEARCH;
    searchRange.choices = [
      { id: 'A', text: '使用两次二分查找，分别找左边界和右边界', isCorrect: true },
      { id: 'B', text: '先用二分查找找到任意位置，再向两边扩展', isCorrect: false },
      { id: 'C', text: '线性搜索找到所有匹配位置', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有位置', isCorrect: false }
    ];
    searchRange.explanation =
      '需要进行两次二分查找：第一次找左边界（第一个等于target的位置），第二次找右边界（最后一个等于target的位置）。关键是正确处理边界条件，确保找到的是真正的边界。时间复杂度O(log n)，空间复杂度O(1)。';
    searchRange.hint = '分别用二分查找找左边界和右边界';
    problems.push(searchRange);

    // 搜索旋转排序数组
    const searchRotated = new ProblemModel();
    searchRotated.id = 183;
    searchRotated.title = '搜索旋转排序数组';
    searchRotated.description =
      '整数数组nums按升序排列，数组中的值互不相同。在传递给函数之前，nums在预先未知的某个下标k上进行了旋转。给你旋转后的数组nums和一个整数target，如果nums中存在这个目标值target，则返回它的下标，否则返回-1。';
    searchRotated.difficulty = ProblemDifficulty.MEDIUM;
    searchRotated.category = ProblemCategory.BINARY_SEARCH;
    searchRotated.choices = [
      { id: 'A', text: '判断哪一半是有序的，然后决定在哪一半搜索', isCorrect: true },
      { id: 'B', text: '先找到旋转点，再在对应部分二分查找', isCorrect: false },
      { id: 'C', text: '线性搜索整个数组', isCorrect: false },
      { id: 'D', text: '恢复数组的原始顺序再二分查找', isCorrect: false }
    ];
    searchRotated.explanation =
      '旋转数组的特点是至少有一半是有序的。通过比较中间元素与边界元素，可以判断哪一半是有序的。然后判断目标值是否在有序的那一半中，决定搜索方向。时间复杂度O(log n)，空间复杂度O(1)。';
    searchRotated.hint = '旋转数组至少有一半是有序的';
    problems.push(searchRotated);

    // 寻找旋转排序数组中的最小值
    const findMin = new ProblemModel();
    findMin.id = 184;
    findMin.title = '寻找旋转排序数组中的最小值';
    findMin.description =
      '已知一个长度为n的数组，预先按照升序排列，经由1到n次旋转后，得到输入数组。给你一个元素值互不相同的数组nums，它原来是一个升序排列的数组，并按上述情形进行了多次旋转。请你找出并返回数组中的最小元素。';
    findMin.difficulty = ProblemDifficulty.MEDIUM;
    findMin.category = ProblemCategory.BINARY_SEARCH;
    findMin.choices = [
      { id: 'A', text: '比较中间元素与右边界，决定搜索方向', isCorrect: true },
      { id: 'B', text: '比较中间元素与左边界，决定搜索方向', isCorrect: false },
      { id: 'C', text: '线性搜索找到最小值', isCorrect: false },
      { id: 'D', text: '找到旋转点就是最小值位置', isCorrect: false }
    ];
    findMin.explanation =
      '最小值一定在旋转点。通过比较中间元素与右边界元素：如果mid > right，说明最小值在右半部分；如果mid < right，说明最小值在左半部分（包括mid）。时间复杂度O(log n)，空间复杂度O(1)。';
    findMin.hint = '最小值在旋转点，比较中间元素与右边界';
    problems.push(findMin);

    // 寻找峰值
    const findPeakElement = new ProblemModel();
    findPeakElement.id = 185;
    findPeakElement.title = '寻找峰值';
    findPeakElement.description =
      '峰值元素是指其值严格大于左右相邻值的元素。给你一个整数数组nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回任何一个峰值所在位置即可。';
    findPeakElement.difficulty = ProblemDifficulty.MEDIUM;
    findPeakElement.category = ProblemCategory.BINARY_SEARCH;
    findPeakElement.choices = [
      { id: 'A', text: '比较中间元素与相邻元素，向上坡方向搜索', isCorrect: true },
      { id: 'B', text: '线性搜索找到所有峰值', isCorrect: false },
      { id: 'C', text: '从两端向中间搜索', isCorrect: false },
      { id: 'D', text: '找到最大值就是峰值', isCorrect: false }
    ];
    findPeakElement.explanation =
      '关键观察：如果nums[mid] < nums[mid+1]，说明右侧存在峰值；如果nums[mid] > nums[mid+1]，说明左侧存在峰值（包括mid）。因为数组边界被视为负无穷，所以一定存在峰值。时间复杂度O(log n)，空间复杂度O(1)。';
    findPeakElement.hint = '向上坡方向搜索，一定能找到峰值';
    problems.push(findPeakElement);

    // 搜索二维矩阵
    const searchMatrix = new ProblemModel();
    searchMatrix.id = 186;
    searchMatrix.title = '搜索二维矩阵';
    searchMatrix.description =
      '编写一个高效的算法来判断m x n矩阵中，是否存在一个目标值。该矩阵具有如下特性：每行中的整数从左到右按升序排列。每行的第一个整数大于前一行的最后一个整数。';
    searchMatrix.difficulty = ProblemDifficulty.MEDIUM;
    searchMatrix.category = ProblemCategory.BINARY_SEARCH;
    searchMatrix.choices = [
      { id: 'A', text: '将二维矩阵看作一维有序数组进行二分查找', isCorrect: true },
      { id: 'B', text: '先二分查找行，再二分查找列', isCorrect: false },
      { id: 'C', text: '从右上角开始搜索', isCorrect: false },
      { id: 'D', text: '逐行线性搜索', isCorrect: false }
    ];
    searchMatrix.explanation =
      '由于矩阵的特殊性质，可以将其看作一个有序的一维数组。通过坐标转换：对于位置i，对应的矩阵坐标是(i/n, i%n)。然后进行标准的二分查找。时间复杂度O(log(m*n))，空间复杂度O(1)。';
    searchMatrix.hint = '将二维矩阵映射为一维有序数组';
    problems.push(searchMatrix);

    // 搜索二维矩阵II
    const searchMatrixII = new ProblemModel();
    searchMatrixII.id = 187;
    searchMatrixII.title = '搜索二维矩阵II';
    searchMatrixII.description =
      '编写一个高效的算法来搜索m x n矩阵matrix中的一个目标值target。该矩阵具有以下特性：每行的元素从左到右升序排列。每列的元素从上到下升序排列。';
    searchMatrixII.difficulty = ProblemDifficulty.MEDIUM;
    searchMatrixII.category = ProblemCategory.BINARY_SEARCH;
    searchMatrixII.choices = [
      { id: 'A', text: '从右上角或左下角开始搜索', isCorrect: true },
      { id: 'B', text: '对每一行进行二分查找', isCorrect: false },
      { id: 'C', text: '对每一列进行二分查找', isCorrect: false },
      { id: 'D', text: '从中心开始向四周扩散搜索', isCorrect: false }
    ];
    searchMatrixII.explanation =
      '从右上角开始：如果当前值大于目标值，向左移动；如果小于目标值，向下移动；如果相等，找到目标。这样每次都能排除一行或一列。时间复杂度O(m+n)，空间复杂度O(1)。';
    searchMatrixII.hint = '从右上角开始，每次排除一行或一列';
    problems.push(searchMatrixII);

    // 寻找两个正序数组的中位数
    const findMedian = new ProblemModel();
    findMedian.id = 188;
    findMedian.title = '寻找两个正序数组的中位数';
    findMedian.description =
      '给定两个大小分别为m和n的正序（从小到大）数组nums1和nums2。请你找出并返回这两个正序数组的中位数。算法的时间复杂度应该为O(log (m+n))。';
    findMedian.difficulty = ProblemDifficulty.HARD;
    findMedian.category = ProblemCategory.BINARY_SEARCH;
    findMedian.choices = [
      { id: 'A', text: '在较短数组上二分查找，找到正确的分割点', isCorrect: true },
      { id: 'B', text: '合并两个数组再找中位数', isCorrect: false },
      { id: 'C', text: '使用双指针找到中位数位置', isCorrect: false },
      { id: 'D', text: '分别在两个数组上二分查找', isCorrect: false }
    ];
    findMedian.explanation =
      '关键是找到一个分割点，使得左半部分的最大值小于等于右半部分的最小值，且两部分长度相等（或相差1）。在较短数组上进行二分查找，确定分割位置，然后计算另一个数组的分割位置。时间复杂度O(log(min(m,n)))，空间复杂度O(1)。';
    findMedian.hint = '在较短数组上二分查找分割点';
    problems.push(findMedian);

    // 第一个错误的版本
    const firstBadVersion = new ProblemModel();
    firstBadVersion.id = 189;
    firstBadVersion.title = '第一个错误的版本';
    firstBadVersion.description =
      '你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错误的。假设你有n个版本[1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。';
    firstBadVersion.difficulty = ProblemDifficulty.EASY;
    firstBadVersion.category = ProblemCategory.BINARY_SEARCH;
    firstBadVersion.choices = [
      { id: 'A', text: '使用二分查找，找到第一个错误版本', isCorrect: true },
      { id: 'B', text: '从第一个版本开始线性搜索', isCorrect: false },
      { id: 'C', text: '从最后一个版本开始向前搜索', isCorrect: false },
      { id: 'D', text: '随机选择版本进行检测', isCorrect: false }
    ];
    firstBadVersion.explanation =
      '这是寻找左边界的二分查找问题。如果当前版本是错误的，说明第一个错误版本在左半部分（包括当前版本）；如果当前版本是正确的，说明第一个错误版本在右半部分。时间复杂度O(log n)，空间复杂度O(1)。';
    firstBadVersion.hint = '寻找第一个错误版本，使用左边界二分查找';
    problems.push(firstBadVersion);

    // 猜数字大小
    const guessNumber = new ProblemModel();
    guessNumber.id = 190;
    guessNumber.title = '猜数字大小';
    guessNumber.description =
      '猜数字游戏的规则如下：每轮游戏，我都会从1到n随机选择一个数字。请你猜选出的数字。如果你猜错了，我会告诉你，你猜测的数字比我选出的数字是大了还是小了。你可以通过调用一个预先定义好的接口int guess(int num)来获取猜测结果。';
    guessNumber.difficulty = ProblemDifficulty.EASY;
    guessNumber.category = ProblemCategory.BINARY_SEARCH;
    guessNumber.choices = [
      { id: 'A', text: '使用二分查找，根据guess函数的返回值调整搜索范围', isCorrect: true },
      { id: 'B', text: '从1开始线性搜索', isCorrect: false },
      { id: 'C', text: '随机猜测数字', isCorrect: false },
      { id: 'D', text: '使用三分查找', isCorrect: false }
    ];
    guessNumber.explanation =
      '标准的二分查找应用。根据guess函数的返回值：-1表示猜大了，1表示猜小了，0表示猜对了。相应地调整搜索范围。时间复杂度O(log n)，空间复杂度O(1)。';
    guessNumber.hint = '根据guess函数返回值调整二分查找范围';
    problems.push(guessNumber);

    // 完全平方数
    const isPerfectSquare = new ProblemModel();
    isPerfectSquare.id = 191;
    isPerfectSquare.title = '有效的完全平方数';
    isPerfectSquare.description =
      '给定一个正整数num，编写一个函数，如果num是一个完全平方数，则返回true，否则返回false。进阶：不要使用任何内置的库函数，如sqrt。';
    isPerfectSquare.difficulty = ProblemDifficulty.EASY;
    isPerfectSquare.category = ProblemCategory.BINARY_SEARCH;
    isPerfectSquare.choices = [
      { id: 'A', text: '使用二分查找找到平方根', isCorrect: true },
      { id: 'B', text: '使用牛顿迭代法', isCorrect: false },
      { id: 'C', text: '逐个尝试所有可能的平方根', isCorrect: false },
      { id: 'D', text: '使用数学公式判断', isCorrect: false }
    ];
    isPerfectSquare.explanation =
      '在1到num之间二分查找，找到一个数x使得x*x = num。注意处理整数溢出问题，可以通过x <= num/x来避免。时间复杂度O(log n)，空间复杂度O(1)。';
    isPerfectSquare.hint = '二分查找平方根，注意避免整数溢出';
    problems.push(isPerfectSquare);

    // 两数之和II - 输入有序数组
    const twoSumSorted = new ProblemModel();
    twoSumSorted.id = 192;
    twoSumSorted.title = '两数之和II - 输入有序数组';
    twoSumSorted.description =
      '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。如果设这两个数分别是numbers[index1]和numbers[index2]，则1 <= index1 < index2 <= numbers.length。';
    twoSumSorted.difficulty = ProblemDifficulty.MEDIUM;
    twoSumSorted.category = ProblemCategory.BINARY_SEARCH;
    twoSumSorted.choices = [
      { id: 'A', text: '使用双指针从两端向中间搜索', isCorrect: true },
      { id: 'B', text: '对每个元素二分查找其补数', isCorrect: false },
      { id: 'C', text: '使用哈希表存储已遍历的元素', isCorrect: false },
      { id: 'D', text: '暴力搜索所有可能的组合', isCorrect: false }
    ];
    twoSumSorted.explanation =
      '利用数组有序的特性，使用双指针：如果两数之和大于目标值，右指针左移；如果小于目标值，左指针右移；如果等于目标值，找到答案。时间复杂度O(n)，空间复杂度O(1)。';
    twoSumSorted.hint = '利用有序特性，使用双指针技巧';
    problems.push(twoSumSorted);

    // 寻找比目标字母大的最小字母
    const nextGreatestLetter = new ProblemModel();
    nextGreatestLetter.id = 193;
    nextGreatestLetter.title = '寻找比目标字母大的最小字母';
    nextGreatestLetter.description =
      '给你一个排序后的字符列表letters，列表中只包含小写英文字母。另给出一个目标字母target，请你寻找在这一有序列表里比目标字母大的最小字母。在比较时，字母是依照ASCII码顺序比较的。比如，目标字母target = "z"时，应该返回"a"。';
    nextGreatestLetter.difficulty = ProblemDifficulty.EASY;
    nextGreatestLetter.category = ProblemCategory.BINARY_SEARCH;
    nextGreatestLetter.choices = [
      { id: 'A', text: '使用二分查找找到第一个大于目标的字母', isCorrect: true },
      { id: 'B', text: '线性搜索找到第一个大于目标的字母', isCorrect: false },
      { id: 'C', text: '从后往前搜索', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有字母', isCorrect: false }
    ];
    nextGreatestLetter.explanation =
      '这是寻找右边界的二分查找变形。需要找到第一个大于target的字母。如果所有字母都不大于target，则返回第一个字母（循环特性）。时间复杂度O(log n)，空间复杂度O(1)。';
    nextGreatestLetter.hint = '寻找第一个大于目标的字母，注意循环特性';
    problems.push(nextGreatestLetter);

    // 山脉数组的峰顶索引
    const peakIndexInMountainArray = new ProblemModel();
    peakIndexInMountainArray.id = 194;
    peakIndexInMountainArray.title = '山脉数组的峰顶索引';
    peakIndexInMountainArray.description =
      '符合下列属性的数组arr称为山脉数组：arr.length >= 3，存在i（0 < i < arr.length - 1）使得：arr[0] < arr[1] < ... arr[i-1] < arr[i]，arr[i] > arr[i+1] > ... > arr[arr.length - 1]。给你由整数组成的山脉数组arr，返回任何满足arr[0] < arr[1] < ... arr[i-1] < arr[i] > arr[i+1] > ... > arr[arr.length - 1]的下标i。';
    peakIndexInMountainArray.difficulty = ProblemDifficulty.EASY;
    peakIndexInMountainArray.category = ProblemCategory.BINARY_SEARCH;
    peakIndexInMountainArray.choices = [
      { id: 'A', text: '使用二分查找，比较中间元素与相邻元素', isCorrect: true },
      { id: 'B', text: '线性搜索找到峰顶', isCorrect: false },
      { id: 'C', text: '从两端向中间搜索', isCorrect: false },
      { id: 'D', text: '找到最大值的位置', isCorrect: false }
    ];
    peakIndexInMountainArray.explanation =
      '山脉数组保证存在唯一峰顶。使用二分查找：如果arr[mid] < arr[mid+1]，说明峰顶在右半部分；如果arr[mid] > arr[mid+1]，说明峰顶在左半部分（包括mid）。时间复杂度O(log n)，空间复杂度O(1)。';
    peakIndexInMountainArray.hint = '山脉数组有唯一峰顶，向上坡方向搜索';
    problems.push(peakIndexInMountainArray);

    // 分割数组的最大值
    const splitArray = new ProblemModel();
    splitArray.id = 195;
    splitArray.title = '分割数组的最大值';
    splitArray.description =
      '给定一个非负整数数组nums和一个整数m，你需要将这个数组分成m个非空的连续子数组。设计一个算法使得这m个子数组各自和的最大值最小。';
    splitArray.difficulty = ProblemDifficulty.HARD;
    splitArray.category = ProblemCategory.BINARY_SEARCH;
    splitArray.choices = [
      { id: 'A', text: '二分查找答案，检查是否能在m个子数组内完成分割', isCorrect: true },
      { id: 'B', text: '使用动态规划计算最优分割', isCorrect: false },
      { id: 'C', text: '贪心算法分割数组', isCorrect: false },
      { id: 'D', text: '暴力尝试所有可能的分割方案', isCorrect: false }
    ];
    splitArray.explanation =
      '这是"二分查找答案"的经典应用。答案的范围是[max(nums), sum(nums)]。对于每个可能的答案，检查是否能在m个子数组内完成分割。使用贪心策略：尽可能让每个子数组的和接近但不超过当前答案。时间复杂度O(n*log(sum))，空间复杂度O(1)。';
    splitArray.hint = '二分查找答案，贪心检查分割可行性';
    problems.push(splitArray);

    // 在D天内送达包裹的能力
    const shipWithinDays = new ProblemModel();
    shipWithinDays.id = 196;
    shipWithinDays.title = '在D天内送达包裹的能力';
    shipWithinDays.description =
      '传送带上的包裹必须在D天内从一个港口运送到另一个港口。传送带上的第i个包裹的重量为weights[i]。每一天，我们都会按给出重量的顺序往传送带上装载包裹。我们装载的重量不会超过船的最大运载能力。返回能在D天内将传送带上的所有包裹送达的船的最低运载能力。';
    shipWithinDays.difficulty = ProblemDifficulty.MEDIUM;
    shipWithinDays.category = ProblemCategory.BINARY_SEARCH;
    shipWithinDays.choices = [
      { id: 'A', text: '二分查找船的运载能力，检查是否能在D天内完成', isCorrect: true },
      { id: 'B', text: '贪心算法计算最小运载能力', isCorrect: false },
      { id: 'C', text: '动态规划计算最优方案', isCorrect: false },
      { id: 'D', text: '平均分配包裹重量', isCorrect: false }
    ];
    shipWithinDays.explanation =
      '又一个"二分查找答案"问题。运载能力的范围是[max(weights), sum(weights)]。对于每个可能的运载能力，模拟装载过程，检查是否能在D天内完成。时间复杂度O(n*log(sum))，空间复杂度O(1)。';
    shipWithinDays.hint = '二分查找运载能力，模拟装载过程';
    problems.push(shipWithinDays);

    // 爱吃香蕉的珂珂
    const minEatingSpeed = new ProblemModel();
    minEatingSpeed.id = 197;
    minEatingSpeed.title = '爱吃香蕉的珂珂';
    minEatingSpeed.description =
      '珂珂喜欢吃香蕉。这里有N堆香蕉，第i堆中有piles[i]根香蕉。警卫已经离开了，将在H小时后回来。珂珂可以决定她吃香蕉的速度K（单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉K根。如果这堆香蕉少于K根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。返回她可以在H小时内吃掉所有香蕉的最小速度K。';
    minEatingSpeed.difficulty = ProblemDifficulty.MEDIUM;
    minEatingSpeed.category = ProblemCategory.BINARY_SEARCH;
    minEatingSpeed.choices = [
      { id: 'A', text: '二分查找吃香蕉的速度，检查是否能在H小时内吃完', isCorrect: true },
      { id: 'B', text: '计算平均速度作为答案', isCorrect: false },
      { id: 'C', text: '贪心选择最优速度', isCorrect: false },
      { id: 'D', text: '线性搜索所有可能的速度', isCorrect: false }
    ];
    minEatingSpeed.explanation =
      '经典的"二分查找答案"问题。速度的范围是[1, max(piles)]。对于每个可能的速度K，计算吃完所有香蕉需要的时间：对于每堆香蕉piles[i]，需要ceil(piles[i]/K)小时。时间复杂度O(n*log(max))，空间复杂度O(1)。';
    minEatingSpeed.hint = '二分查找吃香蕉的速度，计算所需时间';
    problems.push(minEatingSpeed);

    // 制作m束花所需的最少天数
    const minDaysBloom = new ProblemModel();
    minDaysBloom.id = 198;
    minDaysBloom.title = '制作m束花所需的最少天数';
    minDaysBloom.description =
      '给你一个整数数组bloomDay，以及两个整数m和k。现需要制作m束花。制作花束时，需要使用花园中相邻的k朵花。花园中有n朵花，第i朵花会在bloomDay[i]时盛开，当花盛开后，就可以用于制作花束。请你返回从花园中摘k朵相邻的花来制作m束花所需要的最少天数。如果不能制作出m束花则返回-1。';
    minDaysBloom.difficulty = ProblemDifficulty.MEDIUM;
    minDaysBloom.category = ProblemCategory.BINARY_SEARCH;
    minDaysBloom.choices = [
      { id: 'A', text: '二分查找天数，检查是否能制作出m束花', isCorrect: true },
      { id: 'B', text: '贪心选择最早盛开的花', isCorrect: false },
      { id: 'C', text: '动态规划计算最优方案', isCorrect: false },
      { id: 'D', text: '排序后选择合适的时间段', isCorrect: false }
    ];
    minDaysBloom.explanation =
      '"二分查找答案"问题。天数范围是[min(bloomDay), max(bloomDay)]。对于每个可能的天数，检查有多少朵花已经盛开，然后统计能制作多少束花（需要k朵相邻的花）。时间复杂度O(n*log(max))，空间复杂度O(1)。';
    minDaysBloom.hint = '二分查找天数，统计相邻盛开花朵的数量';
    problems.push(minDaysBloom);

    return problems;
  }

  /**
   * 栈类题目
   */
  private static getStackProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 有效的括号
    const validParentheses = new ProblemModel();
    validParentheses.id = 161;
    validParentheses.title = '有效的括号';
    validParentheses.description =
      '给定一个只包括"("，")"，"{"，"}"，"["，"]"的字符串s，判断字符串是否有效。有效字符串需满足：左括号必须用相同类型的右括号闭合，左括号必须以正确的顺序闭合。';
    validParentheses.difficulty = ProblemDifficulty.EASY;
    validParentheses.category = ProblemCategory.STACK;
    validParentheses.choices = [
      { id: 'A', text: '使用栈存储左括号，遇到右括号时检查匹配', isCorrect: true },
      { id: 'B', text: '使用计数器分别统计各种括号的数量', isCorrect: false },
      { id: 'C', text: '使用递归检查括号匹配', isCorrect: false },
      { id: 'D', text: '从左到右扫描，直接匹配相邻的括号对', isCorrect: false }
    ];
    validParentheses.explanation =
      '栈是解决括号匹配问题的经典数据结构。遍历字符串，遇到左括号时入栈，遇到右括号时检查栈顶是否为对应的左括号。如果匹配则出栈继续，不匹配则返回false。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validParentheses.hint = '使用栈来匹配括号，左括号入栈，右括号时检查匹配';
    problems.push(validParentheses);

    // 最小栈
    const minStack = new ProblemModel();
    minStack.id = 199;
    minStack.title = '最小栈';
    minStack.description =
      '设计一个支持push，pop，top操作，并能在常数时间内检索到最小元素的栈。实现MinStack类：MinStack()初始化堆栈对象。void push(int val)将元素val推入堆栈。void pop()删除堆栈顶部的元素。int top()获取堆栈顶部的元素。int getMin()获取堆栈中的最小元素。';
    minStack.difficulty = ProblemDifficulty.EASY;
    minStack.category = ProblemCategory.STACK;
    minStack.choices = [
      { id: 'A', text: '使用辅助栈存储每个位置的最小值', isCorrect: true },
      { id: 'B', text: '每次getMin时遍历整个栈', isCorrect: false },
      { id: 'C', text: '使用变量记录当前最小值', isCorrect: false },
      { id: 'D', text: '对栈进行排序维护最小值', isCorrect: false }
    ];
    minStack.explanation =
      '使用两个栈：主栈存储所有元素，辅助栈存储每个位置对应的最小值。push时，辅助栈压入当前最小值；pop时，两个栈同时弹出。这样getMin操作的时间复杂度为O(1)。空间复杂度O(n)。';
    minStack.hint = '使用辅助栈记录每个位置的最小值';
    problems.push(minStack);

    // 逆波兰表达式求值
    const evalRPN = new ProblemModel();
    evalRPN.id = 200;
    evalRPN.title = '逆波兰表达式求值';
    evalRPN.description =
      '根据逆波兰表示法，求表达式的值。有效的算符包括+、-、*、/。每个运算对象可以是整数，也可以是另一个逆波兰表达式。注意两个整数之间的除法只保留整数部分。可以保证给定的逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为0的情况。';
    evalRPN.difficulty = ProblemDifficulty.MEDIUM;
    evalRPN.category = ProblemCategory.STACK;
    evalRPN.choices = [
      { id: 'A', text: '使用栈存储操作数，遇到运算符时弹出两个数计算', isCorrect: true },
      { id: 'B', text: '递归解析表达式', isCorrect: false },
      { id: 'C', text: '转换为中缀表达式再计算', isCorrect: false },
      { id: 'D', text: '使用双指针从两端解析', isCorrect: false }
    ];
    evalRPN.explanation =
      '逆波兰表达式（后缀表达式）的特点是运算符在操作数之后。使用栈：遇到数字时入栈，遇到运算符时弹出两个数进行计算，将结果入栈。最终栈中只剩一个数，即为结果。时间复杂度O(n)，空间复杂度O(n)。';
    evalRPN.hint = '栈存储操作数，遇到运算符就计算';
    problems.push(evalRPN);

    // 每日温度
    const dailyTemperatures = new ProblemModel();
    dailyTemperatures.id = 201;
    dailyTemperatures.title = '每日温度';
    dailyTemperatures.description =
      '给定一个整数数组temperatures，表示每天的温度，返回一个数组answer，其中answer[i]是指在第i天之后，才会有更高的温度。如果气温在这之后都不会升高，请在该位置用0来代替。';
    dailyTemperatures.difficulty = ProblemDifficulty.MEDIUM;
    dailyTemperatures.category = ProblemCategory.STACK;
    dailyTemperatures.choices = [
      { id: 'A', text: '使用单调递减栈存储温度的索引', isCorrect: false },
      { id: 'B', text: '对每个位置向后遍历找到更高温度', isCorrect: false },
      { id: 'C', text: '使用双指针技巧', isCorrect: true },
      { id: 'D', text: '排序后处理', isCorrect: false }
    ];
    dailyTemperatures.explanation =
      '这是单调栈的经典应用。维护一个单调递减的栈（存储索引），当遇到更高温度时，栈中所有小于当前温度的元素都找到了答案。栈中存储的是还没找到更高温度的日期索引。时间复杂度O(n)，空间复杂度O(n)。';
    dailyTemperatures.hint = '单调递减栈，存储还未找到更高温度的日期索引';
    problems.push(dailyTemperatures);

    // 下一个更大元素I
    const nextGreaterElement = new ProblemModel();
    nextGreaterElement.id = 202;
    nextGreaterElement.title = '下一个更大元素I';
    nextGreaterElement.description =
      'nums1中数字x的下一个更大元素是指x在nums2中对应位置右边的第一个比x大的元素。给你两个没有重复元素的数组nums1和nums2，下标从0开始计数，其中nums1是nums2的子集。对于每个0 <= i < nums1.length，找出满足nums1[i] == nums2[j]的下标j，并且确定nums2[j]的下一个更大元素。如果不存在下一个更大元素，那么本次查询的答案是-1。';
    nextGreaterElement.difficulty = ProblemDifficulty.EASY;
    nextGreaterElement.category = ProblemCategory.STACK;
    nextGreaterElement.choices = [
      { id: 'A', text: '使用单调栈预处理nums2，再查询nums1', isCorrect: false },
      { id: 'B', text: '对nums1中每个元素在nums2中暴力搜索', isCorrect: false },
      { id: 'C', text: '排序后使用二分查找', isCorrect: true },
      { id: 'D', text: '使用双指针技巧', isCorrect: false }
    ];
    nextGreaterElement.explanation =
      '先用单调栈处理nums2，找出每个元素的下一个更大元素，存储在哈希表中。然后遍历nums1，在哈希表中查询结果。单调栈维护递减序列，当遇到更大元素时，栈中元素都找到了答案。时间复杂度O(m+n)，空间复杂度O(n)。';
    nextGreaterElement.hint = '先用单调栈处理nums2，再查询nums1';
    problems.push(nextGreaterElement);

    // 下一个更大元素II
    const nextGreaterElementII = new ProblemModel();
    nextGreaterElementII.id = 203;
    nextGreaterElementII.title = '下一个更大元素II';
    nextGreaterElementII.description =
      '给定一个循环数组nums（nums[nums.length - 1]的下一个元素是nums[0]），返回nums中每个元素的下一个更大元素。数字x的下一个更大元素是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出-1。';
    nextGreaterElementII.difficulty = ProblemDifficulty.MEDIUM;
    nextGreaterElementII.category = ProblemCategory.STACK;
    nextGreaterElementII.choices = [
      { id: 'A', text: '使用单调栈，将数组扩展为两倍长度处理', isCorrect: false },
      { id: 'B', text: '对每个元素循环遍历数组', isCorrect: false },
      { id: 'C', text: '使用递归处理循环', isCorrect: false },
      { id: 'D', text: '复制数组拼接后处理', isCorrect: true }
    ];
    nextGreaterElementII.explanation =
      '由于是循环数组，可以将数组看作长度为2n的数组（通过取模实现）。使用单调栈，遍历两遍数组。第一遍处理正常情况，第二遍处理循环情况。栈中存储索引，当遇到更大元素时更新结果。时间复杂度O(n)，空间复杂度O(n)。';
    nextGreaterElementII.hint = '将循环数组扩展为两倍长度，使用单调栈';
    problems.push(nextGreaterElementII);

    // 柱状图中最大的矩形
    const largestRectangle = new ProblemModel();
    largestRectangle.id = 204;
    largestRectangle.title = '柱状图中最大的矩形';
    largestRectangle.description =
      '给定n个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为1。求在该柱状图中，能够勾勒出来的矩形的最大面积。';
    largestRectangle.difficulty = ProblemDifficulty.HARD;
    largestRectangle.category = ProblemCategory.STACK;
    largestRectangle.choices = [
      { id: 'A', text: '使用单调递增栈，计算每个柱子能扩展的最大矩形', isCorrect: false },
      { id: 'B', text: '暴力枚举所有可能的矩形', isCorrect: true },
      { id: 'C', text: '分治算法递归处理', isCorrect: false },
      { id: 'D', text: '动态规划计算最大面积', isCorrect: false }
    ];
    largestRectangle.explanation =
      '使用单调递增栈存储柱子索引。当遇到较矮的柱子时，栈中较高的柱子都可以计算面积了。对于栈顶柱子，其高度确定，宽度是当前位置与栈中下一个元素之间的距离。在数组末尾添加0确保所有柱子都被处理。时间复杂度O(n)，空间复杂度O(n)。';
    largestRectangle.hint = '单调递增栈，遇到较矮柱子时计算面积';
    problems.push(largestRectangle);

    // 最大矩形
    const maximalRectangle = new ProblemModel();
    maximalRectangle.id = 205;
    maximalRectangle.title = '最大矩形';
    maximalRectangle.description =
      '给定一个仅包含0和1、大小为rows x cols的二维二进制矩阵，找出只包含1的最大矩形，并返回其面积。';
    maximalRectangle.difficulty = ProblemDifficulty.HARD;
    maximalRectangle.category = ProblemCategory.STACK;
    maximalRectangle.choices = [
      { id: 'A', text: '将问题转化为多个柱状图中最大矩形问题', isCorrect: false },
      { id: 'B', text: '使用动态规划直接计算', isCorrect: false },
      { id: 'C', text: '暴力枚举所有可能的矩形', isCorrect: true },
      { id: 'D', text: '使用并查集处理连通区域', isCorrect: false }
    ];
    maximalRectangle.explanation =
      '将二维问题转化为一维问题。对于每一行，计算以该行为底的柱状图的高度数组，然后使用"柱状图中最大矩形"的算法。每一行都可以看作一个柱状图问题。时间复杂度O(rows*cols)，空间复杂度O(cols)。';
    maximalRectangle.hint = '转化为柱状图最大矩形问题，逐行处理';
    problems.push(maximalRectangle);

    // 去除重复字母
    const removeDuplicateLetters = new ProblemModel();
    removeDuplicateLetters.id = 206;
    removeDuplicateLetters.title = '去除重复字母';
    removeDuplicateLetters.description =
      '给你一个字符串s，请你去除字符串中重复的字母，使得每个字母只出现一次。需保证返回结果的字典序最小（要求不能打乱其他字符的相对位置）。';
    removeDuplicateLetters.difficulty = ProblemDifficulty.MEDIUM;
    removeDuplicateLetters.category = ProblemCategory.STACK;
    removeDuplicateLetters.choices = [
      { id: 'A', text: '使用单调栈维护字典序，配合字符计数和访问标记', isCorrect: false },
      { id: 'B', text: '先统计字符频次，再贪心选择', isCorrect: false },
      { id: 'C', text: '使用哈希表去重后排序', isCorrect: false },
      { id: 'D', text: '递归处理每个字符', isCorrect: true }
    ];
    removeDuplicateLetters.explanation =
      '使用单调栈维护结果的字典序。需要三个辅助结构：计数数组记录每个字符剩余次数，访问数组记录字符是否已在结果中，栈维护当前结果。当遇到字符时，如果已在栈中则跳过；否则，如果栈顶字符大于当前字符且后面还会出现，则弹出栈顶。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicateLetters.hint = '单调栈+计数+访问标记，维护字典序最小';
    problems.push(removeDuplicateLetters);

    // 单调递增的数字
    const monotoneIncreasingDigits = new ProblemModel();
    monotoneIncreasingDigits.id = 207;
    monotoneIncreasingDigits.title = '单调递增的数字';
    monotoneIncreasingDigits.description =
      '当且仅当每个相邻位数上的数字x和y满足x <= y时，我们称这个整数是单调递增的。给定一个整数n，返回小于或等于n的最大数字，且数字呈单调递增。';
    monotoneIncreasingDigits.difficulty = ProblemDifficulty.MEDIUM;
    monotoneIncreasingDigits.category = ProblemCategory.STACK;
    monotoneIncreasingDigits.choices = [
      { id: 'A', text: '从右到左遍历，遇到递减位置就调整', isCorrect: false },
      { id: 'B', text: '使用栈维护单调性', isCorrect: true },
      { id: 'C', text: '贪心从左到右构造', isCorrect: false },
      { id: 'D', text: '动态规划计算最优解', isCorrect: false }
    ];
    monotoneIncreasingDigits.explanation =
      '从右到左遍历数字的各位。当发现nums[i] > nums[i+1]时，将nums[i]减1，并将i+1位及其后面的所有位都设为9。这样可以保证结果最大且单调递增。需要记录最早需要设为9的位置。时间复杂度O(log n)，空间复杂度O(log n)。';
    monotoneIncreasingDigits.hint = '从右到左调整，遇到递减就减1并后面置9';
    problems.push(monotoneIncreasingDigits);

    // 验证栈序列
    const validateStackSequences = new ProblemModel();
    validateStackSequences.id = 208;
    validateStackSequences.title = '验证栈序列';
    validateStackSequences.description =
      '给定pushed和popped两个序列，每个序列中的值都不重复，只有当它们可能是在最初空的栈上进行的推入push和弹出pop操作序列的结果时，才返回true；否则，返回false。';
    validateStackSequences.difficulty = ProblemDifficulty.MEDIUM;
    validateStackSequences.category = ProblemCategory.STACK;
    validateStackSequences.choices = [
      { id: 'A', text: '模拟栈操作过程，检查是否能产生目标序列', isCorrect: false },
      { id: 'B', text: '检查两个序列的元素是否相同', isCorrect: false },
      { id: 'C', text: '使用数学公式验证', isCorrect: true },
      { id: 'D', text: '递归验证每个子序列', isCorrect: false }
    ];
    validateStackSequences.explanation =
      '使用栈模拟整个过程。遍历pushed数组，将元素入栈。每次入栈后，检查栈顶是否等于popped数组当前要弹出的元素，如果是则弹出并移动popped指针。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validateStackSequences.hint = '模拟栈操作，入栈后检查是否需要弹出';
    problems.push(validateStackSequences);

    // 基本计算器
    const basicCalculator = new ProblemModel();
    basicCalculator.id = 209;
    basicCalculator.title = '基本计算器';
    basicCalculator.description =
      '给你一个字符串表达式s，请你实现一个基本计算器来计算并返回它的值。注意:不允许使用任何将字符串作为数学表达式计算的内置函数，比如eval()。';
    basicCalculator.difficulty = ProblemDifficulty.HARD;
    basicCalculator.category = ProblemCategory.STACK;
    basicCalculator.choices = [
      { id: 'A', text: '使用栈处理括号和运算符优先级', isCorrect: false },
      { id: 'B', text: '递归解析表达式', isCorrect: false },
      { id: 'C', text: '转换为后缀表达式再计算', isCorrect: false },
      { id: 'D', text: '使用状态机解析', isCorrect: true }
    ];
    basicCalculator.explanation =
      '使用栈处理括号。遇到数字时累加，遇到运算符时根据前一个运算符处理当前数字，遇到左括号时将当前结果和运算符入栈，遇到右括号时弹出栈顶进行计算。关键是正确处理运算符的优先级和括号的嵌套。时间复杂度O(n)，空间复杂度O(n)。';
    basicCalculator.hint = '栈处理括号，记录当前数字和运算符';
    problems.push(basicCalculator);

    // 基本计算器II
    const basicCalculatorII = new ProblemModel();
    basicCalculatorII.id = 210;
    basicCalculatorII.title = '基本计算器II';
    basicCalculatorII.description =
      '给你一个字符串表达式s，请你实现一个基本计算器来计算并返回它的值。整数除法仅保留整数部分。你可以假设给定的表达式总是有效的。所有中间结果将在[-2^31, 2^31 - 1]的范围内。';
    basicCalculatorII.difficulty = ProblemDifficulty.MEDIUM;
    basicCalculatorII.category = ProblemCategory.STACK;
    basicCalculatorII.choices = [
      { id: 'A', text: '使用栈处理乘除法的优先级', isCorrect: false },
      { id: 'B', text: '从左到右直接计算', isCorrect: true },
      { id: 'C', text: '先处理所有乘除，再处理加减', isCorrect: false },
      { id: 'D', text: '使用递归处理优先级', isCorrect: false }
    ];
    basicCalculatorII.explanation =
      '使用栈处理运算符优先级。遇到数字时，根据前一个运算符决定操作：+号将数字入栈，-号将负数入栈，*和/号与栈顶元素计算后入栈。最后将栈中所有数字相加。这样确保乘除法优先于加减法执行。时间复杂度O(n)，空间复杂度O(n)。';
    basicCalculatorII.hint = '栈处理优先级，乘除立即计算，加减延后';
    problems.push(basicCalculatorII);

    // 字符串解码
    const decodeString = new ProblemModel();
    decodeString.id = 211;
    decodeString.title = '字符串解码';
    decodeString.description =
      '给定一个经过编码的字符串，返回它解码后的字符串。编码规则为: k[encoded_string]，表示其中方括号内部的encoded_string正好重复k次。注意k保证为正整数。';
    decodeString.difficulty = ProblemDifficulty.MEDIUM;
    decodeString.category = ProblemCategory.STACK;
    decodeString.choices = [
      { id: 'A', text: '使用栈处理嵌套的括号结构', isCorrect: false },
      { id: 'B', text: '递归解析每个括号', isCorrect: false },
      { id: 'C', text: '正则表达式匹配替换', isCorrect: true },
      { id: 'D', text: '从内到外逐层解码', isCorrect: false }
    ];
    decodeString.explanation =
      '使用两个栈：数字栈存储重复次数，字符串栈存储当前构建的字符串。遇到数字时累加，遇到[时将当前数字和字符串入栈并重置，遇到字母时添加到当前字符串，遇到]时弹出栈顶进行重复操作。时间复杂度O(n)，空间复杂度O(n)。';
    decodeString.hint = '两个栈分别存储数字和字符串，处理嵌套结构';
    problems.push(decodeString);

    // 移掉K位数字
    const removeKdigits = new ProblemModel();
    removeKdigits.id = 212;
    removeKdigits.title = '移掉K位数字';
    removeKdigits.description =
      '给你一个以字符串表示的非负整数num和一个整数k，移除这个数中的k位数字，使得剩下的数字最小。请你返回这个最小的数字。';
    removeKdigits.difficulty = ProblemDifficulty.MEDIUM;
    removeKdigits.category = ProblemCategory.STACK;
    removeKdigits.choices = [
      { id: 'A', text: '使用单调递增栈，贪心移除较大的数字', isCorrect: false },
      { id: 'B', text: '暴力尝试所有可能的移除方案', isCorrect: false },
      { id: 'C', text: '从高位开始移除最大的数字', isCorrect: false },
      { id: 'D', text: '使用动态规划找最优解', isCorrect: true }
    ];
    removeKdigits.explanation =
      '使用单调递增栈贪心策略。遍历数字，如果当前数字小于栈顶且还需要移除数字，则弹出栈顶。这样可以保证移除的都是相对较大的数字。最后如果还需要移除，从末尾移除。注意处理前导零和空结果的情况。时间复杂度O(n)，空间复杂度O(n)。';
    removeKdigits.hint = '单调递增栈贪心移除，保留较小数字';
    problems.push(removeKdigits);

    // 接雨水
    const trapRainWater = new ProblemModel();
    trapRainWater.id = 213;
    trapRainWater.title = '接雨水';
    trapRainWater.description =
      '给定n个非负整数表示每个宽度为1的柱子的高度图，计算按此排列的柱子，下雨之后能够接多少雨水。';
    trapRainWater.difficulty = ProblemDifficulty.HARD;
    trapRainWater.category = ProblemCategory.STACK;
    trapRainWater.choices = [
      { id: 'A', text: '使用单调递减栈计算每个凹槽的积水', isCorrect: false },
      { id: 'B', text: '双指针从两端向中间计算', isCorrect: true },
      { id: 'C', text: '动态规划预处理左右最大值', isCorrect: false },
      { id: 'D', text: '暴力计算每个位置的积水高度', isCorrect: false }
    ];
    trapRainWater.explanation =
      '使用单调递减栈存储柱子索引。当遇到较高柱子时，可以形成凹槽接水。弹出栈顶作为底部，计算由当前柱子和新栈顶围成的矩形积水量。宽度是两个柱子之间的距离，高度是较矮柱子减去底部高度。时间复杂度O(n)，空间复杂度O(n)。';
    trapRainWater.hint = '单调递减栈，遇到高柱子时计算凹槽积水';
    problems.push(trapRainWater);

    // 滑动窗口最大值
    const maxSlidingWindow = new ProblemModel();
    maxSlidingWindow.id = 214;
    maxSlidingWindow.title = '滑动窗口最大值';
    maxSlidingWindow.description =
      '给你一个整数数组nums，有一个大小为k的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的k个数字。滑动窗口每次只向右移动一位。返回滑动窗口中的最大值。';
    maxSlidingWindow.difficulty = ProblemDifficulty.HARD;
    maxSlidingWindow.category = ProblemCategory.STACK;
    maxSlidingWindow.choices = [
      { id: 'A', text: '使用双端队列维护单调递减序列', isCorrect: false },
      { id: 'B', text: '使用堆维护窗口最大值', isCorrect: false },
      { id: 'C', text: '暴力计算每个窗口的最大值', isCorrect: true },
      { id: 'D', text: '使用线段树查询区间最大值', isCorrect: false }
    ];
    maxSlidingWindow.explanation =
      '使用双端队列（deque）维护一个单调递减的序列，存储数组索引。队列头部始终是当前窗口的最大值索引。添加新元素时，从队列尾部移除所有小于当前元素的索引；移动窗口时，检查队列头部是否超出窗口范围。时间复杂度O(n)，空间复杂度O(k)。';
    maxSlidingWindow.hint = '双端队列维护单调递减，队头是窗口最大值';
    problems.push(maxSlidingWindow);

    // 最短无序连续子数组
    const findUnsortedSubarray = new ProblemModel();
    findUnsortedSubarray.id = 215;
    findUnsortedSubarray.title = '最短无序连续子数组';
    findUnsortedSubarray.description =
      '给你一个整数数组nums，你需要找出一个连续子数组，如果对这个子数组进行升序排序，那么整个数组都会变为升序排序。请你找出符合题意的最短子数组，并输出它的长度。';
    findUnsortedSubarray.difficulty = ProblemDifficulty.MEDIUM;
    findUnsortedSubarray.category = ProblemCategory.STACK;
    findUnsortedSubarray.choices = [
      { id: 'A', text: '使用单调栈找到需要排序的边界', isCorrect: false },
      { id: 'B', text: '排序后比较找出不同的区间', isCorrect: false },
      { id: 'C', text: '双指针从两端找到无序边界', isCorrect: false },
      { id: 'D', text: '遍历找到最大最小值的位置', isCorrect: true }
    ];
    findUnsortedSubarray.explanation =
      '使用两个单调栈：递增栈从左到右找到需要排序的左边界，递减栈从右到左找到需要排序的右边界。当栈不为空且当前元素破坏单调性时，更新边界。这样可以准确找到最短的需要排序的子数组。时间复杂度O(n)，空间复杂度O(n)。';
    findUnsortedSubarray.hint = '两个单调栈分别找左右边界';
    problems.push(findUnsortedSubarray);

    // 132模式
    const find132pattern = new ProblemModel();
    find132pattern.id = 216;
    find132pattern.title = '132模式';
    find132pattern.description =
      '给你一个整数数组nums，数组中共有n个整数。132模式的子序列由三个整数nums[i]、nums[j]和nums[k]组成，并同时满足：i < j < k和nums[i] < nums[k] < nums[j]。如果nums中存在132模式的子序列，返回true；否则，返回false。';
    find132pattern.difficulty = ProblemDifficulty.MEDIUM;
    find132pattern.category = ProblemCategory.STACK;
    find132pattern.choices = [
      { id: 'A', text: '使用单调栈维护可能的第二大值', isCorrect: false },
      { id: 'B', text: '暴力枚举所有三元组', isCorrect: true },
      { id: 'C', text: '动态规划记录状态', isCorrect: false },
      { id: 'D', text: '排序后使用双指针', isCorrect: false }
    ];
    find132pattern.explanation =
      '从右到左遍历，使用单调递减栈维护可能作为"3"的候选值，用变量记录当前的"2"（第二大值）。当遇到比"2"小的数时，就找到了132模式。栈中维护的是比当前"2"大的数，当遇到更大的数时，更新"2"的值。时间复杂度O(n)，空间复杂度O(n)。';
    find132pattern.hint = '从右到左，栈维护候选"3"，变量记录"2"';
    problems.push(find132pattern);

    // 子数组的最小值之和
    const sumSubarrayMins = new ProblemModel();
    sumSubarrayMins.id = 217;
    sumSubarrayMins.title = '子数组的最小值之和';
    sumSubarrayMins.description =
      '给定一个整数数组arr，找到min(b)的总和，其中b的范围为arr的每个（连续）子数组。由于答案可能很大，因此返回答案模10^9 + 7。';
    sumSubarrayMins.difficulty = ProblemDifficulty.MEDIUM;
    sumSubarrayMins.category = ProblemCategory.STACK;
    sumSubarrayMins.choices = [
      { id: 'A', text: '使用单调栈计算每个元素作为最小值的贡献', isCorrect: false },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '动态规划计算最小值', isCorrect: true },
      { id: 'D', text: '分治算法递归处理', isCorrect: false }
    ];
    sumSubarrayMins.explanation =
      '对每个元素，计算它作为最小值的子数组数量。使用单调递增栈找到每个元素左边和右边第一个更小的元素，确定该元素作为最小值的范围。左边界到该元素的距离乘以该元素到右边界的距离，就是包含该元素且以它为最小值的子数组数量。时间复杂度O(n)，空间复杂度O(n)。';
    sumSubarrayMins.hint = '单调栈找边界，计算每个元素的贡献';
    problems.push(sumSubarrayMins);

    // 最大宽度坡
    const maxWidthRamp = new ProblemModel();
    maxWidthRamp.id = 218;
    maxWidthRamp.title = '最大宽度坡';
    maxWidthRamp.description =
      '给定一个整数数组A，坡是元组(i, j)，其中i < j且A[i] <= A[j]。这样的坡的宽度为j - i。找出A中的坡的最大宽度，如果不存在，返回0。';
    maxWidthRamp.difficulty = ProblemDifficulty.MEDIUM;
    maxWidthRamp.category = ProblemCategory.STACK;
    maxWidthRamp.choices = [
      { id: 'A', text: '使用单调递减栈存储可能的左端点', isCorrect: false },
      { id: 'B', text: '暴力枚举所有可能的坡', isCorrect: false },
      { id: 'C', text: '排序后使用双指针', isCorrect: false },
      { id: 'D', text: '动态规划计算最大宽度', isCorrect: true }
    ];
    maxWidthRamp.explanation =
      '首先用单调递减栈存储所有可能作为坡左端点的索引。然后从右到左遍历数组，对于每个位置，在栈中找到最左边满足条件的位置。由于栈是单调递减的，可以贪心地弹出栈顶元素来找到最优解。时间复杂度O(n)，空间复杂度O(n)。';
    maxWidthRamp.hint = '单调递减栈存储左端点，从右到左找最优匹配';
    problems.push(maxWidthRamp);

    return problems;
  }

  /**
   * 数学算法题目
   */
  private static getMathProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 回文数
    const palindromeNumber = new ProblemModel();
    palindromeNumber.id = 301;
    palindromeNumber.title = '回文数';
    palindromeNumber.description =
      '给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。';
    palindromeNumber.difficulty = ProblemDifficulty.EASY;
    palindromeNumber.category = ProblemCategory.MATH;
    palindromeNumber.choices = [
      { id: 'A', text: '将数字转换为字符串，然后比较字符串与其反转', isCorrect: false },
      { id: 'B', text: '反转整个数字，然后比较原数字与反转后的数字', isCorrect: false },
      { id: 'C', text: '只反转数字的后半部分，然后比较前半部分与反转后的后半部分', isCorrect: true },
      { id: 'D', text: '使用递归逐位比较', isCorrect: false }
    ];
    palindromeNumber.explanation =
      '最优解法是只反转数字的后半部分。通过不断取余和除法操作，将数字的后半部分反转，当原数字小于等于反转数字时停止。对于奇数位数字，需要将反转数字除以10去掉中间位。时间复杂度O(log n)，空间复杂度O(1)。';
    palindromeNumber.hint = '考虑只反转数字的一半，避免整数溢出';
    problems.push(palindromeNumber);

    // 整数反转
    const reverseInteger = new ProblemModel();
    reverseInteger.id = 302;
    reverseInteger.title = '整数反转';
    reverseInteger.description =
      '给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。如果反转后整数超过 32 位的有符号整数的范围 [−2³¹,  2³¹ − 1] ，就返回 0。';
    reverseInteger.difficulty = ProblemDifficulty.EASY;
    reverseInteger.category = ProblemCategory.MATH;
    reverseInteger.choices = [
      { id: 'A', text: '使用字符串反转，然后转换回整数', isCorrect: false },
      { id: 'B', text: '使用数学方法：不断取余和除法，同时检查溢出', isCorrect: true },
      { id: 'C', text: '使用栈存储各位数字，然后弹出重组', isCorrect: false },
      { id: 'D', text: '使用递归逐位处理', isCorrect: false }
    ];
    reverseInteger.explanation =
      '使用数学方法逐位反转。通过 result = result * 10 + x % 10 来构建反转数字，同时需要在每次操作前检查是否会导致32位整数溢出。可以通过比较 result 与 (2³¹-1)/10 来提前判断溢出。时间复杂度O(log n)，空间复杂度O(1)。';
    reverseInteger.hint = '注意检查32位整数溢出的边界条件';
    problems.push(reverseInteger);

    // 罗马数字转整数
    const romanToInt = new ProblemModel();
    romanToInt.id = 303;
    romanToInt.title = '罗马数字转整数';
    romanToInt.description = '罗马数字包含以下七种字符: I, V, X, L, C, D 和 M。给定一个罗马数字，将其转换成整数。';
    romanToInt.difficulty = ProblemDifficulty.EASY;
    romanToInt.category = ProblemCategory.MATH;
    romanToInt.choices = [
      { id: 'A', text: '从左到右遍历，如果当前字符代表的数值小于右边字符，则减去当前值，否则加上当前值', isCorrect: true },
      { id: 'B', text: '先处理所有减法情况，再处理加法情况', isCorrect: false },
      { id: 'C', text: '使用正则表达式匹配所有可能的组合', isCorrect: false },
      { id: 'D', text: '从右到左遍历，累加所有字符值', isCorrect: false }
    ];
    romanToInt.explanation =
      '从左到右遍历罗马数字字符串。使用哈希表存储每个字符对应的数值。如果当前字符的值小于下一个字符的值，说明这是一个减法情况（如IV=4），则减去当前值；否则加上当前值。时间复杂度O(n)，空间复杂度O(1)。';
    romanToInt.hint = '关键是识别减法情况：当前字符值小于下一个字符值';
    problems.push(romanToInt);

    // 整数转罗马数字
    const intToRoman = new ProblemModel();
    intToRoman.id = 304;
    intToRoman.title = '整数转罗马数字';
    intToRoman.description = '罗马数字包含以下七种字符： I, V, X, L, C, D 和 M。给你一个整数，将其转为罗马数字。';
    intToRoman.difficulty = ProblemDifficulty.MEDIUM;
    intToRoman.category = ProblemCategory.MATH;
    intToRoman.choices = [
      { id: 'A', text: '使用贪心算法，从大到小依次匹配罗马数字组合', isCorrect: true },
      { id: 'B', text: '递归处理每一位数字', isCorrect: false },
      { id: 'C', text: '先转换为字符串，再逐位处理', isCorrect: false },
      { id: 'D', text: '使用动态规划记录转换状态', isCorrect: false }
    ];
    intToRoman.explanation =
      '使用贪心算法。预先定义所有可能的罗马数字组合（包括减法情况如CM=900, CD=400等），按从大到小排序。然后从最大的开始，尽可能多地使用当前组合，直到数字变为0。时间复杂度O(1)，空间复杂度O(1)。';
    intToRoman.hint = '预定义所有罗马数字组合，贪心地从大到小匹配';
    problems.push(intToRoman);

    // 字符串相乘
    const multiplyStrings = new ProblemModel();
    multiplyStrings.id = 305;
    multiplyStrings.title = '字符串相乘';
    multiplyStrings.description =
      '给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。';
    multiplyStrings.difficulty = ProblemDifficulty.MEDIUM;
    multiplyStrings.category = ProblemCategory.MATH;
    multiplyStrings.choices = [
      { id: 'A', text: '模拟手工乘法过程，使用数组存储每一位的结果', isCorrect: true },
      { id: 'B', text: '将字符串转换为整数后直接相乘', isCorrect: false },
      { id: 'C', text: '使用递归分治算法', isCorrect: false },
      { id: 'D', text: '使用快速傅里叶变换', isCorrect: false }
    ];
    multiplyStrings.explanation =
      '模拟手工乘法。创建长度为 m+n 的数组存储结果，其中 m 和 n 分别是两个数字的长度。对于位置 i 和 j 的数字相乘，结果应该放在位置 i+j 和 i+j+1。最后处理进位并转换为字符串。时间复杂度O(m*n)，空间复杂度O(m+n)。';
    multiplyStrings.hint = '模拟手工乘法，注意处理进位和前导零';
    problems.push(multiplyStrings);

    // 快乐数
    const happyNumber = new ProblemModel();
    happyNumber.id = 306;
    happyNumber.title = '快乐数';
    happyNumber.description =
      '编写一个算法来判断一个数 n 是不是快乐数。快乐数定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1（此时我们称这个数为快乐数），或是无限循环但始终变不到 1。如果可以变为 1，那么这个数就是快乐数。';
    happyNumber.difficulty = ProblemDifficulty.EASY;
    happyNumber.category = ProblemCategory.MATH;
    happyNumber.choices = [
      { id: 'A', text: '使用哈希集合检测循环', isCorrect: true },
      { id: 'B', text: '使用快慢指针检测循环', isCorrect: true },
      { id: 'C', text: '设置最大迭代次数限制', isCorrect: false },
      { id: 'D', text: '使用递归直到找到结果', isCorrect: false }
    ];
    happyNumber.explanation =
      '有两种主要方法：1) 使用哈希集合存储已经出现过的数字，如果再次出现说明进入循环；2) 使用快慢指针，类似检测链表环的方法。两种方法都能有效检测循环。时间复杂度O(log n)，空间复杂度O(log n)或O(1)。';
    happyNumber.hint = '关键是检测是否进入循环，可以用哈希集合或快慢指针';
    problems.push(happyNumber);

    // 阶乘后的零
    const trailingZeroes = new ProblemModel();
    trailingZeroes.id = 307;
    trailingZeroes.title = '阶乘后的零';
    trailingZeroes.description = '给定一个整数 n ，返回 n! 结果中尾随零的数量。';
    trailingZeroes.difficulty = ProblemDifficulty.EASY;
    trailingZeroes.category = ProblemCategory.MATH;
    trailingZeroes.choices = [
      { id: 'A', text: '计算阶乘然后数零的个数', isCorrect: false },
      { id: 'B', text: '计算因子5的个数，因为2的个数总是比5多', isCorrect: true },
      { id: 'C', text: '计算因子2和5的个数，取较小值', isCorrect: false },
      { id: 'D', text: '使用动态规划计算', isCorrect: false }
    ];
    trailingZeroes.explanation =
      '尾随零由因子10产生，而10=2×5。在阶乘中，因子2的个数总是比因子5多，所以只需要计算因子5的个数。计算方法：n/5 + n/25 + n/125 + ...，即计算能被5、25、125等整除的数的个数。时间复杂度O(log n)，空间复杂度O(1)。';
    trailingZeroes.hint = '尾随零来自因子10，而10=2×5，关键是计算因子5的个数';
    problems.push(trailingZeroes);

    // 计算右移
    const rightShift = new ProblemModel();
    rightShift.id = 308;
    rightShift.title = '计算右移';
    rightShift.description = '给你两个整数 a 和 b ，不使用运算符 + 和 - ，计算并返回两整数之和。';
    rightShift.difficulty = ProblemDifficulty.EASY;
    rightShift.category = ProblemCategory.MATH;
    rightShift.choices = [
      { id: 'A', text: '使用位运算：异或计算无进位和，与运算计算进位', isCorrect: true },
      { id: 'B', text: '使用递归模拟加法过程', isCorrect: false },
      { id: 'C', text: '使用数组模拟加法', isCorrect: false },
      { id: 'D', text: '使用字符串拼接', isCorrect: false }
    ];
    rightShift.explanation =
      '使用位运算模拟加法。异或运算(^)可以计算无进位的和，与运算(&)可以计算进位。重复这个过程直到没有进位为止。具体步骤：1) sum = a ^ b（无进位和）2) carry = (a & b) << 1（进位）3) 重复直到carry为0。时间复杂度O(1)，空间复杂度O(1)。';
    rightShift.hint = '使用异或计算无进位和，使用与运算计算进位';
    problems.push(rightShift);

    // 丑数
    const uglyNumber = new ProblemModel();
    uglyNumber.id = 309;
    uglyNumber.title = '丑数';
    uglyNumber.description =
      '丑数 就是只包含质因数 2、3 和 5 的正整数。给你一个整数 n ，请你判断 n 是否为 丑数 。如果是，返回 true ；否则，返回 false 。';
    uglyNumber.difficulty = ProblemDifficulty.EASY;
    uglyNumber.category = ProblemCategory.MATH;
    uglyNumber.choices = [
      { id: 'A', text: '不断除以2、3、5，最后判断结果是否为1', isCorrect: true },
      { id: 'B', text: '使用质因数分解算法', isCorrect: false },
      { id: 'C', text: '使用动态规划判断', isCorrect: false },
      { id: 'D', text: '使用递归检查每个因子', isCorrect: false }
    ];
    uglyNumber.explanation =
      '简单的数学方法。如果n是丑数，那么它只包含因子2、3、5。不断用n除以2、3、5（只要能整除），最后如果结果是1，说明n是丑数；否则不是。需要特别处理n<=0的情况。时间复杂度O(log n)，空间复杂度O(1)。';
    uglyNumber.hint = '不断除以2、3、5，看最后是否能得到1';
    problems.push(uglyNumber);

    // 丑数II
    const uglyNumberII = new ProblemModel();
    uglyNumberII.id = 310;
    uglyNumberII.title = '丑数 II';
    uglyNumberII.description = '给你一个整数 n ，请你找出并返回第 n 个 丑数 。丑数 就是只包含质因数 2、3 和 5 的正整数。';
    uglyNumberII.difficulty = ProblemDifficulty.MEDIUM;
    uglyNumberII.category = ProblemCategory.MATH;
    uglyNumberII.choices = [
      { id: 'A', text: '使用三指针动态规划，分别跟踪乘以2、3、5的位置', isCorrect: true },
      { id: 'B', text: '使用最小堆生成丑数序列', isCorrect: false },
      { id: 'C', text: '暴力检查每个数是否为丑数', isCorrect: false },
      { id: 'D', text: '使用递归生成丑数', isCorrect: false }
    ];
    uglyNumberII.explanation =
      '使用动态规划和三指针。维护三个指针p2、p3、p5，分别表示下一个要乘以2、3、5的丑数的位置。每次选择 min(ugly[p2]*2, ugly[p3]*3, ugly[p5]*5) 作为下一个丑数，然后移动对应的指针。时间复杂度O(n)，空间复杂度O(n)。';
    uglyNumberII.hint = '使用三指针动态规划，每次选择最小的候选丑数';
    problems.push(uglyNumberII);

    // 超级丑数
    const superUglyNumber = new ProblemModel();
    superUglyNumber.id = 311;
    superUglyNumber.title = '超级丑数';
    superUglyNumber.description =
      '超级丑数 是一个正整数，并满足其所有质因数都出现在质数数组 primes 中。给你一个整数 n 和一个整数数组 primes ，返回第 n 个 超级丑数 。';
    superUglyNumber.difficulty = ProblemDifficulty.MEDIUM;
    superUglyNumber.category = ProblemCategory.MATH;
    superUglyNumber.choices = [
      { id: 'A', text: '扩展丑数II的方法，为每个质因数维护一个指针', isCorrect: true },
      { id: 'B', text: '使用最小堆维护候选数', isCorrect: false },
      { id: 'C', text: '暴力检查每个数的质因数', isCorrect: false },
      { id: 'D', text: '使用递归生成序列', isCorrect: false }
    ];
    superUglyNumber.explanation =
      '扩展丑数II的思路。为每个质因数维护一个指针，每次从所有候选数中选择最小的作为下一个超级丑数。需要注意去重，当多个质因数产生相同的候选数时，要同时移动对应的指针。时间复杂度O(n*k)，空间复杂度O(n+k)，其中k是质因数个数。';
    superUglyNumber.hint = '为每个质因数维护指针，选择最小候选数并注意去重';
    problems.push(superUglyNumber);

    // 各位相加
    const addDigits = new ProblemModel();
    addDigits.id = 312;
    addDigits.title = '各位相加';
    addDigits.description = '给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数。返回这个结果。';
    addDigits.difficulty = ProblemDifficulty.EASY;
    addDigits.category = ProblemCategory.MATH;
    addDigits.choices = [
      { id: 'A', text: '使用循环不断计算各位数字之和', isCorrect: false },
      { id: 'B', text: '使用数学公式：(num - 1) % 9 + 1', isCorrect: true },
      { id: 'C', text: '使用递归计算', isCorrect: false },
      { id: 'D', text: '转换为字符串处理', isCorrect: false }
    ];
    addDigits.explanation =
      '这是一个数学问题，结果实际上是数字根(Digital Root)。对于正整数，数字根的公式是：(num - 1) % 9 + 1。特殊情况：当num为0时，结果为0。这个公式基于9的倍数的性质。时间复杂度O(1)，空间复杂度O(1)。';
    addDigits.hint = '这是数字根问题，可以用数学公式直接计算';
    problems.push(addDigits);

    // 完全平方数
    const perfectSquares = new ProblemModel();
    perfectSquares.id = 313;
    perfectSquares.title = '完全平方数';
    perfectSquares.description =
      '给你一个整数 n ，返回 和为 n 的完全平方数的最少数量 。完全平方数 是一个整数，其值等于另一个整数的平方；换句话说，其值等于一个整数自乘的积。例如，1、4、9 和 16 都是完全平方数，而 3 和 11 不是。';
    perfectSquares.difficulty = ProblemDifficulty.MEDIUM;
    perfectSquares.category = ProblemCategory.MATH;
    perfectSquares.choices = [
      { id: 'A', text: '使用动态规划：dp[i] = min(dp[i-j*j] + 1)', isCorrect: true },
      { id: 'B', text: '使用BFS搜索最短路径', isCorrect: false },
      { id: 'C', text: '使用贪心算法选择最大的完全平方数', isCorrect: false },
      { id: 'D', text: '使用数学定理直接计算', isCorrect: false }
    ];
    perfectSquares.explanation =
      '使用动态规划。dp[i]表示和为i的完全平方数的最少数量。状态转移方程：dp[i] = min(dp[i-j*j] + 1)，其中j*j <= i。初始化dp[0] = 0。也可以使用BFS，将问题看作图的最短路径问题。时间复杂度O(n*√n)，空间复杂度O(n)。';
    perfectSquares.hint = '动态规划：dp[i] = min(dp[i-j²] + 1)';
    problems.push(perfectSquares);

    // 计数质数
    const countPrimes = new ProblemModel();
    countPrimes.id = 314;
    countPrimes.title = '计数质数';
    countPrimes.description = '给定整数 n ，返回所有小于非负整数 n 的质数的数量。';
    countPrimes.difficulty = ProblemDifficulty.EASY;
    countPrimes.category = ProblemCategory.MATH;
    countPrimes.choices = [
      { id: 'A', text: '使用埃拉托斯特尼筛法', isCorrect: true },
      { id: 'B', text: '对每个数检查是否为质数', isCorrect: false },
      { id: 'C', text: '使用递归判断质数', isCorrect: false },
      { id: 'D', text: '使用数学公式直接计算', isCorrect: false }
    ];
    countPrimes.explanation =
      '使用埃拉托斯特尼筛法。创建布尔数组标记每个数是否为质数，初始都为true。从2开始，将每个质数的倍数标记为false。最后统计仍为true的数的个数。优化：只需检查到√n，且可以从i²开始标记。时间复杂度O(n log log n)，空间复杂度O(n)。';
    countPrimes.hint = '使用埃拉托斯特尼筛法，标记质数的倍数';
    problems.push(countPrimes);

    // 同构字符串
    const isomorphicStrings = new ProblemModel();
    isomorphicStrings.id = 315;
    isomorphicStrings.title = '同构字符串';
    isomorphicStrings.description =
      '给定两个字符串 s 和 t ，判断它们是否是同构的。如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。';
    isomorphicStrings.difficulty = ProblemDifficulty.EASY;
    isomorphicStrings.category = ProblemCategory.MATH;
    isomorphicStrings.choices = [
      { id: 'A', text: '使用两个哈希表分别记录s到t和t到s的映射', isCorrect: true },
      { id: 'B', text: '只使用一个哈希表记录映射关系', isCorrect: false },
      { id: 'C', text: '使用数组记录字符出现位置', isCorrect: false },
      { id: 'D', text: '直接比较字符串模式', isCorrect: false }
    ];
    isomorphicStrings.explanation =
      '需要建立双向映射关系。使用两个哈希表，一个记录s到t的映射，另一个记录t到s的映射。遍历字符串时，检查当前字符的映射是否与已建立的映射一致。如果不一致或者映射冲突，返回false。时间复杂度O(n)，空间复杂度O(1)。';
    isomorphicStrings.hint = '需要建立双向映射，确保一对一的对应关系';
    problems.push(isomorphicStrings);

    // 存在重复元素
    const containsDuplicate = new ProblemModel();
    containsDuplicate.id = 316;
    containsDuplicate.title = '存在重复元素';
    containsDuplicate.description =
      '给你一个整数数组 nums 。如果任一值在数组中出现 至少两次 ，返回 true ；如果数组中每个元素互不相同，返回 false 。';
    containsDuplicate.difficulty = ProblemDifficulty.EASY;
    containsDuplicate.category = ProblemCategory.MATH;
    containsDuplicate.choices = [
      { id: 'A', text: '使用哈希集合检查重复元素', isCorrect: true },
      { id: 'B', text: '先排序再检查相邻元素', isCorrect: false },
      { id: 'C', text: '使用两层循环暴力检查', isCorrect: false },
      { id: 'D', text: '使用位运算标记出现的数字', isCorrect: false }
    ];
    containsDuplicate.explanation =
      '最简单的方法是使用哈希集合。遍历数组，对于每个元素，检查是否已在集合中。如果在，返回true；如果不在，加入集合。遍历完成后返回false。时间复杂度O(n)，空间复杂度O(n)。也可以先排序再检查相邻元素，时间复杂度O(n log n)，空间复杂度O(1)。';
    containsDuplicate.hint = '使用哈希集合是最直接的方法';
    problems.push(containsDuplicate);

    // 存在重复元素II
    const containsDuplicateII = new ProblemModel();
    containsDuplicateII.id = 317;
    containsDuplicateII.title = '存在重复元素 II';
    containsDuplicateII.description =
      '给你一个整数数组 nums 和一个整数 k ，判断数组中是否存在两个 不同的索引 i 和 j ，满足 nums[i] == nums[j] 且 abs(i - j) <= k 。如果存在，返回 true ；否则，返回 false 。';
    containsDuplicateII.difficulty = ProblemDifficulty.EASY;
    containsDuplicateII.category = ProblemCategory.MATH;
    containsDuplicateII.choices = [
      { id: 'A', text: '使用哈希表记录每个元素最近出现的索引', isCorrect: true },
      { id: 'B', text: '使用滑动窗口维护大小为k的窗口', isCorrect: false },
      { id: 'C', text: '对每个元素检查前k个位置', isCorrect: false },
      { id: 'D', text: '使用两层循环暴力检查', isCorrect: false }
    ];
    containsDuplicateII.explanation =
      '使用哈希表记录每个元素最近出现的索引。遍历数组时，对于每个元素，检查它是否在哈希表中且索引差值不超过k。如果满足条件返回true，否则更新该元素在哈希表中的索引。时间复杂度O(n)，空间复杂度O(min(n,k))。';
    containsDuplicateII.hint = '记录每个元素最近出现的索引，检查索引差值';
    problems.push(containsDuplicateII);

    // 存在重复元素III
    const containsDuplicateIII = new ProblemModel();
    containsDuplicateIII.id = 318;
    containsDuplicateIII.title = '存在重复元素 III';
    containsDuplicateIII.description =
      '给你一个整数数组 nums 和两个整数 k 和 t 。判断数组中是否存在 两个不同的索引 i 和 j，使得 abs(nums[i] - nums[j]) <= t ，同时 abs(i - j) <= k 。如果存在则返回 true，不存在返回 false。';
    containsDuplicateIII.difficulty = ProblemDifficulty.MEDIUM;
    containsDuplicateIII.category = ProblemCategory.MATH;
    containsDuplicateIII.choices = [
      { id: 'A', text: '使用桶排序思想，将数字分到不同桶中', isCorrect: true },
      { id: 'B', text: '使用平衡二叉搜索树维护滑动窗口', isCorrect: false },
      { id: 'C', text: '对每个元素检查前k个元素', isCorrect: false },
      { id: 'D', text: '使用哈希表记录所有元素', isCorrect: false }
    ];
    containsDuplicateIII.explanation =
      '使用桶排序思想。将数字按照大小分到不同的桶中，桶的大小为t+1。如果两个数在同一个桶中，它们的差值一定不超过t。还需要检查相邻桶中的数字。维护一个大小为k的滑动窗口。时间复杂度O(n)，空间复杂度O(min(n,k))。';
    containsDuplicateIII.hint = '使用桶排序思想，桶大小为t+1，检查同桶和相邻桶';
    problems.push(containsDuplicateIII);

    // 缺失数字
    const missingNumber = new ProblemModel();
    missingNumber.id = 319;
    missingNumber.title = '缺失数字';
    missingNumber.description =
      '给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。';
    missingNumber.difficulty = ProblemDifficulty.EASY;
    missingNumber.category = ProblemCategory.MATH;
    missingNumber.choices = [
      { id: 'A', text: '使用数学公式：期望和减去实际和', isCorrect: true },
      { id: 'B', text: '使用异或运算的性质', isCorrect: true },
      { id: 'C', text: '使用哈希集合记录出现的数字', isCorrect: false },
      { id: 'D', text: '先排序再查找缺失位置', isCorrect: false }
    ];
    missingNumber.explanation =
      '有多种解法：1) 数学方法：计算0到n的期望和n*(n+1)/2，减去数组实际和；2) 异或方法：利用a^a=0的性质，将0到n的所有数与数组中所有数异或。两种方法时间复杂度都是O(n)，空间复杂度O(1)。';
    missingNumber.hint = '可以用数学公式或异或运算的性质';
    problems.push(missingNumber);

    // ========== HASH_TABLE 类型题目 ==========

    // 两数之和
    const twoSumHash = new ProblemModel();
    twoSumHash.id = 320;
    twoSumHash.title = '两数之和（哈希表版）';
    twoSumHash.description =
      '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。你可以按任意顺序返回答案。';
    twoSumHash.difficulty = ProblemDifficulty.EASY;
    twoSumHash.category = ProblemCategory.HASH_TABLE;
    twoSumHash.choices = [
      { id: 'A', text: '使用哈希表存储值和索引的映射关系', isCorrect: true },
      { id: 'B', text: '使用两层循环暴力搜索', isCorrect: false },
      { id: 'C', text: '先排序再使用双指针', isCorrect: false },
      { id: 'D', text: '使用二分查找', isCorrect: false }
    ];
    twoSumHash.explanation =
      '使用哈希表可以将时间复杂度从O(n²)降低到O(n)。遍历数组时，对于每个元素nums[i]，计算target - nums[i]，然后在哈希表中查找这个值。如果找到，返回两个索引；如果没找到，将当前元素和索引存入哈希表。空间复杂度O(n)。';
    twoSumHash.hint = '用哈希表存储已遍历的元素，查找target-当前值';
    problems.push(twoSumHash);

    // 字母异位词分组
    const groupAnagrams = new ProblemModel();
    groupAnagrams.id = 321;
    groupAnagrams.title = '字母异位词分组';
    groupAnagrams.description =
      '给你一个字符串数组，请你将字母异位词组合在一起。可以按任意顺序返回结果列表。字母异位词是通过重新排列不同单词或短语的字母而形成的单词或短语，通常只使用所有原始字母一次。';
    groupAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    groupAnagrams.category = ProblemCategory.HASH_TABLE;
    groupAnagrams.choices = [
      { id: 'A', text: '将每个字符串排序后作为哈希表的键', isCorrect: true },
      { id: 'B', text: '计算每个字符串的字符频次作为键', isCorrect: false },
      { id: 'C', text: '使用字符串长度分组', isCorrect: false },
      { id: 'D', text: '逐个比较字符串是否为异位词', isCorrect: false }
    ];
    groupAnagrams.explanation =
      '将每个字符串按字符排序，排序后相同的字符串就是异位词。使用哈希表，键为排序后的字符串，值为原字符串列表。遍历所有字符串，对每个字符串排序后加入对应的组。时间复杂度O(n*k*log k)，其中n是字符串数量，k是字符串平均长度。';
    groupAnagrams.hint = '将字符串排序后作为哈希表的键进行分组';
    problems.push(groupAnagrams);

    // 最长连续序列
    const longestConsecutive = new ProblemModel();
    longestConsecutive.id = 322;
    longestConsecutive.title = '最长连续序列';
    longestConsecutive.description =
      '给定一个未排序的整数数组 nums ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。请你设计并实现时间复杂度为 O(n) 的算法解决此问题。';
    longestConsecutive.difficulty = ProblemDifficulty.MEDIUM;
    longestConsecutive.category = ProblemCategory.HASH_TABLE;
    longestConsecutive.choices = [
      { id: 'A', text: '使用哈希集合，对每个序列起点向右扩展', isCorrect: true },
      { id: 'B', text: '先排序再查找连续序列', isCorrect: false },
      { id: 'C', text: '使用并查集合并连续数字', isCorrect: false },
      { id: 'D', text: '使用动态规划记录最长序列', isCorrect: false }
    ];
    longestConsecutive.explanation =
      '使用哈希集合存储所有数字。对于每个数字，如果它是序列的起点（即num-1不在集合中），就向右扩展计算连续序列长度。这样每个数字最多被访问两次，时间复杂度O(n)，空间复杂度O(n)。关键是识别序列起点，避免重复计算。';
    longestConsecutive.hint = '用哈希集合存储数字，找到序列起点后向右扩展';
    problems.push(longestConsecutive);

    // ========== BACKTRACKING 类型题目 ==========

    // 全排列
    const permutations = new ProblemModel();
    permutations.id = 323;
    permutations.title = '全排列';
    permutations.description = '给定一个不含重复数字的数组 nums ，返回其所有可能的全排列。你可以按任意顺序返回答案。';
    permutations.difficulty = ProblemDifficulty.MEDIUM;
    permutations.category = ProblemCategory.BACKTRACKING;
    permutations.choices = [
      { id: 'A', text: '使用回溯算法，维护已使用元素的标记数组', isCorrect: true },
      { id: 'B', text: '使用递归交换元素位置', isCorrect: false },
      { id: 'C', text: '使用迭代生成所有排列', isCorrect: false },
      { id: 'D', text: '使用数学公式计算排列', isCorrect: false }
    ];
    permutations.explanation =
      '使用回溯算法。维护一个当前排列和一个标记数组记录哪些元素已被使用。递归过程：选择一个未使用的元素加入当前排列，标记为已使用，递归处理剩余位置，回溯时撤销选择。时间复杂度O(n!*n)，空间复杂度O(n)。';
    permutations.hint = '回溯算法：选择→递归→撤销选择';
    problems.push(permutations);

    // 子集
    const subsets = new ProblemModel();
    subsets.id = 324;
    subsets.title = '子集';
    subsets.description =
      '给你一个整数数组 nums ，数组中的元素互不相同。返回该数组所有可能的子集（幂集）。解集不能包含重复的子集。你可以按任意顺序返回解集。';
    subsets.difficulty = ProblemDifficulty.MEDIUM;
    subsets.category = ProblemCategory.BACKTRACKING;
    subsets.choices = [
      { id: 'A', text: '使用回溯算法，每个元素选择包含或不包含', isCorrect: true },
      { id: 'B', text: '使用位运算枚举所有可能', isCorrect: false },
      { id: 'C', text: '使用迭代逐个添加元素', isCorrect: false },
      { id: 'D', text: '使用递归分治', isCorrect: false }
    ];
    subsets.explanation =
      '使用回溯算法。对于每个元素，有两种选择：包含在当前子集中或不包含。递归过程：对于当前位置的元素，先选择包含它，递归处理下一个位置，然后回溯；再选择不包含它，递归处理下一个位置。时间复杂度O(2^n)，空间复杂度O(n)。';
    subsets.hint = '每个元素都有包含和不包含两种选择';
    problems.push(subsets);

    // N皇后
    const nQueens = new ProblemModel();
    nQueens.id = 325;
    nQueens.title = 'N 皇后';
    nQueens.description =
      'n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。给你一个整数 n ，返回所有不同的 n 皇后问题的解决方案。每一种解法包含一个不同的 n 皇后问题的棋盘配置，其中 \'Q\' 和 \'.\' 分别代表了皇后和空位。';
    nQueens.difficulty = ProblemDifficulty.HARD;
    nQueens.category = ProblemCategory.BACKTRACKING;
    nQueens.choices = [
      { id: 'A', text: '使用回溯算法，逐行放置皇后并检查冲突', isCorrect: true },
      { id: 'B', text: '使用动态规划计算可行解', isCorrect: false },
      { id: 'C', text: '使用贪心算法选择最优位置', isCorrect: false },
      { id: 'D', text: '使用数学公式直接计算', isCorrect: false }
    ];
    nQueens.explanation =
      '使用回溯算法逐行放置皇后。对于每一行，尝试在每一列放置皇后，检查是否与之前放置的皇后冲突（同列、同对角线）。如果不冲突，继续下一行；如果冲突或所有列都尝试过，回溯到上一行。可以用集合记录已占用的列和对角线以优化冲突检查。时间复杂度O(n!)。';
    nQueens.hint = '逐行放置皇后，检查列和对角线冲突';
    problems.push(nQueens);

    // ========== GREEDY 类型题目 ==========

    // 买卖股票的最佳时机II
    const maxProfitII = new ProblemModel();
    maxProfitII.id = 326;
    maxProfitII.title = '买卖股票的最佳时机 II';
    maxProfitII.description =
      '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候最多只能持有一股股票。你也可以先购买，然后在同一天出售。返回你能获得的最大利润。';
    maxProfitII.difficulty = ProblemDifficulty.MEDIUM;
    maxProfitII.category = ProblemCategory.GREEDY;
    maxProfitII.choices = [
      { id: 'A', text: '贪心策略：只要第二天价格上涨就交易', isCorrect: true },
      { id: 'B', text: '动态规划记录持有和不持有股票的状态', isCorrect: false },
      { id: 'C', text: '找到所有的波峰和波谷进行交易', isCorrect: false },
      { id: 'D', text: '使用滑动窗口找最大利润区间', isCorrect: false }
    ];
    maxProfitII.explanation =
      '贪心策略：只要明天的价格比今天高，就今天买入明天卖出。这等价于把所有上涨的价格差累加起来。因为可以多次交易，所以每次价格上涨都是获利机会。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfitII.hint = '贪心：累加所有相邻上涨的价格差';
    problems.push(maxProfitII);

    // 跳跃游戏
    const canJump = new ProblemModel();
    canJump.id = 327;
    canJump.title = '跳跃游戏';
    canJump.description =
      '给定一个非负整数数组 nums ，你最初位于数组的第一个下标。数组中的每个元素代表你在该位置可以跳跃的最大长度。判断你是否能够到达最后一个下标。';
    canJump.difficulty = ProblemDifficulty.MEDIUM;
    canJump.category = ProblemCategory.GREEDY;
    canJump.choices = [
      { id: 'A', text: '贪心策略：维护能到达的最远位置', isCorrect: true },
      { id: 'B', text: '使用动态规划记录每个位置是否可达', isCorrect: false },
      { id: 'C', text: '使用BFS搜索所有可能的路径', isCorrect: false },
      { id: 'D', text: '使用回溯算法尝试所有跳跃方案', isCorrect: false }
    ];
    canJump.explanation =
      '贪心策略：维护一个变量记录当前能到达的最远位置。遍历数组，对于每个位置i，如果i在可达范围内，就更新最远可达位置为max(最远位置, i + nums[i])。如果最远位置大于等于最后一个索引，返回true。时间复杂度O(n)，空间复杂度O(1)。';
    canJump.hint = '贪心：维护并更新能到达的最远位置';
    problems.push(canJump);

    // 分发饼干
    const findContentChildren = new ProblemModel();
    findContentChildren.id = 328;
    findContentChildren.title = '分发饼干';
    findContentChildren.description =
      '假设你是一位很棒的家长，想要给你的孩子们一些小饼干。但是，每个孩子最多只能给一块饼干。对每个孩子 i，都有一个胃口值 g[i]，这是能让孩子们满足胃口的饼干的最小尺寸；并且每块饼干 j，都有一个尺寸 s[j] 。如果 s[j] >= g[i]，我们可以将这块饼干 j 分配给孩子 i ，这个孩子会得到满足。你的目标是尽可能满足越多数量的孩子，并输出这个最大数值。';
    findContentChildren.difficulty = ProblemDifficulty.EASY;
    findContentChildren.category = ProblemCategory.GREEDY;
    findContentChildren.choices = [
      { id: 'A', text: '先排序，然后用最小的饼干满足胃口最小的孩子', isCorrect: true },
      { id: 'B', text: '用最大的饼干优先满足胃口最大的孩子', isCorrect: false },
      { id: 'C', text: '使用动态规划计算最优分配方案', isCorrect: false },
      { id: 'D', text: '使用回溯算法尝试所有分配方案', isCorrect: false }
    ];
    findContentChildren.explanation =
      '贪心策略：将孩子的胃口和饼干尺寸都按升序排序，然后用最小的能满足当前孩子的饼干来满足他。这样可以保证剩下的饼干能满足更多的孩子。使用双指针分别指向孩子和饼干数组。时间复杂度O(m log m + n log n)，空间复杂度O(1)。';
    findContentChildren.hint = '排序后用最小的合适饼干满足每个孩子';
    problems.push(findContentChildren);

    // ========== BIT_MANIPULATION 类型题目 ==========

    // 位1的个数
    const hammingWeight = new ProblemModel();
    hammingWeight.id = 329;
    hammingWeight.title = '位1的个数';
    hammingWeight.description =
      '编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 \'1\' 的个数（也被称为汉明重量）。';
    hammingWeight.difficulty = ProblemDifficulty.EASY;
    hammingWeight.category = ProblemCategory.BIT_MANIPULATION;
    hammingWeight.choices = [
      { id: 'A', text: '使用 n & (n-1) 消除最低位的1', isCorrect: true },
      { id: 'B', text: '逐位检查每一位是否为1', isCorrect: false },
      { id: 'C', text: '转换为字符串后统计字符1的个数', isCorrect: false },
      { id: 'D', text: '使用递归分治计算', isCorrect: false }
    ];
    hammingWeight.explanation =
      '最优解法是使用位运算技巧 n & (n-1)，这个操作会消除n的二进制表示中最低位的1。重复这个操作直到n变为0，操作次数就是1的个数。时间复杂度O(k)，其中k是1的个数，空间复杂度O(1)。';
    hammingWeight.hint = '使用 n & (n-1) 可以消除最低位的1';
    problems.push(hammingWeight);

    // 颠倒二进制位
    const reverseBits = new ProblemModel();
    reverseBits.id = 330;
    reverseBits.title = '颠倒二进制位';
    reverseBits.description = '颠倒给定的 32 位无符号整数的二进制位。';
    reverseBits.difficulty = ProblemDifficulty.EASY;
    reverseBits.category = ProblemCategory.BIT_MANIPULATION;
    reverseBits.choices = [
      { id: 'A', text: '逐位取出并左移构建结果', isCorrect: true },
      { id: 'B', text: '转换为字符串后反转再转回数字', isCorrect: false },
      { id: 'C', text: '使用递归分治处理', isCorrect: false },
      { id: 'D', text: '使用位运算的分治算法', isCorrect: false }
    ];
    reverseBits.explanation =
      '逐位处理：从右到左取出原数字的每一位，从左到右构建结果。具体做法：result = (result << 1) | (n & 1)，然后n >>= 1。重复32次。时间复杂度O(1)，空间复杂度O(1)。也可以使用分治的位运算优化。';
    reverseBits.hint = '逐位取出原数字的位，构建反转后的结果';
    problems.push(reverseBits);

    // 只出现一次的数字
    const singleNumber = new ProblemModel();
    singleNumber.id = 331;
    singleNumber.title = '只出现一次的数字';
    singleNumber.description =
      '给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。';
    singleNumber.difficulty = ProblemDifficulty.EASY;
    singleNumber.category = ProblemCategory.BIT_MANIPULATION;
    singleNumber.choices = [
      { id: 'A', text: '使用异或运算，相同数字异或为0', isCorrect: true },
      { id: 'B', text: '使用哈希表统计每个数字的出现次数', isCorrect: false },
      { id: 'C', text: '先排序再查找不成对的数字', isCorrect: false },
      { id: 'D', text: '使用数学方法计算', isCorrect: false }
    ];
    singleNumber.explanation =
      '利用异或运算的性质：a ^ a = 0，a ^ 0 = a。将数组中所有数字进行异或运算，相同的数字会相互抵消变成0，最后剩下的就是只出现一次的数字。时间复杂度O(n)，空间复杂度O(1)。';
    singleNumber.hint = '异或运算：相同数字异或为0，任何数与0异或等于自己';
    problems.push(singleNumber);

    // ========== DESIGN 类型题目 ==========

    // 设计哈希映射
    const designHashMap = new ProblemModel();
    designHashMap.id = 332;
    designHashMap.title = '设计哈希映射';
    designHashMap.description =
      '不使用任何内建的哈希表库设计一个哈希映射（HashMap）。实现 MyHashMap 类：MyHashMap() 用空映射初始化对象；void put(int key, int value) 向 HashMap 插入一个键值对 (key, value)；int get(int key) 返回特定的 key 所映射的 value；void remove(key) 如果映射中存在 key 的映射，则移除 key 和它所对应的 value。';
    designHashMap.difficulty = ProblemDifficulty.EASY;
    designHashMap.category = ProblemCategory.DESIGN;
    designHashMap.choices = [
      { id: 'A', text: '使用数组+链表处理哈希冲突', isCorrect: true },
      { id: 'B', text: '使用单个大数组存储所有键值对', isCorrect: false },
      { id: 'C', text: '使用二叉搜索树存储', isCorrect: false },
      { id: 'D', text: '使用动态数组自动扩容', isCorrect: false }
    ];
    designHashMap.explanation =
      '使用数组+链表的方式实现。选择一个合适的数组大小（如2069），使用简单的取模运算作为哈希函数。每个数组位置存储一个链表，用于处理哈希冲突。链表节点包含key和value。put操作：计算哈希值，在对应链表中查找或插入；get操作：计算哈希值，在链表中查找；remove操作：在链表中删除节点。';
    designHashMap.hint = '数组+链表，用链表处理哈希冲突';
    problems.push(designHashMap);

    // 最小栈
    const minStack = new ProblemModel();
    minStack.id = 333;
    minStack.title = '最小栈';
    minStack.description =
      '设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。实现 MinStack 类：MinStack() 初始化堆栈对象；void push(int val) 将元素val推入堆栈；void pop() 删除堆栈顶部的元素；int top() 获取堆栈顶部的元素；int getMin() 获取堆栈中的最小元素。';
    minStack.difficulty = ProblemDifficulty.EASY;
    minStack.category = ProblemCategory.DESIGN;
    minStack.choices = [
      { id: 'A', text: '使用辅助栈存储每个位置的最小值', isCorrect: true },
      { id: 'B', text: '每次getMin时遍历整个栈', isCorrect: false },
      { id: 'C', text: '使用单个变量记录最小值', isCorrect: false },
      { id: 'D', text: '使用有序数据结构维护最小值', isCorrect: false }
    ];
    minStack.explanation =
      '使用两个栈：数据栈存储实际数据，辅助栈存储每个位置对应的最小值。push时：数据栈正常push，辅助栈push当前最小值；pop时：两个栈同时pop；getMin时：返回辅助栈顶元素。所有操作时间复杂度O(1)，空间复杂度O(n)。';
    minStack.hint = '使用辅助栈存储每个位置的最小值';
    problems.push(minStack);

    // LRU缓存
    const lruCache = new ProblemModel();
    lruCache.id = 334;
    lruCache.title = 'LRU 缓存';
    lruCache.description =
      '请你设计并实现一个满足 LRU (最近最少使用) 缓存约束的数据结构。实现 LRUCache 类：LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存；int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1；void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。';
    lruCache.difficulty = ProblemDifficulty.MEDIUM;
    lruCache.category = ProblemCategory.DESIGN;
    lruCache.choices = [
      { id: 'A', text: '使用哈希表+双向链表实现', isCorrect: true },
      { id: 'B', text: '使用数组记录访问时间戳', isCorrect: false },
      { id: 'C', text: '使用单链表按访问顺序排序', isCorrect: false },
      { id: 'D', text: '使用栈记录访问顺序', isCorrect: false }
    ];
    lruCache.explanation =
      '使用哈希表+双向链表。哈希表提供O(1)的查找，双向链表维护访问顺序。链表头部是最近使用的，尾部是最久未使用的。get操作：在哈希表中查找，如果存在则移动到链表头部；put操作：如果key存在则更新并移到头部，如果不存在则插入头部，容量超限时删除尾部节点。';
    lruCache.hint = '哈希表+双向链表，头部最新，尾部最旧';
    problems.push(lruCache);

    // ========== DIVIDE_CONQUER 类型题目 ==========

    // 归并排序
    const mergeSort = new ProblemModel();
    mergeSort.id = 335;
    mergeSort.title = '归并排序';
    mergeSort.description = '给你一个整数数组 nums，请你将该数组升序排列。要求使用归并排序算法实现。';
    mergeSort.difficulty = ProblemDifficulty.MEDIUM;
    mergeSort.category = ProblemCategory.DIVIDE_CONQUER;
    mergeSort.choices = [
      { id: 'A', text: '递归分割数组，然后合并有序子数组', isCorrect: true },
      { id: 'B', text: '使用快速排序的分区思想', isCorrect: false },
      { id: 'C', text: '使用堆排序的思想', isCorrect: false },
      { id: 'D', text: '使用冒泡排序优化', isCorrect: false }
    ];
    mergeSort.explanation =
      '分治思想：将数组递归分割成两半，直到只有一个元素；然后将有序的子数组合并成更大的有序数组。合并过程使用双指针技术。时间复杂度O(n log n)，空间复杂度O(n)。归并排序是稳定排序，性能稳定。';
    mergeSort.hint = '分治：递归分割，然后合并有序子数组';
    problems.push(mergeSort);

    // 快速排序
    const quickSort = new ProblemModel();
    quickSort.id = 336;
    quickSort.title = '快速排序';
    quickSort.description = '给你一个整数数组 nums，请你将该数组升序排列。要求使用快速排序算法实现。';
    quickSort.difficulty = ProblemDifficulty.MEDIUM;
    quickSort.category = ProblemCategory.DIVIDE_CONQUER;
    quickSort.choices = [
      { id: 'A', text: '选择基准元素，分区后递归排序两部分', isCorrect: true },
      { id: 'B', text: '使用归并排序的合并思想', isCorrect: false },
      { id: 'C', text: '使用选择排序的思想', isCorrect: false },
      { id: 'D', text: '使用插入排序优化', isCorrect: false }
    ];
    quickSort.explanation =
      '分治思想：选择一个基准元素，将数组分区使得左边都小于基准，右边都大于基准；然后递归排序左右两部分。分区是关键操作，可以使用双指针实现。平均时间复杂度O(n log n)，最坏情况O(n²)，空间复杂度O(log n)。';
    quickSort.hint = '选择基准，分区，递归排序左右两部分';
    problems.push(quickSort);

    // 最大子数组和
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 337;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description =
      '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.DIVIDE_CONQUER;
    maxSubArray.choices = [
      { id: 'A', text: '分治：递归求左半、右半、跨中点的最大子数组和', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i] = max(nums[i], dp[i-1] + nums[i])', isCorrect: false },
      { id: 'C', text: '贪心算法：当前和为负时重新开始', isCorrect: false },
      { id: 'D', text: '暴力枚举所有子数组', isCorrect: false }
    ];
    maxSubArray.explanation =
      '分治解法：将数组分成两半，最大子数组和可能在左半部分、右半部分或跨越中点。递归求解左右两部分，跨中点的情况需要分别向左右扩展找最大和。时间复杂度O(n log n)，空间复杂度O(log n)。虽然动态规划更优，但这里考查分治思想。';
    maxSubArray.hint = '分治：考虑左半、右半、跨中点三种情况';
    problems.push(maxSubArray);

    // ========== SLIDING_WINDOW 类型题目 ==========

    // 无重复字符的最长子串
    const lengthOfLongestSubstring = new ProblemModel();
    lengthOfLongestSubstring.id = 338;
    lengthOfLongestSubstring.title = '无重复字符的最长子串';
    lengthOfLongestSubstring.description = '给定一个字符串 s ，请你找出其中不含有重复字符的最长子串的长度。';
    lengthOfLongestSubstring.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLongestSubstring.category = ProblemCategory.SLIDING_WINDOW;
    lengthOfLongestSubstring.choices = [
      { id: 'A', text: '使用滑动窗口和哈希集合', isCorrect: true },
      { id: 'B', text: '使用动态规划记录最长长度', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子串', isCorrect: false },
      { id: 'D', text: '使用双指针和排序', isCorrect: false }
    ];
    lengthOfLongestSubstring.explanation =
      '使用滑动窗口技术。维护一个窗口[left, right]和一个哈希集合记录窗口内的字符。右指针不断扩展，当遇到重复字符时，左指针收缩直到窗口内无重复字符。记录过程中窗口的最大长度。时间复杂度O(n)，空间复杂度O(min(m,n))，其中m是字符集大小。';
    lengthOfLongestSubstring.hint = '滑动窗口：右指针扩展，左指针收缩';
    problems.push(lengthOfLongestSubstring);

    // 最小覆盖子串
    const minWindow = new ProblemModel();
    minWindow.id = 339;
    minWindow.title = '最小覆盖子串';
    minWindow.description =
      '给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.SLIDING_WINDOW;
    minWindow.choices = [
      { id: 'A', text: '使用滑动窗口和哈希表记录字符频次', isCorrect: true },
      { id: 'B', text: '使用回溯算法枚举所有可能', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最小长度', isCorrect: false },
      { id: 'D', text: '使用贪心算法选择最优起点', isCorrect: false }
    ];
    minWindow.explanation =
      '使用滑动窗口。先用哈希表记录t中各字符的频次。右指针扩展窗口直到包含t的所有字符，然后左指针收缩窗口寻找最小覆盖。使用formed变量记录已满足要求的字符种类数。时间复杂度O(|s| + |t|)，空间复杂度O(|s| + |t|)。';
    minWindow.hint = '滑动窗口：右指针扩展到覆盖，左指针收缩到最小';
    problems.push(minWindow);

    // 长度最小的子数组
    const minSubArrayLen = new ProblemModel();
    minSubArrayLen.id = 340;
    minSubArrayLen.title = '长度最小的子数组';
    minSubArrayLen.description =
      '给定一个含有 n 个正整数的数组和一个正整数 target 。找出该数组中满足其和 ≥ target 的长度最小的连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。';
    minSubArrayLen.difficulty = ProblemDifficulty.MEDIUM;
    minSubArrayLen.category = ProblemCategory.SLIDING_WINDOW;
    minSubArrayLen.choices = [
      { id: 'A', text: '使用滑动窗口，维护窗口和大于等于target', isCorrect: true },
      { id: 'B', text: '使用前缀和和二分查找', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最小长度', isCorrect: false },
      { id: 'D', text: '暴力枚举所有子数组', isCorrect: false }
    ];
    minSubArrayLen.explanation =
      '使用滑动窗口。维护窗口[left, right]和窗口内元素的和。右指针扩展直到和大于等于target，记录当前长度，然后左指针收缩直到和小于target。重复这个过程。时间复杂度O(n)，空间复杂度O(1)。';
    minSubArrayLen.hint = '滑动窗口：和>=target时收缩，和<target时扩展';
    problems.push(minSubArrayLen);

    // ========== PREFIX_SUM 类型题目 ==========

    // 区域和检索 - 数组不可变
    const numArray = new ProblemModel();
    numArray.id = 341;
    numArray.title = '区域和检索 - 数组不可变';
    numArray.description =
      '给定一个整数数组 nums，处理以下类型的多个查询：计算索引 left 和 right （包含 left 和 right）之间的 nums 元素的和 ，其中 left <= right 。实现 NumArray 类：NumArray(int[] nums) 使用数组 nums 初始化对象；int sumRange(int left, int right) 返回数组 nums 中索引 left 和 right 之间的元素的总和 ，包含 left 和 right 两点。';
    numArray.difficulty = ProblemDifficulty.EASY;
    numArray.category = ProblemCategory.PREFIX_SUM;
    numArray.choices = [
      { id: 'A', text: '使用前缀和数组，sumRange = prefix[right+1] - prefix[left]', isCorrect: false },
      { id: 'B', text: '每次查询时遍历计算区间和', isCorrect: true },
      { id: 'C', text: '使用线段树维护区间和', isCorrect: false },
      { id: 'D', text: '使用二维数组存储所有可能的区间和', isCorrect: false }
    ];
    numArray.explanation =
      '使用前缀和数组。构造时计算prefix[i] = nums[0] + nums[1] + ... + nums[i-1]。查询sumRange(left, right)时返回prefix[right+1] - prefix[left]。构造时间复杂度O(n)，查询时间复杂度O(1)，空间复杂度O(n)。';
    numArray.hint = '前缀和：prefix[i]表示前i个元素的和';
    problems.push(numArray);

    // 二维区域和检索 - 矩阵不可变
    const numMatrix = new ProblemModel();
    numMatrix.id = 342;
    numMatrix.title = '二维区域和检索 - 矩阵不可变';
    numMatrix.description =
      '给定一个二维矩阵 matrix，以下类型的多个请求：计算其子矩形范围内元素的总和，该子矩阵的左上角为 (row1, col1) ，右下角为 (row2, col2) 。实现 NumMatrix 类：NumMatrix(int[][] matrix) 给定整数矩阵 matrix 进行初始化；int sumRegion(int row1, int col1, int row2, int col2) 返回左上角 (row1, col1) 、右下角 (row2, col2) 所描述的子矩阵的元素总和。';
    numMatrix.difficulty = ProblemDifficulty.MEDIUM;
    numMatrix.category = ProblemCategory.PREFIX_SUM;
    numMatrix.choices = [
      { id: 'A', text: '使用二维前缀和，应用容斥原理计算', isCorrect: false },
      { id: 'B', text: '对每行使用一维前缀和', isCorrect: false },
      { id: 'C', text: '每次查询时遍历子矩阵', isCorrect: true },
      { id: 'D', text: '使用四叉树分割矩阵', isCorrect: false }
    ];
    numMatrix.explanation =
      '使用二维前缀和。prefix[i][j]表示从(0,0)到(i-1,j-1)的矩形和。查询时使用容斥原理：sumRegion = prefix[row2+1][col2+1] - prefix[row1][col2+1] - prefix[row2+1][col1] + prefix[row1][col1]。构造时间复杂度O(mn)，查询时间复杂度O(1)。';
    numMatrix.hint = '二维前缀和+容斥原理';
    problems.push(numMatrix);

    // 和为K的子数组
    const subarraySum = new ProblemModel();
    subarraySum.id = 343;
    subarraySum.title = '和为K的子数组';
    subarraySum.description = '给你一个整数数组 nums 和一个整数 k ，请你统计并返回该数组中和为 k 的连续子数组的个数。';
    subarraySum.difficulty = ProblemDifficulty.MEDIUM;
    subarraySum.category = ProblemCategory.PREFIX_SUM;
    subarraySum.choices = [
      { id: 'A', text: '使用前缀和+哈希表，查找sum-k', isCorrect: false },
      { id: 'B', text: '使用滑动窗口技术', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'D', text: '使用动态规划记录子数组和', isCorrect: true }
    ];
    subarraySum.explanation =
      '使用前缀和+哈希表。遍历数组计算前缀和，对于当前前缀和sum，在哈希表中查找sum-k的出现次数，这就是以当前位置结尾且和为k的子数组个数。然后将当前前缀和加入哈希表。时间复杂度O(n)，空间复杂度O(n)。';
    subarraySum.hint = '前缀和+哈希表：查找sum-k的出现次数';
    problems.push(subarraySum);

    // ========== MONOTONIC_STACK 类型题目 ==========

    // 每日温度
    const dailyTemperatures = new ProblemModel();
    dailyTemperatures.id = 344;
    dailyTemperatures.title = '每日温度';
    dailyTemperatures.description =
      '给定一个整数数组 temperatures ，表示每天的温度，返回一个数组 answer ，其中 answer[i] 是指在第 i 天之后，才会有更高的温度。如果气温在这之后都不会升高，请在该位置用 0 来代替。';
    dailyTemperatures.difficulty = ProblemDifficulty.MEDIUM;
    dailyTemperatures.category = ProblemCategory.MONOTONIC_STACK;
    dailyTemperatures.choices = [
      { id: 'A', text: '使用单调递减栈存储索引', isCorrect: false },
      { id: 'B', text: '对每个位置向后遍历查找', isCorrect: true },
      { id: 'C', text: '使用动态规划记录下一个更大元素', isCorrect: false },
      { id: 'D', text: '使用二分查找在有序数组中查找', isCorrect: false }
    ];
    dailyTemperatures.explanation =
      '使用单调递减栈存储温度的索引。遍历数组，当前温度大于栈顶索引对应的温度时，说明找到了栈顶位置的答案，弹出栈顶并计算天数差。然后将当前索引入栈。栈中始终保持索引对应温度的递减顺序。时间复杂度O(n)，空间复杂度O(n)。';
    dailyTemperatures.hint = '单调递减栈：栈顶是还没找到答案的位置';
    problems.push(dailyTemperatures);

    // 下一个更大元素 I
    const nextGreaterElement = new ProblemModel();
    nextGreaterElement.id = 345;
    nextGreaterElement.title = '下一个更大元素 I';
    nextGreaterElement.description =
      'nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置右边的第一个比 x 大的元素。给你两个没有重复元素的数组 nums1 和 nums2 ，下标从 0 开始计数，其中nums1 是 nums2 的子集。对于每个 0 <= i < nums1.length ，找出满足 nums1[i] == nums2[j] 的下标 j ，并且在 nums2 中确定 nums2[j] 的下一个更大元素。如果不存在下一个更大元素，那么本次查询的答案是 -1 。';
    nextGreaterElement.difficulty = ProblemDifficulty.EASY;
    nextGreaterElement.category = ProblemCategory.MONOTONIC_STACK;
    nextGreaterElement.choices = [
      { id: 'A', text: '使用单调栈预处理nums2，哈希表存储结果', isCorrect: false },
      { id: 'B', text: '对nums1中每个元素在nums2中暴力查找', isCorrect: false },
      { id: 'C', text: '使用双指针技术', isCorrect: true },
      { id: 'D', text: '使用二分查找', isCorrect: false }
    ];
    nextGreaterElement.explanation =
      '先用单调栈处理nums2，找出每个元素的下一个更大元素，存储在哈希表中。然后遍历nums1，在哈希表中查找对应的答案。单调栈维护递减序列，当遇到更大元素时弹出栈中较小的元素并记录答案。时间复杂度O(m+n)，空间复杂度O(n)。';
    nextGreaterElement.hint = '单调栈预处理+哈希表查询';
    problems.push(nextGreaterElement);

    // 柱状图中最大的矩形
    const largestRectangleArea = new ProblemModel();
    largestRectangleArea.id = 346;
    largestRectangleArea.title = '柱状图中最大的矩形';
    largestRectangleArea.description =
      '给定 n 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。求在该柱状图中，能够勾勒出来的矩形的最大面积。';
    largestRectangleArea.difficulty = ProblemDifficulty.HARD;
    largestRectangleArea.category = ProblemCategory.MONOTONIC_STACK;
    largestRectangleArea.choices = [
      { id: 'A', text: '使用单调递增栈，计算每个柱子为高的最大矩形', isCorrect: false },
      { id: 'B', text: '对每个柱子向左右扩展找边界', isCorrect: false },
      { id: 'C', text: '使用分治算法递归求解', isCorrect: false },
      { id: 'D', text: '使用动态规划记录最大面积', isCorrect: false }
    ];
    largestRectangleArea.explanation =
      '使用单调递增栈。栈中存储柱子的索引，保持对应高度递增。当遇到较小高度时，弹出栈顶并计算以栈顶高度为矩形高度的最大面积。矩形宽度是当前位置与新栈顶之间的距离。需要在数组末尾添加0作为哨兵。时间复杂度O(n)，空间复杂度O(n)。';
    largestRectangleArea.hint = '单调递增栈：弹出时计算以栈顶为高的矩形面积';
    problems.push(largestRectangleArea);

    // ========== TRIE 类型题目 ==========

    // 实现 Trie (前缀树)
    const implementTrie = new ProblemModel();
    implementTrie.id = 347;
    implementTrie.title = '实现 Trie (前缀树)';
    implementTrie.description =
      'Trie（发音类似 "try"）或者说前缀树是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。请你实现 Trie 类：Trie() 初始化前缀树对象。void insert(String word) 向前缀树中插入字符串 word 。boolean search(String word) 如果字符串 word 在前缀树中，返回 true；否则，返回 false 。boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。';
    implementTrie.difficulty = ProblemDifficulty.MEDIUM;
    implementTrie.category = ProblemCategory.TRIE;
    implementTrie.choices = [
      { id: 'A', text: '使用TrieNode节点，每个节点包含children数组和isEnd标志', isCorrect: true },
      { id: 'B', text: '使用哈希表存储所有单词', isCorrect: false },
      { id: 'C', text: '使用二叉搜索树存储字符串', isCorrect: false },
      { id: 'D', text: '使用数组存储所有可能的前缀', isCorrect: false }
    ];
    implementTrie.explanation =
      '使用TrieNode节点构建前缀树。每个节点包含一个children数组（大小为26，对应a-z）和一个isEnd布尔值标记是否为单词结尾。插入时沿路径创建节点，搜索时沿路径查找，前缀搜索不需要检查isEnd。时间复杂度：插入O(m)，搜索O(m)，其中m是字符串长度。';
    implementTrie.hint = 'TrieNode：children数组+isEnd标志';
    problems.push(implementTrie);

    // 单词搜索 II
    const findWords = new ProblemModel();
    findWords.id = 348;
    findWords.title = '单词搜索 II';
    findWords.description =
      '给定一个 m x n 二维字符网格 board 和一个单词列表 words，找出所有同时在二维网格和字典中出现的单词。单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中"相邻"单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母在一个单词中不允许被重复使用。';
    findWords.difficulty = ProblemDifficulty.HARD;
    findWords.category = ProblemCategory.TRIE;
    findWords.choices = [
      { id: 'A', text: '构建Trie树存储words，DFS遍历board匹配', isCorrect: true },
      { id: 'B', text: '对每个word在board中进行DFS搜索', isCorrect: false },
      { id: 'C', text: '使用动态规划记录路径', isCorrect: false },
      { id: 'D', text: '使用BFS遍历所有可能路径', isCorrect: false }
    ];
    findWords.explanation =
      '先将words构建成Trie树，然后对board的每个位置进行DFS。DFS过程中同时在Trie树中移动，如果到达某个单词的结尾就加入结果。使用visited数组避免重复访问。为避免重复结果，找到单词后将Trie节点的isEnd设为false。时间复杂度O(m*n*4^l)，其中l是最长单词长度。';
    findWords.hint = 'Trie树+DFS：同时在board和Trie中移动';
    problems.push(findWords);

    // 最长公共前缀
    const longestCommonPrefix = new ProblemModel();
    longestCommonPrefix.id = 349;
    longestCommonPrefix.title = '最长公共前缀';
    longestCommonPrefix.description =
      '编写一个函数来查找字符串数组中的最长公共前缀。如果不存在公共前缀，返回空字符串 ""。';
    longestCommonPrefix.difficulty = ProblemDifficulty.EASY;
    longestCommonPrefix.category = ProblemCategory.TRIE;
    longestCommonPrefix.choices = [
      { id: 'A', text: '构建Trie树，找到所有字符串都经过的最长路径', isCorrect: true },
      { id: 'B', text: '逐个字符比较所有字符串', isCorrect: false },
      { id: 'C', text: '使用二分查找确定前缀长度', isCorrect: false },
      { id: 'D', text: '使用分治算法递归求解', isCorrect: false }
    ];
    longestCommonPrefix.explanation =
      '可以使用Trie树解决。将所有字符串插入Trie，然后从根节点开始，只要当前节点只有一个子节点且不是任何字符串的结尾，就继续向下。当遇到分叉或字符串结尾时停止。也可以直接逐字符比较，时间复杂度O(S)，其中S是所有字符串的字符总数。';
    longestCommonPrefix.hint = 'Trie树：找到分叉点或字符串结尾';
    problems.push(longestCommonPrefix);

    // ========== GRAPH 类型题目 ==========

    // 岛屿数量
    const numIslands = new ProblemModel();
    numIslands.id = 350;
    numIslands.title = '岛屿数量';
    numIslands.description =
      '给你一个由 \'1\'（陆地）和 \'0\'（水）组成的的二维网格，请你计算网格中岛屿的数量。岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。此外，你可以假设该网格的四条边均被水包围。';
    numIslands.difficulty = ProblemDifficulty.MEDIUM;
    numIslands.category = ProblemCategory.GRAPH;
    numIslands.choices = [
      { id: 'A', text: '使用DFS或BFS遍历连通的陆地，标记为已访问', isCorrect: true },
      { id: 'B', text: '使用动态规划计算岛屿数量', isCorrect: false },
      { id: 'C', text: '使用贪心算法选择最大岛屿', isCorrect: false },
      { id: 'D', text: '使用分治算法递归计算', isCorrect: false }
    ];
    numIslands.explanation =
      '使用DFS或BFS遍历。遍历网格，遇到\'1\'时岛屿数量+1，然后用DFS/BFS将所有相邻的\'1\'标记为\'0\'（或使用visited数组）。这样每次遇到\'1\'都代表发现了一个新岛屿。时间复杂度O(mn)，空间复杂度O(mn)（递归栈或队列）。';
    numIslands.hint = 'DFS/BFS：遇到\'1\'时计数并标记整个岛屿';
    problems.push(numIslands);

    // 课程表
    const canFinish = new ProblemModel();
    canFinish.id = 351;
    canFinish.title = '课程表';
    canFinish.description =
      '你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1 。在选修某些课程之前需要一些先修课程。 先修课程按数组 prerequisites 给出，其中 prerequisites[i] = [ai, bi] ，表示如果要学习课程 ai 则 必须 先学习课程 bi 。例如，先修课程对 [0, 1] 表示：想要学习课程 0 ，你需要先完成课程 1 。请你判断是否可能完成所有课程的学习？';
    canFinish.difficulty = ProblemDifficulty.MEDIUM;
    canFinish.category = ProblemCategory.GRAPH;
    canFinish.choices = [
      { id: 'A', text: '使用拓扑排序检测有向图是否有环', isCorrect: true },
      { id: 'B', text: '使用DFS检查是否存在强连通分量', isCorrect: false },
      { id: 'C', text: '使用并查集检测连通性', isCorrect: false },
      { id: 'D', text: '使用动态规划计算最短路径', isCorrect: false }
    ];
    canFinish.explanation =
      '这是检测有向图是否有环的问题。可以使用拓扑排序：统计每个节点的入度，将入度为0的节点加入队列，不断取出节点并减少其邻居的入度，如果最终处理的节点数等于总课程数，说明无环。也可以用DFS检测环：使用三种状态（未访问、访问中、已完成）。时间复杂度O(V+E)。';
    canFinish.hint = '拓扑排序：检测有向图是否有环';
    problems.push(canFinish);

    // 克隆图
    const cloneGraph = new ProblemModel();
    cloneGraph.id = 352;
    cloneGraph.title = '克隆图';
    cloneGraph.description =
      '给你无向连通图中一个节点的引用，请你返回该图的深拷贝（克隆）。图中的每个节点都包含它的值 val（int） 和其邻居的列表（list[Node]）。';
    cloneGraph.difficulty = ProblemDifficulty.MEDIUM;
    cloneGraph.category = ProblemCategory.GRAPH;
    cloneGraph.choices = [
      { id: 'A', text: '使用DFS或BFS遍历，哈希表存储原节点到克隆节点的映射', isCorrect: true },
      { id: 'B', text: '使用拓扑排序复制节点', isCorrect: false },
      { id: 'C', text: '使用并查集构建新图', isCorrect: false },
      { id: 'D', text: '使用最短路径算法遍历', isCorrect: false }
    ];
    cloneGraph.explanation =
      '使用DFS或BFS遍历图，同时用哈希表存储原节点到克隆节点的映射。对于每个节点，先检查是否已经克隆过，如果没有则创建克隆节点。然后递归处理所有邻居节点，将克隆的邻居添加到当前克隆节点的邻居列表中。时间复杂度O(V+E)，空间复杂度O(V)。';
    cloneGraph.hint = 'DFS/BFS+哈希表：存储原节点到克隆节点的映射';
    problems.push(cloneGraph);

    // ========== SORT 类型题目 ==========

    // 合并区间
    const mergeIntervals = new ProblemModel();
    mergeIntervals.id = 353;
    mergeIntervals.title = '合并区间';
    mergeIntervals.description =
      '以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。';
    mergeIntervals.difficulty = ProblemDifficulty.MEDIUM;
    mergeIntervals.category = ProblemCategory.SORT;
    mergeIntervals.choices = [
      { id: 'A', text: '按起始位置排序，然后遍历合并重叠区间', isCorrect: true },
      { id: 'B', text: '使用堆维护区间的优先级', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最优合并方案', isCorrect: false },
      { id: 'D', text: '使用分治算法递归合并', isCorrect: false }
    ];
    mergeIntervals.explanation =
      '先按区间的起始位置排序。然后遍历排序后的区间，如果当前区间的起始位置小于等于结果中最后一个区间的结束位置，说明有重叠，更新最后一个区间的结束位置为两者的最大值；否则直接添加当前区间。时间复杂度O(nlogn)，空间复杂度O(1)。';
    mergeIntervals.hint = '排序+贪心：按起始位置排序后合并';
    problems.push(mergeIntervals);

    // 数组中的第K个最大元素
    const findKthLargest = new ProblemModel();
    findKthLargest.id = 354;
    findKthLargest.title = '数组中的第K个最大元素';
    findKthLargest.description =
      '给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。';
    findKthLargest.difficulty = ProblemDifficulty.MEDIUM;
    findKthLargest.category = ProblemCategory.SORT;
    findKthLargest.choices = [
      { id: 'A', text: '使用快速选择算法，平均O(n)时间复杂度', isCorrect: true },
      { id: 'B', text: '使用归并排序后取第k个元素', isCorrect: false },
      { id: 'C', text: '使用大小为k的最小堆', isCorrect: false },
      { id: 'D', text: '使用计数排序统计元素频次', isCorrect: false }
    ];
    findKthLargest.explanation =
      '使用快速选择算法（QuickSelect）。基于快速排序的分区思想，每次选择一个pivot，将数组分为大于和小于pivot的两部分。如果pivot的位置正好是n-k，则找到答案；如果位置大于n-k，在左半部分继续查找；否则在右半部分查找。平均时间复杂度O(n)，最坏O(n²)。';
    findKthLargest.hint = '快速选择：基于快排分区，不需要完全排序';
    problems.push(findKthLargest);

    // 颜色分类
    const sortColors = new ProblemModel();
    sortColors.id = 355;
    sortColors.title = '颜色分类';
    sortColors.description =
      '给定一个包含红色、白色和蓝色、共 n 个元素的数组 nums ，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。我们使用整数 0、1 和 2 分别表示红色、白色和蓝色。必须在不使用库的sort函数的情况下解决这个问题。';
    sortColors.difficulty = ProblemDifficulty.MEDIUM;
    sortColors.category = ProblemCategory.SORT;
    sortColors.choices = [
      { id: 'A', text: '使用三指针（荷兰国旗问题），一次遍历完成排序', isCorrect: true },
      { id: 'B', text: '使用计数排序，统计每种颜色的数量', isCorrect: false },
      { id: 'C', text: '使用快速排序算法', isCorrect: false },
      { id: 'D', text: '使用冒泡排序交换相邻元素', isCorrect: false }
    ];
    sortColors.explanation =
      '使用三指针解决荷兰国旗问题。left指向0的右边界，right指向2的左边界，current遍历数组。遇到0时与left交换并移动left和current；遇到2时与right交换并移动right，current不动（因为交换来的元素还未处理）；遇到1时current直接前进。时间复杂度O(n)，空间复杂度O(1)。';
    sortColors.hint = '三指针：left(0边界)、current(遍历)、right(2边界)';
    problems.push(sortColors);

    return problems;
  }

  /**
   * 哈希表类题目
   */
  private static getHashTableProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 有效的字母异位词
    const isAnagram = new ProblemModel();
    isAnagram.id = 401;
    isAnagram.title = '有效的字母异位词';
    isAnagram.description = '给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。';
    isAnagram.difficulty = ProblemDifficulty.EASY;
    isAnagram.category = ProblemCategory.HASH_TABLE;
    isAnagram.choices = [
      { id: 'A', text: '使用哈希表统计字符频次', isCorrect: true },
      { id: 'B', text: '先排序再比较', isCorrect: false },
      { id: 'C', text: '逐个字符比较', isCorrect: false },
      { id: 'D', text: '使用双指针', isCorrect: false }
    ];
    isAnagram.explanation =
      '使用哈希表统计两个字符串中每个字符的出现次数，然后比较两个哈希表是否相等。时间复杂度O(n)，空间复杂度O(1)。';
    isAnagram.hint = '统计字符频次，比较是否相同';
    problems.push(isAnagram);

    return problems;
  }

  /**
   * 回溯算法类题目
   */
  private static getBacktrackingProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 全排列
    const permute = new ProblemModel();
    permute.id = 501;
    permute.title = '全排列';
    permute.description = '给定一个不含重复数字的数组 nums ，返回其所有可能的全排列。你可以按任意顺序返回答案。';
    permute.difficulty = ProblemDifficulty.MEDIUM;
    permute.category = ProblemCategory.BACKTRACKING;
    permute.choices = [
      { id: 'A', text: '使用回溯算法递归生成排列', isCorrect: true },
      { id: 'B', text: '使用迭代法生成', isCorrect: false },
      { id: 'C', text: '使用动态规划', isCorrect: false },
      { id: 'D', text: '使用数学公式计算', isCorrect: false }
    ];
    permute.explanation =
      '使用回溯算法。递归地选择下一个位置的数字，当选择完所有数字时记录一个排列，然后回溯继续尝试其他可能。时间复杂度O(n!×n)，空间复杂度O(n)。';
    permute.hint = '回溯算法：选择→递归→撤销选择';
    problems.push(permute);

    return problems;
  }

  /**
   * 贪心算法类题目
   */
  private static getGreedyProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 买卖股票的最佳时机 II
    const maxProfitII = new ProblemModel();
    maxProfitII.id = 601;
    maxProfitII.title = '买卖股票的最佳时机 II';
    maxProfitII.description =
      '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候最多只能持有一股股票。你也可以先购买，然后在同一天出售。';
    maxProfitII.difficulty = ProblemDifficulty.MEDIUM;
    maxProfitII.category = ProblemCategory.GREEDY;
    maxProfitII.choices = [
      { id: 'A', text: '贪心策略：只要第二天价格上涨就买入卖出', isCorrect: true },
      { id: 'B', text: '动态规划记录买入卖出状态', isCorrect: false },
      { id: 'C', text: '暴力枚举所有买卖组合', isCorrect: false },
      { id: 'D', text: '找到全局最低点和最高点', isCorrect: false }
    ];
    maxProfitII.explanation =
      '贪心策略：只要第二天价格比今天高，就在今天买入明天卖出。这样可以捕获所有的价格上涨区间。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfitII.hint = '贪心思想：抓住每次价格上涨的机会';
    problems.push(maxProfitII);

    return problems;
  }

  /**
   * 位运算类题目
   */
  private static getBitManipulationProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 位1的个数
    const hammingWeight = new ProblemModel();
    hammingWeight.id = 701;
    hammingWeight.title = '位1的个数';
    hammingWeight.description =
      '编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 1 的个数。';
    hammingWeight.difficulty = ProblemDifficulty.EASY;
    hammingWeight.category = ProblemCategory.BIT_MANIPULATION;
    hammingWeight.choices = [
      { id: 'A', text: '使用 n & (n-1) 消除最低位的1', isCorrect: true },
      { id: 'B', text: '逐位检查每一位是否为1', isCorrect: false },
      { id: 'C', text: '转换为字符串统计字符', isCorrect: false },
      { id: 'D', text: '使用除法和取模', isCorrect: false }
    ];
    hammingWeight.explanation =
      '使用位运算技巧 n & (n-1) 可以消除 n 的二进制表示中最低位的1。重复此操作直到 n 为0，操作次数就是1的个数。时间复杂度O(logn)，空间复杂度O(1)。';
    hammingWeight.hint = '位运算：n & (n-1) 消除最低位的1';
    problems.push(hammingWeight);

    return problems;
  }

  /**
   * 设计题类题目
   */
  private static getDesignProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // LRU 缓存
    const lruCache = new ProblemModel();
    lruCache.id = 801;
    lruCache.title = 'LRU 缓存';
    lruCache.description = '请你设计并实现一个满足 LRU (最近最少使用) 缓存约束的数据结构。';
    lruCache.difficulty = ProblemDifficulty.MEDIUM;
    lruCache.category = ProblemCategory.DESIGN;
    lruCache.choices = [
      { id: 'A', text: '使用哈希表+双向链表实现', isCorrect: true },
      { id: 'B', text: '使用数组记录访问时间', isCorrect: false },
      { id: 'C', text: '使用栈记录访问顺序', isCorrect: false },
      { id: 'D', text: '使用优先队列维护优先级', isCorrect: false }
    ];
    lruCache.explanation =
      '使用哈希表存储key到节点的映射，双向链表维护访问顺序。get和put操作都需要移动节点到链表头部，删除LRU节点时从链表尾部删除。时间复杂度O(1)。';
    lruCache.hint = '哈希表+双向链表：快速定位+维护顺序';
    problems.push(lruCache);

    return problems;
  }

  /**
   * 分治算法类题目
   */
  private static getDivideConquerProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 归并排序
    const mergeSort = new ProblemModel();
    mergeSort.id = 901;
    mergeSort.title = '归并排序';
    mergeSort.description =
      '给你一个整数数组 nums，请你将该数组升序排列。你必须在不使用任何内建的排序函数的情况下解决这个问题。';
    mergeSort.difficulty = ProblemDifficulty.MEDIUM;
    mergeSort.category = ProblemCategory.DIVIDE_CONQUER;
    mergeSort.choices = [
      { id: 'A', text: '分治思想：分割数组，递归排序，合并结果', isCorrect: true },
      { id: 'B', text: '直接使用双指针排序', isCorrect: false },
      { id: 'C', text: '使用堆排序算法', isCorrect: false },
      { id: 'D', text: '使用计数排序', isCorrect: false }
    ];
    mergeSort.explanation =
      '分治算法：将数组分成两半，递归地对每一半进行排序，然后合并两个有序数组。时间复杂度O(nlogn)，空间复杂度O(n)。';
    mergeSort.hint = '分治：分割→递归→合并';
    problems.push(mergeSort);

    return problems;
  }

  /**
   * 滑动窗口类题目
   */
  private static getSlidingWindowProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 长度最小的子数组
    const minSubArrayLen = new ProblemModel();
    minSubArrayLen.id = 1001;
    minSubArrayLen.title = '长度最小的子数组';
    minSubArrayLen.description =
      '给定一个含有 n 个正整数的数组和一个正整数 target 。找出该数组中满足其和 ≥ target 的长度最小的连续子数组，并返回其长度。';
    minSubArrayLen.difficulty = ProblemDifficulty.MEDIUM;
    minSubArrayLen.category = ProblemCategory.SLIDING_WINDOW;
    minSubArrayLen.choices = [
      { id: 'A', text: '使用滑动窗口，动态调整窗口大小', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '使用二分查找', isCorrect: false },
      { id: 'D', text: '使用动态规划', isCorrect: false }
    ];
    minSubArrayLen.explanation =
      '使用滑动窗口。维护左右指针，右指针不断扩展直到和>=target，然后收缩左指针直到和<target，记录最小长度。时间复杂度O(n)，空间复杂度O(1)。';
    minSubArrayLen.hint = '滑动窗口：扩展右边界，收缩左边界';
    problems.push(minSubArrayLen);

    return problems;
  }

  /**
   * 前缀和类题目
   */
  private static getPrefixSumProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 和为K的子数组
    const subarraySum = new ProblemModel();
    subarraySum.id = 1101;
    subarraySum.title = '和为K的子数组';
    subarraySum.description = '给你一个整数数组 nums 和一个整数 k ，请你统计并返回该数组中和为 k 的连续子数组的个数。';
    subarraySum.difficulty = ProblemDifficulty.MEDIUM;
    subarraySum.category = ProblemCategory.PREFIX_SUM;
    subarraySum.choices = [
      { id: 'A', text: '前缀和+哈希表，记录前缀和出现次数', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '使用滑动窗口', isCorrect: false },
      { id: 'D', text: '使用动态规划', isCorrect: false }
    ];
    subarraySum.explanation =
      '使用前缀和+哈希表。对于每个位置，计算前缀和，然后查找哈希表中是否存在 prefixSum-k，如果存在说明找到了和为k的子数组。时间复杂度O(n)，空间复杂度O(n)。';
    subarraySum.hint = '前缀和：prefixSum[i] - prefixSum[j] = k';
    problems.push(subarraySum);

    // 区域和检索 - 数组不可变
    const rangeSum = new ProblemModel();
    rangeSum.id = 1102;
    rangeSum.title = '区域和检索 - 数组不可变';
    rangeSum.description =
      '给定一个整数数组 nums，处理以下类型的多个查询: 计算索引 left 和 right （包含left 和 right）之间的 nums 元素的和，其中 left <= right。';
    rangeSum.difficulty = ProblemDifficulty.EASY;
    rangeSum.category = ProblemCategory.PREFIX_SUM;
    rangeSum.choices = [
      { id: 'A', text: '预处理计算前缀和数组，查询时O(1)返回', isCorrect: true },
      { id: 'B', text: '每次查询时遍历指定区间', isCorrect: false },
      { id: 'C', text: '使用线段树数据结构', isCorrect: false },
      { id: 'D', text: '使用堆数据结构', isCorrect: false }
    ];
    rangeSum.explanation =
      '预处理计算前缀和数组 prefixSum，其中prefixSum[i] = nums[0] + nums[1] + ... + nums[i-1]。查询[left, right]区间和时，直接返回prefixSum[right+1] - prefixSum[left]。';
    rangeSum.hint = '前缀和：预处理+O(1)查询';
    problems.push(rangeSum);

    // 二维区域和检索
    const rangeSum2D = new ProblemModel();
    rangeSum2D.id = 1103;
    rangeSum2D.title = '二维区域和检索 - 矩阵不可变';
    rangeSum2D.description =
      '给定一个二维矩阵 matrix，以下类型的多个请求：计算其子矩形范围内元素的总和，该子矩形的左上角为 (row1, col1) ，右下角为 (row2, col2) 。';
    rangeSum2D.difficulty = ProblemDifficulty.MEDIUM;
    rangeSum2D.category = ProblemCategory.PREFIX_SUM;
    rangeSum2D.choices = [
      { id: 'A', text: '构建二维前缀和数组，使用容斥原理', isCorrect: true },
      { id: 'B', text: '对每个查询遍历子矩形', isCorrect: false },
      { id: 'C', text: '按行计算一维前缀和', isCorrect: false },
      { id: 'D', text: '使用分治算法', isCorrect: false }
    ];
    rangeSum2D.explanation =
      '构建二维前缀和数组，prefixSum[i][j]表示从(0,0)到(i-1,j-1)的矩形和。查询时使用容斥原理：结果 = 总和 - 左边 - 上边 + 左上角。';
    rangeSum2D.hint = '二维前缀和：容斥原理计算';
    problems.push(rangeSum2D);

    return problems;
  }

  /**
   * 单调栈类题目
   */
  private static getMonotonicStackProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 每日温度
    const dailyTemperatures = new ProblemModel();
    dailyTemperatures.id = 1201;
    dailyTemperatures.title = '每日温度';
    dailyTemperatures.description =
      '给定一个整数数组 temperatures ，表示每天的温度，返回一个数组 answer ，其中 answer[i] 是指在第 i 天之后，才会有更高的温度。如果气温在这之后都不会升高，请在该位置用 0 来代替。';
    dailyTemperatures.difficulty = ProblemDifficulty.MEDIUM;
    dailyTemperatures.category = ProblemCategory.MONOTONIC_STACK;
    dailyTemperatures.choices = [
      { id: 'A', text: '使用单调递减栈，存储温度的索引', isCorrect: true },
      { id: 'B', text: '暴力方法，对每个位置向后查找', isCorrect: false },
      { id: 'C', text: '使用队列处理', isCorrect: false },
      { id: 'D', text: '使用二分查找', isCorrect: false }
    ];
    dailyTemperatures.explanation =
      '使用单调递减栈存储温度的索引。遍历数组，如果当前温度大于栈顶索引对应的温度，说明找到了更高温度，计算天数差并弹出栈顶。时间复杂度O(n)，空间复杂度O(n)。';
    dailyTemperatures.hint = '单调栈：维护递减序列，快速找到下一个更大元素';
    problems.push(dailyTemperatures);

    // 下一个更大元素 I
    const nextGreater = new ProblemModel();
    nextGreater.id = 1202;
    nextGreater.title = '下一个更大元素 I';
    nextGreater.description =
      'nums1 中数字 x 的 下一个更大元素 是指 x 在 nums2 中对应位置 右侧 的 第一个 比 x 大的元素。给你两个 没有重复元素 的数组 nums1 和 nums2，下标从 0 开始计数，其中 nums1 是 nums2 的子集。';
    nextGreater.difficulty = ProblemDifficulty.EASY;
    nextGreater.category = ProblemCategory.MONOTONIC_STACK;
    nextGreater.choices = [
      { id: 'A', text: '使用单调栈+哈希表，预处理nums2', isCorrect: true },
      { id: 'B', text: '对nums1每个元素在nums2中查找', isCorrect: false },
      { id: 'C', text: '排序后使用二分查找', isCorrect: false },
      { id: 'D', text: '使用双指针技巧', isCorrect: false }
    ];
    nextGreater.explanation =
      '先用单调栈处理nums2，为每个元素找到下一个更大元素，结果存在哈希表中。然后对nums1中每个元素查询哈希表获取结果。';
    nextGreater.hint = '单调栈+哈希表：预处理+查询';
    problems.push(nextGreater);

    // 柱状图中最大的矩形
    const largestRectangle = new ProblemModel();
    largestRectangle.id = 1203;
    largestRectangle.title = '柱状图中最大的矩形';
    largestRectangle.description =
      '给定 n 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子的宽度为 1 。求在该柱状图中，能够勾勒出来的矩形的最大面积。';
    largestRectangle.difficulty = ProblemDifficulty.HARD;
    largestRectangle.category = ProblemCategory.MONOTONIC_STACK;
    largestRectangle.choices = [
      { id: 'A', text: '使用单调递增栈，计算每个柱子的最大面积', isCorrect: true },
      { id: 'B', text: '暑力枚举所有可能的矩形', isCorrect: false },
      { id: 'C', text: '使用分治算法', isCorrect: false },
      { id: 'D', text: '使用动态规划', isCorrect: false }
    ];
    largestRectangle.explanation =
      '使用单调递增栈。对每个柱子，找到它左边和右边第一个比它低的柱子，计算以它为高的矩形面积。维护递增栈能高效找到边界。';
    largestRectangle.hint = '单调递增栈：找每个柱子的左右边界';
    problems.push(largestRectangle);

    return problems;
  }

  /**
   * 字典树类题目
   */
  private static getTrieProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 实现 Trie (前缀树)
    const trie = new ProblemModel();
    trie.id = 1301;
    trie.title = '实现 Trie (前缀树)';
    trie.description =
      'Trie（发音类似 "try"）或者说前缀树是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。';
    trie.difficulty = ProblemDifficulty.MEDIUM;
    trie.category = ProblemCategory.TRIE;
    trie.choices = [
      { id: 'A', text: '使用树节点，每个节点包含26个子节点指针', isCorrect: true },
      { id: 'B', text: '使用哈希表存储所有字符串', isCorrect: false },
      { id: 'C', text: '使用数组存储字符串', isCorrect: false },
      { id: 'D', text: '使用链表连接字符', isCorrect: false }
    ];
    trie.explanation =
      '字典树的每个节点包含26个子节点指针（对应a-z）和一个布尔值标记是否为单词结尾。插入时沿路径创建节点，搜索时沿路径查找。时间复杂度O(m)，m为字符串长度。';
    trie.hint = '树节点：26个子指针 + 结束标记';
    problems.push(trie);

    // 单词搜索 II
    const wordSearch2 = new ProblemModel();
    wordSearch2.id = 1302;
    wordSearch2.title = '单词搜索 II';
    wordSearch2.description =
      '给定一个 m x n 二维字符网格 board 和一个单词（字符串）列表 words，找出所有同时在二维网格和字典中出现的单词。';
    wordSearch2.difficulty = ProblemDifficulty.HARD;
    wordSearch2.category = ProblemCategory.TRIE;
    wordSearch2.choices = [
      { id: 'A', text: '构建字典树，然后在网格中DFS搜索', isCorrect: true },
      { id: 'B', text: '对每个单词在网格中单独搜索', isCorrect: false },
      { id: 'C', text: '使用动态规划', isCorrect: false },
      { id: 'D', text: '使用BFS广度优先搜索', isCorrect: false }
    ];
    wordSearch2.explanation =
      '先将所有单词插入字典树，然后从网格每个位置开始DFS，沿着字典树路径搜索。利用字典树的前缀特性，可以有效剪枝，避免重复搜索。';
    wordSearch2.hint = '字典树+DFS：构建Trie后在网格中搜索';
    problems.push(wordSearch2);

    // 添加与删除单词 - 数据结构设计
    const wordDictionary = new ProblemModel();
    wordDictionary.id = 1303;
    wordDictionary.title = '添加与删除单词 - 数据结构设计';
    wordDictionary.description =
      '请你设计一个数据结构，支持添加新单词和查找字符串是否与任何先前添加的字符串匹配。查找可以包含文字字符或正则表达式字符"."。';
    wordDictionary.difficulty = ProblemDifficulty.MEDIUM;
    wordDictionary.category = ProblemCategory.TRIE;
    wordDictionary.choices = [
      { id: 'A', text: '使用字典树，"."字符时递归所有子节点', isCorrect: true },
      { id: 'B', text: '使用哈希集合存储所有单词', isCorrect: false },
      { id: 'C', text: '使用正则表达式匹配', isCorrect: false },
      { id: 'D', text: '使用数组存储所有可能的组合', isCorrect: false }
    ];
    wordDictionary.explanation =
      '使用字典树结构。遇到普通字符时正常匹配，遇到"."字符时需要递归搜索当前节点的所有非空子节点。';
    wordDictionary.hint = '字典树+递归："."时搜索所有子节点';
    problems.push(wordDictionary);

    // 单词替换
    const replaceWords = new ProblemModel();
    replaceWords.id = 1304;
    replaceWords.title = '单词替换';
    replaceWords.description =
      '在英语中，我们有一个叫做词根的概念，可以词根后面添加其他一些词组成另一个较长的单词——我们称这个单词为继承词。给定一个由许多词根组成的词典和一个用空格分隔单词组成的句子。你需要将句子中的所有继承词用词根替换掉。';
    replaceWords.difficulty = ProblemDifficulty.MEDIUM;
    replaceWords.category = ProblemCategory.TRIE;
    replaceWords.choices = [
      { id: 'A', text: '构建词根字典树，查找每个单词的最短前缀', isCorrect: true },
      { id: 'B', text: '对每个单词遍历所有词根进行匹配', isCorrect: false },
      { id: 'C', text: '使用字符串匹配算法', isCorrect: false },
      { id: 'D', text: '使用正则表达式替换', isCorrect: false }
    ];
    replaceWords.explanation =
      '将所有词根插入字典树，对句子中每个单词在字典树中查找，找到第一个完整词根就替换。字典树可以高效地进行前缀匹配。';
    replaceWords.hint = '字典树：查找最短词根前缀';
    problems.push(replaceWords);

    // 最大异或对
    const maxXor = new ProblemModel();
    maxXor.id = 1305;
    maxXor.title = '数组中两个数的最大异或值';
    maxXor.description = '给你一个整数数组 nums ，返回 nums[i] XOR nums[j] 的最大运算结果，其中 0 ≤ i ≤ j < n 。';
    maxXor.difficulty = ProblemDifficulty.MEDIUM;
    maxXor.category = ProblemCategory.TRIE;
    maxXor.choices = [
      { id: 'A', text: '使用二进制字典树，贪心选择异或位', isCorrect: true },
      { id: 'B', text: '双重循环遍历所有数对', isCorrect: false },
      { id: 'C', text: '使用位运算性质直接计算', isCorrect: false },
      { id: 'D', text: '排序后使用双指针', isCorrect: false }
    ];
    maxXor.explanation =
      '构建二进制字典树（每个节点有0和1两个子节点）。对每个数字，在字典树中贪心地选择能产生最大异或值的路径，即尽量选择与当前位不同的分支。';
    maxXor.hint = '二进制字典树：贪心选择异或位';
    problems.push(maxXor);

    // 自动补全系统
    const autoComplete = new ProblemModel();
    autoComplete.id = 1306;
    autoComplete.title = '搜索推荐系统';
    autoComplete.description =
      '给你一个产品数组 products 和一个字符串 searchWord ，products 数组中每个产品都是一个字符串。请你设计一个推荐系统，在依次输入单词 searchWord 的每一个字母后，推荐最多三个长度相同或更长的产品。';
    autoComplete.difficulty = ProblemDifficulty.MEDIUM;
    autoComplete.category = ProblemCategory.TRIE;
    autoComplete.choices = [
      { id: 'A', text: '构建字典树，每个节点存储前缀对应的产品列表', isCorrect: true },
      { id: 'B', text: '对每个前缀遍历所有产品进行匹配', isCorrect: false },
      { id: 'C', text: '使用二分查找', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有前缀', isCorrect: false }
    ];
    autoComplete.explanation =
      '构建字典树，在插入产品时，沿路径的每个节点都保存以该前缀开头的产品列表（最多3个）。查询时直接返回对应节点的产品列表。';
    autoComplete.hint = '字典树：节点保存前缀产品列表';
    problems.push(autoComplete);

    // 单词频率
    const wordFrequency = new ProblemModel();
    wordFrequency.id = 1307;
    wordFrequency.title = '实现一个魔法字典';
    wordFrequency.description =
      '设计一个使用单词列表进行初始化的数据结构，单词列表中的单词互不相同。如果给出一个单词，请判定能否只将这个单词中一个字母换成另一个字母，使得所形成的新单词存在于你构建的字典中。';
    wordFrequency.difficulty = ProblemDifficulty.MEDIUM;
    wordFrequency.category = ProblemCategory.TRIE;
    wordFrequency.choices = [
      { id: 'A', text: '使用字典树，搜索时允许一次字符不匹配', isCorrect: true },
      { id: 'B', text: '生成所有可能的单字符替换组合', isCorrect: false },
      { id: 'C', text: '使用编辑距离算法', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有单词', isCorrect: false }
    ];
    wordFrequency.explanation =
      '构建字典树存储所有单词。搜索时，使用DFS遍历字典树，允许最多一次字符不匹配。需要确保恰好有一次不匹配。';
    wordFrequency.hint = '字典树+DFS：允许一次字符不匹配';
    problems.push(wordFrequency);

    // 短编码
    const shortEncoding = new ProblemModel();
    shortEncoding.id = 1308;
    shortEncoding.title = '单词的压缩编码';
    shortEncoding.description =
      '单词数组 words 的有效编码由任意助记字符串 s 和下标数组 indices 组成，且满足：words[i] = s[indices[i]...indices[i]+words[i].length-1]';
    shortEncoding.difficulty = ProblemDifficulty.MEDIUM;
    shortEncoding.category = ProblemCategory.TRIE;
    shortEncoding.choices = [
      { id: 'A', text: '构建后缀字典树，移除被包含的单词', isCorrect: true },
      { id: 'B', text: '排序后查找包含关系', isCorrect: false },
      { id: 'C', text: '使用字符串匹配', isCorrect: false },
      { id: 'D', text: '使用动态规划', isCorrect: false }
    ];
    shortEncoding.explanation =
      '将所有单词反转后插入字典树（后缀树）。如果一个单词是另一个单词的后缀，则可以被压缩。最终统计所有叶子节点对应的单词长度。';
    shortEncoding.hint = '后缀字典树：反转单词后构建Trie';
    problems.push(shortEncoding);

    // 最长公共前缀
    const longestPrefix = new ProblemModel();
    longestPrefix.id = 1309;
    longestPrefix.title = '键值映射';
    longestPrefix.description =
      '实现一个 MapSum 类，支持两个方法，insert 和 sum：MapSum() 初始化 MapSum 对象；void insert(String key, int val) 插入 key-val 键值对，字符串表示键 key ，整数表示值 val；int sum(string prefix) 返回所有以该前缀 prefix 开头的键 key 的值的总和。';
    longestPrefix.difficulty = ProblemDifficulty.MEDIUM;
    longestPrefix.category = ProblemCategory.TRIE;
    longestPrefix.choices = [
      { id: 'A', text: '使用字典树，每个节点存储经过该节点的所有值的和', isCorrect: true },
      { id: 'B', text: '使用哈希表存储所有前缀的和', isCorrect: false },
      { id: 'C', text: '每次查询时遍历所有键值对', isCorrect: false },
      { id: 'D', text: '使用平衡二叉搜索树', isCorrect: false }
    ];
    longestPrefix.explanation =
      '构建字典树，每个节点维护一个总和值。插入时沿路径更新每个节点的总和，查询时找到前缀对应的节点并返回其总和值。';
    longestPrefix.hint = '字典树：节点维护路径总和';
    problems.push(longestPrefix);

    // 连接词
    const concatenated = new ProblemModel();
    concatenated.id = 1310;
    concatenated.title = '连接词';
    concatenated.description =
      '给你一个不含重复单词的字符串数组 words ，请你找出并返回 words 中的所有连接词。连接词定义为：一个完全由数组中的至少两个较短单词组成的字符串。';
    concatenated.difficulty = ProblemDifficulty.HARD;
    concatenated.category = ProblemCategory.TRIE;
    concatenated.choices = [
      { id: 'A', text: '构建字典树，对每个单词进行DFS分解验证', isCorrect: true },
      { id: 'B', text: '使用动态规划判断单词可分解性', isCorrect: false },
      { id: 'C', text: '排序后逐个验证包含关系', isCorrect: false },
      { id: 'D', text: '使用回溯算法生成所有组合', isCorrect: false }
    ];
    concatenated.explanation =
      '先将所有单词插入字典树，然后对每个单词进行DFS分解，检查是否可以完全由其他较短单词组成。使用字典树可以高效地验证前缀匹配。';
    concatenated.hint = '字典树+DFS：验证单词可分解性';
    problems.push(concatenated);

    return problems;
  }

  /**
   * 图类题目
   */
  private static getGraphProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 岛屿数量
    const numIslands = new ProblemModel();
    numIslands.id = 1401;
    numIslands.title = '岛屿数量';
    numIslands.description =
      '给你一个由 "1"（陆地）和 "0"（水）组成的的二维网格，请你计算网格中岛屿的数量。岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。';
    numIslands.difficulty = ProblemDifficulty.MEDIUM;
    numIslands.category = ProblemCategory.GRAPH;
    numIslands.choices = [
      { id: 'A', text: '使用DFS或BFS遍历连通的陆地', isCorrect: true },
      { id: 'B', text: '使用动态规划计算', isCorrect: false },
      { id: 'C', text: '使用并查集', isCorrect: false },
      { id: 'D', text: '逐行逐列统计', isCorrect: false }
    ];
    numIslands.explanation =
      '使用DFS或BFS。遍历网格，遇到陆地时开始DFS/BFS，将连通的所有陆地标记为已访问，岛屿数量加1。时间复杂度O(mn)，空间复杂度O(mn)。';
    numIslands.hint = 'DFS/BFS：遍历连通分量';
    problems.push(numIslands);

    // 课程表
    const canFinish = new ProblemModel();
    canFinish.id = 1402;
    canFinish.title = '课程表';
    canFinish.description =
      '你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1 。在选修某些课程之前需要一些先修课程。 先修课程和课程之间的关系是：[0, 1] 表示如果要学习课程 0 ，你需要先完成课程 1 。请你判断是否可能完成所有课程的学习？';
    canFinish.difficulty = ProblemDifficulty.MEDIUM;
    canFinish.category = ProblemCategory.GRAPH;
    canFinish.choices = [
      { id: 'A', text: '拓扑排序：检测有向图中是否有环', isCorrect: true },
      { id: 'B', text: '使用并查集检测环', isCorrect: false },
      { id: 'C', text: '深度优先搜索所有路径', isCorrect: false },
      { id: 'D', text: '使用动态规划', isCorrect: false }
    ];
    canFinish.explanation =
      '这是一个拓扑排序问题。构建有向图，然后检测是否有环。可以使用Kahn算法（BFS+入度）或DFS+颜色标记。如果能完成拓扑排序，说明无环。';
    canFinish.hint = '拓扑排序：检测有向图环';
    problems.push(canFinish);

    // 克隆图
    const cloneGraph = new ProblemModel();
    cloneGraph.id = 1403;
    cloneGraph.title = '克隆图';
    cloneGraph.description = '给你无向 连通 图中一个节点的引用，请你返回该图的 深拷贝（克隆）。';
    cloneGraph.difficulty = ProblemDifficulty.MEDIUM;
    cloneGraph.category = ProblemCategory.GRAPH;
    cloneGraph.choices = [
      { id: 'A', text: '使用DFS/BFS+哈希表记录已访问节点', isCorrect: true },
      { id: 'B', text: '递归遍历所有节点', isCorrect: false },
      { id: 'C', text: '先统计节点数量再构建', isCorrect: false },
      { id: 'D', text: '使用数组记录邻接关系', isCorrect: false }
    ];
    cloneGraph.explanation =
      '使用DFS或BFS遍历原图，同时使用哈希表建立原节点和新节点的映射关系。遍历时创建新节点并建立邻接关系。';
    cloneGraph.hint = 'DFS/BFS+哈希表：记录节点映射';
    problems.push(cloneGraph);

    return problems;
  }

  /**
   * 排序类题目
   */
  private static getSortProblems(): ProblemModel[] {
    const problems: ProblemModel[] = [];

    // 1506. 有序数组的平方（LeetCode 977）
    const sortedSquares = new ProblemModel();
    sortedSquares.id = 1506;
    sortedSquares.title = '有序数组的平方';
    sortedSquares.description =
      '给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。';
    sortedSquares.difficulty = ProblemDifficulty.EASY;
    sortedSquares.category = ProblemCategory.ARRAY;
    sortedSquares.choices = [
      { id: 'A', text: '使用双指针从数组两端向中间移动，比较平方后的值并逆序填充结果数组', isCorrect: true },
      { id: 'B', text: '先计算所有元素的平方，再用排序算法（如快排）对结果排序', isCorrect: false },
      { id: 'C', text: '用二分查找找到负数与正数的分界点，再合并两个有序子数组', isCorrect: false },
      { id: 'D', text: '使用单调栈存储平方值，最后弹出并反转得到有序数组', isCorrect: false }
    ];
    sortedSquares.explanation =
      '双指针最优解：原数组非递减，平方后最大的值一定在数组两端（因为负数平方可能大于正数）。定义左指针（left=0）、右指针（right=nums.length-1），结果数组（res）长度与原数组一致，从后向前填充。每次比较nums[left]²与nums[right]²，将较大值放入res的当前位置，对应指针向中间移动。时间复杂度O(n)，空间复杂度O(n)（结果数组必用），优于「平方+排序」的O(n log n)。';
    sortedSquares.hint = '原数组的有序性决定了「平方后的最大值在两端」，逆向填充结果数组是关键';
    problems.push(sortedSquares);

    // 1508. 螺旋矩阵（LeetCode 54）
    const spiralOrder = new ProblemModel();
    spiralOrder.id = 1508;
    spiralOrder.title = '螺旋矩阵';
    spiralOrder.description = '给你一个 m 行 n 列的矩阵 matrix ，请按照 顺时针螺旋顺序 ，返回矩阵中的所有元素。';
    spiralOrder.difficulty = ProblemDifficulty.MEDIUM;
    spiralOrder.category = ProblemCategory.ARRAY;
    spiralOrder.choices = [
      { id: 'A', text: '定义上下左右四个边界，按「右→下→左→上」的顺序遍历，遍历后收缩对应边界', isCorrect: true },
      { id: 'B', text: '使用递归，每次遍历矩阵的外层，再递归处理内层矩阵', isCorrect: false },
      { id: 'C', text: '将矩阵转置后反转每行，重复操作直到所有元素遍历完毕', isCorrect: false },
      { id: 'D', text: '使用方向数组（右、下、左、上），遇到边界或已遍历元素时切换方向', isCorrect: false }
    ];
    spiralOrder.explanation =
      '边界收缩解法最直观：初始化上边界（top=0）、下边界（bottom=m-1）、左边界（left=0）、右边界（right=n-1），结果数组（res）。①从左到右遍历上边界行，加入res后top++；②从上到下遍历右边界列，加入res后right--；③若top≤bottom，从右到左遍历下边界行，加入res后bottom--；④若left≤right，从下到上遍历左边界列，加入res后left++。重复①-④直到top>bottom或left>right。时间复杂度O(mn)（遍历所有元素），空间复杂度O(1)（除结果数组外）。';
    spiralOrder.hint = '通过收缩边界控制遍历范围，避免重复遍历或越界';
    problems.push(spiralOrder);

    // 1509. 反转字符串（LeetCode 344）
    const reverseString = new ProblemModel();
    reverseString.id = 1509;
    reverseString.title = '反转字符串';
    reverseString.description =
      '编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。\n\n不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。';
    reverseString.difficulty = ProblemDifficulty.EASY;
    reverseString.category = ProblemCategory.STRING;
    reverseString.choices = [
      { id: 'A', text: '使用双指针，左指针从数组头部、右指针从尾部向中间移动，交换两指针位置的字符', isCorrect: true },
      { id: 'B', text: '使用数组的reverse()方法直接反转（非原地实现场景下）', isCorrect: false },
      { id: 'C', text: '将字符数组转为字符串，再通过切片（如s[::-1]）反转后转回数组', isCorrect: false },
      { id: 'D', text: '使用栈存储字符，再弹出到原数组实现反转', isCorrect: false }
    ];
    reverseString.explanation =
      '双指针原地解法：左指针（left=0）、右指针（right=s.length-1）。当left < right时，交换s[left]和s[right]，然后left++、right--。遍历结束后数组即完成反转。时间复杂度O(n)（遍历数组一半元素），空间复杂度O(1)，完全满足原地修改要求，且效率高于栈或切片方法。';
    reverseString.hint = '双指针的核心是「对称位置交换」，无需额外空间';
    problems.push(reverseString);


    // 1511. 字符串中的第一个唯一字符（LeetCode 387）
    const firstUniqChar = new ProblemModel();
    firstUniqChar.id = 1511;
    firstUniqChar.title = '字符串中的第一个唯一字符';
    firstUniqChar.description = '给定一个字符串 s ，找到 它的第一个不重复的字符，并返回它的索引 。如果不存在，则返回 -1 。';
    firstUniqChar.difficulty = ProblemDifficulty.EASY;
    firstUniqChar.category = ProblemCategory.HASH_TABLE;
    firstUniqChar.choices = [
      { id: 'A', text: '用哈希表统计每个字符的出现次数，再遍历字符串找到第一个次数为1的字符', isCorrect: true },
      { id: 'B', text: '遍历每个字符，用indexOf()和lastIndexOf()判断是否唯一', isCorrect: false },
      { id: 'C', text: '使用数组（针对26个小写字母）统计次数，再遍历字符串找目标字符', isCorrect: false },
      { id: 'D', text: '用排序算法将字符串排序，再遍历查找唯一字符', isCorrect: false }
    ];
    firstUniqChar.explanation =
      '哈希表解法：①遍历字符串s，用哈希表（如Map）记录每个字符的出现次数；②再次遍历s，对每个字符查询哈希表中的次数，第一个次数为1的字符索引即为答案；若遍历结束未找到则返回-1。时间复杂度O(n)（两次遍历字符串），空间复杂度O(k)（k为字符集大小，如小写字母为26）。数组统计是哈希表的特例（适用于固定字符集），但哈希表通用性更强。';
    firstUniqChar.hint = '哈希表的核心是「快速统计字符频率」，两次遍历即可定位第一个唯一字符';
    problems.push(firstUniqChar);

    // 1512. 验证回文串（LeetCode 125）
    const isPalindrome = new ProblemModel();
    isPalindrome.id = 1512;
    isPalindrome.title = '验证回文串';
    isPalindrome.description =
      '如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样，则可以认为该短语是一个 回文串 。\n\n字母和数字都属于字母数字字符。给你一个字符串 s，如果它是 回文串 ，返回 true ；否则，返回 false 。';
    isPalindrome.difficulty = ProblemDifficulty.EASY;
    isPalindrome.category = ProblemCategory.TWO_POINTERS;
    isPalindrome.choices = [
      { id: 'A', text: '使用双指针从两端向中间移动，跳过非字母数字字符，比较大小写转换后的字符', isCorrect: true },
      { id: 'B', text: '先过滤非字母数字字符并转小写，再反转字符串比较是否相等', isCorrect: false },
      { id: 'C', text: '使用栈存储有效字符，再弹出与原有效字符序列比较', isCorrect: false },
      { id: 'D', text: '用正则表达式匹配所有有效字符，再递归比较首尾字符', isCorrect: false }
    ];
    isPalindrome.explanation =
      '双指针原地解法：①初始化左指针（left=0）、右指针（right=s.length-1）；②循环当left < right时：若s[left]非字母数字则left++，若s[right]非字母数字则right--；否则将两者转小写后比较，若不相等则返回false，若相等则left++、right--；③循环结束返回true。时间复杂度O(n)，空间复杂度O(1)，无需额外存储过滤后的字符串，效率更高。';
    isPalindrome.hint = '双指针的关键是「跳过无效字符」，避免提前处理整个字符串';
    problems.push(isPalindrome);

    // 1513. 实现 strStr()（LeetCode 28）
    const strStr = new ProblemModel();
    strStr.id = 1513;
    strStr.title = '实现 strStr()';
    strStr.description =
      '实现 strStr() 函数。给你两个字符串 haystack 和 needle ，请你在 haystack 字符串中找出 needle 字符串出现的第一个位置（下标从 0 开始）。如果不存在，则返回  -1 。\n\n说明：当 needle 是空字符串时，我们应当返回 0 。';
    strStr.difficulty = ProblemDifficulty.EASY;
    strStr.category = ProblemCategory.STRING;
    strStr.choices = [
      { id: 'A', text: '使用KMP算法，通过预处理needle生成前缀表，减少匹配过程中的回溯', isCorrect: true },
      { id: 'B', text: '暴力匹配：遍历haystack每个位置，检查以该位置为起点是否匹配needle', isCorrect: false },
      { id: 'C', text: '使用滑动窗口，窗口大小为needle长度，逐个比较窗口内字符串与needle', isCorrect: false },
      { id: 'D', text: '将haystack和needle转为字符数组，用哈希表存储needle的字符位置再匹配', isCorrect: false }
    ];
    strStr.explanation =
      'KMP算法是最优解（避免暴力法的O(mn)时间）：①预处理needle生成前缀表（next数组），记录每个位置的最长相等前后缀长度；②用i遍历haystack、j遍历needle：若haystack[i] == needle[j]则i++、j++；若j == needle.length则返回i-j（匹配成功）；若不相等且j>0则j=next[j-1]（回溯j到前缀表对应位置）；若j=0则i++；③遍历结束返回-1。时间复杂度O(m+n)（m为haystack长度，n为needle长度），空间复杂度O(n)（存储next数组）。';
    strStr.hint = 'KMP的核心是「利用前缀表减少回溯」，避免haystack指针的回退';
    problems.push(strStr);


    // 1535. 二分查找（LeetCode 704）
    const search = new ProblemModel();
    search.id = 1535;
    search.title = ' 二分查找 ';
    search.description =
      ' 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。';
    search.difficulty = ProblemDifficulty.EASY;
    search.category = ProblemCategory.BINARY_SEARCH;
    search.choices = [{
      id: 'A',
      text: ' 使用左右指针，计算中间索引，比较中间值与目标值，调整指针范围直至找到或范围无效 ',
      isCorrect: true
    }, { id: 'B', text: ' 递归实现，每次取数组中间元素比较，缩小搜索范围 ', isCorrect: false },
      { id: 'C', text: ' 遍历数组每个元素，逐个比较寻找目标值 ', isCorrect: false },
      { id: 'D', text: ' 使用哈希表存储数组值与下标，直接查询目标值 ', isCorrect: false }];
    search.explanation =
      ' 迭代二分查找：①初始化左指针（left=0）、右指针（right=nums.length-1）；②循环当 left ≤ right 时：计算中间索引（mid = left + Math.floor ((right-left)/2)，避免溢出）；若 nums [mid] == target：返回 mid；若 nums [mid] < target：left=mid+1（目标在右半部分）；若 nums [mid] > target：right=mid-1（目标在左半部分）；③循环结束返回 - 1（目标不存在）。时间复杂度 O (log n)，空间复杂度 O (1)，远优于遍历法（O (n)），是有序数组查找的最优解。';
    search.hint = ' 二分查找的关键是「每次缩小一半搜索范围」，需注意边界条件（left ≤ right）';
    problems.push(search);
    // 1536. x 的平方根（LeetCode 69）
    const mySqrt = new ProblemModel();
    mySqrt.id = 1536;
    mySqrt.title = 'x 的平方根 ';
    mySqrt.description =
      ' 给你一个非负整数 x ，计算并返回 x 的 算术平方根 。由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。\n\n 注意：不允许使用任何内置指数函数和算符，例如 pow (x, 0.5) 或者 x **0.5 。';
    mySqrt.difficulty = ProblemDifficulty.EASY;
    mySqrt.category = ProblemCategory.BINARY_SEARCH;
    mySqrt.choices =
      [{ id: 'A', text: ' 使用二分查找，在 [0, x] 范围内寻找最大的整数 mid，使得 mid² ≤ x', isCorrect: true },
        { id: 'B', text: ' 使用牛顿迭代法，通过迭代公式逼近平方根 ', isCorrect: false },
        { id: 'C', text: ' 从 0 开始递增计算平方，直到平方值超过 x，返回前一个数 ', isCorrect: false },
        { id: 'D', text: ' 利用数学公式转化为指数和对数计算（如 e^(0.5*lnx)）', isCorrect: false }];
    mySqrt.explanation =
      ' 二分查找解法：①若 x < 2：直接返回 x（0 的平方根是 0，1 的平方根是 1）；②初始化左指针（left=2）、右指针（right=x）、结果（res=0）；③循环当 left ≤ right 时：mid = left + Math.floor ((right-left)/2)；square = mid * mid；若 square == x：返回 mid；若 square < x：res=mid（可能是候选解），left=mid+1（寻找更大的 mid）；若 square > x：right=mid-1；④循环结束返回 res。时间复杂度 O (log x)，空间复杂度 O (1)，避免了暴力法的 O (√x) 时间开销，且符合题目禁用内置函数的要求。';
    mySqrt.hint = ' 核心是「寻找满足 mid² ≤ x 的最大整数 mid」，二分查找范围可优化为 [0, x/2+1]';
    problems.push(mySqrt);
    // 1538. 寻找旋转排序数组中的最小值（LeetCode 153）
    const findMin = new ProblemModel();
    findMin.id = 1538;
    findMin.title = ' 寻找旋转排序数组中的最小值 ';
    findMin.description =
      ' 已知一个长度为 n 的数组，预先按照升序排列，经由 1 到 n 次 旋转 后，得到输入数组。例如，原数组 nums = [0,1,2,4,5,6,7] 在变化后可能得到：若旋转 4 次，则可以得到 [4,5,6,7,0,1,2]；若旋转 7 次，则可以得到 [0,1,2,4,5,6,7]。\n\n 给你一个元素值 互不相同 的数组 nums ，它原来是一个升序排列的数组，并按上述情形进行了多次旋转。请你找出并返回数组中的 最小元素 。你必须设计一个时间复杂度为 O (log n) 的算法。';
    findMin.difficulty = ProblemDifficulty.MEDIUM;
    findMin.category = ProblemCategory.BINARY_SEARCH;
    findMin.choices =
      [{ id: 'A', text: ' 二分查找，比较中间值与右边界值，判断最小值在左半部分还是右半部分 ', isCorrect: true },
        { id: 'B', text: ' 找到旋转点（左右相邻元素递减的位置），旋转点的下一个元素即为最小值 ', isCorrect: false },
        { id: 'C', text: ' 遍历数组寻找最小值，时间复杂度 O (n)', isCorrect: false },
        { id: 'D', text: ' 将数组恢复为升序后返回第一个元素 ', isCorrect: false }];
    findMin.explanation =
      ' 二分查找解法：①初始化 left=0，right=nums.length-1；②循环当 left < right 时：mid = Math.floor ((left+right)/2)；若 nums [mid] < nums [right]（右半部分有序，最小值在左半部分）：right=mid；else（左半部分有序，最小值在右半部分）：left=mid+1；③循环结束时 left == right，即为最小值索引，返回 nums [left]。时间复杂度 O (log n)，空间复杂度 O (1)，利用旋转后数组的特性（至少一半是有序的）快速定位最小值。';
    findMin.hint = ' 核心是「与右边界比较」，确定最小值所在的无序半部分 ';
    problems.push(findMin);
    // 1540. 两数相加（LeetCode 2）
    const addTwoNumbers = new ProblemModel();
    addTwoNumbers.id = 1540;
    addTwoNumbers.title = ' 两数相加 ';
    addTwoNumbers.description =
      ' 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。请你将两个数相加，并以相同形式返回一个表示和的链表。你可以假设除了数字 0 之外，这两个数都不会以 0 开头。';
    addTwoNumbers.difficulty = ProblemDifficulty.MEDIUM;
    addTwoNumbers.category = ProblemCategory.LINKED_LIST;
    addTwoNumbers.choices = [{ id: 'A', text: ' 遍历两个链表，逐位相加并记录进位，构造结果链表 ', isCorrect: true },
      { id: 'B', text: ' 将链表转为整数相加后，再转回链表 ', isCorrect: false },
      { id: 'C', text: ' 递归处理两个链表，传递进位并构造结果节点 ', isCorrect: false },
      { id: 'D', text: ' 反转链表后相加，再反转结果 ', isCorrect: false }];
    addTwoNumbers.explanation =
      ' 迭代解法：①创建虚拟头节点（dummy）和当前指针（curr=dummy），进位（carry=0）；②循环当 l1 不为 null 或 l2 不为 null 或 carry>0 时：val1 = l1 ? l1.val : 0；val2 = l2 ? l2.val : 0；sum = val1 + val2 + carry；carry = Math.floor (sum / 10)；curr.next = new TreeNode (sum % 10)；curr = curr.next；若 l1 不为 null 则 l1 = l1.next；若 l2 不为 null 则 l2 = l2.next；③返回 dummy.next。时间复杂度 O (max (m,n))（m、n 为两链表长度），空间复杂度 O (max (m,n))（结果链表长度），避免了大数溢出问题（链表转整数可能因数字过大溢出）。';
    addTwoNumbers.hint = ' 核心是「逐位相加 + 进位处理」，注意链表长度不同和最后进位的情况 ';
    problems.push(addTwoNumbers);
    // 1541. 无重复字符的最长子串（LeetCode 3）
    const lengthOfLongestSubstring = new ProblemModel();
    lengthOfLongestSubstring.id = 1541;
    lengthOfLongestSubstring.title = ' 无重复字符的最长子串 ';
    lengthOfLongestSubstring.description = ' 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。';
    lengthOfLongestSubstring.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLongestSubstring.category = ProblemCategory.SLIDING_WINDOW;
    lengthOfLongestSubstring.choices =
      [{ id: 'A', text: ' 使用滑动窗口（双指针）+ 哈希表，记录字符最后出现位置，动态调整窗口左边界 ', isCorrect: true },
        { id: 'B', text: ' 暴力枚举所有子串，检查是否有重复字符并记录最长长度 ', isCorrect: false },
        { id: 'C', text: ' 使用队列存储当前子串，遇到重复字符则出队直到无重复，记录队列长度 ', isCorrect: false },
        { id: 'D', text: ' 动态规划，dp [i] 表示以第 i 个字符结尾的最长无重复子串长度 ', isCorrect: false }];
    lengthOfLongestSubstring.explanation =
      ' 滑动窗口 + 哈希表解法：①初始化左指针（left=0）、最大长度（maxLen=0）、哈希表（map 存储字符→最后索引）；②右指针（right）遍历 s：若 map 中存在 s [right] 且 map.get (s [right]) >= left（重复字符在当前窗口内）：left = map.get (s [right]) + 1（移动左指针到重复字符右侧）；map.set (s [right], right)（更新字符最后出现位置）；maxLen = Math.max (maxLen, right - left + 1)；③遍历结束返回 maxLen。时间复杂度 O (n)（每个字符遍历一次），空间复杂度 O (k)（k 为字符集大小，如 ASCII 为 128），效率远高于暴力法（O (n²)）。';
    lengthOfLongestSubstring.hint = ' 滑动窗口的关键是「右扩左缩」，哈希表记录字符位置避免重复检查 ';
    problems.push(lengthOfLongestSubstring);
    // 1544. 最接近的三数之和（LeetCode 16）
    const threeSumClosest = new ProblemModel();
    threeSumClosest.id = 1544;
    threeSumClosest.title = ' 最接近的三数之和 ';
    threeSumClosest.description =
      ' 给你一个长度为 n 的整数数组 nums 和 一个目标值 target。请你从 nums 中选出三个整数，使它们的和与 target 最接近。返回这三个数的和。假定每组输入只存在恰好一个解。';
    threeSumClosest.difficulty = ProblemDifficulty.MEDIUM;
    threeSumClosest.category = ProblemCategory.ARRAY;
    threeSumClosest.choices =
      [{ id: 'A', text: ' 先排序，固定第一个数，双指针寻找另外两个数，记录最接近 target 的和 ', isCorrect: true },
        { id: 'B', text: ' 暴力三重循环枚举所有三元组，计算和并比较与 target 的距离 ', isCorrect: false },
        { id: 'C', text: ' 使用哈希表存储两数之和，再遍历第三个数寻找最接近的组合 ', isCorrect: false },
        { id: 'D', text: ' 随机采样多个三元组，估算最接近的和 ', isCorrect: false }];
    threeSumClosest.explanation =
      ' 排序 + 双指针解法：①排序数组；②初始化最接近和（res = nums [0]+nums [1]+nums [2]）；③遍历固定第一个数 i（0 <= i < n-2）：左指针（left=i+1），右指针（right=n-1）；循环当 left < right 时：sum = nums [i] + nums [left] + nums [right]；若 sum == target：直接返回 target（最接近）；若 Math.abs (sum-target) < Math.abs (res-target)：更新 res=sum；若 sum < target：left++；else：right--；④遍历结束返回 res。时间复杂度 O (n²)，空间复杂度 O (log n)（排序），比暴力法（O (n³)）高效得多，且能确保找到最优解。';
    threeSumClosest.hint = ' 核心是「通过双指针动态调整三数和」，向 target 逼近并记录最小值 ';
    problems.push(threeSumClosest);

    // 1554. 分发饼干（LeetCode 455）
    const findContentChildren = new ProblemModel();
    findContentChildren.id = 1554;
    findContentChildren.title = '分发饼干';
    findContentChildren.description = '假设你是一位很棒的家长，想要给你的孩子们一些小饼干。但是，每个孩子最多只能给一块饼干。对每个孩子 i，都有一个胃口值 g[i]，这是能让孩子们满足胃口的饼干的最小尺寸；并且每块饼干 j，都有一个尺寸 s[j] 。如果 s[j] >= g[i]，我们可以将这个饼干 j 分配给孩子 i ，这个孩子会得到满足。你的目标是尽可能满足越多数量的孩子，并输出这个最大数值。';
    findContentChildren.difficulty = ProblemDifficulty.EASY;
    findContentChildren.category = ProblemCategory.GREEDY;
    findContentChildren.choices = [
      { id: 'A', text: '排序两个数组，用最小的饼干满足最小胃口的孩子，双指针推进', isCorrect: true },
      { id: 'B', text: '优先用最大的饼干满足最大胃口的孩子', isCorrect: false },
      { id: 'C', text: '暴力枚举所有可能的分配方式，寻找最大值', isCorrect: false },
      { id: 'D', text: '动态规划，记录前i个孩子和前j个饼干的最大满足数', isCorrect: false }
    ];
    findContentChildren.explanation = '贪心解法：①排序胃口数组g和饼干数组s；②初始化双指针i=0（孩子）、j=0（饼干）、count=0；③循环当i < g.length且j < s.length时：若s[j] >= g[i]（饼干能满足孩子）：count++，i++，j++；else（饼干太小）：j++；④返回count。时间复杂度O(m log m + n log n)（排序耗时），空间复杂度O(log m + log n)（排序栈空间），通过贪心策略最大化满足数量，是最优解法。';
    findContentChildren.hint = '关键是「从小到大匹配」，用最小的合适饼干满足每个孩子';
    problems.push(findContentChildren);

    // 1555. 跳跃游戏（LeetCode 55）
    const canJump = new ProblemModel();
    canJump.id = 1555;
    canJump.title = '跳跃游戏';
    canJump.description = '给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。数组中的每个元素代表你在该位置可以跳跃的最大长度。判断你是否能够到达最后一个下标。';
    canJump.difficulty = ProblemDifficulty.MEDIUM;
    canJump.category = ProblemCategory.GREEDY;
    canJump.choices = [
      { id: 'A', text: '贪心算法，记录当前能到达的最远距离，遍历数组更新最远距离', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i]表示能否到达位置i', isCorrect: false },
      { id: 'C', text: '回溯法，尝试所有可能的跳跃路径', isCorrect: false },
      { id: 'D', text: 'BFS，将每个可达位置入队，探索所有可达位置', isCorrect: false }
    ];
    canJump.explanation = '贪心解法：①初始化最远可达距离maxReach=0；②遍历数组每个位置i：若i > maxReach（当前位置不可达）：return false；maxReach = Math.max(maxReach, i + nums[i])；若maxReach >= nums.length-1（已能到达终点）：return true；③遍历结束后返回maxReach >= nums.length-1。时间复杂度O(n)，空间复杂度O(1)，高效判断可达性，无需记录所有路径。';
    canJump.hint = '核心是「只关心最远能到达的位置」，无需知道具体路径';
    problems.push(canJump);

    // 1558. 从前序与中序遍历序列构造二叉树（LeetCode 105）
    const buildTree = new ProblemModel();
    buildTree.id = 1558;
    buildTree.title = '从前序与中序遍历序列构造二叉树';
    buildTree.description = '给定两个整数数组 preorder 和 inorder ，其中 preorder 是二叉树的先序遍历， inorder 是同一棵树的中序遍历，请构造二叉树并返回其根节点。';
    buildTree.difficulty = ProblemDifficulty.MEDIUM;
    buildTree.category = ProblemCategory.BINARY_TREE;
    buildTree.choices = [
      { id: 'A', text: '前序首元素为根，中序中根左侧为左子树，右侧为右子树，递归构造', isCorrect: true },
      { id: 'B', text: '中序末元素为根，前序中分割左右子树，递归构造', isCorrect: false },
      { id: 'C', text: '使用栈迭代构建，模拟前序遍历过程', isCorrect: false },
      { id: 'D', text: '先构建链表，再转换为二叉树结构', isCorrect: false }
    ];
    buildTree.explanation = '递归解法：①若preorder为空：返回null；②根节点值rootVal = preorder[0]；在inorder中找到rootVal的索引index；③左子树节点数leftSize = index；④左子树前序：preorder.slice(1, 1+leftSize)，左子树中序：inorder.slice(0, index)；⑤右子树前序：preorder.slice(1+leftSize)，右子树中序：inorder.slice(index+1)；⑥构造根节点，递归设置root.left = buildTree(左前序, 左中序)，root.right = buildTree(右前序, 右中序)；⑦返回root。时间复杂度O(n)（优化后用哈希表查index），空间复杂度O(n)（存储中序索引+递归栈），利用遍历特性递归构建。';
    buildTree.hint = '关键是「前序定根，中序分左右」，通过根节点在中序中的位置分割子树';
    problems.push(buildTree);


    // 1563. LRU 缓存（LeetCode 146）
    const LRUCache = new ProblemModel();
    LRUCache.id = 1563;
    LRUCache.title = 'LRU 缓存';
    LRUCache.description = '请你设计并实现一个满足  LRU (最近最少使用) 缓存 约束的数据结构。实现 LRUCache 类：LRUCache(int capacity) 以 正整数 作为容量 capacity 初始化 LRU 缓存；int get(int key) 如果关键字 key 存在于缓存中，则获取关键字的值，否则返回 -1 ；void put(int key, int value) 如果关键字 key 已经存在，则变更其数据值；如果不存在，则向缓存中插入该组 key-value 。如果插入操作导致关键字数量超过 capacity ，则应该 逐出 最久未使用的关键字。函数 get 和 put 必须以 O(1) 的平均时间复杂度运行。';
    LRUCache.difficulty = ProblemDifficulty.MEDIUM;
    LRUCache.category = ProblemCategory.DESIGN;
    LRUCache.choices = [
      { id: 'A', text: '哈希表+双向链表，哈希表快速访问，双向链表维护使用顺序', isCorrect: true },
      { id: 'B', text: '数组存储键值对，记录访问时间戳，超时淘汰', isCorrect: false },
      { id: 'C', text: '使用JavaScript的Map对象，利用其插入顺序特性', isCorrect: false },
      { id: 'D', text: '二叉搜索树记录访问顺序，实现O(log n)操作', isCorrect: false }
    ];
    LRUCache.explanation = '哈希表+双向链表解法：①双向链表节点存储key、value，维护最近使用顺序（头部是最近使用，尾部是最久未使用）；②哈希表map存储key→节点的映射，实现O(1)访问；③get操作：若key存在，将节点移到链表头部，返回value；否则返回-1；④put操作：若key存在，更新value并移到头部；否则创建新节点插入头部，若超出容量，删除链表尾部节点并从map中移除；⑤所有操作均为O(1)时间复杂度。空间复杂度O(capacity)，严格满足题目要求。';
    LRUCache.hint = '核心是「两种数据结构结合」，哈希表提供快速访问，链表维护使用顺序';
    problems.push(LRUCache);

    // 1568. 盛最多水的容器（LeetCode 11）
    const maxArea = new ProblemModel();
    maxArea.id = 1568;
    maxArea.title = '盛最多水的容器';
    maxArea.description = '给定一个长度为 n 的整数数组 height 。有 n 条垂线，第 i 条线的两个端点是 (i, 0) 和 (i, height[i]) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。返回容器可以储存的最大水量。说明：你不能倾斜容器。';
    maxArea.difficulty = ProblemDifficulty.MEDIUM;
    maxArea.category = ProblemCategory.ARRAY;
    maxArea.choices = [
      { id: 'A', text: '双指针从两端向中间移动，每次移动较短的那条边', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的两条线，计算面积取最大值', isCorrect: false },
      { id: 'C', text: '排序高度数组，再计算最大宽度对应的面积', isCorrect: false },
      { id: 'D', text: '动态规划，记录区间[i,j]的最大面积', isCorrect: false }
    ];
    maxArea.explanation = '双指针解法：①初始化左指针left=0，右指针right=height.length-1，最大面积max=0；②循环当left < right时：计算当前面积area = (right-left) * Math.min(height[left], height[right])；更新max = Math.max(max, area)；若height[left] <= height[right]：left++（移动较短边寻找更大面积）；else：right--；③循环结束返回max。时间复杂度O(n)，空间复杂度O(1)，比暴力法O(n²)高效，通过贪心策略缩小搜索范围。';
    maxArea.hint = '关键是「移动较短边可能获得更大面积」，因为宽度减小的同时高度可能增加';
    problems.push(maxArea);

    // 1569. 零钱兑换（LeetCode 322）
    const coinChange = new ProblemModel();
    coinChange.id = 1569;
    coinChange.title = '零钱兑换';
    coinChange.description = '给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。计算并返回可以凑成总金额所需的 最少的硬币个数 。如果没有任何一种硬币组合能组成总金额，返回 -1 。你可以认为每种硬币的数量是无限的。';
    coinChange.difficulty = ProblemDifficulty.MEDIUM;
    coinChange.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    coinChange.choices = [
      { id: 'A', text: '动态规划，dp[i]表示凑成金额i所需的最少硬币数', isCorrect: true },
      { id: 'B', text: '贪心算法，优先使用大面额硬币', isCorrect: false },
      { id: 'C', text: '递归+记忆化，计算凑成金额amount的最少硬币数', isCorrect: false },
      { id: 'D', text: 'BFS，从0开始逐层累加硬币面额，找到amount的最少步数', isCorrect: false }
    ];
    coinChange.explanation = '动态规划解法：①初始化dp数组，长度amount+1，填充Infinity；dp[0] = 0（金额0需0个硬币）；②遍历金额i从1到amount：遍历每个硬币coin：若coin <= i：dp[i] = Math.min(dp[i], dp[i-coin] + 1)；③若dp[amount]仍为Infinity：返回-1；否则返回dp[amount]。时间复杂度O(amount×k)（k为硬币种类），空间复杂度O(amount)，通过子问题最优解构建全局最优解。';
    coinChange.hint = '核心是「状态转移方程：dp[i] = min(dp[i-coin] + 1)」，从金额0逐步计算到目标金额';
    problems.push(coinChange);

    // 1570. 编辑距离（LeetCode 72）
    const minDistance = new ProblemModel();
    minDistance.id = 1570;
    minDistance.title = '编辑距离';
    minDistance.description = '给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数 。你可以对一个单词进行如下三种操作：1. 插入一个字符；2. 删除一个字符；3. 替换一个字符。';
    minDistance.difficulty = ProblemDifficulty.HARD;
    minDistance.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    minDistance.choices = [
      { id: 'A', text: '动态规划，dp[i][j]表示word1前i个字符转word2前j个字符的最少操作数', isCorrect: true },
      { id: 'B', text: '递归+记忆化，计算子问题的编辑距离', isCorrect: false },
      { id: 'C', text: '贪心算法，优先匹配相同字符', isCorrect: false },
      { id: 'D', text: '基于最长公共子序列计算，操作数=长度差+替换数', isCorrect: false }
    ];
    minDistance.explanation = '动态规划解法：①定义dp[m+1][n+1]（m、n为两单词长度）；②初始化：dp[i][0] = i（删除i个字符），dp[0][j] = j（插入j个字符）；③填充dp表：若word1[i-1] == word2[j-1]：dp[i][j] = dp[i-1][j-1]；else：dp[i][j] = 1 + min(dp[i-1][j]（删除）, dp[i][j-1]（插入）, dp[i-1][j-1]（替换）)；④返回dp[m][n]。时间复杂度O(m×n)，空间复杂度O(m×n)（可优化为O(min(m,n))），是编辑距离问题的标准解法。';
    minDistance.hint = '关键是「分解三种操作的子问题」，通过状态转移方程累积最优解';
    problems.push(minDistance);

    // 1571. 拓扑排序（LeetCode 207）
    const canFinish = new ProblemModel();
    canFinish.id = 1571;
    canFinish.title = '课程表';
    canFinish.description = '你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1。在选修某些课程之前需要一些先修课程，例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示：[0,1]。给定课程总数以及它们的先决条件，请你判断是否可能完成所有课程的学习？';
    canFinish.difficulty = ProblemDifficulty.MEDIUM;
    canFinish.category = ProblemCategory.GRAPH;
    canFinish.choices = [
      { id: 'A', text: '拓扑排序（ Kahn 算法），统计入度，使用队列处理入度为0的节点', isCorrect: true },
      { id: 'B', text: '深度优先搜索，检测有向图中是否存在环', isCorrect: false },
      { id: 'C', text: '暴力枚举所有课程顺序，检查是否满足先决条件', isCorrect: false },
      { id: 'D', text: '广度优先搜索，随机选择课程并检查依赖', isCorrect: false }
    ];
    canFinish.explanation = 'Kahn算法解法：①构建邻接表和入度数组；②初始化队列，将所有入度为0的节点入队；③计数变量count=0；④循环当队列不为空时：节点u出队，count++；遍历u的邻接节点v：入度[v]--，若入度[v]==0则入队；⑤若count==numCourses：返回true（无环，可完成）；else：返回false。时间复杂度O(n+m)（n为课程数，m为先决条件数），空间复杂度O(n+m)，通过入度管理实现拓扑排序，高效判断是否存在环。';
    canFinish.hint = '核心是「检测有向图是否无环」，入度为0的节点可优先处理，逐步减少依赖';
    problems.push(canFinish);

    // 1572. 位1的个数（LeetCode 191）
    const hammingWeight = new ProblemModel();
    hammingWeight.id = 1572;
    hammingWeight.title = '位1的个数';
    hammingWeight.description = '编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 \'1\' 的个数（也被称为汉明重量）。';
    hammingWeight.difficulty = ProblemDifficulty.EASY;
    hammingWeight.category = ProblemCategory.BIT_MANIPULATION;
    hammingWeight.choices = [
      { id: 'A', text: '位运算，n & (n-1) 消除最后一个1，计数直到n为0', isCorrect: true },
      { id: 'B', text: '循环检查每一位是否为1，右移n直到为0', isCorrect: false },
      { id: 'C', text: '将数字转为二进制字符串，统计\'1\'的个数', isCorrect: false },
      { id: 'D', text: '使用内置函数计算二进制中1的个数', isCorrect: false }
    ];
    hammingWeight.explanation = '最优位运算解法：①初始化计数count=0；②循环当n!=0时：n = n & (n-1)（消除最后一个1）；count++；③返回count。原理是n&(n-1)会将n二进制中最后一个1变为0，其余位不变。时间复杂度O(k)（k为二进制中1的个数），空间复杂度O(1)，比检查所有位的O(32)更高效。';
    hammingWeight.hint = '关键是「n & (n-1)的特性」，每次操作直接消除一个1，无需逐位检查';
    problems.push(hammingWeight);

    // 1573. 找不同（LeetCode 389）
    const findTheDifference = new ProblemModel();
    findTheDifference.id = 1573;
    findTheDifference.title = '找不同';
    findTheDifference.description = '给定两个字符串 s 和 t，它们只包含小写字母。字符串 t 由字符串 s 随机重排，然后在随机位置添加一个字母。请找出在 t 中被添加的字母。';
    findTheDifference.difficulty = ProblemDifficulty.EASY;
    findTheDifference.category = ProblemCategory.BIT_MANIPULATION;
    findTheDifference.choices = [
      { id: 'A', text: '位运算，将所有字符异或，结果即为添加的字符', isCorrect: true },
      { id: 'B', text: '计算两个字符串的ASCII码总和，差值即为添加字符', isCorrect: false },
      { id: 'C', text: '使用哈希表统计字符出现次数，找出多出现一次的字符', isCorrect: false },
      { id: 'D', text: '排序两个字符串，比较找出不同的字符', isCorrect: false }
    ];
    findTheDifference.explanation = '异或解法：①初始化result=0；②遍历s中每个字符：result ^= charCodeAt；③遍历t中每个字符：result ^= charCodeAt；④返回String.fromCharCode(result)。原理是异或运算的特性：a^a=0，0^a=a，相同字符会抵消，剩余的就是添加的字符。时间复杂度O(n)，空间复杂度O(1)，无需额外空间，效率最优。';
    findTheDifference.hint = '核心是「异或的抵消特性」，相同字符异或结果为0，最终剩余的就是目标字符';
    problems.push(findTheDifference);


    // 1575. Pow(x, n)（LeetCode 50）
    const myPow = new ProblemModel();
    myPow.id = 1575;
    myPow.title = 'Pow(x, n)';
    myPow.description = '实现 pow(x, n) ，即计算 x 的整数 n 次幂函数（即，x^n）。';
    myPow.difficulty = ProblemDifficulty.MEDIUM;
    myPow.category = ProblemCategory.RECURSION;
    myPow.choices = [
      { id: 'A', text: '快速幂（分治），将指数分解为偶数或奇数情况递归计算', isCorrect: true },
      { id: 'B', text: '迭代法，累乘n次x', isCorrect: false },
      { id: 'C', text: '使用数学库函数直接计算', isCorrect: false },
      { id: 'D', text: '转换为指数和对数计算（x^n = e^(n ln x)）', isCorrect: false }
    ];
    myPow.explanation = '快速幂解法：①处理边界：若n=0：return 1；若n<0：return 1/myPow(x, -n)；②递归计算：若n为偶数：return myPow(x*x, n/2)；若n为奇数：return x * myPow(x*x, (n-1)/2)。原理是将指数n分解为二进制形式，减少乘法次数。时间复杂度O(log n)，空间复杂度O(log n)（递归栈），比暴力乘法的O(n)高效得多，尤其适合大指数。';
    myPow.hint = '核心是「指数二分」，通过x^n = (x^2)^(n/2) 减少计算步骤';
    problems.push(myPow);


    // 1577. 二叉树的最近公共祖先（LeetCode 236）
    const lowestCommonAncestorBT = new ProblemModel();
    lowestCommonAncestorBT.id = 1577;
    lowestCommonAncestorBT.title = '二叉树的最近公共祖先';
    lowestCommonAncestorBT.description = '给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”';
    lowestCommonAncestorBT.difficulty = ProblemDifficulty.MEDIUM;
    lowestCommonAncestorBT.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestorBT.choices = [
      { id: 'A', text: '递归后序遍历，若左右子树分别包含p和q，则当前节点为LCA', isCorrect: true },
      { id: 'B', text: '记录每个节点的父节点，再通过回溯找交点', isCorrect: false },
      { id: 'C', text: '层次遍历，找到包含p和q的最小子树的根', isCorrect: false },
      { id: 'D', text: '先找到p的路径，再检查q是否在某节点的子树中', isCorrect: false }
    ];
    lowestCommonAncestorBT.explanation = '递归解法：①若root为null或root==p或root==q：return root；②递归左子树：left = lowestCommonAncestor(root.left, p, q)；③递归右子树：right = lowestCommonAncestor(root.right, p, q)；④若left和right都不为null：return root（p、q分别在左右子树）；⑤若left不为null：return left；else：return right。时间复杂度O(n)，空间复杂度O(h)（递归栈），通过后序遍历一次完成查找，无需额外存储空间。';
    lowestCommonAncestorBT.hint = '核心是「后序遍历的回溯特性」，判断左右子树是否包含目标节点';
    problems.push(lowestCommonAncestorBT);

    // 1578. 字符串转换整数 (atoi)（LeetCode 8）
    const myAtoi = new ProblemModel();
    myAtoi.id = 1578;
    myAtoi.title = '字符串转换整数 (atoi)';
    myAtoi.description = '请你来实现一个 myAtoi(string s) 函数，使其能将字符串转换成一个 32 位有符号整数（类似 C/C++ 中的 atoi 函数）。函数 myAtoi(string s) 的算法如下：1. 读入字符串并丢弃无用的前导空格；2. 检查下一个字符（假设还未到字符末尾）为正还是负号，读取该字符（如果有）。 确定最终结果的符号，如果两者都不存在，则假定结果为正。3. 读入下一个字符，直到到达下一个非数字字符或到达输入的结尾。字符串的其余部分将被忽略。4. 将前面步骤读入的这些数字转换为整数（即，"123" -> 123， "0032" -> 32）。如果没有读入数字，则整数为 0 。必要时更改符号（从步骤 2 开始）。5. 如果整数数超过 32 位有符号整数范围 [−2^31,  2^31 − 1] ，需要截断这个整数，使其保持在这个范围内。具体来说，小于 −2^31 的整数应该被固定为 −2^31 ，大于 2^31 − 1 的整数应该被固定为 2^31 − 1 。6. 返回这个整数。';
    myAtoi.difficulty = ProblemDifficulty.MEDIUM;
    myAtoi.category = ProblemCategory.STRING;
    myAtoi.choices = [
      { id: 'A', text: '按步骤处理：跳过空格→确定符号→提取数字→处理溢出', isCorrect: true },
      { id: 'B', text: '使用正则表达式匹配数字部分，再处理符号和溢出', isCorrect: false },
      { id: 'C', text: '转换为数组后过滤非数字字符，再转换计算', isCorrect: false },
      { id: 'D', text: '使用内置函数直接转换后判断范围', isCorrect: false }
    ];
    myAtoi.explanation = '分步解法：①初始化索引i=0，n=s.length，符号sign=1，结果res=0；②跳过前导空格：while(i<n && s[i]==\' \') i++；③处理符号：if(i<n && (s[i]==\'+\' || s[i]==\'-\')) { sign = s[i]==\'-\' ? -1 : 1; i++；}；④提取数字：while(i<n && !isNaN(parseInt(s[i]))) { digit = parseInt(s[i])；// 处理溢出：若res > (2^31-1 - digit)/10 → 溢出 if(res > (Math.pow(2,31)-1 - digit)/10) { return sign > 0 ? Math.pow(2,31)-1 : -Math.pow(2,31)；} res = res*10 + digit；i++；}；⑤返回res*sign。时间复杂度O(n)，空间复杂度O(1)，严格按照步骤处理所有边界情况。';
    myAtoi.hint = '关键是「处理所有边界条件」，包括空格、符号、非数字字符和整数溢出';
    problems.push(myAtoi);


    // 1580. 打家劫舍（LeetCode 198）
    const rob = new ProblemModel();
    rob.id = 1580;
    rob.title = '打家劫舍';
    rob.description = '你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。';
    rob.difficulty = ProblemDifficulty.EASY;
    rob.difficulty = ProblemDifficulty.EASY;
    rob.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    rob.choices = [
      { id: 'A', text: '动态规划，dp[i] = max(dp[i-1], dp[i-2] + nums[i])', isCorrect: true },
      { id: 'B', text: '递归+记忆化，计算偷或不偷当前房屋的最大收益', isCorrect: false },
      { id: 'C', text: '贪心算法，交替选择房屋偷窃', isCorrect: false },
      { id: 'D', text: '滑动窗口，计算奇数和与偶数和的最大值', isCorrect: false }
    ];
    rob.explanation = '动态规划解法：①边界处理：若nums为空：return 0；若长度为1：return nums[0]；②初始化dp数组：dp[0] = nums[0]；dp[1] = Math.max(nums[0], nums[1])；③迭代计算：for(let i=2; i<nums.length; i++) { dp[i] = Math.max(dp[i-1], dp[i-2] + nums[i])；}；④返回dp[nums.length-1]。空间优化：可用两个变量存储dp[i-1]和dp[i-2]，空间复杂度O(1)。时间复杂度O(n)，通过状态转移方程记录最优解。';
    rob.hint = '关键是「状态转移方程」，当前房屋的最大收益=max(不偷当前房, 偷当前房+前前房收益)';
    problems.push(rob);
    // 1581. 最长回文子串（LeetCode 5）
    const longestPalindrome = new ProblemModel();
    longestPalindrome.id = 1581;
    longestPalindrome.title = '最长回文子串';
    longestPalindrome.description = '给你一个字符串 s，找到 s 中最长的回文子串。如果字符串的反序与原始字符串相同，则该字符串称为回文字符串。';
    longestPalindrome.difficulty = ProblemDifficulty.MEDIUM;
    longestPalindrome.category = ProblemCategory.STRING;
    longestPalindrome.choices = [
      { id: 'A', text: '中心扩展法，以每个字符和字符间隙为中心向两边扩展', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i][j]表示s[i..j]是否为回文子串', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子串，检查是否为回文并记录最长', isCorrect: false },
      { id: 'D', text: 'Manacher算法，线性时间复杂度的最优解', isCorrect: false }
    ];
    longestPalindrome.explanation = '中心扩展解法：①初始化最长回文子串的起始索引和长度；②遍历字符串每个字符，以当前字符为中心（奇数长度）和当前字符与下一个字符之间为中心（偶数长度）进行扩展；③扩展时检查左右字符是否相等，更新最长回文子串的位置和长度；④最终截取并返回最长回文子串。时间复杂度O(n²)，空间复杂度O(1)，实现简单且效率优于动态规划的O(n²)空间复杂度。';
    longestPalindrome.hint = '核心是「回文的中心对称性」，考虑奇数和偶数长度两种情况';
    problems.push(longestPalindrome);


    // 1584. 全排列（LeetCode 46）
    const permute = new ProblemModel();
    permute.id = 1584;
    permute.title = '全排列';
    permute.description = '给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。';
    permute.difficulty = ProblemDifficulty.MEDIUM;
    permute.category = ProblemCategory.BACKTRACKING;
    permute.choices = [
      { id: 'A', text: '回溯法，通过标记已使用元素构建所有排列', isCorrect: true },
      { id: 'B', text: '递归交换元素，生成所有可能的排列', isCorrect: false },
      { id: 'C', text: '动态规划，基于n-1的排列生成n的排列', isCorrect: false },
      { id: 'D', text: '使用next_permutation算法迭代生成', isCorrect: false }
    ];
    permute.explanation = '回溯解法：①初始化结果数组和路径数组；②创建used数组标记元素是否已使用；③定义回溯函数backtrack()：若路径长度等于nums长度：加入结果；return；遍历nums每个元素：若已使用则跳过；标记为已使用；路径加入该元素；backtrack()；路径弹出该元素；取消标记；④调用backtrack()，返回结果。时间复杂度O(n×n!)（n!个排列，每个需O(n)时间），空间复杂度O(n)（递归栈和used数组），是全排列问题的标准解法。';
    permute.hint = '关键是「标记已使用元素」，确保每个元素在排列中只出现一次';
    problems.push(permute);

    // 1585. 单词搜索（LeetCode 79）
    const exist = new ProblemModel();
    exist.id = 1585;
    exist.title = '单词搜索';
    exist.description = '给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。';
    exist.difficulty = ProblemDifficulty.MEDIUM;
    exist.category = ProblemCategory.BACKTRACKING;
    exist.choices = [
      { id: 'A', text: '回溯法，从每个单元格开始，上下左右递归搜索并标记已访问', isCorrect: true },
      { id: 'B', text: 'BFS，从匹配首字母的位置开始逐层搜索单词', isCorrect: false },
      { id: 'C', text: '前缀树，先构建单词前缀树再搜索网格', isCorrect: false },
      { id: 'D', text: '动态规划，记录到达每个位置匹配的单词长度', isCorrect: false }
    ];
    exist.explanation = '回溯解法：①遍历网格每个单元格(i,j)：若board[i][j] == word[0]：调用回溯函数；②回溯函数(i,j,index)：若index == word长度：return true；若i、j越界或已访问或字符不匹配：return false；标记当前单元格为已访问；递归搜索上下左右四个方向，若任一方向返回true：return true；取消标记；return false；③若所有起点都搜索失败：return false。时间复杂度O(m×n×3^L)（m,n为网格尺寸，L为单词长度，每个步有3个方向），空间复杂度O(L)（递归栈深度），通过回溯和标记避免重复访问。';
    exist.hint = '核心是「递归探索+回溯标记」，及时剪枝不匹配的路径';
    problems.push(exist);

    // 1586. 最大子数组和（LeetCode 53）
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 1586;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description = '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。子数组 是数组中的一个连续部分。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxSubArray.choices = [
      { id: 'A', text: 'Kadane算法，遍历数组，累加和为负则重置为当前元素', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i] = max(nums[i], dp[i-1] + nums[i])', isCorrect: false },
      { id: 'C', text: '分治法，将数组分为左右两部分，最大子数组在左/右/跨中间', isCorrect: false },
      { id: 'D', text: '前缀和，计算前缀和后找差值最大的两个点', isCorrect: false }
    ];
    maxSubArray.explanation = 'Kadane算法：①初始化当前最大和currentSum与全局最大和maxSum为nums[0]；②遍历数组从索引1开始：currentSum = Math.max(nums[i], currentSum + nums[i])（若之前累加和为负则重置）；maxSum = Math.max(maxSum, currentSum)；③返回maxSum。时间复杂度O(n)，空间复杂度O(1)，一次遍历完成，是该问题的最优解法，比动态规划更简洁。';
    maxSubArray.hint = '关键是「放弃负收益」，当累加和为负时，从当前元素重新开始累加';
    problems.push(maxSubArray);

    // 1587. 寻找两个正序数组的中位数（LeetCode 4）
    const findMedianSortedArrays = new ProblemModel();
    findMedianSortedArrays.id = 1587;
    findMedianSortedArrays.title = '寻找两个正序数组的中位数';
    findMedianSortedArrays.description = '给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。算法的时间复杂度应该为 O(log (m+n)) 。';
    findMedianSortedArrays.difficulty = ProblemDifficulty.HARD;
    findMedianSortedArrays.category = ProblemCategory.BINARY_SEARCH;
    findMedianSortedArrays.choices = [
      { id: 'A', text: '二分查找，在短数组中寻找分割点，确保左右元素满足中位数条件', isCorrect: true },
      { id: 'B', text: '合并两个数组后直接取中位数', isCorrect: false },
      { id: 'C', text: '双指针遍历，找到第k小的元素（k为中位数位置）', isCorrect: false },
      { id: 'D', text: '递归寻找两个数组的第k小元素', isCorrect: false }
    ];
    findMedianSortedArrays.explanation = '二分查找解法：①确保nums1是较短数组（优化时间复杂度）；②初始化左右指针left=0，right=m；③循环找到正确分割：i=(left+right)/2（nums1分割点），j=(m+n+1)/2 - i（nums2分割点）；确保nums1[i-1] <= nums2[j]且nums2[j-1] <= nums1[i]；④若总长度为奇数：return max(nums1[i-1], nums2[j-1])；⑤若为偶数：return (max左 + min右)/2。时间复杂度O(log min(m,n))，满足题目要求，通过二分查找避免合并数组。';
    findMedianSortedArrays.hint = '核心是「寻找正确的分割点」，使分割后左半部分元素均小于等于右半部分';
    problems.push(findMedianSortedArrays);


    // 1590. 最小覆盖子串（LeetCode 76）
    const minWindow = new ProblemModel();
    minWindow.id = 1590;
    minWindow.title = '最小覆盖子串';
    minWindow.description = '给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.SLIDING_WINDOW;
    minWindow.choices = [
      { id: 'A', text: '滑动窗口+哈希表，记录窗口中字符数量，收缩左边界找最小窗口', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子串，检查是否包含t的所有字符', isCorrect: false },
      { id: 'C', text: '动态规划，记录包含t前i个字符的最小子串', isCorrect: false },
      { id: 'D', text: '预处理t的字符频率，使用双指针寻找符合条件的窗口', isCorrect: false }
    ];
    minWindow.explanation = '滑动窗口解法：①创建哈希表记录t中字符频率；②初始化左右指针left=0，right=0，有效字符数valid=0，最小长度minLen= Infinity，结果起始索引start=0；③右移right扩大窗口：若字符在t中，更新窗口内频率，若达到t中的频率则valid++；④当valid等于t中不同字符数时：尝试左移left缩小窗口；更新最小窗口信息；若移除的是t中字符且频率低于t中的，则valid--；⑤返回最小窗口或空串。时间复杂度O(m+n)（m、n分别为s和t的长度），空间复杂度O(k)（k为t中不同字符数），高效找到最小覆盖子串。';
    minWindow.hint = '核心是「扩大窗口找可行解，缩小窗口求最优解」，通过哈希表跟踪字符匹配情况';
    problems.push(minWindow);

    // 1592. 比特位计数（LeetCode 338）
    const countBits = new ProblemModel();
    countBits.id = 1592;
    countBits.title = '比特位计数';
    countBits.description = '给你一个整数 n ，对于 0 ≤ i ≤ n 中的每个 i ，计算其二进制表示中 1 的个数 ，返回一个长度为 n + 1 的数组 ans 作为答案。';
    countBits.difficulty = ProblemDifficulty.EASY;
    countBits.category = ProblemCategory.BIT_MANIPULATION;
    countBits.choices = [
      { id: 'A', text: '动态规划，利用i&(i-1)消除最后一个1，dp[i] = dp[i&(i-1)] + 1', isCorrect: true },
      { id: 'B', text: '循环计算每个数的二进制中1的个数', isCorrect: false },
      { id: 'C', text: '利用奇偶性，偶数dp[i] = dp[i/2]，奇数dp[i] = dp[i-1] + 1', isCorrect: false },
      { id: 'D', text: '使用内置函数计算每个数的1的个数', isCorrect: false }
    ];
    countBits.explanation = '动态规划解法：①初始化dp数组，dp[0] = 0；②遍历i从1到n：dp[i] = dp[i & (i - 1)] + 1（i&(i-1)消除最后一个1，比i少一个1）；③返回dp数组。时间复杂度O(n)，空间复杂度O(n)，一次遍历完成所有计算，比逐个计算的O(n log n)更高效。';
    countBits.hint = '核心是「利用已计算的结果」，i与i&(i-1)的1的个数相差1';
    problems.push(countBits);

    // 1593. 丑数 II（LeetCode 264）
    const nthUglyNumber = new ProblemModel();
    nthUglyNumber.id = 1593;
    nthUglyNumber.title = '丑数 II';
    nthUglyNumber.description = '给你一个整数 n ，请你找出并返回第 n 个 丑数 。丑数 就是只包含质因数 2、3 和/或 5 的正整数。';
    nthUglyNumber.difficulty = ProblemDifficulty.MEDIUM;
    nthUglyNumber.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    nthUglyNumber.choices = [
      { id: 'A', text: '动态规划，维护三个指针分别乘以2、3、5，取最小值', isCorrect: true },
      { id: 'B', text: '暴力判断每个数是否为丑数，直到找到第n个', isCorrect: false },
      { id: 'C', text: '优先队列（最小堆），每次取出最小值并生成新的丑数', isCorrect: false },
      { id: 'D', text: '数学公式直接计算第n个丑数', isCorrect: false }
    ];
    nthUglyNumber.explanation = '动态规划解法：①初始化dp数组，dp[1] = 1（第一个丑数）；②三个指针p2=p3=p5=1；③遍历i从2到n：计算三个候选值：dp[p2]×2、dp[p3]×3、dp[p5]×5；dp[i] = 三个候选值的最小值；④若dp[i]等于某个候选值，对应指针++（避免重复）；⑤返回dp[n]。时间复杂度O(n)，空间复杂度O(n)，高效生成丑数，避免判断非丑数的开销。';
    nthUglyNumber.hint = '关键是「丑数的生成特性」，每个丑数都是之前的丑数乘以2、3或5得到的';
    problems.push(nthUglyNumber);

    // 1594. 最大正方形（LeetCode 221）
    const maximalSquare = new ProblemModel();
    maximalSquare.id = 1594;
    maximalSquare.title = '最大正方形';
    maximalSquare.description = '在一个由 \'0\' 和 \'1\' 组成的二维矩阵内，找到只包含 \'1\' 的最大正方形，并返回其面积。';
    maximalSquare.difficulty = ProblemDifficulty.MEDIUM;
    maximalSquare.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maximalSquare.choices = [
      { id: 'A', text: '动态规划，dp[i][j]表示以(i,j)为右下角的最大正方形边长', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的正方形，检查是否全为1', isCorrect: false },
      { id: 'C', text: '预处理每行的连续1的长度，再对每列寻找最大正方形', isCorrect: false },
      { id: 'D', text: 'BFS，从每个1开始向外扩展，寻找最大正方形', isCorrect: false }
    ];
    maximalSquare.explanation = '动态规划解法：①若矩阵为空：return 0；②初始化dp矩阵与原矩阵同大小，最大边长maxLen=0；③第一行和第一列的dp值等于原矩阵值（只能形成1x1正方形）；④遍历其他单元格：若matrix[i][j] == \'1\'：dp[i][j] = Math.min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1；更新maxLen；⑤返回maxLen²。时间复杂度O(m×n)，空间复杂度O(m×n)（可优化为O(n)），通过子问题的解构建更大的正方形。';
    maximalSquare.hint = '核心是「状态转移方程」，当前最大正方形边长受左上、上、左三个方向的最小值限制';
    problems.push(maximalSquare);

    // 1595. 从前序遍历构造二叉搜索树（LeetCode 1008）
    const bstFromPreorder = new ProblemModel();
    bstFromPreorder.id = 1595;
    bstFromPreorder.title = '从前序遍历构造二叉搜索树';
    bstFromPreorder.description = '给定一个整数数组，它表示BST(即 二叉搜索树 )的 先序遍历 ，构造树并返回其根。保证 对于给定的测试用例，总能构造出满足要求的 BST。二叉搜索树是一棵二叉树，其中每个节点， Node.left 的任何后代的值 严格小于 Node.val ， Node.right 的任何后代的值 严格大于 Node.val。先序遍历是遍历方式之一，它遵循 根-左-右 的访问顺序。';
    bstFromPreorder.difficulty = ProblemDifficulty.MEDIUM;
    bstFromPreorder.category = ProblemCategory.BINARY_TREE;
    bstFromPreorder.choices = [
      { id: 'A', text: '递归，根为第一个元素，划分左右子树的元素范围', isCorrect: true },
      { id: 'B', text: '迭代，使用栈记录节点，根据BST特性确定左右孩子', isCorrect: false },
      { id: 'C', text: '先排序得到中序遍历，再用前序+中序构造BST', isCorrect: false },
      { id: 'D', text: '构建链表后转换为BST结构', isCorrect: false }
    ];
    bstFromPreorder.explanation = '递归解法：①若preorder为空：return null；②根节点值val = preorder[0]；找到第一个大于val的索引index（左子树元素均小于val，右子树均大于val）；③左子树前序：preorder.slice(1, index)；右子树前序：preorder.slice(index)；④构造根节点，root.left = bstFromPreorder(左子树前序)；root.right = bstFromPreorder(右子树前序)；⑤返回root。时间复杂度O(n²)（最坏情况二叉树为链状），空间复杂度O(n)（递归栈），利用BST的特性直接从前序遍历构建，无需中序遍历。';
    bstFromPreorder.hint = '关键是「BST的前序特性」，根节点后先出现所有左子树元素（小于根），再出现右子树元素（大于根）';
    problems.push(bstFromPreorder);
    // 1596. 最长重复子数组（LeetCode 718）
    const findLength = new ProblemModel();
    findLength.id = 1596;
    findLength.title = '最长重复子数组';
    findLength.description = '给两个整数数组 nums1 和 nums2 ，返回 两个数组中 公共的 、长度最长的子数组的长度 。子数组是指数组中连续的元素序列。';
    findLength.difficulty = ProblemDifficulty.MEDIUM;
    findLength.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    findLength.choices = [
      { id: 'A', text: '动态规划，dp[i][j]表示以nums1[i-1]和nums2[j-1]结尾的最长公共子数组长度', isCorrect: true },
      { id: 'B', text: '滑动窗口，将两个数组对齐后滑动，计算重叠部分的最长连续匹配', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子数组，比较是否相同并记录最长长度', isCorrect: false },
      { id: 'D', text: '二分查找+哈希，二分长度并用哈希检查是否存在该长度的公共子数组', isCorrect: false }
    ];
    findLength.explanation = '动态规划解法：①初始化dp二维数组，dp[i][j]表示nums1前i个元素与nums2前j个元素的最长公共子数组长度；②遍历i从1到nums1.length，j从1到nums2.length：若nums1[i-1] == nums2[j-1]：dp[i][j] = dp[i-1][j-1] + 1；否则dp[i][j] = 0；③记录最大的dp[i][j]值；④返回最大值。时间复杂度O(m×n)（m、n为两数组长度），空间复杂度O(m×n)（可优化为O(n)），直接通过子问题求解最长连续匹配。';
    findLength.hint = '关键是「连续子数组的特性」，只有当前元素相等时才能延续之前的公共子数组';
    problems.push(findLength);

    // 1599. 最大数（LeetCode 179）
    const largestNumber = new ProblemModel();
    largestNumber.id = 1599;
    largestNumber.title = '最大数';
    largestNumber.description = '给定一组非负整数 nums，重新排列每个数的顺序（每个数不可拆分）使之组成一个最大的整数。注意：输出结果可能非常大，所以你需要返回一个字符串而不是整数。';
    largestNumber.difficulty = ProblemDifficulty.MEDIUM;
    largestNumber.category = ProblemCategory.SORT;
    largestNumber.choices = [
      { id: 'A', text: '自定义排序，比较两个数字拼接的两种方式（a+b与b+a）', isCorrect: true },
      { id: 'B', text: '按数字的最高位排序，高位大的放前面', isCorrect: false },
      { id: 'C', text: '转换为字符串后按字典序降序排列', isCorrect: false },
      { id: 'D', text: '动态规划，逐步构建最大数', isCorrect: false }
    ];
    largestNumber.explanation = '自定义排序解法：①将nums转换为字符串数组；②自定义比较函数：a + b > b + a 则a应排在b前面；③使用该比较函数对字符串数组排序；④拼接排序后的数组；⑤若结果以"0"开头（全零情况）：返回"0"；否则返回拼接结果。时间复杂度O(n log n)（排序耗时），空间复杂度O(n)，通过自定义比较规则确保拼接出最大数。';
    largestNumber.hint = '核心是「比较拼接结果」，两个数字的最优排列方式由它们不同拼接顺序的结果决定';
    problems.push(largestNumber);



    // 1602. 旋转图像（LeetCode 48）
    const rotate = new ProblemModel();
    rotate.id = 1602;
    rotate.title = '旋转图像';
    rotate.description = '给定一个 n × n 的二维矩阵 matrix 表示一个图像。请你将图像顺时针旋转 90 度。你必须在 原地 旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要 使用另一个矩阵来旋转图像。';
    rotate.difficulty = ProblemDifficulty.MEDIUM;
    rotate.category = ProblemCategory.ARRAY;
    rotate.choices = [
      { id: 'A', text: '先转置矩阵，再反转每一行', isCorrect: true },
      { id: 'B', text: '先反转每一行，再转置矩阵', isCorrect: false },
      { id: 'C', text: '逐层旋转，交换四个对应位置的元素', isCorrect: false },
      { id: 'D', text: '使用辅助数组存储旋转后的结果，再复制回原数组', isCorrect: false }
    ];
    rotate.explanation = '转置+反转解法：①转置矩阵：遍历矩阵，交换matrix[i][j]与matrix[j][i]（i < j）；②反转每一行：遍历每一行，反转元素顺序；③操作后矩阵已顺时针旋转90度。时间复杂度O(n²)，空间复杂度O(1)，原地操作满足题目要求，比逐层旋转更简洁。';
    rotate.hint = '关键是「分解旋转操作」，转置+行反转的组合等价于顺时针旋转90度';
    problems.push(rotate);


    // 1604. 不同路径（LeetCode 62）
    const uniquePaths = new ProblemModel();
    uniquePaths.id = 1604;
    uniquePaths.title = '不同路径';
    uniquePaths.description = '一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish”）。问总共有多少条不同的路径？';
    uniquePaths.difficulty = ProblemDifficulty.MEDIUM;
    uniquePaths.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    uniquePaths.choices = [
      { id: 'A', text: '动态规划，dp[i][j] = dp[i-1][j] + dp[i][j-1]', isCorrect: true },
      { id: 'B', text: '组合数学，计算从(m+n-2)步中选(m-1)步向下的组合数', isCorrect: false },
      { id: 'C', text: '递归+记忆化，缓存子问题的解', isCorrect: false },
      { id: 'D', text: 'BFS，遍历所有可能的路径', isCorrect: false }
    ];
    uniquePaths.explanation = '动态规划解法：①初始化dp二维数组，dp[i][j]表示到达(i,j)的路径数；②第一行和第一列均为1（只有一种走法）；③遍历其他单元格：dp[i][j] = dp[i-1][j]（从上方来） + dp[i][j-1]（从左方来）；④返回dp[m-1][n-1]。空间优化：使用一维数组，dp[j] = dp[j] + dp[j-1]。时间复杂度O(m×n)，空间复杂度O(min(m,n))，高效计算路径数量。';
    uniquePaths.hint = '关键是「状态转移方程」，到达当前格子的路径数是到达上方和左方格子的路径数之和';
    problems.push(uniquePaths);

    // 1605. 岛屿数量（LeetCode 200）
    const numIslands = new ProblemModel();
    numIslands.id = 1605;
    numIslands.title = '岛屿数量';
    numIslands.description = '给你一个由 \'1\'（陆地）和 \'0\'（水）组成的的二维网格，请你计算网格中岛屿的数量。岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。此外，你可以假设该网格的四条边均被水包围。';
    numIslands.difficulty = ProblemDifficulty.MEDIUM;
    numIslands.category = ProblemCategory.GRAPH;
    numIslands.choices = [
      { id: 'A', text: 'DFS，遇到陆地则递归标记所有相连的陆地为水，计数加1', isCorrect: true },
      { id: 'B', text: 'BFS，遇到陆地则用队列标记所有相连的陆地为水，计数加1', isCorrect: false },
      { id: 'C', text: '并查集，将相邻陆地合并为同一集合，统计集合数量', isCorrect: false },
      { id: 'D', text: '遍历网格，遇到陆地则计数加1，同时标记所有相连陆地', isCorrect: false }
    ];
    numIslands.explanation = 'DFS解法：①初始化岛屿数量count=0；②遍历网格每个单元格(i,j)：若grid[i][j] == \'1\'：count++；调用DFS标记所有相连的\'1\'为\'0\'（避免重复计数）；③DFS函数：若i、j越界或grid[i][j] != \'1\'：return；标记grid[i][j] = \'0\'；递归访问上下左右四个方向；④返回count。时间复杂度O(m×n)，空间复杂度O(m×n)（最坏情况全是陆地，递归栈深度），通过淹没陆地的方式高效计数。';
    numIslands.hint = '核心是「淹没岛屿」，每发现一个未访问的陆地，就将其及相连陆地标记为水，确保每个岛屿只计数一次';
    problems.push(numIslands);

    // 1606. 打家劫舍 III（LeetCode 337）
    const robIII = new ProblemModel();
    robIII.id = 1606;
    robIII.title = '打家劫舍 III';
    robIII.description = '小偷又发现了一个新的可行窃的地区。这个地区只有一个入口，我们称之为 root 。除了 root 之外，每栋房子有且只有一个“父“房子与之相连。一番侦察之后，聪明的小偷意识到“这个地方的所有房屋的排列类似于一棵二叉树”。 如果 两个直接相连的房子在同一天晚上被打劫 ，房屋将自动报警。给定二叉树的 root 。返回 在不触动警报的情况下 ，小偷能够盗取的最高金额 。';
    robIII.difficulty = ProblemDifficulty.MEDIUM;
    robIII.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    robIII.choices = [
      { id: 'A', text: '后序遍历+动态规划，每个节点返回偷与不偷的最大金额', isCorrect: true },
      { id: 'B', text: '递归，计算偷当前节点或不偷当前节点的最大值', isCorrect: false },
      { id: 'C', text: '层次遍历，隔层累加金额，取两层和的最大值', isCorrect: false },
      { id: 'D', text: '将二叉树转为数组，应用打家劫舍I的解法', isCorrect: false }
    ];
    robIII.explanation = '后序DP解法：①定义递归函数，返回一个数组[notRob, rob]，分别表示不偷/偷当前节点的最大金额；②若节点为null：return [0, 0]；③递归左子树left = dfs(node.left)；递归右子树right = dfs(node.right)；④不偷当前节点：notRob = Math.max(left[0], left[1]) + Math.max(right[0], right[1])；⑤偷当前节点：rob = node.val + left[0] + right[0]；⑥返回[notRob, rob]；⑦根节点调用后返回两个值的最大值。时间复杂度O(n)，空间复杂度O(h)，通过后序遍历计算每个节点的最优解。';
    robIII.hint = '关键是「每个节点的两种状态」，偷或不偷，状态转移依赖于子节点的状态';
    problems.push(robIII);

    // 1607. 零钱兑换 II（LeetCode 518）
    const change = new ProblemModel();
    change.id = 1607;
    change.title = '零钱兑换 II';
    change.description = '给你一个整数数组 coins 表示不同面额的硬币，另给一个整数 amount 表示总金额。请你计算并返回可以凑成总金额的硬币组合数。如果任何硬币组合都无法凑出总金额，返回 0 。假设每一种面额的硬币有无限个。 题目数据保证结果符合 32 位带符号整数。';
    change.difficulty = ProblemDifficulty.MEDIUM;
    change.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    change.choices = [
      { id: 'A', text: '动态规划，外层遍历硬币，内层遍历金额，累加组合数', isCorrect: true },
      { id: 'B', text: '动态规划，外层遍历金额，内层遍历硬币', isCorrect: false },
      { id: 'C', text: '递归+记忆化，计算使用或不使用当前硬币的组合数', isCorrect: false },
      { id: 'D', text: '数学公式计算组合数', isCorrect: false }
    ];
    change.explanation = '动态规划解法：①初始化dp数组，dp[0] = 1（金额0有一种组合方式）；②遍历每个硬币coin：遍历金额i从coin到amount：dp[i] += dp[i - coin]；③返回dp[amount]。时间复杂度O(amount×k)（k为硬币种类），空间复杂度O(amount)，外层遍历硬币确保组合不重复（如[1,2]和[2,1]视为同一种组合）。';
    change.hint = '核心是「控制遍历顺序」，先遍历硬币再遍历金额，避免不同顺序的同一组合被重复计数';
    problems.push(change);

    // 1608. 合并区间（LeetCode 56）
    const merge = new ProblemModel();
    merge.id = 1608;
    merge.title = '合并区间';
    merge.description = '以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回 一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间 。';
    merge.difficulty = ProblemDifficulty.MEDIUM;
    merge.category = ProblemCategory.SORT;
    merge.choices = [
      { id: 'A', text: '先按区间起始位置排序，再遍历合并重叠区间', isCorrect: true },
      { id: 'B', text: '按区间结束位置排序，再从后往前合并', isCorrect: false },
      { id: 'C', text: '暴力检查所有区间对，合并重叠的', isCorrect: false },
      { id: 'D', text: '使用哈希表记录区间范围，再提取合并后的区间', isCorrect: false }
    ];
    merge.explanation = '排序合并解法：①若intervals为空：return []；②按区间starti排序；③初始化结果数组，加入第一个区间；④遍历剩余区间：获取结果中最后一个区间last；若当前区间starti <= last.end：合并为[last.start, max(last.end, 当前end)]；else：直接加入结果；⑤返回结果。时间复杂度O(n log n)（排序耗时），空间复杂度O(log n)（排序所需栈空间），高效合并所有重叠区间。';
    merge.hint = '关键是「先排序」，使重叠区间相邻，便于一次遍历完成合并';
    problems.push(merge);

    // 1609. 子集 II（LeetCode 90）
    const subsetsWithDup = new ProblemModel();
    subsetsWithDup.id = 1609;
    subsetsWithDup.title = '子集 II';
    subsetsWithDup.description = '给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。';
    subsetsWithDup.difficulty = ProblemDifficulty.MEDIUM;
    subsetsWithDup.category = ProblemCategory.BACKTRACKING;
    subsetsWithDup.choices = [
      { id: 'A', text: '回溯法，排序数组后跳过重复元素，相同元素只在第一个未使用时加入', isCorrect: true },
      { id: 'B', text: '普通回溯生成所有子集后用Set去重', isCorrect: false },
      { id: 'C', text: '基于子集I的解法，对每个新元素只添加到不包含它的子集', isCorrect: false },
      { id: 'D', text: '二进制位运算，过滤掉包含重复元素的子集', isCorrect: false }
    ];
    subsetsWithDup.explanation = '回溯解法：①排序nums数组（使重复元素相邻）；②初始化结果数组和路径数组；③定义回溯函数backtrack(start)：将路径加入结果；遍历i从start到nums.length-1：若i>start且nums[i]==nums[i-1]：跳过（去重）；路径加入nums[i]；backtrack(i+1)；路径弹出；④调用backtrack(0)，返回结果。时间复杂度O(n×2^n)，空间复杂度O(n)，通过排序和条件判断高效去重，避免生成重复子集。';
    subsetsWithDup.hint = '核心是「排序+跳过重复元素」，确保相同元素只在第一次出现时被考虑';
    problems.push(subsetsWithDup);

    // 1610. 目标和（LeetCode 494）
    const findTargetSumWays = new ProblemModel();
    findTargetSumWays.id = 1610;
    findTargetSumWays.title = '目标和';
    findTargetSumWays.description = '给你一个整数数组 nums 和一个整数 target 。向数组中的每个整数前添加 \'+\' 或 \'-\' ，然后串联起所有整数，可以构造一个 表达式 。例如，nums = [2, 1] ，可以在 2 前添加 \'+\' ，在 1 前添加 \'-\' ，得到表达式 "+2-1" 。返回可以通过上述方法构造的、运算结果等于 target 的不同 表达式 的数目。';
    findTargetSumWays.difficulty = ProblemDifficulty.MEDIUM;
    findTargetSumWays.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    findTargetSumWays.choices = [
      { id: 'A', text: '动态规划，转换为子集和问题：找到和为(sum+target)/2的子集数量', isCorrect: true },
      { id: 'B', text: '递归+记忆化，记录当前索引和当前和的组合数', isCorrect: false },
      { id: 'C', text: 'BFS，逐层计算所有可能的和及数量', isCorrect: false },
      { id: 'D', text: '暴力枚举所有可能的符号组合，计算结果是否为target', isCorrect: false }
    ];
    findTargetSumWays.explanation = 'DP子集和解法：①计算数组总和sum；若sum < |target|或(sum+target)为奇数：return 0；②目标子集和targetSum = (sum + target) / 2；③初始化dp数组，dp[0] = 1；④遍历每个数字num：遍历j从targetSum到num：dp[j] += dp[j - num]；⑤返回dp[targetSum]。原理：设正数和为x，负数和为-sum+x，x - (sum - x) = target → x = (sum+target)/2。时间复杂度O(n×targetSum)，空间复杂度O(targetSum)，将问题转化为更易解的子集和问题。';
    findTargetSumWays.hint = '关键是「问题转换」，通过数学推导将目标和问题转化为子集和计数问题';
    problems.push(findTargetSumWays);

    // 1611. 滑动窗口最大值（LeetCode 239）
    const maxSlidingWindow = new ProblemModel();
    maxSlidingWindow.id = 1611;
    maxSlidingWindow.title = '滑动窗口最大值';
    maxSlidingWindow.description = '给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。返回 滑动窗口中的最大值 。';
    maxSlidingWindow.difficulty = ProblemDifficulty.HARD;
    maxSlidingWindow.category = ProblemCategory.QUEUE;
    maxSlidingWindow.choices = [
      { id: 'A', text: '单调队列，维护队列中元素递减，队首为当前窗口最大值', isCorrect: true },
      { id: 'B', text: '暴力法，每个窗口计算最大值', isCorrect: false },
      { id: 'C', text: '优先队列（最大堆），每次取堆顶元素', isCorrect: false },
      { id: 'D', text: '分块预处理，计算块内最大值和前缀/后缀最大值', isCorrect: false }
    ];
    maxSlidingWindow.explanation = '单调队列解法：①初始化双端队列deque（存储索引）和结果数组；②遍历数组每个元素i：③若队列不为空且队首索引 <= i - k：出队（移除窗口外元素）；④若队列不为空且nums[i] >= nums[队尾]：队尾出队（维护递减队列）；⑤当前索引i入队；⑥若i >= k - 1：队首元素为当前窗口最大值，加入结果；⑦返回结果。时间复杂度O(n)（每个元素入队出队各一次），空间复杂度O(k)，高效计算每个窗口的最大值。';
    maxSlidingWindow.hint = '核心是「维护单调递减队列」，确保队列中始终是窗口内可能成为最大值的元素';
    problems.push(maxSlidingWindow);

    // 1612. 最长递增子序列（LeetCode 300）
    const lengthOfLIS = new ProblemModel();
    lengthOfLIS.id = 1612;
    lengthOfLIS.title = '最长递增子序列';
    lengthOfLIS.description = '给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。子序列 是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。';
    lengthOfLIS.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLIS.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    lengthOfLIS.choices = [
      { id: 'A', text: '贪心+二分查找，维护一个递增序列，替换元素使序列尽可能小', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i]表示以nums[i]结尾的最长递增子序列长度', isCorrect: false },
      { id: 'C', text: '递归+记忆化，计算包含或不包含当前元素的最长子序列', isCorrect: false },
      { id: 'D', text: '排序+最长公共子序列，与原数组比较', isCorrect: false }
    ];
    lengthOfLIS.explanation = '贪心+二分解法：①初始化空数组tails；②遍历每个数字num：③若num > tails最后一个元素：加入tails；④else：二分查找tails中第一个 >= num的位置，替换为num；⑤tails的长度即为最长递增子序列的长度。时间复杂度O(n log n)，空间复杂度O(n)，比动态规划的O(n²)更高效，尤其适合大数据量。';
    lengthOfLIS.hint = '关键是「维护潜在的最长序列」，通过替换操作保留更多增长可能性';
    problems.push(lengthOfLIS);

    // 1613. 二叉树的直径（LeetCode 543）
    const diameterOfBinaryTree = new ProblemModel();
    diameterOfBinaryTree.id = 1613;
    diameterOfBinaryTree.title = '二叉树的直径';
    diameterOfBinaryTree.description = '给定一棵二叉树，你需要计算它的直径长度。一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过也可能不穿过根结点。';
    diameterOfBinaryTree.difficulty = ProblemDifficulty.EASY;
    diameterOfBinaryTree.category = ProblemCategory.BINARY_TREE;
    diameterOfBinaryTree.choices = [
      { id: 'A', text: '后序遍历，计算每个节点的左右子树深度和，记录最大值', isCorrect: true },
      { id: 'B', text: '层次遍历，计算每个节点的左右深度', isCorrect: false },
      { id: 'C', text: '先计算每个节点到根的距离，再找任意两点的最大距离', isCorrect: false },
      { id: 'D', text: '递归计算左子树直径、右子树直径和穿过根的直径', isCorrect: false }
    ];
    diameterOfBinaryTree.explanation = '后序遍历解法：①初始化最大直径maxDiameter=0；②定义深度函数depth(node)：若node为null：return 0；左深度left = depth(node.left)；右深度right = depth(node.right)；③更新maxDiameter = Math.max(maxDiameter, left + right)；④返回1 + Math.max(left, right)；⑤调用depth(root)，返回maxDiameter。时间复杂度O(n)，空间复杂度O(h)，在计算深度的同时更新最大直径，一次遍历完成。';
    diameterOfBinaryTree.hint = '核心是「直径=左右子树深度之和」，对每个节点计算并更新最大值';
    problems.push(diameterOfBinaryTree);

    // 1614. 用栈实现队列（LeetCode 232）
    const MyQueue = new ProblemModel();
    MyQueue.id = 1614;
    MyQueue.title = '用栈实现队列';
    MyQueue.description = '请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）：实现 MyQueue 类：void push(int x) 将元素 x 推到队列的末尾；int pop() 从队列的开头移除并返回元素；int peek() 返回队列开头的元素；boolean empty() 如果队列为空，返回 true ，否则返回 false 。说明：你 只能 使用标准的栈操作 —— 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。你所使用的语言也许不支持栈。你可以使用 list 或 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。';
    MyQueue.difficulty = ProblemDifficulty.EASY;
    MyQueue.category = ProblemCategory.STACK;
    MyQueue.choices = [
      { id: 'A', text: '两个栈，一个输入栈一个输出栈，需要时将输入栈元素转移到输出栈', isCorrect: true },
      { id: 'B', text: '单个栈，每次push时将所有元素弹出再压回', isCorrect: false },
      { id: 'C', text: '两个栈，每次操作都保持一个栈为空', isCorrect: false },
      { id: 'D', text: '使用栈的底层数据结构直接实现队列操作', isCorrect: false }
    ];
    MyQueue.explanation = '双栈解法：①初始化两个栈inStack和outStack；②push操作：元素压入inStack；③pop操作：若outStack为空，将inStack所有元素弹出并压入outStack；outStack弹出栈顶元素；④peek操作：类似pop，但不弹出元素；⑤empty操作：判断两个栈是否都为空。时间复杂度：push和empty为O(1)，pop和peek均摊O(1)；空间复杂度O(n)，符合栈的标准操作限制。';
    MyQueue.hint = '关键是「栈的反转特性」，两个栈配合使用可实现队列的先进先出';
    problems.push(MyQueue);

    // 1615. 用队列实现栈（LeetCode 225）
    const MyStack = new ProblemModel();
    MyStack.id = 1615;
    MyStack.title = '用队列实现栈';
    MyStack.description = '请你仅使用两个队列实现一个后入先出（LIFO）的栈，并支持普通栈的全部四种操作（push、top、pop 和 empty）。实现 MyStack 类：void push(int x) 将元素 x 压入栈顶。int pop() 移除并返回栈顶元素。int top() 返回栈顶元素。boolean empty() 如果栈是空的，返回 true ；否则，返回 false 。注意：你只能使用队列的基本操作 —— 也就是 push to back、peek/pop from front、size 和 is empty 这些操作。你所使用的语言也许不支持队列。你可以使用 list （列表）或者 deque（双端队列）来模拟一个队列 , 只要是标准的队列操作即可。';
    MyStack.difficulty = ProblemDifficulty.EASY;
    MyStack.category = ProblemCategory.QUEUE;
    MyStack.choices = [
      { id: 'A', text: '两个队列，push到非空队列，pop时将n-1个元素移到另一个队列', isCorrect: true },
      { id: 'B', text: '单个队列，push后将前n-1个元素移到队尾', isCorrect: false },
      { id: 'C', text: '两个队列，始终保持一个为空，交替转移元素', isCorrect: false },
      { id: 'D', text: '使用队列的底层数据结构直接实现栈操作', isCorrect: false }
    ];
    MyStack.explanation = '双队列解法：①初始化两个队列q1和q2；②push操作：将元素加入非空队列（若都为空则加入q1）；③pop操作：将非空队列的前size-1个元素移到另一个队列；弹出剩余的一个元素（栈顶）；④top操作：类似pop，但不移除元素，而是记录后放回；⑤empty操作：判断两个队列是否都为空。时间复杂度：push为O(1)，pop和top为O(n)；空间复杂度O(n)，符合队列的标准操作限制。';
    MyStack.hint = '核心是「队列的先进先出特性」，通过转移元素使队尾元素能被优先取出';
    problems.push(MyStack);

    // 1616. 字符串相加（LeetCode 415）
    const addStrings = new ProblemModel();
    addStrings.id = 1616;
    addStrings.title = '字符串相加';
    addStrings.description = '给定两个字符串形式的非负整数 num1 和 num2 ，计算它们的和并同样以字符串形式返回。你不能使用任何内建的用于处理大整数的库（比如 BigInteger）， 也不能直接将输入的字符串转换为整数形式。';
    addStrings.difficulty = ProblemDifficulty.EASY;
    addStrings.category = ProblemCategory.STRING;
    addStrings.choices = [
      { id: 'A', text: '双指针从末尾开始，模拟手动加法，处理进位', isCorrect: true },
      { id: 'B', text: '将字符串转换为字符数组，反转后逐位相加', isCorrect: false },
      { id: 'C', text: '使用BigInt类型转换后相加，再转回字符串', isCorrect: false },
      { id: 'D', text: '按位计算ASCII码差值，累加后转换为字符串', isCorrect: false }
    ];
    addStrings.explanation = '双指针解法：①初始化指针i = num1.length-1，j = num2.length-1，进位carry=0，结果数组；②循环当i>=0或j>=0或carry>0：获取num1[i]的数值a（i>=0则为num1.charCodeAt(i)-48，否则0）；获取num2[j]的数值b（同理）；③当前和sum = a + b + carry；carry = Math.floor(sum / 10)；当前位sum % 10加入结果数组；④i--，j--；⑤反转结果数组并拼接为字符串返回。时间复杂度O(max(m,n))，空间复杂度O(max(m,n)+1)，模拟人工加法过程，处理大整数相加。';
    addStrings.hint = '关键是「模拟手动加法」，从低位到高位逐位相加，处理进位和不同长度的情况';
    problems.push(addStrings);

    // 1617. 两数相加 II（LeetCode 445）
    const addTwoNumbersII = new ProblemModel();
    addTwoNumbersII.id = 1617;
    addTwoNumbersII.title = '两数相加 II';
    addTwoNumbersII.description = '给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。你可以假设除了数字 0 之外，这两个数字都不会以零开头。';
    addTwoNumbersII.difficulty = ProblemDifficulty.MEDIUM;
    addTwoNumbersII.category = ProblemCategory.LINKED_LIST;
    addTwoNumbersII.choices = [
      { id: 'A', text: '使用栈存储两个链表的节点值，出栈时相加，构建结果链表', isCorrect: true },
      { id: 'B', text: '反转两个链表，相加后再反转结果', isCorrect: false },
      { id: 'C', text: '计算两个链表的数值后相加，再构建结果链表', isCorrect: false },
      { id: 'D', text: '递归到链表末尾，从后往前相加', isCorrect: false }
    ];
    addTwoNumbersII.explanation = '栈解法：①创建两个栈s1和s2；②遍历l1，节点值入s1；遍历l2，节点值入s2；③初始化进位carry=0，结果链表头null；④循环当s1不为空或s2不为空或carry>0：弹出s1值a（为空则0）；弹出s2值b（为空则0）；sum = a + b + carry；carry = Math.floor(sum / 10)；⑤创建新节点sum % 10，插入结果链表头部；⑥返回结果链表。时间复杂度O(m+n)，空间复杂度O(m+n)，无需修改原链表结构，通过栈实现从低位到高位相加。';
    addTwoNumbersII.hint = '核心是「栈的后进先出特性」，使链表尾部（低位）的数字能先被处理';
    problems.push(addTwoNumbersII);

    // 1618. 字符串相乘（LeetCode 43）
    const multiply = new ProblemModel();
    multiply.id = 1618;
    multiply.title = '字符串相乘';
    multiply.description = '给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。注意：不能使用任何内置的 BigInteger 库或直接将输入转换为整数。';
    multiply.difficulty = ProblemDifficulty.MEDIUM;
    multiply.category = ProblemCategory.STRING;
    multiply.choices = [
      { id: 'A', text: '模拟乘法过程，使用数组存储每位乘积，处理进位', isCorrect: true },
      { id: 'B', text: '将其中一个数转换为整数，逐位相乘另一个字符串', isCorrect: false },
      { id: 'C', text: '使用Karatsuba算法优化大整数乘法', isCorrect: false },
      { id: 'D', text: '递归分治，将大数分解为小数相乘', isCorrect: false }
    ];
    multiply.explanation = '模拟乘法解法：①若num1或num2为"0"：return "0"；②初始化结果数组res，长度为两数长度和；③遍历num1从后往前i：遍历num2从后往前j：计算乘积mul = (num1[i]-"0") * (num2[j]-"0")；p1 = i + j，p2 = i + j + 1；总和sum = mul + res[p2]；res[p2] = sum % 10；res[p1] += Math.floor(sum / 10)；④将res数组转换为字符串，跳过前导0；⑤返回结果。时间复杂度O(m×n)，空间复杂度O(m+n)，完全模拟手工乘法过程，处理大整数相乘。';
    multiply.hint = '关键是「乘积的位置对应」，num1[i]与num2[j]的乘积影响结果的i+j+1和i+j位';
    problems.push(multiply);

    // 1619. 路径总和 III（LeetCode 437）
    const pathSumIII = new ProblemModel();
    pathSumIII.id = 1619;
    pathSumIII.title = '路径总和 III';
    pathSumIII.description = '给定一个二叉树的根节点 root ，和一个整数 targetSum ，求该二叉树里节点值之和等于 targetSum 的 路径 的数目。路径 不需要从根节点开始，也不需要在叶子节点结束，但是路径方向必须是向下的（只能从父节点到子节点）。';
    pathSumIII.difficulty = ProblemDifficulty.MEDIUM;
    pathSumIII.category = ProblemCategory.BINARY_TREE;
    pathSumIII.choices = [
      { id: 'A', text: '前缀和+哈希表，记录路径上的前缀和出现次数，计算符合条件的路径', isCorrect: true },
      { id: 'B', text: '递归，对每个节点计算以其为起点的路径和', isCorrect: false },
      { id: 'C', text: 'BFS，记录每个节点的所有前缀和', isCorrect: false },
      { id: 'D', text: '动态规划，记录到达每个节点的所有可能路径和', isCorrect: false }
    ];
    pathSumIII.explanation = '前缀和解法：①初始化哈希表map，记录前缀和出现次数，map.set(0, 1)；②定义递归函数dfs(node, currentSum)：若node为null：return 0；currentSum += node.val；③目标前缀和target = currentSum - targetSum；结果count += map.get(target) || 0；④map.set(currentSum, (map.get(currentSum) || 0) + 1)；⑤递归左子树和右子树，累加结果；⑥回溯：map.set(currentSum, map.get(currentSum) - 1)；⑦返回count；⑧调用dfs(root, 0)，返回结果。时间复杂度O(n)，空间复杂度O(h)，通过前缀和高效计算任意路径和。';
    pathSumIII.hint = '核心是「前缀和的差值」，若currentSum - targetSum存在于前缀和中，则存在对应路径';
    problems.push(pathSumIII);

    // 1620. 三数之和（LeetCode 15）
    const threeSum = new ProblemModel();
    threeSum.id = 1620;
    threeSum.title = '三数之和';
    threeSum.description = '给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。注意：答案中不可以包含重复的三元组。';
    threeSum.difficulty = ProblemDifficulty.MEDIUM;
    threeSum.category = ProblemCategory.ARRAY;
    threeSum.choices = [
      { id: 'A', text: '排序+双指针，固定第一个数，左右指针找另外两个数，跳过重复元素', isCorrect: true },
      { id: 'B', text: '哈希表，固定前两个数，查找第三个数', isCorrect: false },
      { id: 'C', text: '暴力三重循环，检查所有可能的三元组', isCorrect: false },
      { id: 'D', text: '先计算两数之和，再查找第三个数', isCorrect: false }
    ];
    threeSum.explanation = '排序+双指针解法：①排序nums数组；②初始化结果数组；③遍历i从0到nums.length-3：若nums[i] > 0：break（三数和不可能为0）；若i>0且nums[i]==nums[i-1]：continue（去重）；④左指针left = i+1，右指针right = nums.length-1；⑤循环当left < right：sum = nums[i] + nums[left] + nums[right]；若sum == 0：加入结果；跳过left和right的重复元素；left++，right--；若sum < 0：left++；else：right--；⑥返回结果。时间复杂度O(n²)，空间复杂度O(log n)（排序所需），通过排序和双指针优化，高效去重。';
    threeSum.hint = '关键是「排序+去重」，固定一个数后用双指针寻找另外两个数，避免重复三元组';
    problems.push(threeSum);

    // 1622. 移除链表元素（LeetCode 203）
    const removeElements = new ProblemModel();
    removeElements.id = 1622;
    removeElements.title = '移除链表元素';
    removeElements.description = '给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。';
    removeElements.difficulty = ProblemDifficulty.EASY;
    removeElements.category = ProblemCategory.LINKED_LIST;
    removeElements.choices = [
      { id: 'A', text: '使用虚拟头节点，遍历链表删除符合条件的节点', isCorrect: true },
      { id: 'B', text: '递归，若当前节点值为val则返回子问题结果，否则连接后返回', isCorrect: false },
      { id: 'C', text: '先处理头节点，再遍历删除其他节点', isCorrect: false },
      { id: 'D', text: '转换为数组处理后重建链表', isCorrect: false }
    ];
    removeElements.explanation = '虚拟头节点解法：①创建虚拟头节点dummy，dummy.next = head；②当前指针curr = dummy；③循环当curr.next不为null：若curr.next.val == val：curr.next = curr.next.next（删除节点）；else：curr = curr.next；④返回dummy.next。时间复杂度O(n)，空间复杂度O(1)，通过虚拟头节点统一处理头节点和其他节点的删除逻辑，避免特殊处理。';
    removeElements.hint = '关键是「虚拟头节点」，解决删除头节点时的特殊情况，使代码更简洁';
    problems.push(removeElements);

    // 1623. 反转链表 II（LeetCode 92）
    const reverseBetween = new ProblemModel();
    reverseBetween.id = 1623;
    reverseBetween.title = '反转链表 II';
    reverseBetween.description = '给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回 反转后的链表 。';
    reverseBetween.difficulty = ProblemDifficulty.MEDIUM;
    reverseBetween.category = ProblemCategory.LINKED_LIST;
    reverseBetween.choices = [
      { id: 'A', text: '找到反转起始点，反转left到right的节点，再连接前后部分', isCorrect: true },
      { id: 'B', text: '将链表分为三部分，反转中间部分后重新连接', isCorrect: false },
      { id: 'C', text: '先反转整个链表，再反转两边不需要反转的部分', isCorrect: false },
      { id: 'D', text: '转换为数组，反转对应区间后重建链表', isCorrect: false }
    ];
    reverseBetween.explanation = '局部反转解法：①创建虚拟头节点dummy，dummy.next = head；②前驱节点prev = dummy；③移动prev到left前一个节点（循环left-1次）；④反转起始节点start = prev.next；⑤当前节点curr = start.next；⑥循环right-left次：start.next = curr.next；curr.next = prev.next；prev.next = curr；curr = start.next；⑦返回dummy.next。时间复杂度O(n)，空间复杂度O(1)，只反转指定区间的节点，高效且原地操作。';
    reverseBetween.hint = '核心是「局部反转技巧」，通过调整指针实现指定区间的反转，连接前后未反转部分';
    problems.push(reverseBetween);

    // 1624. 环形链表（LeetCode 141）
    const hasCycle = new ProblemModel();
    hasCycle.id = 1624;
    hasCycle.title = '环形链表';
    hasCycle.description = '给你一个链表的头节点 head ，判断链表中是否有环。如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。注意：pos 不作为参数进行传递 。仅仅是为了标识链表的实际情况。如果链表中存在环，则返回 true 。 否则，返回 false 。';
    hasCycle.difficulty = ProblemDifficulty.EASY;
    hasCycle.category = ProblemCategory.LINKED_LIST;
    hasCycle.choices = [
      { id: 'A', text: '快慢指针，快指针每次走两步，慢指针走一步，若相遇则有环', isCorrect: true },
      { id: 'B', text: '哈希表，存储访问过的节点，若再次访问则有环', isCorrect: false },
      { id: 'C', text: '遍历链表，标记访问过的节点，若遇到标记则有环', isCorrect: false },
      { id: 'D', text: '递归遍历，检查是否回到已访问节点', isCorrect: false }
    ];
    hasCycle.explanation = '快慢指针解法：①若head为空或head.next为空：return false；②慢指针slow = head；快指针fast = head.next；③循环当slow != fast：若fast为空或fast.next为空：return false；slow = slow.next；fast = fast.next.next；④返回true。时间复杂度O(n)，空间复杂度O(1)，无需额外空间，利用速度差判断是否有环，是最优解法。';
    hasCycle.hint = '关键是「速度差」，若有环，快指针终将追上慢指针；无环则快指针先到达终点';
    problems.push(hasCycle);

    // 1625. 环形链表 II（LeetCode 142）
    const detectCycle = new ProblemModel();
    detectCycle.id = 1625;
    detectCycle.title = '环形链表 II';
    detectCycle.description = '给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。不允许修改 链表。';
    detectCycle.difficulty = ProblemDifficulty.MEDIUM;
    detectCycle.category = ProblemCategory.LINKED_LIST;
    detectCycle.choices = [
      { id: 'A', text: '快慢指针，相遇后慢指针回到头，两指针同速前进，相遇点为入环点', isCorrect: true },
      { id: 'B', text: '哈希表，存储访问过的节点，第一个重复访问的节点为入环点', isCorrect: false },
      { id: 'C', text: '遍历链表并标记，第一个遇到的标记节点为入环点', isCorrect: false },
      { id: 'D', text: '计算环的长度，再用双指针找到入环点', isCorrect: false }
    ];
    detectCycle.explanation = '快慢指针解法：①若head为空：return null；②慢指针slow = head；快指针fast = head；③循环当fast和fast.next不为空：slow = slow.next；fast = fast.next.next；若slow == fast：跳出循环；④若fast或fast.next为空：return null（无环）；⑤慢指针重置为head；⑥循环当slow != fast：slow = slow.next；fast = fast.next；⑦返回slow。时间复杂度O(n)，空间复杂度O(1)，基于数学推导：头到入环点距离=相遇点到入环点距离，无需额外空间。';
    detectCycle.hint = '核心是「数学推导」，快慢指针相遇后，慢指针从头开始，两指针同速前进将在入环点相遇';
    problems.push(detectCycle);

    // 1626. 相交链表（LeetCode 160）
    const getIntersectionNode = new ProblemModel();
    getIntersectionNode.id = 1626;
    getIntersectionNode.title = '相交链表';
    getIntersectionNode.description = '给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。图示两个链表在节点 c1 开始相交：题目数据 保证 整个链式结构中不存在环。注意，函数返回结果后，链表必须 保持其原始结构 。';
    getIntersectionNode.difficulty = ProblemDifficulty.EASY;
    getIntersectionNode.category = ProblemCategory.LINKED_LIST;
    getIntersectionNode.choices = [
      { id: 'A', text: '双指针，分别从两链表头出发，到达末尾后切换到另一链表，相遇点即为交点', isCorrect: true },
      { id: 'B', text: '计算两链表长度差，长链表指针先走差值步，再同步前进找交点', isCorrect: false },
      { id: 'C', text: '哈希表存储一个链表的节点，再遍历另一个链表查找', isCorrect: false },
      { id: 'D', text: '暴力法，逐个比较两个链表的节点', isCorrect: false }
    ];
    getIntersectionNode.explanation = '双指针解法：①指针pA = headA，pB = headB；②循环当pA != pB：pA = pA ? pA.next : headB；pB = pB ? pB.next : headA；③返回pA。原理：两指针走过的总长度相同（lenA + lenB），若有交点则会在交点相遇，否则同时到达null。时间复杂度O(m+n)，空间复杂度O(1)，无需计算长度，代码简洁高效。';
    getIntersectionNode.hint = '关键是「等长路径」，两指针分别遍历两个链表，总路程相同，确保交点处相遇';
    problems.push(getIntersectionNode);

    // 1627. 二叉搜索树中的搜索（LeetCode 700）
    const searchBST = new ProblemModel();
    searchBST.id = 1627;
    searchBST.title = '二叉搜索树中的搜索';
    searchBST.description = '给定二叉搜索树（BST）的根节点 root 和一个整数值 val。你需要在 BST 中找到节点值等于 val 的节点。返回以该节点为根的子树。如果节点不存在，则返回 null 。';
    searchBST.difficulty = ProblemDifficulty.EASY;
    searchBST.category = ProblemCategory.BINARY_TREE;
    searchBST.choices = [
      { id: 'A', text: '利用BST特性，递归搜索：val小则左子树，大则右子树', isCorrect: true },
      { id: 'B', text: '迭代法，根据BST特性循环查找', isCorrect: false },
      { id: 'C', text: '前序遍历整个树，查找目标节点', isCorrect: false },
      { id: 'D', text: '中序遍历BST得到有序数组，再二分查找', isCorrect: false }
    ];
    searchBST.explanation = '递归解法：①若root为null或root.val == val：return root；②若val < root.val：return searchBST(root.left, val)；③else：return searchBST(root.right, val)。时间复杂度O(h)（h为树高，平衡BST为O(log n)，最坏O(n)），空间复杂度O(h)（递归栈），充分利用BST左小右大的特性，无需遍历整棵树。';
    searchBST.hint = '核心是「BST的有序性」，通过与当前节点值比较确定搜索方向，减少搜索范围';
    problems.push(searchBST);


    // 1629. 删除二叉搜索树中的节点（LeetCode 450）
    const deleteNode = new ProblemModel();
    deleteNode.id = 1629;
    deleteNode.title = '删除二叉搜索树中的节点';
    deleteNode.description = '给定一个二叉搜索树的根节点 root 和一个值 key，删除二叉搜索树中的 key 对应的节点，并保证二叉搜索树的性质不变。返回二叉搜索树（有可能被更新）的根节点的引用。一般来说，删除节点可分为两个步骤：1. 首先找到需要删除的节点；2. 如果找到了，删除它。';
    deleteNode.difficulty = ProblemDifficulty.MEDIUM;
    deleteNode.category = ProblemCategory.BINARY_TREE;
    deleteNode.choices = [
      { id: 'A', text: '递归，分情况处理：无孩子、一个孩子、两个孩子（找前驱或后继替换）', isCorrect: true },
      { id: 'B', text: '迭代，找到节点后根据子节点情况处理', isCorrect: false },
      { id: 'C', text: '先转换为数组，删除元素后重建BST', isCorrect: false },
      { id: 'D', text: '标记删除，不实际移除节点', isCorrect: false }
    ];
    deleteNode.explanation = '递归解法：①若root为null：return null；②若key < root.val：root.left = deleteNode(root.left, key)；③若key > root.val：root.right = deleteNode(root.right, key)；④若key == root.val：若无左孩子：return root.right；若无右孩子：return root.left；否则：找到右子树的最小节点（后继）；root.val = 后继.val；root.right = deleteNode(root.right, 后继.val)；⑤返回root。时间复杂度O(h)，空间复杂度O(h)，正确处理三种删除情况，保持BST性质。';
    deleteNode.hint = '核心是「处理有两个孩子的节点」，用后继（右子树最小）或前驱（左子树最大）替换后删除';
    problems.push(deleteNode);

    // 1630. 实现 Trie (前缀树)（LeetCode 208）
    const Trie = new ProblemModel();
    Trie.id = 1630;
    Trie.title = '实现 Trie (前缀树)';
    Trie.description = 'Trie（发音类似 "try"）或者说 前缀树 是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。请你实现 Trie 类：Trie() 初始化前缀树对象。void insert(String word) 向前缀树中插入字符串 word 。boolean search(String word) 如果字符串 word 在前缀树中，返回 true（即，在检索之前已经插入）；否则，返回 false 。boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。';
    Trie.difficulty = ProblemDifficulty.MEDIUM;
    Trie.category = ProblemCategory.DESIGN;
    Trie.choices = [
      { id: 'A', text: '设计节点包含26个字母的子节点数组和是否为单词结尾的标志', isCorrect: true },
      { id: 'B', text: '使用哈希表存储子节点，提高空间效率', isCorrect: false },
      { id: 'C', text: '使用数组存储所有单词，搜索时检查前缀', isCorrect: false },
      { id: 'D', text: '使用二叉搜索树存储单词，按字典序排列', isCorrect: false }
    ];
    Trie.explanation = '前缀树实现：①节点结构：children数组（26个元素，对应a-z），isEnd标志；②insert：从根节点开始，对每个字符：计算索引=charCode-97；若children[index]不存在则创建新节点；移动到该节点；最后标记isEnd=true；③search：类似insert，若任何字符不存在则返回false；最后检查isEnd；④startsWith：类似search，但无需检查isEnd，只要所有字符存在即可。时间复杂度O(L)（L为字符串长度），空间复杂度O(L×n)（n为插入的字符串数），高效支持前缀相关操作。';
    Trie.hint = '关键是「字符的分层存储」，每个节点代表一个字符，路径形成字符串，isEnd标志完整单词';
    problems.push(Trie);
    // 1631. 爬楼梯（LeetCode 70）
    const climbStairs = new ProblemModel();
    climbStairs.id = 1631;
    climbStairs.title = '爬楼梯';
    climbStairs.description = '假设你正在爬楼梯。需要 n 阶你才能到达楼顶。每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？';
    climbStairs.difficulty = ProblemDifficulty.EASY;
    climbStairs.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    climbStairs.choices = [
      { id: 'A', text: '动态规划，dp[i] = dp[i-1] + dp[i-2]，初始dp[1]=1, dp[2]=2', isCorrect: true },
      { id: 'B', text: '递归+记忆化，缓存子问题结果', isCorrect: false },
      { id: 'C', text: '斐波那契数列公式直接计算', isCorrect: false },
      { id: 'D', text: '暴力枚举所有可能的步数组合', isCorrect: false }
    ];
    climbStairs.explanation = '动态规划解法：①若n<=2：return n；②初始化dp数组，dp[1]=1，dp[2]=2；③遍历i从3到n：dp[i] = dp[i-1] + dp[i-2]；④返回dp[n]。空间优化：只需保存前两个值，空间复杂度O(1)。时间复杂度O(n)，高效计算爬楼梯的方法数，基于每个台阶的方法数是前两个台阶之和的原理。';
    climbStairs.hint = '关键是「状态转移关系」，到达第i阶的方法数等于到达i-1阶和i-2阶的方法数之和';
    problems.push(climbStairs);

    // 1632. 买卖股票的最佳时机（LeetCode 121）
    const maxProfitI = new ProblemModel();
    maxProfitI.id = 1632;
    maxProfitI.title = '买卖股票的最佳时机';
    maxProfitI.description = '给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。';
    maxProfitI.difficulty = ProblemDifficulty.EASY;
    maxProfitI.category = ProblemCategory.GREEDY;
    maxProfitI.choices = [
      { id: 'A', text: '一次遍历，记录最低价格，计算当前价格与最低价的利润并更新最大值', isCorrect: true },
      { id: 'B', text: '暴力法，计算所有可能的买卖组合利润', isCorrect: false },
      { id: 'C', text: '动态规划，记录每天的最大利润', isCorrect: false },
      { id: 'D', text: '先找到最小值，再找其后的最大值', isCorrect: false }
    ];
    maxProfitI.explanation = '贪心解法：①初始化最低价格minPrice为Infinity，最大利润maxProfit为0；②遍历每天价格price：若price < minPrice：更新minPrice = price；else：计算利润profit = price - minPrice；若profit > maxProfit：更新maxProfit；③返回maxProfit。时间复杂度O(n)，空间复杂度O(1)，一次遍历完成，高效找到最大利润。';
    maxProfitI.hint = '核心是「低买高卖」，通过记录历史最低价，实时计算当前可能的最大利润';
    problems.push(maxProfitI);

    // 1633. 买卖股票的最佳时机 II（LeetCode 122）
    const maxProfitII = new ProblemModel();
    maxProfitII.id = 1633;
    maxProfitII.title = '买卖股票的最佳时机 II';
    maxProfitII.description = '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。你也可以先购买，然后在 同一天 出售。返回 你能获得的 最大 利润 。';
    maxProfitII.difficulty = ProblemDifficulty.EASY;
    maxProfitII.category = ProblemCategory.GREEDY;
    maxProfitII.choices = [
      { id: 'A', text: '贪心，累加所有上涨的差价（price[i] > price[i-1]则加）', isCorrect: true },
      { id: 'B', text: '动态规划，记录每天持有和不持有的最大利润', isCorrect: false },
      { id: 'C', text: '找到所有上升区间，计算总利润', isCorrect: false },
      { id: 'D', text: '暴力枚举所有可能的买卖组合', isCorrect: false }
    ];
    maxProfitII.explanation = '贪心解法：①初始化利润profit=0；②遍历i从1到prices.length-1：若prices[i] > prices[i-1]：profit += prices[i] - prices[i-1]；③返回profit。原理：多次买卖的总利润等于所有上升区间的差价之和。时间复杂度O(n)，空间复杂度O(1)，简单高效计算最大利润。';
    maxProfitII.hint = '关键是「抓住所有上涨机会」，每次上涨都进行一次买卖，总利润最大';
    problems.push(maxProfitII);

    // 1634. 有效的括号（LeetCode 20）
    const isValid = new ProblemModel();
    isValid.id = 1634;
    isValid.title = '有效的括号';
    isValid.description = '给定一个只包括 \'(\'，\')\'，\'{\'，\'}\'，\'[\'，\']\' 的字符串 s ，判断字符串是否有效。有效字符串需满足：1. 左括号必须用相同类型的右括号闭合。2. 左括号必须以正确的顺序闭合。';
    isValid.difficulty = ProblemDifficulty.EASY;
    isValid.category = ProblemCategory.STACK;
    isValid.choices = [
      { id: 'A', text: '栈，遇到左括号入栈，右括号则与栈顶比较，不匹配则无效', isCorrect: true },
      { id: 'B', text: '替换法，反复替换成对的括号直到无法替换，检查是否为空', isCorrect: false },
      { id: 'C', text: '计数法，统计每种括号的数量是否匹配', isCorrect: false },
      { id: 'D', text: '递归检查，找到最内层的括号对并移除，重复直到完成', isCorrect: false }
    ];
    isValid.explanation = '栈解法：①创建映射表，右括号对应左括号；②初始化栈；③遍历每个字符：若为左括号：入栈；若为右括号：若栈为空或栈顶 != 映射值：return false；否则栈顶出栈；④遍历结束后，若栈为空：return true；else false。时间复杂度O(n)，空间复杂度O(n)，准确判断括号的有效性和顺序。';
    isValid.hint = '核心是「栈的匹配特性」，右括号必须与最近的左括号匹配，栈能保持这种顺序关系';
    problems.push(isValid);

    // 1635. 合并两个有序链表（LeetCode 21）
    const mergeTwoLists = new ProblemModel();
    mergeTwoLists.id = 1635;
    mergeTwoLists.title = '合并两个有序链表';
    mergeTwoLists.description = '将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。';
    mergeTwoLists.difficulty = ProblemDifficulty.EASY;
    mergeTwoLists.category = ProblemCategory.LINKED_LIST;
    mergeTwoLists.choices = [
      { id: 'A', text: '迭代，创建虚拟头节点，比较两链表节点值，小的先连接', isCorrect: true },
      { id: 'B', text: '递归，比较头节点，较小的节点的next指向剩余节点的合并结果', isCorrect: false },
      { id: 'C', text: '转换为数组排序后重建链表', isCorrect: false },
      { id: 'D', text: '插入法，将一个链表的节点插入到另一个链表的正确位置', isCorrect: false }
    ];
    mergeTwoLists.explanation = '迭代解法：①创建虚拟头节点dummy，当前指针curr = dummy；②循环当l1和l2都不为空：若l1.val <= l2.val：curr.next = l1；l1 = l1.next；else：curr.next = l2；l2 = l2.next；curr = curr.next；③将剩余的非空链表连接到curr.next；④返回dummy.next。时间复杂度O(m+n)，空间复杂度O(1)，原地合并两个有序链表。';
    mergeTwoLists.hint = '关键是「有序合并」，通过比较节点值，按顺序连接，保持升序特性';
    problems.push(mergeTwoLists);

    // 1637. 二叉树的最大深度（LeetCode 104）
    const maxDepth = new ProblemModel();
    maxDepth.id = 1637;
    maxDepth.title = '二叉树的最大深度';
    maxDepth.description = '给定一个二叉树，找出其最大深度。二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。说明: 叶子节点是指没有子节点的节点。';
    maxDepth.difficulty = ProblemDifficulty.EASY;
    maxDepth.category = ProblemCategory.BINARY_TREE;
    maxDepth.choices = [
      { id: 'A', text: '递归，树的深度=1+max(左子树深度, 右子树深度)', isCorrect: true },
      { id: 'B', text: 'BFS，层序遍历记录层数', isCorrect: false },
      { id: 'C', text: 'DFS，迭代记录最大深度', isCorrect: false },
      { id: 'D', text: '计算左右子树的节点数，取最大值', isCorrect: false }
    ];
    maxDepth.explanation = '递归解法：①若root为null：return 0；②左深度leftDepth = maxDepth(root.left)；③右深度rightDepth = maxDepth(root.right)；④返回1 + Math.max(leftDepth, rightDepth)。时间复杂度O(n)，空间复杂度O(h)（递归栈），简洁直观计算树的最大深度。';
    maxDepth.hint = '关键是「递归定义」，树的深度由左右子树的最大深度决定，加1是当前节点';
    problems.push(maxDepth);

    // 1638. 对称二叉树（LeetCode 101）
    const isSymmetric = new ProblemModel();
    isSymmetric.id = 1638;
    isSymmetric.title = '对称二叉树';
    isSymmetric.description = '给你一个二叉树的根节点 root ， 检查它是否轴对称。';
    isSymmetric.difficulty = ProblemDifficulty.EASY;
    isSymmetric.category = ProblemCategory.BINARY_TREE;
    isSymmetric.choices = [
      { id: 'A', text: '递归，检查左子树的右节点与右子树的左节点是否对称', isCorrect: true },
      { id: 'B', text: '迭代，使用队列层次比较对称位置的节点', isCorrect: false },
      { id: 'C', text: '先反转左子树，再比较与右子树是否相同', isCorrect: false },
      { id: 'D', text: '中序遍历后检查序列是否对称', isCorrect: false }
    ];
    isSymmetric.explanation = '递归解法：①定义辅助函数isMirror(a, b)：若a和b都为null：return true；若其中一个为null：return false；若a.val != b.val：return false；②递归检查a.left与b.right，a.right与b.left，返回两者的与结果；③调用isMirror(root, root)。时间复杂度O(n)，空间复杂度O(h)，通过比较对称位置的节点值判断是否对称。';
    isSymmetric.hint = '核心是「对称条件」，左子树的左节点需与右子树的右节点对称，左子树的右节点需与右子树的左节点对称';
    problems.push(isSymmetric);

    // 1640. 二叉树的最近公共祖先（LeetCode 236）
    const lowestCommonAncestor = new ProblemModel();
    lowestCommonAncestor.id = 1640;
    lowestCommonAncestor.title = '二叉树的最近公共祖先';
    lowestCommonAncestor.description = '给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”';
    lowestCommonAncestor.difficulty = ProblemDifficulty.MEDIUM;
    lowestCommonAncestor.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestor.choices = [
      { id: 'A', text: '递归，若当前节点是p或q则返回，否则递归左右子树，根据返回值判断', isCorrect: true },
      { id: 'B', text: '存储父节点，从p向上标记祖先，再从q向上查找第一个标记的祖先', isCorrect: false },
      { id: 'C', text: '先找到p和q的路径，再找路径的最后一个公共节点', isCorrect: false },
      { id: 'D', text: 'BFS层序遍历，记录每个节点的祖先', isCorrect: false }
    ];
    lowestCommonAncestor.explanation = '递归解法：①若root为null或root == p或root == q：return root；②左子树查找left = lowestCommonAncestor(root.left, p, q)；③右子树查找right = lowestCommonAncestor(root.right, p, q)；④若left和right都不为null：return root（当前节点是LCA）；⑤若left不为null：return left；else return right。时间复杂度O(n)，空间复杂度O(h)，通过递归后序遍历，利用返回值判断公共祖先。';
    lowestCommonAncestor.hint = '核心是「递归返回条件」，若左右子树分别找到p和q，则当前节点为最近公共祖先';
    problems.push(lowestCommonAncestor);

    // 1641. 二叉搜索树的最近公共祖先（LeetCode 235）
    const lowestCommonAncestorBST = new ProblemModel();
    lowestCommonAncestorBST.id = 1641;
    lowestCommonAncestorBST.title = '二叉搜索树的最近公共祖先';
    lowestCommonAncestorBST.description = '给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。” 二叉搜索树有以下特性：节点的左子树只包含小于当前节点的数。节点的右子树只包含大于当前节点的数。所有左子树和右子树自身也是二叉搜索树。';
    lowestCommonAncestorBST.difficulty = ProblemDifficulty.EASY;
    lowestCommonAncestorBST.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestorBST.choices = [
      { id: 'A', text: '利用BST特性，若当前节点值在p和q之间，则为LCA；否则递归左或右子树', isCorrect: true },
      { id: 'B', text: '同普通二叉树的LCA解法', isCorrect: false },
      { id: 'C', text: '先找到p和q的路径，再找路径的最后一个公共节点', isCorrect: false },
      { id: 'D', text: '迭代，根据节点值大小移动指针直到找到LCA', isCorrect: false }
    ];
    lowestCommonAncestorBST.explanation = '递归解法：①若root.val > p.val且root.val > q.val：return 左子树的LCA；②若root.val < p.val且root.val < q.val：return 右子树的LCA；③else：return root（当前节点为LCA）。时间复杂度O(h)，空间复杂度O(h)，利用BST左小右大的特性，无需遍历整棵树，高效找到最近公共祖先。';
    lowestCommonAncestorBST.hint = '关键是「BST的有序性」，最近公共祖先的值必然在p和q的值之间（或等于其中一个）';
    problems.push(lowestCommonAncestorBST);

    // 1642. 路径总和（LeetCode 112）
    const hasPathSum = new ProblemModel();
    hasPathSum.id = 1642;
    hasPathSum.title = '路径总和';
    hasPathSum.description = '给你二叉树的根节点 root 和一个表示目标和的整数 targetSum 。判断该树中是否存在 根节点到叶子节点 的路径，这条路径上所有节点值相加等于目标和 targetSum 。如果存在，返回 true ；否则，返回 false 。叶子节点 是指没有子节点的节点。';
    hasPathSum.difficulty = ProblemDifficulty.EASY;
    hasPathSum.category = ProblemCategory.BINARY_TREE;
    hasPathSum.choices = [
      { id: 'A', text: '递归，减去当前节点值，到达叶子节点时检查是否等于剩余值', isCorrect: true },
      { id: 'B', text: 'BFS，记录每个节点的路径和，到达叶子节点时检查', isCorrect: false },
      { id: 'C', text: 'DFS迭代，使用栈存储节点和当前路径和', isCorrect: false },
      { id: 'D', text: '计算所有根到叶子的路径和，检查是否包含目标和', isCorrect: false }
    ];
    hasPathSum.explanation = '递归解法：①若root为null：return false；②剩余目标和remaining = targetSum - root.val；③若root是叶子节点（无左右孩子）：return remaining == 0；④递归检查左子树或右子树：return hasPathSum(root.left, remaining) || hasPathSum(root.right, remaining)。时间复杂度O(n)，空间复杂度O(h)，在遍历过程中实时计算路径和，提前返回结果。';
    hasPathSum.hint = '核心是「递归递减目标和」，到达叶子节点时判断剩余值是否为0';
    problems.push(hasPathSum);

    // 1643. 二叉树的所有路径（LeetCode 257）
    const binaryTreePaths = new ProblemModel();
    binaryTreePaths.id = 1643;
    binaryTreePaths.title = '二叉树的所有路径';
    binaryTreePaths.description = '给你一个二叉树的根节点 root ，按 任意顺序 ，返回所有从根节点到叶子节点的路径。叶子节点 是指没有子节点的节点。';
    binaryTreePaths.difficulty = ProblemDifficulty.EASY;
    binaryTreePaths.category = ProblemCategory.BINARY_TREE;
    binaryTreePaths.choices = [
      { id: 'A', text: '回溯法，记录当前路径，到达叶子节点时加入结果', isCorrect: true },
      { id: 'B', text: 'BFS，记录每个节点的路径', isCorrect: false },
      { id: 'C', text: '递归，拼接当前节点值到子树路径前', isCorrect: false },
      { id: 'D', text: '先序遍历，使用字符串拼接路径', isCorrect: false }
    ];
    binaryTreePaths.explanation = '回溯解法：①初始化结果数组；②定义回溯函数backtrack(node, path)：若node为null：return；③path += node.val；④若node是叶子节点：结果加入path；return；⑤path += "->"；⑥递归左子树backtrack(node.left, path)；⑦递归右子树backtrack(node.right, path)；⑧调用backtrack(root, "")，返回结果。时间复杂度O(n)，空间复杂度O(h)，通过回溯记录并拼接路径，收集所有根到叶子的路径。';
    binaryTreePaths.hint = '关键是「路径拼接」，到达非叶子节点时添加箭头，叶子节点则直接加入结果';
    problems.push(binaryTreePaths);

    // 1644. 翻转二叉树（LeetCode 226）
    const invertTree = new ProblemModel();
    invertTree.id = 1644;
    invertTree.title = '翻转二叉树';
    invertTree.description = '给你一棵二叉树的根节点 root ，翻转这棵二叉树，并返回其根节点。';
    invertTree.difficulty = ProblemDifficulty.EASY;
    invertTree.category = ProblemCategory.BINARY_TREE;
    invertTree.choices = [
      { id: 'A', text: '递归，交换左右子树，再分别翻转左右子树', isCorrect: true },
      { id: 'B', text: 'BFS，层序遍历中交换每个节点的左右孩子', isCorrect: false },
      { id: 'C', text: 'DFS迭代，使用栈处理节点并交换左右孩子', isCorrect: false },
      { id: 'D', text: '先序遍历收集节点，再反向重建二叉树', isCorrect: false }
    ];
    invertTree.explanation = '递归解法：①若root为null：return null；②交换左右子树：const temp = root.left；root.left = root.right；root.right = temp；③递归翻转左子树invertTree(root.left)；④递归翻转右子树invertTree(root.right)；⑤返回root。时间复杂度O(n)，空间复杂度O(h)，简洁直观地实现二叉树翻转。';
    invertTree.hint = '核心是「交换左右子树」，对每个节点都执行左右子树的交换操作';
    problems.push(invertTree);

    // 1645. 相同的树（LeetCode 100）
    const isSameTree = new ProblemModel();
    isSameTree.id = 1645;
    isSameTree.title = '相同的树';
    isSameTree.description = '给你两棵二叉树的根节点 p 和 q ，编写一个函数来检验这两棵树是否相同。如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。';
    isSameTree.difficulty = ProblemDifficulty.EASY;
    isSameTree.category = ProblemCategory.BINARY_TREE;
    isSameTree.choices = [
      { id: 'A', text: '递归，比较当前节点值，再递归比较左右子树', isCorrect: true },
      { id: 'B', text: 'BFS，层序遍历同时比较两个树的节点', isCorrect: false },
      { id: 'C', text: '先序遍历两个树，比较遍历结果', isCorrect: false },
      { id: 'D', text: '计算两棵树的节点数和值之和，若相同则认为相同', isCorrect: false }
    ];
    isSameTree.explanation = '递归解法：①若p和q都为null：return true；②若其中一个为null：return false；③若p.val != q.val：return false；④递归比较左子树和右子树：return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)。时间复杂度O(n)，空间复杂度O(h)，逐层比较两棵树的结构和节点值。';
    isSameTree.hint = '关键是「同步比较」，同时检查节点是否都存在、值是否相同，以及左右子树是否相同';
    problems.push(isSameTree);

    // 1646. 对称的二叉树（LeetCode 剑指 Offer 28）
    const isSymmetricTree = new ProblemModel();
    isSymmetricTree.id = 1646;
    isSymmetricTree.title = '对称的二叉树';
    isSymmetricTree.description = '请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。';
    isSymmetricTree.difficulty = ProblemDifficulty.EASY;
    isSymmetricTree.category = ProblemCategory.BINARY_TREE;
    isSymmetricTree.choices = [
      { id: 'A', text: '递归，比较左子树的右节点与右子树的左节点是否对称', isCorrect: true },
      { id: 'B', text: '先翻转左子树，再比较与右子树是否相同', isCorrect: false },
      { id: 'C', text: 'BFS，使用队列按对称顺序存储节点并比较', isCorrect: false },
      { id: 'D', text: '中序遍历后检查序列是否回文', isCorrect: false }
    ];
    isSymmetricTree.explanation = '递归解法：①若root为null：return true；②定义辅助函数isMirror(a, b)：若a和b都为null：return true；若其中一个为null：return false；若a.val != b.val：return false；③返回isMirror(a.left, b.right) && isMirror(a.right, b.left)；④调用isMirror(root.left, root.right)。时间复杂度O(n)，空间复杂度O(h)，通过比较对称位置的节点判断是否对称。';
    isSymmetricTree.hint = '核心是「镜像对称条件」，左子树的结构和值需与右子树的镜像一致';
    problems.push(isSymmetricTree);


    // 1648. 平衡二叉树（LeetCode 110）
    const isBalanced = new ProblemModel();
    isBalanced.id = 1648;
    isBalanced.title = '平衡二叉树';
    isBalanced.description = '给定一个二叉树，判断它是否是高度平衡的二叉树。本题中，一棵高度平衡二叉树定义为：一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。';
    isBalanced.difficulty = ProblemDifficulty.EASY;
    isBalanced.category = ProblemCategory.BINARY_TREE;
    isBalanced.choices = [
      { id: 'A', text: '后序遍历，计算每个节点的左右子树高度，同时判断是否平衡', isCorrect: true },
      { id: 'B', text: '先序遍历，对每个节点计算左右子树高度并比较', isCorrect: false },
      { id: 'C', text: 'BFS，层序遍历中检查每个节点的子树高度', isCorrect: false },
      { id: 'D', text: '计算整棵树的高度，再检查左右子树高度差', isCorrect: false }
    ];
    isBalanced.explanation = '后序遍历解法：①定义辅助函数getHeight(node)：若node为null：return 0；②左高度left = getHeight(node.left)；若left == -1：return -1（左子树不平衡）；③右高度right = getHeight(node.right)；若right == -1：return -1（右子树不平衡）；④若Math.abs(left - right) > 1：return -1（当前节点不平衡）；⑤return 1 + Math.max(left, right)；⑥调用getHeight(root) != -1。时间复杂度O(n)，空间复杂度O(h)，一次遍历同时计算高度和判断平衡，避免重复计算。';
    isBalanced.hint = '核心是「后序遍历+剪枝」，在计算高度的同时判断是否平衡，发现不平衡立即返回';
    problems.push(isBalanced);

    // 1649. 二叉树的最小深度（LeetCode 111）
    const minDepth = new ProblemModel();
    minDepth.id = 1649;
    minDepth.title = '二叉树的最小深度';
    minDepth.description = '给定一个二叉树，找出其最小深度。最小深度是从根节点到最近叶子节点的最短路径上的节点数量。说明：叶子节点是指没有子节点的节点。';
    minDepth.difficulty = ProblemDifficulty.EASY;
    minDepth.category = ProblemCategory.BINARY_TREE;
    minDepth.choices = [
      { id: 'A', text: 'BFS，层序遍历，遇到第一个叶子节点时返回当前层数', isCorrect: true },
      { id: 'B', text: '递归，树的最小深度=1+min(左子树最小深度, 右子树最小深度)，注意处理单侧为空的情况', isCorrect: false },
      { id: 'C', text: 'DFS，记录最小深度并更新', isCorrect: false },
      { id: 'D', text: '计算左右子树的深度，取最小值', isCorrect: false }
    ];
    minDepth.explanation = 'BFS解法：①若root为null：return 0；②初始化队列，加入root；深度depth=1；③循环当队列不为空：获取当前层节点数size；④循环size次：出队节点；若为叶子节点（无左右孩子）：return depth；⑤左右孩子入队；⑥depth++；⑦返回depth。时间复杂度O(n)，空间复杂度O(n)，找到最近的叶子节点后立即返回，无需遍历整棵树。';
    minDepth.hint = '关键是「层序遍历的特性」，先遇到的叶子节点所在的层即为最小深度';
    problems.push(minDepth);

    // 1650. 左叶子之和（LeetCode 404）
    const sumOfLeftLeaves = new ProblemModel();
    sumOfLeftLeaves.id = 1650;
    sumOfLeftLeaves.title = '左叶子之和';
    sumOfLeftLeaves.description = '给定二叉树的根节点 root ，返回所有左叶子之和。';
    sumOfLeftLeaves.difficulty = ProblemDifficulty.EASY;
    sumOfLeftLeaves.category = ProblemCategory.BINARY_TREE;
    sumOfLeftLeaves.choices = [
      { id: 'A', text: '递归，判断左孩子是否为叶子节点，若是则累加其值，否则递归处理', isCorrect: true },
      { id: 'B', text: 'BFS，层序遍历中检查左叶子节点并累加', isCorrect: false },
      { id: 'C', text: 'DFS迭代，使用栈处理节点，识别左叶子并累加', isCorrect: false },
      { id: 'D', text: '先序遍历收集所有左叶子，再求和', isCorrect: false }
    ];
    sumOfLeftLeaves.explanation = '递归解法：①若root为null：return 0；②初始化和sum=0；③若root.left不为null且是叶子节点（无左右孩子）：sum += root.left.val；④else：sum += sumOfLeftLeaves(root.left)；⑤sum += sumOfLeftLeaves(root.right)；⑥返回sum。时间复杂度O(n)，空间复杂度O(h)，准确识别左叶子节点并累加其值。';
    sumOfLeftLeaves.hint = '核心是「左叶子的定义」，既是左孩子又是叶子节点（无左右子树）';
    problems.push(sumOfLeftLeaves);


    // 1652. 二叉搜索树的范围和（LeetCode 938）
    const rangeSumBST = new ProblemModel();
    rangeSumBST.id = 1652;
    rangeSumBST.title = '二叉搜索树的范围和';
    rangeSumBST.description = '给定二叉搜索树的根结点 root，返回值位于范围 [low, high] 之间的所有结点的值的和。';
    rangeSumBST.difficulty = ProblemDifficulty.EASY;
    rangeSumBST.category = ProblemCategory.BINARY_TREE;
    rangeSumBST.choices = [
      { id: 'A', text: '利用BST特性递归，若当前节点值小于low则只遍历右子树，大于high则只遍历左子树', isCorrect: true },
      { id: 'B', text: '中序遍历得到有序数组，再计算范围内的和', isCorrect: false },
      { id: 'C', text: 'BFS遍历所有节点，累加范围内的值', isCorrect: false },
      { id: 'D', text: '递归遍历所有节点，累加范围内的值', isCorrect: false }
    ];
    rangeSumBST.explanation = 'BST特性解法：①若root为null：return 0；②sum=0；③若root.val >= low && root.val <= high：sum += root.val；④若root.val > low：sum += rangeSumBST(root.left, low, high)；⑤若root.val < high：sum += rangeSumBST(root.right, low, high)；⑥返回sum。时间复杂度O(n)（最坏情况），平均O(log n)，利用BST特性减少不必要的遍历。';
    rangeSumBST.hint = '核心是「BST的有序性」，通过节点值与范围的比较，剪枝不需要遍历的子树';
    problems.push(rangeSumBST);


    // 1654. 二叉树中第二小的节点（LeetCode 671）
    const findSecondMinimumValue = new ProblemModel();
    findSecondMinimumValue.id = 1654;
    findSecondMinimumValue.title = '二叉树中第二小的节点';
    findSecondMinimumValue.description = '给定一个非空特殊的二叉树，每个节点都是正数，并且每个节点的子节点数量只能为 2 或 0。如果一个节点有两个子节点的话，那么该节点的值等于两个子节点中较小的一个。更正式地说，即 root.val = min(root.left.val, root.right.val) 总成立。找出二叉树中第二小的值。如果第二小的值不存在，输出 -1 。';
    findSecondMinimumValue.difficulty = ProblemDifficulty.EASY;
    findSecondMinimumValue.category = ProblemCategory.BINARY_TREE;
    findSecondMinimumValue.choices = [
      { id: 'A', text: '递归，寻找比根节点大的最小值，即为第二小', isCorrect: true },
      { id: 'B', text: 'BFS遍历所有节点，记录最小值和第二小值', isCorrect: false },
      { id: 'C', text: '中序遍历得到有序数组，取第二个元素', isCorrect: false },
      { id: 'D', text: '利用树的特性，只检查与根节点值不同的子树', isCorrect: false }
    ];
    findSecondMinimumValue.explanation = '递归解法：①若root为null：return -1；②定义辅助函数findMin(node, val)：寻找以node为根且大于val的最小值；③若node为null：return -1；④若node.val > val：return node.val；⑤左结果left = findMin(node.left, val)；⑥右结果right = findMin(node.right, val)；⑦若left != -1且right != -1：return Math.min(left, right)；⑧else return left != -1 ? left : right；⑨调用findMin(root, root.val)。时间复杂度O(n)，空间复杂度O(h)，利用树的特性减少不必要的搜索。';
    findSecondMinimumValue.hint = '核心是「树的特性」，根节点是最小值，第二小的值是第一个比根节点大的值';
    problems.push(findSecondMinimumValue);

    // 1655. 二叉树的右视图（LeetCode 199）
    const rightSideView = new ProblemModel();
    rightSideView.id = 1655;
    rightSideView.title = '二叉树的右视图';
    rightSideView.description = '给定一个二叉树的 根节点 root，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。';
    rightSideView.difficulty = ProblemDifficulty.MEDIUM;
    rightSideView.category = ProblemCategory.BINARY_TREE;
    rightSideView.choices = [
      { id: 'A', text: 'BFS层序遍历，记录每层的最后一个节点值', isCorrect: true },
      { id: 'B', text: 'DFS，优先遍历右子树，每个深度只记录第一个节点', isCorrect: false },
      { id: 'C', text: '递归，传递深度参数，记录每个深度的最右节点', isCorrect: false },
      { id: 'D', text: '先序遍历，记录每个深度的最后一个节点', isCorrect: false }
    ];
    rightSideView.explanation = 'BFS解法：①初始化队列和结果数组；②若root不为空，入队；③循环当队列不为空：获取当前层节点数size；④循环size次：出队节点；若为当前层最后一个节点：加入结果；⑤左右孩子入队；⑥返回结果。时间复杂度O(n)，空间复杂度O(n)，直接获取每层最右侧的节点值，符合右视图的定义。';
    rightSideView.hint = '关键是「层序遍历的最后一个节点」，每层最右侧的节点即为右视图可见的节点';
    problems.push(rightSideView);

    // 1656. 从前序与中序遍历序列构造二叉树（LeetCode 105）
    const buildTreePreIn = new ProblemModel();
    buildTreePreIn.id = 1656;
    buildTreePreIn.title = '从前序与中序遍历序列构造二叉树';
    buildTreePreIn.description = '给定两个整数数组 preorder 和 inorder ，其中 preorder 是二叉树的先序遍历， inorder 是同一棵树的中序遍历，请构造二叉树并返回其根节点。';
    buildTreePreIn.difficulty = ProblemDifficulty.MEDIUM;
    buildTreePreIn.category = ProblemCategory.BINARY_TREE;
    buildTreePreIn.choices = [
      { id: 'A', text: '递归，前序首元素为根，中序中找到根位置，划分左右子树的前序和中序序列', isCorrect: true },
      { id: 'B', text: '迭代，使用栈模拟前序遍历过程', isCorrect: false },
      { id: 'C', text: '先构建哈希表存储中序值的索引，再递归构建', isCorrect: false },
      { id: 'D', text: '分治法，将序列分割为左右子树部分递归处理', isCorrect: false }
    ];
    buildTreePreIn.explanation = '递归解法：①若preorder为空：return null；②根值rootVal = preorder[0]；③在inorder中找到rootVal的索引index；④左子树节点数leftSize = index；⑤左前序preLeft = preorder.slice(1, 1+leftSize)；右前序preRight = preorder.slice(1+leftSize)；⑥左中序inLeft = inorder.slice(0, index)；右中序inRight = inorder.slice(index+1)；⑦构建根节点root；root.left = buildTree(preLeft, inLeft)；root.right = buildTree(preRight, inRight)；⑧返回root。优化：用哈希表存储中序值的索引，避免每次查找。时间复杂度O(n)，空间复杂度O(n)，利用前序和中序的特性递归构建二叉树。';
    buildTreePreIn.hint = '核心是「前序找根，中序分左右」，前序遍历的第一个元素是根，中序中根的左右分别是左右子树';
    problems.push(buildTreePreIn);

    // 1657. 从中序与后序遍历序列构造二叉树（LeetCode 106）
    const buildTreeInPost = new ProblemModel();
    buildTreeInPost.id = 1657;
    buildTreeInPost.title = '从中序与后序遍历序列构造二叉树';
    buildTreeInPost.description = '给定两个整数数组 inorder 和 postorder ，其中 inorder 是二叉树的中序遍历， postorder 是同一棵树的后序遍历，请你构造并返回这颗 二叉树 。';
    buildTreeInPost.difficulty = ProblemDifficulty.MEDIUM;
    buildTreeInPost.category = ProblemCategory.BINARY_TREE;
    buildTreeInPost.choices = [
      { id: 'A', text: '递归，后序尾元素为根，中序中找到根位置，划分左右子树的中序和后序序列', isCorrect: true },
      { id: 'B', text: '迭代，使用栈模拟后序遍历过程', isCorrect: false },
      { id: 'C', text: '先构建哈希表存储中序值的索引，再递归构建', isCorrect: false },
      { id: 'D', text: '分治法，将序列分割为左右子树部分递归处理', isCorrect: false }
    ];
    buildTreeInPost.explanation = '递归解法：①若postorder为空：return null；②根值rootVal = postorder[postorder.length-1]；③在inorder中找到rootVal的索引index；④左子树节点数leftSize = index；⑤左后序postLeft = postorder.slice(0, leftSize)；右后序postRight = postorder.slice(leftSize, postorder.length-1)；⑥左中序inLeft = inorder.slice(0, index)；右中序inRight = inorder.slice(index+1)；⑦构建根节点root；root.left = buildTree(inLeft, postLeft)；root.right = buildTree(inRight, postRight)；⑧返回root。优化：用哈希表存储中序值的索引。时间复杂度O(n)，空间复杂度O(n)，利用后序和中序的特性递归构建二叉树。';
    buildTreeInPost.hint = '关键是「后序找根，中序分左右」，后序遍历的最后一个元素是根，中序中根的左右分别是左右子树';
    problems.push(buildTreeInPost);

    // 1658. 把二叉搜索树转换为累加树（LeetCode 538）
    const convertBST = new ProblemModel();
    convertBST.id = 1658;
    convertBST.title = '把二叉搜索树转换为累加树';
    convertBST.description = '给出二叉 搜索 树的根节点，该树的节点值各不相同，请你将其转换为累加树（Greater Sum Tree），使每个节点 node 的新值等于原树中大于或等于 node.val 的值之和。提醒一下，二叉搜索树满足下列约束条件：节点的左子树仅包含键 小于 节点键的节点。节点的右子树仅包含键 大于 节点键的节点。左右子树也必须是二叉搜索树。';
    convertBST.difficulty = ProblemDifficulty.MEDIUM;
    convertBST.category = ProblemCategory.BINARY_TREE;
    convertBST.choices = [
      { id: 'A', text: '反中序遍历（右-根-左），累加节点值并更新当前节点', isCorrect: true },
      { id: 'B', text: '先计算所有节点的和，再中序遍历减去小于当前节点值的和', isCorrect: false },
      { id: 'C', text: '递归计算每个节点的累加和，等于自身值加右子树的累加和', isCorrect: false },
      { id: 'D', text: 'BFS，从大到小遍历节点并累加', isCorrect: false }
    ];
    convertBST.explanation = '反中序遍历解法：①初始化累加和sum=0；②定义递归函数traverse(node)：若node为null：return；③traverse(node.right)；④sum += node.val；node.val = sum；⑤traverse(node.left)；⑥调用traverse(root)，返回root。时间复杂度O(n)，空间复杂度O(h)，利用BST中序遍历有序的特性，反向遍历实现累加。';
    convertBST.hint = '核心是「BST的反中序遍历」，按从大到小的顺序遍历节点，实时累加并更新节点值';
    problems.push(convertBST);

    // 1659. 二叉搜索树迭代器（LeetCode 173）
    const BSTIterator = new ProblemModel();
    BSTIterator.id = 1659;
    BSTIterator.title = '二叉搜索树迭代器';
    BSTIterator.description = '实现一个二叉搜索树迭代器类BSTIterator ，表示一个按中序遍历二叉搜索树（BST）的迭代器：BSTIterator(TreeNode root) 初始化 BSTIterator 类的一个对象。BST 的根节点会作为构造函数的参数传入。指针初始位置在 BST 中最左的元素处。boolean hasNext() 如果向指针右侧遍历存在数字，则返回 true ；否则返回 false 。int next() 将指针向右移动，然后返回指针处的数字。注意：指针初始位置在 BST 中最左的元素处。你可以假设 next() 调用总是有效的，也就是说，当调用 next() 时，BST 的中序遍历中至少存在一个下一个数字。';
    BSTIterator.difficulty = ProblemDifficulty.MEDIUM;
    BSTIterator.category = ProblemCategory.BINARY_TREE;
    BSTIterator.choices = [
      { id: 'A', text: '受控迭代，使用栈存储左节点，next()时弹出并处理右子树的左节点', isCorrect: true },
      { id: 'B', text: '提前中序遍历存储所有节点值，迭代时依次返回', isCorrect: false },
      { id: 'C', text: '递归中序遍历，使用生成器实现迭代', isCorrect: false },
      { id: 'D', text: '记录当前节点，每次寻找中序后继', isCorrect: false }
    ];
    BSTIterator.explanation = '受控迭代解法：①构造函数：初始化栈；将root的所有左节点入栈；②next()：弹出栈顶节点node；将node.right的所有左节点入栈；返回node.val；③hasNext()：return 栈不为空。时间复杂度：构造函数O(h)，next()摊还O(1)，hasNext()O(1)；空间复杂度O(h)，实现按需遍历，节省空间。';
    BSTIterator.hint = '关键是「栈的受控使用」，只在需要时加载右子树的左节点，实现高效的中序遍历迭代';
    problems.push(BSTIterator);

    // 1660. 二叉树的序列化与反序列化（LeetCode 297）
    const Codec = new ProblemModel();
    Codec.id = 1660;
    Codec.title = '二叉树的序列化与反序列化';
    Codec.description = '序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。';
    Codec.difficulty = ProblemDifficulty.HARD;
    Codec.category = ProblemCategory.BINARY_TREE;
    Codec.choices = [
      { id: 'A', text: '前序遍历序列化，包含空节点标记；反序列化时递归构建', isCorrect: true },
      { id: 'B', text: '层序遍历序列化，包含空节点标记；反序列化时队列辅助', isCorrect: false },
      { id: 'C', text: '中序遍历序列化，反序列化时结合根节点位置', isCorrect: false },
      { id: 'D', text: '后序遍历序列化，反序列化时从后向前处理', isCorrect: false }
    ];
    Codec.explanation = '前序遍历解法：①serialize(root)：若root为null：return "null,"；否则：return root.val + "," + serialize(root.left) + serialize(root.right)；②deserialize(data)：将字符串split为列表；定义辅助函数build()：弹出首元素；若为"null"：return null；创建节点val=当前值；node.left = build()；node.right = build()；return node；调用build()。时间复杂度O(n)，空间复杂度O(n)，通过包含空节点标记，确保反序列化的唯一性。';
    Codec.hint = '核心是「包含空节点信息」，序列化时记录null节点，使反序列化能准确还原树结构';
    problems.push(Codec);

    // 1662. 寻找峰值（LeetCode 162）
    const findPeakElement = new ProblemModel();
    findPeakElement.id = 1662;
    findPeakElement.title = '寻找峰值';
    findPeakElement.description = '峰值元素是指其值严格大于左右相邻值的元素。给你一个整数数组 nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回 任何一个峰值 所在位置即可。你可以假设 nums[-1] = nums[n] = -∞ 。你必须实现时间复杂度为 O(log n) 的算法来解决此问题。';
    findPeakElement.difficulty = ProblemDifficulty.MEDIUM;
    findPeakElement.category = ProblemCategory.ARRAY;
    findPeakElement.choices = [
      { id: 'A', text: '二分查找，若nums[mid] < nums[mid+1]则峰值在右侧，否则在左侧', isCorrect: true },
      { id: 'B', text: '线性扫描，找到第一个满足nums[i] > nums[i+1]的i', isCorrect: false },
      { id: 'C', text: '递归二分，缩小搜索范围', isCorrect: false },
      { id: 'D', text: '寻找数组最大值的索引，一定是峰值', isCorrect: false }
    ];
    findPeakElement.explanation = '二分查找解法：①初始化left=0，right=nums.length-1；②循环当left < right：mid = Math.floor((left + right)/2)；③若nums[mid] < nums[mid+1]：left = mid + 1；④else：right = mid；⑤循环结束后return left。时间复杂度O(log n)，空间复杂度O(1)，利用数组两端为负无穷的特性，通过比较mid和mid+1的值确定峰值所在侧。';
    findPeakElement.hint = '核心是「二分的判断条件」，若mid处的值小于右侧，则右侧必有峰值；否则左侧必有峰值';
    problems.push(findPeakElement);

    // 1663. 搜索旋转排序数组（LeetCode 33）
    const searchRotated = new ProblemModel();
    searchRotated.id = 1663;
    searchRotated.title = '搜索旋转排序数组';
    searchRotated.description = '整数数组 nums 按升序排列，数组中的值 互不相同 。在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。你必须设计一个时间复杂度为 O(log n) 的算法解决此问题。';
    searchRotated.difficulty = ProblemDifficulty.MEDIUM;
    searchRotated.category = ProblemCategory.ARRAY;
    searchRotated.choices = [
      { id: 'A', text: '二分查找，先判断哪部分是有序的，再在有序部分中查找目标', isCorrect: true },
      { id: 'B', text: '先找到旋转点，再在相应的有序区间二分查找', isCorrect: false },
      { id: 'C', text: '线性搜索，找到目标值', isCorrect: false },
      { id: 'D', text: '恢复数组为有序后再二分查找', isCorrect: false }
    ];
    searchRotated.explanation = '二分查找解法：①初始化left=0，right=nums.length-1；②循环当left <= right：mid = Math.floor((left + right)/2)；③若nums[mid] == target：return mid；④若nums[left] <= nums[mid]（左半部分有序）：若nums[left] <= target < nums[mid]：right = mid - 1；else：left = mid + 1；⑤else（右半部分有序）：若nums[mid] < target <= nums[right]：left = mid + 1；else：right = mid - 1；⑥循环结束后return -1。时间复杂度O(log n)，空间复杂度O(1)，在旋转数组中高效查找目标。';
    searchRotated.hint = '关键是「判断有序区间」，每次二分确定哪部分是有序的，再在有序部分中判断目标是否存在';
    problems.push(searchRotated);

    // 1664. 搜索二维矩阵（LeetCode 74）
    const searchMatrix = new ProblemModel();
    searchMatrix.id = 1664;
    searchMatrix.title = '搜索二维矩阵';
    searchMatrix.description = '编写一个高效的算法来判断 m x n 矩阵中，是否存在一个目标值。该矩阵具有如下特性：每行中的整数从左到右按升序排列。每行的第一个整数大于前一行的最后一个整数。';
    searchMatrix.difficulty = ProblemDifficulty.MEDIUM;
    searchMatrix.category = ProblemCategory.ARRAY;
    searchMatrix.choices = [
      { id: 'A', text: '二分查找，将二维矩阵视为一维有序数组，计算对应行列', isCorrect: true },
      { id: 'B', text: '先二分查找行，再在该行二分查找列', isCorrect: false },
      { id: 'C', text: '从右上角开始，小于目标则下移，大于则左移', isCorrect: false },
      { id: 'D', text: '逐行二分查找', isCorrect: false }
    ];
    searchMatrix.explanation = '一维二分解法：①若矩阵为空：return false；②m = matrix.length，n = matrix[0].length；left=0，right = m*n - 1；③循环当left <= right：mid = Math.floor((left + right)/2)；row = Math.floor(mid / n)；col = mid % n；④若matrix[row][col] == target：return true；⑤else if (matrix[row][col] < target)：left = mid + 1；⑥else：right = mid - 1；⑦return false。时间复杂度O(log(mn))，空间复杂度O(1)，将二维矩阵映射为一维有序数组进行二分查找。';
    searchMatrix.hint = '核心是「矩阵的有序性」，整个矩阵可视为按行拼接的一维有序数组，直接计算中间元素的行列位置';
    problems.push(searchMatrix);

    // 1665. 在排序数组中查找元素的第一个和最后一个位置（LeetCode 34）
    const searchRange = new ProblemModel();
    searchRange.id = 1665;
    searchRange.title = '在排序数组中查找元素的第一个和最后一个位置';
    searchRange.description = '给你一个按照非递减顺序排列的整数数组 nums，和一个目标值 target。请你找出给定目标值在数组中的开始位置和结束位置。如果数组中不存在目标值 target，返回 [-1, -1]。你必须设计并实现时间复杂度为 O(log n) 的算法解决此问题。';
    searchRange.difficulty = ProblemDifficulty.MEDIUM;
    searchRange.category = ProblemCategory.ARRAY;
    searchRange.choices = [
      { id: 'A', text: '两次二分查找，分别寻找左边界和右边界', isCorrect: true },
      { id: 'B', text: '一次二分找到目标，再向两边扩展找边界', isCorrect: false },
      { id: 'C', text: '线性扫描找到第一个和最后一个出现的位置', isCorrect: false },
      { id: 'D', text: '使用内置函数indexOf和lastIndexOf', isCorrect: false }
    ];
    searchRange.explanation = '两次二分解法：①定义找左边界函数findLeft()：left=0，right=nums.length-1；res=-1；循环当left <= right：mid=(left+right)/2；if nums[mid] == target：res=mid；right=mid-1；else if nums[mid] < target：left=mid+1；else：right=mid-1；return res；②类似定义找右边界函数findRight()，找到时left=mid+1；③leftIdx = findLeft()；if leftIdx == -1：return [-1,-1]；rightIdx = findRight()；return [leftIdx, rightIdx]。时间复杂度O(log n)，空间复杂度O(1)，准确找到目标值的范围。';
    searchRange.hint = '关键是「二分查找的变体」，寻找左边界时找到目标后继续向左搜索，寻找右边界时继续向右搜索';
    problems.push(searchRange);

    // 1666. 多数元素（LeetCode 169）
    const majorityElement = new ProblemModel();
    majorityElement.id = 1666;
    majorityElement.title = '多数元素';
    majorityElement.description = '给定一个大小为 n 的数组 nums ，返回其中的多数元素。多数元素是指在数组中出现次数 大于 ⌊ n/2 ⌋ 的元素。你可以假设数组是非空的，并且给定的数组总是存在多数元素。';
    majorityElement.difficulty = ProblemDifficulty.EASY;
    majorityElement.category = ProblemCategory.ARRAY;
    majorityElement.choices = [
      { id: 'A', text: '摩尔投票法，遍历数组，相同则计数加1，不同则减1，计数为0则更换候选', isCorrect: true },
      { id: 'B', text: '哈希表，统计每个元素的出现次数，返回次数最多的', isCorrect: false },
      { id: 'C', text: '排序，数组中间的元素即为多数元素', isCorrect: false },
      { id: 'D', text: '分治法，递归寻找左右子数组的多数元素，再比较两者的出现次数', isCorrect: false }
    ];
    majorityElement.explanation = '摩尔投票解法：①初始化候选candidate = nums[0]，计数count=1；②遍历i从1到nums.length-1：if nums[i] == candidate：count++；else：count--；if count == 0：candidate = nums[i]；count=1；③返回candidate。时间复杂度O(n)，空间复杂度O(1)，利用多数元素出现次数超过一半的特性，高效找到多数元素。';
    majorityElement.hint = '核心是「抵消思想」，不同元素相互抵消，最后剩下的一定是多数元素';
    problems.push(majorityElement);

    // 1667. 缺失的第一个正数（LeetCode 41）
    const firstMissingPositive = new ProblemModel();
    firstMissingPositive.id = 1667;
    firstMissingPositive.title = '缺失的第一个正数';
    firstMissingPositive.description = '给你一个未排序的整数数组 nums ，请你找出其中没有出现的最小的正整数。请你实现时间复杂度为 O(n) 并且只使用常数级别额外空间的解决方案。';
    firstMissingPositive.difficulty = ProblemDifficulty.HARD;
    firstMissingPositive.category = ProblemCategory.ARRAY;
    firstMissingPositive.choices = [
      { id: 'A', text: '原地哈希，将正数放到对应的索引位置，再遍历寻找第一个不匹配的索引', isCorrect: true },
      { id: 'B', text: '使用哈希表存储所有正数，再从1开始检查', isCorrect: false },
      { id: 'C', text: '排序数组，再寻找缺失的最小正数', isCorrect: false },
      { id: 'D', text: '位图法，用一个整数的位表示是否出现', isCorrect: false }
    ];
    firstMissingPositive.explanation = '原地哈希解法：①n = nums.length；②遍历数组：若nums[i]是1~n的正数，且nums[nums[i]-1] != nums[i]：交换nums[i]和nums[nums[i]-1]；重复直到无法交换或nums[i]不在范围内；③遍历数组：若nums[i] != i+1：return i+1；④return n+1。时间复杂度O(n)，空间复杂度O(1)，利用数组本身作为哈希表，将正数放到正确位置。';
    firstMissingPositive.hint = '关键是「位置映射」，最小的缺失正数一定在1~n+1之间，通过将数放到对应索引位置来查找';
    problems.push(firstMissingPositive);

    // 1668. 寻找重复数（LeetCode 287）
    const findDuplicate = new ProblemModel();
    findDuplicate.id = 1668;
    findDuplicate.title = '寻找重复数';
    findDuplicate.description = '给定一个包含 n + 1 个整数的数组 nums ，其数字都在 [1, n] 范围内（包括 1 和 n），可知至少存在一个重复的整数。假设 nums 只有 一个重复的整数 ，找出 这个重复的数 。你设计的解决方案必须 不修改 数组 nums 且只用常量级 O(1) 的额外空间。';
    findDuplicate.difficulty = ProblemDifficulty.MEDIUM;
    findDuplicate.category = ProblemCategory.ARRAY;
    findDuplicate.choices = [
      { id: 'A', text: '快慢指针，将数组视为链表，寻找环的入口（弗洛伊德判圈法）', isCorrect: true },
      { id: 'B', text: '二分查找，统计小于等于mid的数的个数，判断重复数在左侧还是右侧', isCorrect: false },
      { id: 'C', text: '哈希表，记录出现过的数', isCorrect: false },
      { id: 'D', text: '排序数组，寻找相邻相等的数', isCorrect: false }
    ];
    findDuplicate.explanation = '快慢指针解法：①慢指针slow = nums[0]；快指针fast = nums[nums[0]]；②循环当slow != fast：slow = nums[slow]；fast = nums[nums[fast]]；③快指针重置为0；④循环当slow != fast：slow = nums[slow]；fast = nums[fast]；⑤return slow。时间复杂度O(n)，空间复杂度O(1)，不修改数组，符合题目约束。原理：数组值范围1~n，索引0~n，可构建链表，重复数为环的入口。';
    findDuplicate.hint = '核心是「环的检测」，通过快慢指针找到环，再找到环的入口即为重复数';
    problems.push(findDuplicate);

    // 1670. 移除元素（LeetCode 27）
    const removeElement = new ProblemModel();
    removeElement.id = 1670;
    removeElement.title = '移除元素';
    removeElement.description = '给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。';
    removeElement.difficulty = ProblemDifficulty.EASY;
    removeElement.category = ProblemCategory.ARRAY;
    removeElement.choices = [
      { id: 'A', text: '双指针，慢指针记录有效元素位置，快指针遍历数组，不等则复制', isCorrect: true },
      { id: 'B', text: '暴力法，遇到val则将后面元素前移', isCorrect: false },
      { id: 'C', text: '将所有val交换到数组末尾，返回新长度', isCorrect: false },
      { id: 'D', text: '使用filter方法创建新数组，再复制回原数组', isCorrect: false }
    ];
    removeElement.explanation = '双指针解法：①初始化慢指针i=0；②遍历快指针j从0到nums.length-1：if nums[j] != val：nums[i] = nums[j]；i++；③返回i。时间复杂度O(n)，空间复杂度O(1)，原地移除元素，保留非val元素的相对顺序。';
    removeElement.hint = '核心是「覆盖无效元素」，慢指针跟踪有效元素的位置，快指针寻找有效元素进行覆盖';
    problems.push(removeElement);

    // 1671. 移除重复元素（LeetCode 26）
    const removeDuplicates = new ProblemModel();
    removeDuplicates.id = 1671;
    removeDuplicates.title = '移除重复元素';
    removeDuplicates.description = '给你一个 升序排列 的数组 nums ，请你 原地 删除重复出现的元素，使每个元素 只出现一次 ，返回删除后数组的新长度。元素的 相对顺序 应该保持 一致 。由于在某些语言中不能改变数组的长度，所以必须将结果放在数组nums的第一部分。更规范地说，如果在删除重复项之后有 k 个元素，那么 nums 的前 k 个元素应该保存最终结果。不需要考虑数组中超出新长度后面的元素。';
    removeDuplicates.difficulty = ProblemDifficulty.EASY;
    removeDuplicates.category = ProblemCategory.ARRAY;
    removeDuplicates.choices = [
      { id: 'A', text: '双指针，慢指针记录不重复元素位置，快指针遍历，不同则复制', isCorrect: true },
      { id: 'B', text: '使用Set存储不重复元素，再复制回原数组', isCorrect: false },
      { id: 'C', text: '暴力法，遇到重复则将后面元素前移', isCorrect: false },
      { id: 'D', text: '使用filter方法过滤重复元素', isCorrect: false }
    ];
    removeDuplicates.explanation = '双指针解法：①若数组长度<=1：return 数组长度；②慢指针i=0；③遍历快指针j从1到nums.length-1：if nums[j] != nums[i]：i++；nums[i] = nums[j]；④返回i+1。时间复杂度O(n)，空间复杂度O(1)，原地移除重复元素，利用数组升序的特性。';
    removeDuplicates.hint = '关键是「利用升序特性」，重复元素必然相邻，通过双指针保留第一个出现的元素';
    problems.push(removeDuplicates);

    // 1672. 移除重复元素 II（LeetCode 80）
    const removeDuplicatesII = new ProblemModel();
    removeDuplicatesII.id = 1672;
    removeDuplicatesII.title = '移除重复元素 II';
    removeDuplicatesII.description = '给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使得出现次数超过两次的元素只出现两次 ，返回删除后数组的新长度。不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。';
    removeDuplicatesII.difficulty = ProblemDifficulty.MEDIUM;
    removeDuplicatesII.category = ProblemCategory.ARRAY;
    removeDuplicatesII.choices = [
      { id: 'A', text: '双指针，慢指针i=2，快指针j=2，若nums[j] != nums[i-2]则保留', isCorrect: true },
      { id: 'B', text: '计数法，记录每个元素出现次数，超过两次则跳过', isCorrect: false },
      { id: 'C', text: '遍历数组，将符合条件的元素复制到前面', isCorrect: false },
      { id: 'D', text: '使用哈希表记录出现次数，再重建数组', isCorrect: false }
    ];
    removeDuplicatesII.explanation = '双指针解法：①若数组长度<=2：return 数组长度；②慢指针i=2；③遍历快指针j从2到nums.length-1：if nums[j] != nums[i-2]：nums[i] = nums[j]；i++；④返回i。时间复杂度O(n)，空间复杂度O(1)，允许元素最多出现两次，通过比较当前元素与i-2位置的元素判断是否保留。';
    removeDuplicatesII.hint = '核心是「允许两次重复」，通过i-2位置的元素判断当前元素是否是第三次出现';
    problems.push(removeDuplicatesII);

    // 1673. 移动零（LeetCode 283）
    const moveZeroes = new ProblemModel();
    moveZeroes.id = 1673;
    moveZeroes.title = '移动零';
    moveZeroes.description = '给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。请注意 ，必须在不复制数组的情况下原地对数组进行操作。';
    moveZeroes.difficulty = ProblemDifficulty.EASY;
    moveZeroes.category = ProblemCategory.ARRAY;
    moveZeroes.choices = [
      { id: 'A', text: '双指针，慢指针记录非零元素位置，快指针遍历，非零则交换，最后填充零', isCorrect: true },
      { id: 'B', text: '遍历数组，遇到零则与后面第一个非零元素交换', isCorrect: false },
      { id: 'C', text: '统计零的个数，将非零元素前移，最后补零', isCorrect: false },
      { id: 'D', text: '使用filter过滤零，再填充到原数组，剩余位置补零', isCorrect: false }
    ];
    moveZeroes.explanation = '双指针解法：①慢指针i=0；②遍历快指针j从0到nums.length-1：if nums[j] != 0：nums[i] = nums[j]；i++；③遍历从i到nums.length-1：nums[k] = 0；④完成。时间复杂度O(n)，空间复杂度O(1)，先移动非零元素，再统一填充零，保持相对顺序。';
    moveZeroes.hint = '关键是「先处理非零元素」，将所有非零元素移到前面，再在剩余位置补零';
    problems.push(moveZeroes);

    // 1674. 加一（LeetCode 66）
    const plusOne = new ProblemModel();
    plusOne.id = 1674;
    plusOne.title = '加一';
    plusOne.description = '给定一个由 整数 组成的 非空 数组所表示的非负整数，在该数的基础上加一。最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。你可以假设除了整数 0 之外，这个整数不会以零开头。';
    plusOne.difficulty = ProblemDifficulty.EASY;
    plusOne.category = ProblemCategory.ARRAY;
    plusOne.choices = [
      { id: 'A', text: '从末尾开始加一，处理进位，若最高位有进位则在开头插入1', isCorrect: true },
      { id: 'B', text: '转换为数字加一后再转换为数组', isCorrect: false },
      { id: 'C', text: '使用BigInt处理大数字', isCorrect: false },
      { id: 'D', text: '递归处理每一位的加一和进位', isCorrect: false }
    ];
    plusOne.explanation = '进位处理解法：①n = digits.length；②遍历i从n-1到0：digits[i] += 1；if digits[i] < 10：return digits；else：digits[i] = 0；③若所有位都进位（如999）：在数组开头插入1；④return digits。时间复杂度O(n)，空间复杂度O(1)（最坏O(n)），正确处理各种进位情况，包括最高位进位。';
    plusOne.hint = '核心是「处理进位」，从最后一位开始加一，若等于10则进位为0，继续处理前一位';
    problems.push(plusOne);

    // 1675. 合并两个有序数组（LeetCode 88）
    const mergeArrays = new ProblemModel();
    mergeArrays.id = 1675;
    mergeArrays.title = '合并两个有序数组';
    mergeArrays.description = '给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。';
    mergeArrays.difficulty = ProblemDifficulty.EASY;
    mergeArrays.category = ProblemCategory.ARRAY;
    mergeArrays.choices = [
      { id: 'A', text: '双指针从后往前，比较两数组末尾元素，大的放到nums1的末尾', isCorrect: true },
      { id: 'B', text: '双指针从前往后，需要额外空间存储nums1的元素', isCorrect: false },
      { id: 'C', text: '将nums2复制到nums1的后面，再排序', isCorrect: false },
      { id: 'D', text: '使用内置的concat和sort方法', isCorrect: false }
    ];
    mergeArrays.explanation = '后向双指针解法：①初始化i = m - 1，j = n - 1，k = m + n - 1；②循环当i >= 0且j >= 0：if nums1[i] > nums2[j]：nums1[k] = nums1[i]；i--；else：nums1[k] = nums2[j]；j--；k--；③若j >= 0：将nums2剩余元素复制到nums1前面；④完成。时间复杂度O(m+n)，空间复杂度O(1)，原地合并，无需额外空间。';
    mergeArrays.hint = '关键是「从后往前合并」，利用nums1后面的空闲空间，避免覆盖未处理的元素';
    problems.push(mergeArrays);

    // 1676. 两数之和（LeetCode 1）
    const twoSum = new ProblemModel();
    twoSum.id = 1676;
    twoSum.title = '两数之和';
    twoSum.description = '给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。';
    twoSum.difficulty = ProblemDifficulty.EASY;
    twoSum.category = ProblemCategory.ARRAY;
    twoSum.choices = [
      { id: 'A', text: '哈希表，存储元素值到索引的映射，遍历同时查找target-当前值', isCorrect: true },
      { id: 'B', text: '暴力双重循环，检查所有可能的两数组合', isCorrect: false },
      { id: 'C', text: '排序后双指针，找到目标和后再找原索引', isCorrect: false },
      { id: 'D', text: '先计算所有元素与target的差值，再查找是否存在', isCorrect: false }
    ];
    twoSum.explanation = '哈希表解法：①创建map存储值到索引的映射；②遍历i从0到nums.length-1：complement = target - nums[i]；if map.has(complement)：return [map.get(complement), i]；map.set(nums[i], i)；③返回空数组（题目保证有解）。时间复杂度O(n)，空间复杂度O(n)，一次遍历完成，高效查找两个数的索引。';
    twoSum.hint = '核心是「空间换时间」，通过哈希表记录已遍历元素，快速查找互补数';
    problems.push(twoSum);

    // 1677. 三数之和（LeetCode 15）- 重复题目，此处为示例延续，实际应避免
    const threeSumAgain = new ProblemModel();
    threeSumAgain.id = 1677;
    threeSumAgain.title = '三数之和（重复示例）';
    threeSumAgain.description = '给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。';
    threeSumAgain.difficulty = ProblemDifficulty.MEDIUM;
    threeSumAgain.category = ProblemCategory.ARRAY;
    threeSumAgain.choices = [
      { id: 'A', text: '排序+双指针，固定第一个数，左右指针找另外两个数', isCorrect: true },
      { id: 'B', text: '哈希表，固定前两个数，查找第三个数', isCorrect: false },
      { id: 'C', text: '暴力三重循环', isCorrect: false },
      { id: 'D', text: '先计算两数之和，再查找第三个数', isCorrect: false }
    ];
    threeSumAgain.explanation = '同1620题三数之和的解释';
    threeSumAgain.hint = '同1620题三数之和的提示';
    problems.push(threeSumAgain);


    // 一、递归类（17题）
    // 1. 斐波那契数列
    const fibonacci = new ProblemModel();
    fibonacci.id = 3001;
    fibonacci.title = '斐波那契数列';
    fibonacci.description = '斐波那契数列定义为：F(0)=0，F(1)=1，F(n)=F(n-1)+F(n-2)（n≥2）。给定n，用递归求F(n)的值。';
    fibonacci.difficulty = ProblemDifficulty.EASY;
    fibonacci.category = ProblemCategory.RECURSION;
    fibonacci.choices = [
      { id: 'A', text: '递归终止条件：n=0返回0，n=1返回1，否则返回F(n-1)+F(n-2)', isCorrect: true },
      { id: 'B', text: '递归终止条件：n≤2返回1，否则返回F(n-1)+F(n-2)', isCorrect: false },
      { id: 'C', text: '迭代计算，用变量存储前两项', isCorrect: false },
      { id: 'D', text: '矩阵快速幂优化递归', isCorrect: false }
    ];
    fibonacci.explanation = '基础递归解法：直接按照定义实现，明确终止条件为n=0和n=1，递归计算n-1和n-2的和。但该方法时间复杂度为O(2ⁿ)，存在大量重复计算，实际应用中需优化。';
    fibonacci.hint = '核心是「递归定义转化」，直接将数学定义翻译为递归函数';
    problems.push(fibonacci);

    // 2. 阶乘计算
    const factorial = new ProblemModel();
    factorial.id = 3002;
    factorial.title = '阶乘计算';
    factorial.description = '阶乘定义为n! = n × (n-1) × ... × 1，0! = 1。给定非负整数n，用递归求n!的值。';
    factorial.difficulty = ProblemDifficulty.EASY;
    factorial.category = ProblemCategory.RECURSION;
    factorial.choices = [
      { id: 'A', text: '终止条件：n=0返回1，否则返回n × factorial(n-1)', isCorrect: true },
      { id: 'B', text: '终止条件：n=1返回1，否则返回n × factorial(n-1)', isCorrect: false },
      { id: 'C', text: '循环累乘计算', isCorrect: false },
      { id: 'D', text: '使用伽马函数近似计算', isCorrect: false }
    ];
    factorial.explanation = '递归解法：当n=0时返回1（0!的定义），对于n>0，递归计算n乘以(n-1)!。时间复杂度O(n)，空间复杂度O(n)（递归栈深度）。';
    factorial.hint = '注意0!的特殊值为1，递归过程从n逐步减到0';
    problems.push(factorial);

    // 3. 汉诺塔问题
    const hanota = new ProblemModel();
    hanota.id = 3003;
    hanota.title = '汉诺塔问题';
    hanota.description = '有A、B、C三根柱子，A上有n个圆盘（上小下大）。每次只能移动一个圆盘，且大盘不能放在小盘上。用递归实现将所有圆盘从A移到C的步骤。';
    hanota.difficulty = ProblemDifficulty.MEDIUM;
    hanota.category = ProblemCategory.RECURSION;
    hanota.choices = [
      { id: 'A', text: 'n=1时直接移A→C；n>1时：先移n-1个从A→B，再移第n个A→C，最后移n-1个从B→C', isCorrect: true },
      { id: 'B', text: 'n=1时移A→B；n>1时：先移n-1个A→C，再移第n个A→B，最后移n-1个C→B', isCorrect: false },
      { id: 'C', text: '用循环模拟移动步骤', isCorrect: false },
      { id: 'D', text: '随机选择柱子移动，检查合法性', isCorrect: false }
    ];
    hanota.explanation = '经典递归问题：将n个圆盘的移动分解为三个步骤，利用中间柱子作为过渡，通过递归处理n-1个圆盘的子问题。时间复杂度O(2ⁿ)，空间复杂度O(n)（递归栈）。';
    hanota.hint = '核心是「问题分解」，把大问题拆解为规模更小的同类问题，利用中间柱子传递圆盘';
    problems.push(hanota);

    // 4. 反转链表（递归版）
    const reverseListRecursive = new ProblemModel();
    reverseListRecursive.id = 3004;
    reverseListRecursive.title = '反转链表（递归版）';
    reverseListRecursive.description = '给你单链表的头节点head，请用递归方法将链表反转，并返回反转后的链表头节点。';
    reverseListRecursive.difficulty = ProblemDifficulty.MEDIUM;
    reverseListRecursive.category = ProblemCategory.RECURSION;
    reverseListRecursive.choices = [
      { id: 'A', text: '终止条件：head或head.next为空返回head；递归反转head.next，将head.next.next指向head，head.next置空', isCorrect: true },
      { id: 'B', text: '遍历链表存储节点，再反向重建链表', isCorrect: false },
      { id: 'C', text: '用三个指针迭代反转', isCorrect: false },
      { id: 'D', text: '递归时直接交换相邻节点的指针', isCorrect: false }
    ];
    reverseListRecursive.explanation = '递归解法：先递归反转当前节点的下一个节点，得到反转后的链表头；再将当前节点设为其下一个节点的下一个节点（反转指针），并断开当前节点与原下一个节点的连接。时间复杂度O(n)，空间复杂度O(n)（递归栈）。';
    hanota.hint = '关注「后序处理」，先完成子链表的反转，再调整当前节点的指针';
    problems.push(reverseListRecursive);


    // 7. 二叉树的中序遍历（递归）
    const inorderTraversal = new ProblemModel();
    inorderTraversal.id = 3007;
    inorderTraversal.title = '二叉树的中序遍历（递归）';
    inorderTraversal.description = '给你二叉树的根节点root，返回它节点值的中序遍历（左→根→右）。要求用递归实现。';
    inorderTraversal.difficulty = ProblemDifficulty.EASY;
    inorderTraversal.category = ProblemCategory.RECURSION;
    inorderTraversal.choices = [
      { id: 'A', text: '递归：递归遍历左子树，访问根节点，递归遍历右子树', isCorrect: true },
      { id: 'B', text: '递归：访问根节点，递归遍历左子树，递归遍历右子树', isCorrect: false },
      { id: 'C', text: '递归：递归遍历左子树，递归遍历右子树，访问根节点', isCorrect: false },
      { id: 'D', text: '用栈迭代实现', isCorrect: false }
    ];
    inorderTraversal.explanation = '中序遍历递归逻辑：先递归处理左子树，再记录当前根节点的值，最后递归处理右子树。时间复杂度O(n)，空间复杂度O(h)。';
    inorderTraversal.hint = '遵循「左根右」的顺序，左子树处理完毕后再访问根节点';
    problems.push(inorderTraversal);

    // 8. 二叉树的后序遍历（递归）
    const postorderTraversal = new ProblemModel();
    postorderTraversal.id = 3008;
    postorderTraversal.title = '二叉树的后序遍历（递归）';
    postorderTraversal.description = '给你二叉树的根节点root，返回它节点值的后序遍历（左→右→根）。要求用递归实现。';
    postorderTraversal.difficulty = ProblemDifficulty.EASY;
    postorderTraversal.category = ProblemCategory.RECURSION;
    postorderTraversal.choices = [
      { id: 'A', text: '递归：递归遍历左子树，递归遍历右子树，访问根节点', isCorrect: true },
      { id: 'B', text: '递归：访问根节点，递归遍历左子树，递归遍历右子树', isCorrect: false },
      { id: 'C', text: '递归：递归遍历左子树，访问根节点，递归遍历右子树', isCorrect: false },
      { id: 'D', text: '用栈迭代实现', isCorrect: false }
    ];
    postorderTraversal.explanation = '后序遍历递归逻辑：先递归处理左子树，再递归处理右子树，最后记录当前根节点的值。时间复杂度O(n)，空间复杂度O(h)。';
    postorderTraversal.hint = '遵循「左右根」的顺序，左右子树均处理完毕后再访问根节点';
    problems.push(postorderTraversal);

    // 10. 子集（无重复元素）
    const subsets = new ProblemModel();
    subsets.id = 3010;
    subsets.title = '子集（无重复元素）';
    subsets.description = '给你一个整数数组nums，数组中的元素互不相同。返回该数组所有可能的子集（幂集）。解集不能包含重复的子集。';
    subsets.difficulty = ProblemDifficulty.MEDIUM;
    subsets.category = ProblemCategory.RECURSION;
    subsets.choices = [
      { id: 'A', text: '递归回溯：每个元素选或不选，递归构建子集，到达末尾时加入结果', isCorrect: true },
      { id: 'B', text: '迭代：从空集开始，每次加入一个元素，与现有子集组合', isCorrect: false },
      { id: 'C', text: '二进制位运算：用位表示元素是否选中', isCorrect: false },
      { id: 'D', text: '动态规划，基于前n-1个元素的子集推导', isCorrect: false }
    ];
    subsets.explanation = '回溯递归解法：定义递归函数，参数为当前索引和临时子集；对于每个元素，有两种选择（加入或不加入子集）；当索引到达数组末尾时，将临时子集加入结果。时间复杂度O(2ⁿ)，空间复杂度O(n)（递归栈+临时子集）。';
    subsets.hint = '利用「选择树」思想，每个元素的选择状态（选/不选）构成所有可能的子集';
    problems.push(subsets);

    // 12. 组合（从n选k）
    const combine = new ProblemModel();
    combine.id = 3012;
    combine.title = '组合（从n选k）';
    combine.description = '给定两个整数n和k，返回范围[1, n]中所有可能的k个数的组合。你可以按任何顺序返回答案。';
    combine.difficulty = ProblemDifficulty.MEDIUM;
    combine.category = ProblemCategory.RECURSION;
    combine.choices = [
      { id: 'A', text: '递归回溯：从start开始选，选够k个加入结果；每次选择后start递增（避免重复）', isCorrect: true },
      { id: 'B', text: '递归时允许重复选择，最后去重', isCorrect: false },
      { id: 'C', text: '用二进制位表示组合，筛选出k个1的情况', isCorrect: false },
      { id: 'D', text: '动态规划，基于n-1选k和n-1选k-1的结果', isCorrect: false }
    ];
    combine.explanation = '回溯解法：定义递归函数，参数为当前组合、起始数字；从start到n遍历，选择数字加入组合；若组合长度为k，加入结果；否则递归选择下一个数字（start+1，确保数字递增，避免重复组合）。时间复杂度O(C(n,k)×k)，空间复杂度O(k)（递归栈+组合存储）。';
    combine.hint = '通过「控制起始索引」避免重复组合，每次选择的数字必须大于上一个';
    problems.push(combine);

    // 13. 组合总和
    const combinationSum = new ProblemModel();
    combinationSum.id = 3013;
    combinationSum.title = '组合总和';
    combinationSum.description = '给你一个无重复元素的整数数组candidates和一个目标整数target，找出candidates中可以使数字和为目标数target的所有不同组合。candidates中的数字可以无限制重复被选取。';
    combinationSum.difficulty = ProblemDifficulty.MEDIUM;
    combinationSum.category = ProblemCategory.RECURSION;
    combinationSum.choices = [
      { id: 'A', text: '排序后递归回溯，每次选择当前或之后的元素（避免重复组合），目标递减至0时加入结果', isCorrect: true },
      { id: 'B', text: '不排序，递归允许任意选择，最后去重', isCorrect: false },
      { id: 'C', text: '动态规划，记录每个目标值的组合方式', isCorrect: false },
      { id: 'D', text: 'BFS层序遍历，每层添加一个元素', isCorrect: false }
    ];
    combinationSum.explanation = '回溯解法：①排序数组（便于剪枝）；②递归函数参数为当前组合、起始索引、剩余目标；③遍历元素从start开始（避免重复组合），若元素>剩余目标则跳过（剪枝）；④选择元素加入组合，递归（目标-元素），回溯移除元素。时间复杂度O(S)（S为所有可行解的长度和），空间复杂度O(target)（递归栈深度）。';
    combinationSum.hint = '「排序+控制起始索引」是去重关键，允许重复选同一元素但需按顺序';
    problems.push(combinationSum);

    // 14. 组合总和II
    const combinationSum2 = new ProblemModel();
    combinationSum2.id = 3014;
    combinationSum2.title = '组合总和II';
    combinationSum2.description = '给定一个候选人编号的集合candidates和一个目标数target，找出candidates中所有可以使数字和为target的组合。candidates中的每个数字在每个组合中只能使用一次。注意：解集不能包含重复的组合。';
    combinationSum2.difficulty = ProblemDifficulty.MEDIUM;
    combinationSum2.category = ProblemCategory.RECURSION;
    combinationSum2.choices = [
      { id: 'A', text: '排序后递归回溯，跳过重复元素（同层相同元素只选第一个），每个元素最多选一次', isCorrect: true },
      { id: 'B', text: '不排序，用哈希表记录已选组合去重', isCorrect: false },
      { id: 'C', text: '允许重复选择，最后过滤重复组合', isCorrect: false },
      { id: 'D', text: '动态规划，基于前i个元素的组合推导', isCorrect: false }
    ];
    combinationSum2.explanation = '带去重的回溯解法：①排序数组；②递归时，若当前元素与前一个相同且前一个未被选择，则跳过（同层去重）；③每个元素只能选择一次（递归时start+1）；④剩余目标为0时加入结果。时间复杂度O(2ⁿ)，空间复杂度O(n)。';
    combinationSum2.hint = '需同时处理「元素不重复使用」和「组合不重复」，排序后剪枝是关键';
    problems.push(combinationSum2);

    // 15. 全排列II（有重复元素）
    const permuteUnique = new ProblemModel();
    permuteUnique.id = 3015;
    permuteUnique.title = '全排列II（有重复元素）';
    permuteUnique.description = '给定一个可包含重复数字的序列nums，按任意顺序返回所有不重复的全排列。';
    permuteUnique.difficulty = ProblemDifficulty.MEDIUM;
    permuteUnique.category = ProblemCategory.RECURSION;
    permuteUnique.choices = [
      { id: 'A', text: '排序后递归回溯，用used数组标记使用状态，同层相同元素若前一个未使用则跳过', isCorrect: true },
      { id: 'B', text: '不排序，递归生成所有排列后去重', isCorrect: false },
      { id: 'C', text: '用哈希表存储已生成的排列，避免重复', isCorrect: false },
      { id: 'D', text: '迭代生成下一个排列，直到所有排列生成', isCorrect: false }
    ];
    permuteUnique.explanation = '去重全排列解法：①排序数组（使重复元素相邻）；②递归时，used[i]为true表示已使用；③若nums[i] == nums[i-1]且used[i-1]为false（同层未使用），则跳过（避免重复）；④其他逻辑同无重复全排列。时间复杂度O(n×n!)，空间复杂度O(n)（used数组+递归栈）。';
    permuteUnique.hint = '「同层去重」是核心，重复元素只在第一个未被使用时选择';
    problems.push(permuteUnique);

    // 16. 电话号码的字母组合
    const letterCombinations = new ProblemModel();
    letterCombinations.id = 3016;
    letterCombinations.title = '电话号码的字母组合';
    letterCombinations.description = '给定一个仅包含数字2-9的字符串，返回所有它能表示的字母组合。答案可以按任意顺序返回。数字到字母的映射与电话按键相同（2→"abc"，3→"def"，...，9→"wxyz"）。';
    letterCombinations.difficulty = ProblemDifficulty.MEDIUM;
    letterCombinations.category = ProblemCategory.RECURSION;
    letterCombinations.choices = [
      { id: 'A', text: '递归回溯：每个数字对应多个字母，递归选择每个位置的字母，拼接成组合', isCorrect: true },
      { id: 'B', text: '迭代：从空字符串开始，每次拼接下一个数字的所有字母', isCorrect: false },
      { id: 'C', text: '用队列存储中间结果，逐层拼接字母', isCorrect: false },
      { id: 'D', text: '动态规划，基于前i个数字的组合推导', isCorrect: false }
    ];
    letterCombinations.explanation = '回溯解法：①建立数字到字母的映射表；②递归函数参数为当前组合和数字索引；③若索引等于数字长度，加入结果；④否则遍历当前数字对应的字母，拼接后递归下一个索引。时间复杂度O(3ⁿ×4ᵐ)（n为对应3个字母的数字数，m为对应4个字母的），空间复杂度O(n+m)。';
    letterCombinations.hint = '将每个数字视为选择层，递归选择每层的字母构建组合';
    problems.push(letterCombinations);

    // 17. 括号生成
    const generateParenthesis = new ProblemModel();
    generateParenthesis.id = 3017;
    generateParenthesis.title = '括号生成';
    generateParenthesis.description = '数字n代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且有效的括号组合。';
    generateParenthesis.difficulty = ProblemDifficulty.MEDIUM;
    generateParenthesis.category = ProblemCategory.RECURSION;
    generateParenthesis.choices = [
      { id: 'A', text: '递归回溯：记录左括号和右括号数量，左<span style="text-decoration: overline;">=</span>n时可加左括号，右<左时可加右括号，长度为2n时加入结果', isCorrect: true },
      { id: 'B', text: '生成所有可能组合，再检查有效性', isCorrect: false },
      { id: 'C', text: '动态规划，基于n-1的结果插入新括号', isCorrect: false },
      { id: 'D', text: '用卡特兰数公式直接计算', isCorrect: false }
    ];
    generateParenthesis.explanation = '回溯解法：通过控制左右括号的生成条件剪枝：①左括号数量小于n时，可添加左括号；②右括号数量小于左括号时，可添加右括号；③当字符串长度为2n时，得到一个有效组合。时间复杂度O(4ⁿ/√n)（卡特兰数增长），空间复杂度O(n)（递归栈）。';
    generateParenthesis.hint = '利用「有效性约束」剪枝，避免生成无效组合（右括号不能多于左括号）';
    problems.push(generateParenthesis);


    // 19. 前K个高频元素
    const topKFrequent = new ProblemModel();
    topKFrequent.id = 3019;
    topKFrequent.title = '前K个高频元素';
    topKFrequent.description = '给你一个整数数组nums和一个整数k，请你返回其中出现频率前k高的元素。你可以按任意顺序返回答案。';
    topKFrequent.difficulty = ProblemDifficulty.MEDIUM;
    topKFrequent.category = ProblemCategory.HEAP;
    topKFrequent.choices = [
      { id: 'A', text: '哈希表统计频率，再用最小堆筛选前k个高频元素', isCorrect: true },
      { id: 'B', text: '哈希表统计频率，排序后取前k个', isCorrect: false },
      { id: 'C', text: '桶排序，按频率分组，从高到低取k个', isCorrect: false },
      { id: 'D', text: '快速选择算法，基于频率数组', isCorrect: false }
    ];
    topKFrequent.explanation = '堆解法：①用哈希表记录元素频率；②构建大小为k的最小堆（存储频率和元素）；③遍历频率表，若堆大小<k则入堆，否则若当前频率>堆顶频率则替换；④最后从堆中提取元素。时间复杂度O(n log k)，空间复杂度O(n)。';
    topKFrequent.hint = '核心是「用堆筛选top k」，避免对所有元素排序的O(n log n)复杂度';
    problems.push(topKFrequent);

    // 20. 数据流中的第K大元素
    const KthLargest = new ProblemModel();
    KthLargest.id = 3020;
    KthLargest.title = '数据流中的第K大元素';
    KthLargest.description = '设计一个找到数据流中第k大元素的类（class）。注意是排序后的第k大元素，不是第k个不同的元素。请实现KthLargest类：KthLargest(int k, int[] nums) 使用整数k和整数流nums初始化对象；int add(int val) 将val插入数据流nums后，返回当前数据流中第k大的元素。';
    KthLargest.difficulty = ProblemDifficulty.EASY;
    KthLargest.category = ProblemCategory.HEAP;
    KthLargest.choices = [
      { id: 'A', text: '维护一个大小为k的最小堆，堆顶即为第k大元素；add时若堆未满则入堆，否则大于堆顶则替换', isCorrect: true },
      { id: 'B', text: '维护一个最大堆，每次add后弹出k-1个元素取堆顶', isCorrect: false },
      { id: 'C', text: '每次add后对数组排序，取第k大', isCorrect: false },
      { id: 'D', text: '用平衡二叉搜索树存储元素，直接访问第k大', isCorrect: false }
    ];
    KthLargest.explanation = '最小堆解法：①初始化时，将nums中元素加入最小堆，保持堆大小为k（多余元素移除）；②add方法：若元素>堆顶或堆未满，加入堆并调整至大小k；③堆顶即为当前第k大元素。时间复杂度：初始化O(n log k)，add O(log k)，空间复杂度O(k)。';
    KthLargest.hint = '堆的大小固定为k，始终保留当前最大的k个元素，堆顶自然是第k大';
    problems.push(KthLargest);

    // 21. 数据流的中位数
    const MedianFinder = new ProblemModel();
    MedianFinder.id = 3021;
    MedianFinder.title = '数据流的中位数';
    MedianFinder.description = '中位数是有序列表中间的数。如果列表长度是偶数，中位数则是中间两个数的平均值。设计一个支持以下两种操作的数据结构：void addNum(int num) - 从数据流中添加一个整数到数据结构中；double findMedian() - 返回目前所有元素的中位数。';
    MedianFinder.difficulty = ProblemDifficulty.HARD;
    MedianFinder.category = ProblemCategory.HEAP;
    MedianFinder.choices = [
      { id: 'A', text: '大顶堆存较小一半元素，小顶堆存较大一半元素；大顶堆 size = 小顶堆 size 或 size+1，中位数为堆顶平均或大顶堆顶', isCorrect: true },
      { id: 'B', text: '每次add后排序，取中间元素', isCorrect: false },
      { id: 'C', text: '用一个大顶堆存储所有元素，取中间元素', isCorrect: false },
      { id: 'D', text: '平衡二叉搜索树，记录元素数量，直接访问中间节点', isCorrect: false }
    ];
    MedianFinder.explanation = '双堆解法：①大顶堆（maxHeap）存储较小的一半元素，小顶堆（minHeap）存储较大的一半；②添加元素时，先加入maxHeap，再将maxHeap顶移至minHeap（或相反），确保平衡；③maxHeap size 等于 minHeap size 或多1；④findMedian时，若size相等取两堆顶平均，否则取maxHeap顶。时间复杂度：add O(log n)，findMedian O(1)，空间复杂度O(n)。';
    MedianFinder.hint = '双堆分别维护两半元素，通过堆顶快速获取中位数，避免全量排序';
    problems.push(MedianFinder);

    // 22. 合并K个排序链表
    const mergeKLists = new ProblemModel();
    mergeKLists.id = 3022;
    mergeKLists.title = '合并K个排序链表';
    mergeKLists.description = '给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。';
    mergeKLists.difficulty = ProblemDifficulty.HARD;
    mergeKLists.category = ProblemCategory.HEAP;
    mergeKLists.choices = [
      { id: 'A', text: '小顶堆：存储各链表当前头节点，每次取堆顶（最小值），并将其next入堆', isCorrect: true },
      { id: 'B', text: '逐一合并：先合并两个，再与第三个合并...', isCorrect: false },
      { id: 'C', text: '分治法：两两合并，递归处理', isCorrect: false },
      { id: 'D', text: '取出所有节点排序后重建链表', isCorrect: false }
    ];
    mergeKLists.explanation = '堆解法：①将k个链表的头节点加入小顶堆（按节点值排序）；②创建虚拟头节点，current指针指向它；③循环：取出堆顶节点（最小值），current.next指向该节点，current后移；④若该节点有next，将next加入堆；⑤直到堆为空，返回虚拟头节点的next。时间复杂度O(N log k)（N为总节点数），空间复杂度O(k)。';
    mergeKLists.hint = '用堆高效获取当前k个节点中的最小值，避免每次线性扫描';
    problems.push(mergeKLists);

    // 23. 最接近原点的K个点
    const kClosest = new ProblemModel();
    kClosest.id = 3023;
    kClosest.title = '最接近原点的K个点';
    kClosest.description = '给定一个数组points，其中points[i] = [x_i, y_i]表示X-Y平面上的一个点，并且是一个整数k，请返回离原点(0,0)最近的k个点。这里，平面上两点之间的距离是欧几里德距离（√(x₁² + y₁²)）。你可以按任何顺序返回答案。';
    kClosest.difficulty = ProblemDifficulty.MEDIUM;
    kClosest.category = ProblemCategory.HEAP;
    kClosest.choices = [
      { id: 'A', text: '最大堆：维护大小为k的堆（存储距离最大的k个点），遍历结束后堆中即为结果', isCorrect: true },
      { id: 'B', text: '最小堆：存储所有点，弹出前k个', isCorrect: false },
      { id: 'C', text: '排序后取前k个', isCorrect: false },
      { id: 'D', text: '快速选择算法，基于距离数组', isCorrect: false }
    ];
    kClosest.explanation = '最大堆解法：①计算每个点到原点的距离（可用平方避免开方）；②构建大小为k的最大堆（存储距离最大的k个候选点）；③遍历点，若堆大小<k则入堆，否则若当前距离<堆顶距离则替换；④最后堆中元素即为最近的k个点。时间复杂度O(n log k)，空间复杂度O(k)。';
    kClosest.hint = '最大堆的堆顶是当前k个点中最远的，若新点更近则替换，最终保留最近的k个';
    problems.push(kClosest);

    // 24. 查找和最小的K对数字
    const kSmallestPairs = new ProblemModel();
    kSmallestPairs.id = 3024;
    kSmallestPairs.title = '查找和最小的K对数字';
    kSmallestPairs.description = '给定两个以升序排列的整数数组nums1和nums2，以及一个整数k。定义一对值(u,v)，其中第一个元素来自nums1，第二个元素来自nums2。请找到和最小的k对数字(u1,v1), (u2,v2) ..., (uk,vk)。';
    kSmallestPairs.difficulty = ProblemDifficulty.MEDIUM;
    kSmallestPairs.category = ProblemCategory.HEAP;
    kSmallestPairs.choices = [
      { id: 'A', text: '小顶堆：初始加入(0,0)，每次取堆顶(i,j)，并加入(i+1,j)和(i,j+1)（避免重复）', isCorrect: true },
      { id: 'B', text: '生成所有可能的对，排序后取前k个', isCorrect: false },
      { id: 'C', text: '最大堆：维护k个最小和的对', isCorrect: false },
      { id: 'D', text: '双指针，类似归并排序', isCorrect: false }
    ];
    kSmallestPairs.explanation = '堆解法：①用小顶堆存储索引对(i,j)，按nums1[i]+nums2[j]排序；②初始加入(0,0)，并用visited数组避免重复；③循环k次：取出堆顶(i,j)加入结果；④若i+1 < len(nums1)且未访问，加入(i+1,j)并标记；⑤若j+1 < len(nums2)且未访问，加入(i,j+1)并标记；⑥返回结果。时间复杂度O(k log k)，空间复杂度O(k)。';
    kSmallestPairs.hint = '利用数组升序特性，从最小和(0,0)开始，逐步扩展候选对';
    problems.push(kSmallestPairs);

    // 25. 第K个最小的素数分数
    const kthSmallestPrimeFraction = new ProblemModel();
    kthSmallestPrimeFraction.id = 3025;
    kthSmallestPrimeFraction.title = '第K个最小的素数分数';
    kthSmallestPrimeFraction.description = '给你一个按递增顺序排序的数组arr，其中每个元素都是一个素数。请你找出arr中第k个最小的分数a/b，其中a和b是数组中的元素，且a < b。';
    kthSmallestPrimeFraction.difficulty = ProblemDifficulty.HARD;
    kthSmallestPrimeFraction.category = ProblemCategory.HEAP;
    kthSmallestPrimeFraction.choices = [
      { id: 'A', text: '小顶堆：初始加入(0,j)（j从1到n-1），每次取堆顶(i,j)，并加入(i+1,j)（i+1<j），第k次取出的即为结果', isCorrect: true },
      { id: 'B', text: '生成所有可能分数，排序后取第k个', isCorrect: false },
      { id: 'C', text: '二分查找，统计小于mid的分数数量', isCorrect: false },
      { id: 'D', text: '最大堆维护k个最小分数', isCorrect: false }
    ];
    kthSmallestPrimeFraction.explanation = '堆解法：①数组递增且元素为素数，故分数a/b随a增大而增大，随b增大而减小；②初始将(0,j)入堆（最小的分数是arr[0]/arr[j]）；③循环k次：取出堆顶(i,j)，若i+1 < j，将(i+1,j)入堆；④第k次取出的(i,j)对应的arr[i]/arr[j]即为答案。时间复杂度O(k log n)，空间复杂度O(n)。';
    kthSmallestPrimeFraction.hint = '利用数组有序性，从最小的候选分数开始，逐步生成更大的分数';
    problems.push(kthSmallestPrimeFraction);

    // 26. 任务调度器
    const leastInterval = new ProblemModel();
    leastInterval.id = 3026;
    leastInterval.title = '任务调度器';
    leastInterval.description = '给你一个用字符数组tasks表示的CPU需要执行的任务列表。其中每个字母表示一种不同种类的任务。任务可以以任意顺序执行，并且每个任务都可以在1个单位时间内执行完。在任何一个单位时间，CPU可以完成一个任务，或者处于待命状态。然而，两个相同种类的任务之间必须有长度为n的冷却时间，因此至少有n个单位时间内CPU在执行不同的任务，或者在待命。返回完成所有任务所需要的最短时间。';
    leastInterval.difficulty = ProblemDifficulty.MEDIUM;
    leastInterval.category = ProblemCategory.HEAP;
    leastInterval.choices = [
      { id: 'A', text: '最大堆：存储任务剩余次数，每次取最多剩余次数的任务执行，冷却期内安排其他任务', isCorrect: true },
      { id: 'B', text: '计算最大频率任务所需的最少时间，与总任务数比较', isCorrect: false },
      { id: 'C', text: '排序后按频率高低安排任务', isCorrect: false },
      { id: 'D', text: '贪心算法，优先执行冷却时间快结束的任务', isCorrect: false }
    ];
    leastInterval.explanation = '堆解法：①用哈希表统计任务频率，放入最大堆；②时间time=0，用队列记录冷却中的任务（剩余次数，下次可执行时间）；③循环：若堆非空，取出顶部任务（次数最多），执行（time++），次数-1；若次数>0，加入队列（time+n）；④若队列非空且队首任务冷却结束，移回堆；⑤直到堆和队列都为空，返回time。时间复杂度O(m log 26)（m为任务总数），空间复杂度O(26)。';
    leastInterval.hint = '始终优先执行剩余次数最多的任务，减少整体待命时间';
    problems.push(leastInterval);

    // 27. 重构字符串
    const reorganizeString = new ProblemModel();
    reorganizeString.id = 3027;
    reorganizeString.title = '重构字符串';
    reorganizeString.description = '给定一个字符串s，检查是否能重新排布其中的字母，使得两相邻的字符不同。返回任意可行的结果。如果不可行，返回空字符串。';
    reorganizeString.difficulty = ProblemDifficulty.MEDIUM;
    reorganizeString.category = ProblemCategory.HEAP;
    reorganizeString.choices = [
      { id: 'A', text: '最大堆：每次取出现次数最多的字符（与前一个不同），减少次数后放回堆（次数>0）', isCorrect: true },
      { id: 'B', text: '排序后间隔放置字符', isCorrect: false },
      { id: 'C', text: '贪心算法，从出现次数最多的字符开始放置', isCorrect: false },
      { id: 'D', text: '检查最大频率是否超过阈值，若超过返回空，否则构造', isCorrect: false }
    ];
    reorganizeString.explanation = '堆解法：①统计字符频率，若最大频率>ceil(n/2)，返回""；②最大堆存储(频率, 字符)；③prev记录上一个使用的字符及剩余频率；④循环：从堆取顶部字符（与prev不同），加入结果，频率-1；⑤若prev频率>0，放回堆；⑥更新prev为当前字符；⑦直到堆空，返回结果。时间复杂度O(n log 26)，空间复杂度O(26)。';
    reorganizeString.hint = '关键是「避免连续相同字符」，用堆每次选择次高频字符';
    problems.push(reorganizeString);

    // 28. 相对名次
    const findRelativeRanks = new ProblemModel();
    findRelativeRanks.id = 3028;
    findRelativeRanks.title = '相对名次';
    findRelativeRanks.description = '给你一个长度为n的整数数组score，其中score[i]是第i位运动员在比赛中的得分。所有得分都 互不相同 。运动员将根据得分 从高到低 获得名次，其中名次第1的运动员得分最高，名次第2的运动员得分第2高，依此类推。名次有三个特殊名称：第1名是"Gold Medal"，第2名是"Silver Medal"，第3名是"Bronze Medal"。其余的名次用它们的排名编号表示（即第4名是"4"，第5名是"5"，以此类推）。返回一个长度为n的字符串数组answer，其中answer[i]是第i位运动员的名次。';
    findRelativeRanks.difficulty = ProblemDifficulty.EASY;
    findRelativeRanks.category = ProblemCategory.HEAP;
    findRelativeRanks.choices = [
      { id: 'A', text: '最大堆：存储(分数, 索引)，弹出时按顺序赋予名次', isCorrect: true },
      { id: 'B', text: '排序后映射名次', isCorrect: false },
      { id: 'C', text: '用哈希表记录分数与名次的对应关系', isCorrect: false },
      { id: 'D', text: '逐个查找每个分数的排名', isCorrect: false }
    ];
    findRelativeRanks.explanation = '堆解法：①将(score[i], i)存入最大堆；②初始化名次计数器rank=1；③循环弹出堆顶元素：根据rank赋值名次（1→金牌，2→银牌，3→铜牌，其余为数字）；④将名次存入answer[索引]；⑤返回answer。时间复杂度O(n log n)，空间复杂度O(n)。';
    findRelativeRanks.hint = '利用最大堆按分数降序获取运动员，依次分配名次';
    problems.push(findRelativeRanks);

    // 29. 最大堆的实现
    const MaxHeap = new ProblemModel();
    MaxHeap.id = 3029;
    MaxHeap.title = '最大堆的实现';
    MaxHeap.description = '实现一个最大堆类，支持以下操作：1. 插入元素；2. 删除并返回堆顶元素（最大值）；3. 获取堆顶元素；4. 判断堆是否为空；5. 获取堆的大小。';
    MaxHeap.difficulty = ProblemDifficulty.MEDIUM;
    MaxHeap.category = ProblemCategory.HEAP;
    MaxHeap.choices = [
      { id: 'A', text: '用数组存储，父节点i的左子节点为2i+1，右子节点为2i+2；插入时上滤，删除时下滤', isCorrect: true },
      { id: 'B', text: '用链表存储，父节点指向子节点，插入时比较父节点', isCorrect: false },
      { id: 'C', text: '插入时直接放在末尾，删除时线性查找最大值', isCorrect: false },
      { id: 'D', text: '用二叉搜索树实现，根节点为最大值', isCorrect: false }
    ];
    MaxHeap.explanation = '数组实现最大堆：①底层用数组存储，索引0为堆顶；②插入：添加到数组末尾，与父节点比较，若更大则交换（上滤），直到根节点或父节点更大；③删除堆顶：用最后一个元素替换堆顶，移除最后一个元素，然后与子节点比较，若小于子节点则交换（下滤），直到叶节点或子节点更小；④其他操作基于数组长度和首元素实现。时间复杂度：插入和删除O(log n)，查询O(1)。';
    MaxHeap.hint = '堆是完全二叉树，数组存储可通过索引计算父子关系，上滤和下滤是维护堆性质的核心';
    problems.push(MaxHeap);

    // 30. 最小堆的实现
    const MinHeap = new ProblemModel();
    MinHeap.id = 3030;
    MinHeap.title = '最小堆的实现';
    MinHeap.description = '实现一个最小堆类，支持以下操作：1. 插入元素；2. 删除并返回堆顶元素（最小值）；3. 获取堆顶元素；4. 判断堆是否为空；5. 获取堆的大小。';
    MinHeap.difficulty = ProblemDifficulty.MEDIUM;
    MinHeap.category = ProblemCategory.HEAP;
    MinHeap.choices = [
      { id: 'A', text: '用数组存储，父节点i的左子节点为2i+1，右子节点为2i+2；插入时上滤（与父节点比较，更小则交换），删除时下滤（与子节点比较，更大则交换）', isCorrect: true },
      { id: 'B', text: '用链表存储，插入时放在头部，再调整', isCorrect: false },
      { id: 'C', text: '插入时直接排序，删除时取第一个元素', isCorrect: false },
      { id: 'D', text: '与最大堆实现相同，只是插入和删除时比较逻辑相反', isCorrect: false }
    ];
    MinHeap.explanation = '数组实现最小堆：①结构同最大堆，区别在于比较逻辑；②插入：添加到末尾，若小于父节点则交换（上滤）；③删除堆顶：用最后一个元素替换，若大于子节点则交换（下滤，与较小的子节点交换）；④其他操作与最大堆类似。时间复杂度：插入和删除O(log n)，查询O(1)。';
    MinHeap.hint = '与最大堆的区别仅在于比较方向，始终保持父节点小于子节点';
    problems.push(MinHeap);

    // 31. 堆排序（升序，用最大堆）
    const heapSortAsc = new ProblemModel();
    heapSortAsc.id = 3031;
    heapSortAsc.title = '堆排序（升序，用最大堆）';
    heapSortAsc.description = '实现堆排序算法，对数组进行升序排序，要求使用最大堆实现。';
    heapSortAsc.difficulty = ProblemDifficulty.MEDIUM;
    heapSortAsc.category = ProblemCategory.HEAP;
    heapSortAsc.choices = [
      { id: 'A', text: '步骤：1. 构建最大堆；2. 交换堆顶（最大值）与末尾元素，堆大小减1；3. 对堆顶下滤；4. 重复至堆大小为1', isCorrect: true },
      { id: 'B', text: '构建最小堆，依次取出堆顶元素', isCorrect: false },
      { id: 'C', text: '每次插入元素后维护堆，再依次取出', isCorrect: false },
      { id: 'D', text: '用二叉搜索树辅助排序', isCorrect: false }
    ];
    heapSortAsc.explanation = '最大堆升序排序：①构建最大堆（从最后一个非叶节点开始下滤）；②循环：将堆顶（最大值）与当前堆的最后一个元素交换；③堆大小减1；④对新堆顶执行下滤；⑤直到堆大小为1。时间复杂度O(n log n)，空间复杂度O(1)（原地排序）。';
    heapSortAsc.hint = '最大堆的堆顶是最大值，通过交换到末尾并缩小堆范围，逐步构建有序数组';
    problems.push(heapSortAsc);

    // 32. 堆排序（降序，用最小堆）
    const heapSortDesc = new ProblemModel();
    heapSortDesc.id = 3032;
    heapSortDesc.title = '堆排序（降序，用最小堆）';
    heapSortDesc.description = '实现堆排序算法，对数组进行降序排序，要求使用最小堆实现。';
    heapSortDesc.difficulty = ProblemDifficulty.MEDIUM;
    heapSortDesc.category = ProblemCategory.HEAP;
    heapSortDesc.choices = [
      { id: 'A', text: '步骤：1. 构建最小堆；2. 交换堆顶（最小值）与末尾元素，堆大小减1；3. 对堆顶下滤；4. 重复至堆大小为1', isCorrect: true },
      { id: 'B', text: '构建最大堆，依次取出堆顶元素', isCorrect: false },
      { id: 'C', text: '每次插入元素后维护堆，再反向取出', isCorrect: false },
      { id: 'D', text: '用冒泡排序思想优化', isCorrect: false }
    ];
    heapSortDesc.explanation = '最小堆降序排序：①构建最小堆；②循环：将堆顶（最小值）与当前堆的最后一个元素交换；③堆大小减1；④对新堆顶执行下滤；⑤直到堆大小为1，数组呈降序。时间复杂度O(n log n)，空间复杂度O(1)。';
    heapSortDesc.hint = '最小堆的堆顶是最小值，交换到末尾后，末尾元素依次增大，形成降序';
    problems.push(heapSortDesc);

    // 33. 找出第K大的异或坐标值
    const kthLargestValue = new ProblemModel();
    kthLargestValue.id = 3033;
    kthLargestValue.title = '找出第K大的异或坐标值';
    kthLargestValue.description = '给你一个二维矩阵matrix和一个整数k，矩阵大小为m x n由非负整数组成。坐标(i,j)的「异或坐标值」定义为：matrix[0][0] XOR matrix[0][1] XOR ... XOR matrix[0][j] XOR matrix[1][0] XOR ... XOR matrix[i][j]（即从(0,0)到(i,j)的异或和）。请你找出matrix的所有异或坐标值中第k大的值。';
    kthLargestValue.difficulty = ProblemDifficulty.MEDIUM;
    kthLargestValue.category = ProblemCategory.HEAP;
    kthLargestValue.choices = [
      { id: 'A', text: '前缀异或计算所有坐标值，用最小堆筛选第k大值', isCorrect: true },
      { id: 'B', text: '计算所有坐标值后排序，取第k大', isCorrect: false },
      { id: 'C', text: '用最大堆存储所有值，弹出k-1个后取堆顶', isCorrect: false },
      { id: 'D', text: '快速选择算法，在坐标值数组中查找', isCorrect: false }
    ];
    kthLargestValue.explanation = '堆解法：①用前缀异或公式计算所有坐标(i,j)的异或值（dp[i][j] = dp[i-1][j] XOR dp[i][j-1] XOR dp[i-1][j-1] XOR matrix[i][j]）；②用大小为k的最小堆存储这些值，超过k则替换堆顶；③最终堆顶即为第k大值。时间复杂度O(mn log k)，空间复杂度O(k + mn)（可优化前缀异或空间）。';
    kthLargestValue.hint = '先高效计算所有异或坐标值，再用堆筛选top k';
    problems.push(kthLargestValue);

    // 34. 吃苹果的最大数目
    const eatenApples = new ProblemModel();
    eatenApples.id = 3034;
    eatenApples.title = '吃苹果的最大数目';
    eatenApples.description = '有一棵特殊的苹果树，一连n天，每天都可以长出若干个苹果。在第i天，树上会长出apples[i]个苹果，这些苹果会在days[i]天后（也就是说，第i + days[i]天）过期，过期的苹果不能吃。每天，你可以吃一个苹果，如果有多个苹果，你要选择最快要过期的那个。请你返回你可以吃掉的苹果的最大数目。';
    eatenApples.difficulty = ProblemDifficulty.MEDIUM;
    eatenApples.category = ProblemCategory.HEAP;
    eatenApples.choices = [
      { id: 'A', text: '小顶堆：存储(过期日, 数量)，每天先移除已过期的，再吃一个（若有），并添加当天新苹果', isCorrect: true },
      { id: 'B', text: '贪心选择数量最多的苹果吃', isCorrect: false },
      { id: 'C', text: '按过期日排序，依次食用', isCorrect: false },
      { id: 'D', text: '动态规划，记录每天能吃的最大苹果数', isCorrect: false }
    ];
    eatenApples.explanation = '堆解法：①小顶堆按过期日排序；②day=0开始，循环：若day < n，将(apples[day], day+days[day])入堆；③移除堆顶过期的（过期日<=day）；④若堆非空，取出堆顶，数量-1，计数+1，若数量>0放回堆；⑤day++；⑥直到堆空且day >=n。时间复杂度O((n + max_day) log n)，空间复杂度O(n)。';
    eatenApples.hint = '核心是「优先吃快过期的苹果」，用小顶堆维护过期日，避免浪费';
    problems.push(eatenApples);


    // 三、队列类（16题）
    // 35. 用队列实现栈
    const MyStackByQueue = new ProblemModel();
    MyStackByQueue.id = 3035;
    MyStackByQueue.title = '用队列实现栈';
    MyStackByQueue.description = '请你仅使用两个队列实现一个后入先出（LIFO）的栈，并支持普通栈的全部四种操作（push、top、pop和empty）。实现MyStack类：void push(int x) 将元素x压入栈顶；int pop() 移除并返回栈顶元素；int top() 返回栈顶元素；boolean empty() 如果栈是空的，返回true；否则，返回false。';
    MyStackByQueue.difficulty = ProblemDifficulty.EASY;
    MyStackByQueue.category = ProblemCategory.QUEUE;
    MyStackByQueue.choices = [
      { id: 'A', text: '两个队列：push到非空队列；pop时将前n-1个元素移到另一个队列，返回最后一个元素', isCorrect: true },
      { id: 'B', text: '两个队列：push到队列后，将前面所有元素移到另一个队列再移回', isCorrect: false },
      { id: 'C', text: '一个队列：push后将前n-1个元素出队再入队，使新元素在队首', isCorrect: false },
      { id: 'D', text: '用链表模拟队列实现栈', isCorrect: false }
    ];
    MyStackByQueue.explanation = '双队列解法：①q1和q2，始终保持一个为空；②push：加入非空队列（初始都空时加q1）；③pop：将非空队列的前size-1个元素移到另一个队列，返回最后一个元素；④top：类似pop，但不移除元素，返回后将元素放回另一个队列；⑤empty：两队列都为空。时间复杂度：push O(1)，pop和top O(n)，空间复杂度O(n)。';
    MyStackByQueue.hint = '栈是LIFO，队列是FIFO，通过转移元素使队列尾部元素能被优先取出';
    problems.push(MyStackByQueue);

    // 36. 用栈实现队列
    const MyQueueByStack = new ProblemModel();
    MyQueueByStack.id = 3036;
    MyQueueByStack.title = '用栈实现队列';
    MyQueueByStack.description = '请你仅使用两个栈实现先入先出队列。队列应当支持一般队列支持的所有操作（push、pop、peek、empty）：void push(int x) 将元素x推到队列的末尾；int pop() 从队列的开头移除并返回元素；int peek() 返回队列开头的元素；boolean empty() 如果队列为空，返回true；否则，返回false。';
    MyQueueByStack.difficulty = ProblemDifficulty.EASY;
    MyQueueByStack.category = ProblemCategory.QUEUE;
    MyQueueByStack.choices = [
      { id: 'A', text: '两个栈：push栈（输入）和pop栈（输出）；pop/peek时若输出栈空，将输入栈元素全部倒入输出栈', isCorrect: true },
      { id: 'B', text: '两个栈：每次push都将元素移到另一个栈再移回', isCorrect: false },
      { id: 'C', text: '一个栈：push时反转栈，pop时直接取', isCorrect: false },
      { id: 'D', text: '用链表模拟栈实现队列', isCorrect: false }
    ];
    MyQueueByStack.explanation = '双栈解法：①inStack负责输入，outStack负责输出；②push：直接入inStack；③pop：若outStack为空，将inStack所有元素弹出并压入outStack，再从outStack弹出；④peek：类似pop，但不弹出元素；⑤empty：两栈都为空。时间复杂度：push O(1)，pop和peek amortized O(1)，空间复杂度O(n)。';
    MyQueueByStack.hint = '输入栈反转后即为输出栈，实现FIFO特性，避免每次操作都转移元素';
    problems.push(MyQueueByStack);

    // 37. 循环队列的实现
    const MyCircularQueue = new ProblemModel();
    MyCircularQueue.id = 3037;
    MyCircularQueue.title = '循环队列的实现';
    MyCircularQueue.description = '设计你的循环队列实现。循环队列是一种线性数据结构，其操作表现基于FIFO（先进先出）原则并且队尾被连接在队首之后以形成一个循环。它也被称为"环形缓冲器"。循环队列的一个好处是我们可以利用这个队列之前用过的空间。在一个普通队列里，一旦一个队列满了，我们就不能插入下一个元素，即使在队列前面仍有空间。但是使用循环队列，我们能使用这些空间去存储新的值。你的实现应该支持如下操作：MyCircularQueue(k) 构造器，设置队列长度为k；boolean enQueue(int value) 向循环队列插入一个元素。如果成功插入则返回真；boolean deQueue() 从循环队列中删除一个元素。如果成功删除则返回真；int Front() 获取队首元素。如果队列为空，返回-1；int Rear() 获取队尾元素。如果队列为空，返回-1；boolean isEmpty() 检查循环队列是否为空；boolean isFull() 检查循环队列是否为满。';
    MyCircularQueue.difficulty = ProblemDifficulty.MEDIUM;
    MyCircularQueue.category = ProblemCategory.QUEUE;
    MyCircularQueue.choices = [
      { id: 'A', text: '用数组实现，维护front（队首索引）、rear（队尾索引+1）、size；空：front == rear；满：(rear+1)%capacity == front', isCorrect: true },
      { id: 'B', text: '用链表实现，记录头、尾节点和当前大小', isCorrect: false },
      { id: 'C', text: '用数组实现，front和rear都指向实际元素，用计数器判断空满', isCorrect: false },
      { id: 'D', text: '用栈模拟循环队列', isCorrect: false }
    ];
    MyCircularQueue.explanation = '数组循环队列：①capacity = k+1（预留一个空位区分空满）；②front=0，rear=0；③enQueue：若不满，rear=(rear+1)%capacity，赋值；④deQueue：若不空，front=(front+1)%capacity；⑤Front：返回arr[front]；⑥Rear：返回arr[(rear-1+capacity)%capacity]；⑦空：front==rear；满：(rear+1)%capacity==front。时间复杂度O(1)，空间复杂度O(k)。';
    MyCircularQueue.hint = '关键是「空满判断」，通过预留一个空位，用front和rear的关系区分';
    problems.push(MyCircularQueue);

    // 38. 设计循环双端队列
    const MyCircularDeque = new ProblemModel();
    MyCircularDeque.id = 3038;
    MyCircularDeque.title = '设计循环双端队列';
    MyCircularDeque.description = '设计实现双端队列。你的实现需要支持以下操作：MyCircularDeque(k)：构造函数,双端队列的大小为k；boolean insertFront(int value)：将一个元素添加到双端队列头部。如果操作成功返回true；boolean insertLast(int value)：将一个元素添加到双端队列尾部。如果操作成功返回true；boolean deleteFront()：从双端队列头部删除一个元素。如果操作成功返回true；boolean deleteLast()：从双端队列尾部删除一个元素。如果操作成功返回true；int getFront()：从双端队列头部获得一个元素。如果双端队列为空，返回-1；int getRear()：获得双端队列的最后一个元素。如果双端队列为空，返回-1；boolean isEmpty()：检查双端队列是否为空；boolean isFull()：检查双端队列是否满了。';
    MyCircularDeque.difficulty = ProblemDifficulty.MEDIUM;
    MyCircularDeque.category = ProblemCategory.QUEUE;
    MyCircularDeque.choices = [
      { id: 'A', text: '数组实现，front和rear指向队首和队尾的下一个位置，支持头部插入（front左移）和尾部插入（rear右移）', isCorrect: true },
      { id: 'B', text: '链表实现，头节点和尾节点支持双向操作', isCorrect: false },
      { id: 'C', text: '两个栈实现，分别处理前后端插入删除', isCorrect: false },
      { id: 'D', text: '循环队列基础上增加头部操作，每次头部插入需移动所有元素', isCorrect: false }
    ];
    MyCircularDeque.explanation = '数组双端队列：①capacity = k+1；②front=0，rear=0；③insertFront：front=(front-1+capacity)%capacity，赋值；④insertLast：同循环队列enQueue；⑤deleteFront：同循环队列deQueue；⑥deleteLast：rear=(rear-1+capacity)%capacity；⑦其他操作类似循环队列。支持两端O(1)插入删除。';
    MyCircularDeque.hint = '在循环队列基础上，允许front指针左移（头部插入）和rear指针左移（尾部删除）';
    problems.push(MyCircularDeque);

    // 39. 最近的请求次数
    const RecentCounter = new ProblemModel();
    RecentCounter.id = 3039;
    RecentCounter.title = '最近的请求次数';
    RecentCounter.description = '写一个RecentCounter类来计算特定时间范围内最近的请求。请实现RecentCounter类：RecentCounter() 初始化计数器，请求数为0；int ping(int t) 在时间t添加一个新请求，其中t表示以毫秒为单位的时间，并返回过去3000毫秒内发生的所有请求数（包括新请求）。确切地说，返回在[t-3000, t]内发生的请求数。';
    RecentCounter.difficulty = ProblemDifficulty.EASY;
    RecentCounter.category = ProblemCategory.QUEUE;
    RecentCounter.choices = [
      { id: 'A', text: '队列：每次ping(t)时，将t入队，再弹出所有小于t-3000的元素，返回队列大小', isCorrect: true },
      { id: 'B', text: '数组：存储所有请求时间，每次ping时二分查找t-3000的位置', isCorrect: false },
      { id: 'C', text: '链表：维护有序请求，删除过期时间', isCorrect: false },
      { id: 'D', text: '哈希表：记录每个时间的请求数，计算范围内总和', isCorrect: false }
    ];
    RecentCounter.explanation = '队列解法：①队列存储请求时间，按时间递增；②ping(t)：t入队；③循环弹出队首元素，直到队首 >= t-3000；④返回队列大小。时间复杂度：每个元素入队出队各一次，amortized O(1)，空间复杂度O(3000)（最多存储3000ms内的请求）。';
    RecentCounter.hint = '请求时间递增，用队列自然维护顺序，过期请求从队首移除';
    problems.push(RecentCounter);


    // 41. 二叉树的层序遍历II（自底向上）
    const levelOrderBottom = new ProblemModel();
    levelOrderBottom.id = 3041;
    levelOrderBottom.title = '二叉树的层序遍历II（自底向上）';
    levelOrderBottom.description = '给你二叉树的根节点root，返回其节点值 自底向上的层序遍历 。（即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）。';
    levelOrderBottom.difficulty = ProblemDifficulty.MEDIUM;
    levelOrderBottom.category = ProblemCategory.QUEUE;
    levelOrderBottom.choices = [
      { id: 'A', text: '队列层序遍历（自顶向下），最后反转结果列表', isCorrect: true },
      { id: 'B', text: '栈存储每层节点，出栈后遍历', isCorrect: false },
      { id: 'C', text: '递归时先处理子树，再添加当前层', isCorrect: false },
      { id: 'D', text: '计算树的深度，从最深层开始收集节点', isCorrect: false }
    ];
    levelOrderBottom.explanation = '队列解法：①同自顶向下的层序遍历，得到每层节点列表；②将结果列表反转，得到自底向上的顺序。时间复杂度O(n)，空间复杂度O(n)。';
    levelOrderBottom.hint = '最简单的方法是先获取自顶向下的层序结果，再反转列表';
    problems.push(levelOrderBottom);

    // 43. 课程表II（拓扑排序，BFS）
    const findOrder = new ProblemModel();
    findOrder.id = 3043;
    findOrder.title = '课程表II（拓扑排序，BFS）';
    findOrder.description = '现在你总共有numCourses门课需要学习，记为0到numCourses-1。给你一个数组prerequisites，其中prerequisites[i] = [ai, bi]，表示在选修课程ai之前必须先选修bi。请你返回一个可以学完所有课程的顺序。可能会有多个正确的顺序，你只要返回任意一个就可以了。如果不可能完成所有课程，返回一个空数组。';
    findOrder.difficulty = ProblemDifficulty.MEDIUM;
    findOrder.category = ProblemCategory.QUEUE;
    findOrder.choices = [
      { id: 'A', text: '队列BFS（Kahn算法）：入度为0的节点入队，出队时加入结果，减少邻接节点入度，重复至队空，若结果长度≠numCourses返回空', isCorrect: true },
      { id: 'B', text: 'DFS检测环并记录后序遍历，反转后为拓扑序', isCorrect: false },
      { id: 'C', text: '贪心选择，每次选没有先修课的课程', isCorrect: false },
      { id: 'D', text: '动态规划，记录每个课程的先修顺序', isCorrect: false }
    ];
    findOrder.explanation = 'BFS拓扑排序：①构建邻接表和入度数组；②入度为0的节点入队；③result列表；④循环：出队u，加入result；⑤遍历u的邻接节点v：入度[v]--；若入度[v]==0，入队；⑥队空后，若result长度==numCourses返回，否则返回空。时间复杂度O(n+m)，空间复杂度O(n+m)。';
    findOrder.hint = '拓扑排序的BFS实现核心是「处理入度为0的节点」，逐步消除依赖';
    problems.push(findOrder);

    // 44. 岛屿数量（BFS版）
    const numIslandsBFS = new ProblemModel();
    numIslandsBFS.id = 3044;
    numIslandsBFS.title = '岛屿数量（BFS版）';
    numIslandsBFS.description = '给你一个由\'1\'（陆地）和\'0\'（水）组成的的二维网格，请你计算网格中岛屿的数量。岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。此外，你可以假设该网格的四条边均被水包围。要求用BFS实现。';
    numIslandsBFS.difficulty = ProblemDifficulty.MEDIUM;
    numIslandsBFS.category = ProblemCategory.QUEUE;
    numIslandsBFS.choices = [
      { id: 'A', text: 'BFS：遍历网格，遇到\'1\'则计数+1，并用队列将所有相连的\'1\'改为\'0\'（淹没）', isCorrect: true },
      { id: 'B', text: 'BFS：记录访问过的陆地，不修改原网格', isCorrect: false },
      { id: 'C', text: '队列存储所有陆地，逐一处理', isCorrect: false },
      { id: 'D', text: '分层BFS，记录岛屿层级', isCorrect: false }
    ];
    numIslandsBFS.explanation = 'BFS解法：①计数count=0；②遍历网格每个单元格(i,j)；③若grid[i][j]==\'1\'：count++；④队列加入(i,j)，grid[i][j]=\'0\'（标记为水）；⑤队列非空：出队(x,y)，检查上下左右四个方向；⑥若邻居为\'1\'，入队并标记为\'0\'；⑦返回count。时间复杂度O(mn)，空间复杂度O(min(m,n))（队列最大大小为网格中最小边）。';
    numIslandsBFS.hint = '与DFS思路相同，只是用队列替代递归栈，通过淹没岛屿避免重复计数';
    problems.push(numIslandsBFS);

    // 45. 打开转盘锁
    const openLock = new ProblemModel();
    openLock.id = 3045;
    openLock.title = '打开转盘锁';
    openLock.description = '你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字：\'0\'-\'9\'。每个拨轮可以自由旋转：例如把\'9\'变为\'0\'，\'0\'变为\'9\'。每次旋转都只能旋转一个拨轮的一位数字。锁的初始数字为\'0000\'，一个代表四个拨轮的数字的字符串。列表deadends包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。字符串target代表可以解锁的数字，请给出解锁需要的最小旋转次数，如果无论如何不能解锁，返回-1。';
    openLock.difficulty = ProblemDifficulty.MEDIUM;
    openLock.category = ProblemCategory.QUEUE;
    openLock.choices = [
      { id: 'A', text: 'BFS：从"0000"开始，每次旋转一个拨轮生成新状态，避开deadends和已访问状态，直到到达target', isCorrect: true },
      { id: 'B', text: 'DFS：尝试所有可能的旋转路径，记录最小次数', isCorrect: false },
      { id: 'C', text: '双向BFS：从"0000"和target同时开始，相遇时返回步数和', isCorrect: false },
      { id: 'D', text: '动态规划，记录每个状态的最小步数', isCorrect: false }
    ];
    openLock.explanation = 'BFS解法：①deadends转集合，若"0000"在其中返回-1；②队列初始化["0000"]，访问集合记为{"0000"}；③步数step=0；④循环：队列大小size，循环size次：出队current；⑤若current==target，返回step；⑥生成8种可能的下一状态（每个拨轮+1或-1）；⑦若状态不在deadends且未访问，加入队列和访问集；⑧step++；⑨队空返回-1。时间复杂度O(10^4)（最多10000种状态），空间复杂度O(10^4)。';
    openLock.hint = 'BFS适合求最短路径（最小步数），每个状态的邻居是旋转一个拨轮得到的8种可能';
    problems.push(openLock);

    // 46. 完全平方数（BFS求最少步数）
    const numSquares = new ProblemModel();
    numSquares.id = 3046;
    numSquares.title = '完全平方数（BFS求最少步数）';
    numSquares.description = '给你一个整数n，返回和为n的完全平方数的最少数量。完全平方数是一个整数，其值等于另一个整数的平方；换句话说，其值等于n²，其中n是整数。例如，1、4、9和16都是完全平方数，而3和11不是。要求用BFS实现。';
    numSquares.difficulty = ProblemDifficulty.MEDIUM;
    numSquares.category = ProblemCategory.QUEUE;
    numSquares.choices = [
      { id: 'A', text: 'BFS：将n视为起点，每次减去一个完全平方数，到达0的最少步数即为答案', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i]表示和为i的最少数量', isCorrect: false },
      { id: 'C', text: '数学公式，判断n是否为4^k*(8m+7)，若是则返回4，否则尝试1或2', isCorrect: false },
      { id: 'D', text: '贪心算法，从最大的完全平方数开始减', isCorrect: false }
    ];
    numSquares.explanation = 'BFS解法：①生成所有<=n的完全平方数squares；②队列存储当前和与步数，初始(0,0)；③访问集合记录已处理的和；④循环：出队(current, step)；⑤若current==n，返回step；⑥遍历squares：next=current+s；⑦若next>n：跳过；⑧若next未访问：加入队列(step+1)和访问集；⑨返回-1（理论上不会触发）。时间复杂度O(n√n)，空间复杂度O(n)。';
    numSquares.hint = '将问题转化为「从0到n的最短路径」，每次可走的步数是完全平方数';
    problems.push(numSquares);

    // 47. 单词接龙
    const ladderLength = new ProblemModel();
    ladderLength.id = 3047;
    ladderLength.title = '单词接龙';
    ladderLength.description = '字典wordList中从单词beginWord和endWord的转换序列是一个按下述规格形成的序列beginWord -> s1 -> s2 -> ... -> sk：每一对相邻的单词只差一个字母；对于1 <= i <= k时，每个si都在wordList中；注意，beginWord不需要在wordList中；sk == endWord。给你两个单词beginWord和endWord和一个字典wordList，返回从beginWord到endWord的最短转换序列中的单词数目。如果不存在这样的转换序列，返回0。';
    ladderLength.difficulty = ProblemDifficulty.HARD;
    ladderLength.category = ProblemCategory.QUEUE;
    ladderLength.choices = [
      { id: 'A', text: 'BFS：从beginWord开始，每次变换一个字母生成新单词，在wordList中且未访问则入队，直到endWord', isCorrect: true },
      { id: 'B', text: '双向BFS：从beginWord和endWord同时开始，相遇时返回步数和', isCorrect: false },
      { id: 'C', text: 'DFS：尝试所有可能的变换路径，记录最短长度', isCorrect: false },
      { id: 'D', text: '构建单词图（边为相差一个字母），求最短路径', isCorrect: false }
    ];
    ladderLength.explanation = 'BFS解法：①wordList转集合，若endWord不在其中返回0；②队列初始化[beginWord]，访问集{beginWord}；③长度length=1；④循环：队列大小size；⑤循环size次：出队word；⑥若word==endWord，返回length；⑦生成所有可能的变换（每个位置替换为a-z）；⑧若变换在wordList且未访问：加入队列和访问集；⑨length++；⑩队空返回0。时间复杂度O(L×26×n)（L为单词长度，n为wordList大小），空间复杂度O(n)。';
    ladderLength.hint = 'BFS求最短转换序列，关键是高效生成相邻单词（变换一个字母）';
    problems.push(ladderLength);

    // 48. 滑动窗口的平均值
    const MovingAverage = new ProblemModel();
    MovingAverage.id = 3048;
    MovingAverage.title = '滑动窗口的平均值';
    MovingAverage.description = '给定一个整数数据流和一个窗口大小，根据该滑动窗口的大小，计算滑动窗口里所有数字的平均值。实现MovingAverage类：MovingAverage(int size) 用窗口大小size初始化对象；double next(int val) 成员函数next每次调用的时候都会往滑动窗口增加一个整数，请计算并返回数据流中最后size个值的移动平均值，即滑动窗口里所有数字的平均值。';
    MovingAverage.difficulty = ProblemDifficulty.EASY;
    MovingAverage.category = ProblemCategory.QUEUE;
    MovingAverage.choices = [
      { id: 'A', text: '队列：维护窗口内的元素，超过size时出队队首；用sum记录总和，每次next返回sum/窗口大小', isCorrect: true },
      { id: 'B', text: '数组：记录所有元素，每次计算最后size个的平均值', isCorrect: false },
      { id: 'C', text: '双端队列：两端维护窗口边界', isCorrect: false },
      { id: 'D', text: '循环数组：固定大小，用指针记录窗口位置', isCorrect: false }
    ];
    MovingAverage.explanation = '队列解法：①队列存储窗口内元素，sum记录总和；②next(val)：val入队，sum += val；③若队列大小>size：sum -= 队首元素，队首出队；④返回sum / 队列大小。时间复杂度O(1)，空间复杂度O(size)。';
    MovingAverage.hint = '队列天然适合维护滑动窗口，确保只保留最新的size个元素，sum变量避免重复计算';
    problems.push(MovingAverage);

    // 49. 设计前中后队列
    const FrontMiddleBackQueue = new ProblemModel();
    FrontMiddleBackQueue.id = 3049;
    FrontMiddleBackQueue.title = '设计前中后队列';
    FrontMiddleBackQueue.description = '设计一个队列，支持在前，中，后三个位置的push和pop操作。请实现FrontMiddleBack类：FrontMiddleBack() 初始化队列；void pushFront(int val) 将val添加到队列的前面；void pushMiddle(int val) 将val添加到队列的中间；void pushBack(int val) 将val添加到队列的后面；int popFront() 将队列前面的元素移除并返回；如果队列是空的，返回-1；int popMiddle() 将队列中间的元素移除并返回；如果队列是空的，返回-1；int popBack() 将队列后面的元素移除并返回；如果队列是空的，返回-1。请注意，当有两个中间位置时，选择靠前面的位置进行操作。例如：[1, 2, 3, 4] 的中间位置是索引1和2，选择索引1。';
    FrontMiddleBackQueue.difficulty = ProblemDifficulty.MEDIUM;
    FrontMiddleBackQueue.category = ProblemCategory.QUEUE;
    FrontMiddleBackQueue.choices = [
      { id: 'A', text: '两个双端队列：left存储前半部分，right存储后半部分（right.size() = left.size() 或 left.size()+1）；中间操作基于两队列的边界', isCorrect: true },
      { id: 'B', text: '链表：维护头、中、尾指针，插入删除时调整指针', isCorrect: false },
      { id: 'C', text: '动态数组：每次操作后重新计算中间位置', isCorrect: false },
      { id: 'D', text: '栈和队列组合，分别处理前后端', isCorrect: false }
    ];
    FrontMiddleBackQueue.explanation = '双端队列解法：①left和right两个deque，保持right.size()为left.size()或left.size()+1；②pushMiddle：若left.size() == right.size()，则push到left尾部再移到right头部；否则push到left尾部；③popMiddle：若left.size() < right.size()，从right头部移到left尾部再pop left尾部；否则pop left尾部；④前后操作直接调用deque的前后方法，操作后调整两队列平衡。时间复杂度O(1)，空间复杂度O(n)。';
    FrontMiddleBackQueue.hint = '用两个队列拆分存储，使中间位置始终在两队列的交界处，简化操作';
    problems.push(FrontMiddleBackQueue);

    // 50. 用两个队列实现栈（优化版）
    const MyStackOptimal = new ProblemModel();
    MyStackOptimal.id = 3050;
    MyStackOptimal.title = '用两个队列实现栈（优化版）';
    MyStackOptimal.description = '请你仅使用两个队列实现一个后入先出（LIFO）的栈，并优化pop操作的时间复杂度。支持普通栈的全部四种操作（push、top、pop和empty）。';
    MyStackOptimal.difficulty = ProblemDifficulty.EASY;
    MyStackOptimal.category = ProblemCategory.QUEUE;
    MyStackOptimal.choices = [
      { id: 'A', text: '两个队列：push时加入空队列，再将另一个队列所有元素移过来（新元素在队首）；pop直接取队首', isCorrect: true },
      { id: 'B', text: '与基础版相同，pop时转移n-1个元素', isCorrect: false },
      { id: 'C', text: '主队列存储元素，辅助队列仅在pop时临时使用', isCorrect: false },
      { id: 'D', text: '始终保持一个队列为空，push到非空队列', isCorrect: false }
    ];
    MyStackOptimal.explanation = '优化pop的双队列解法：①q1和q2，始终一个为空；②push(val)：将val加入空队列（如q2），再将q1所有元素移到q2，交换q1和q2（使q1非空，q2空）；③pop：直接弹出q1队首；④top：返回q1队首。时间复杂度：push O(n)，pop和top O(1)，空间复杂度O(n)。适合pop操作频繁的场景。';
    MyStackOptimal.hint = '通过在push时转移元素，使栈顶元素始终在队列头部，优化pop的时间复杂度';
    problems.push(MyStackOptimal);

    // 4002. 除自身以外数组的乘积
    const productExceptSelf = new ProblemModel ();productExceptSelf.id = 4002;productExceptSelf.title = ' 除自身以外数组的乘积 ';productExceptSelf.description = ' 给你一个整数数组 nums，返回数组 answer，其中 answer [i] 等于 nums 中除 nums [i] 之外其余各元素的乘积。题目数据 保证 数组 nums 之中任意元素的全部前缀元素和后缀的乘积都在 32 位 整数范围内。请 不要使用除法，且在 O (n) 时间复杂度、O (1) 额外空间复杂度内完成此题（输出数组不计入额外空间）。';productExceptSelf.difficulty = ProblemDifficulty.MEDIUM;productExceptSelf.category = ProblemCategory.ARRAY;productExceptSelf.choices = [{ id: 'A', text: ' 左右乘积数组优化：用输出数组存前缀积，再从后向前计算后缀积并相乘 ', isCorrect: true },{ id: 'B', text: ' 计算总乘积，再除以每个元素（无法处理 0）', isCorrect: false },{ id: 'C', text: ' 双重循环，每个元素遍历计算其他元素乘积 ', isCorrect: false },{ id: 'D', text: ' 前缀积数组 + 后缀积数组，两者相乘（额外空间 O (n)）', isCorrect: false }];productExceptSelf.explanation = ' 空间优化解法：①初始化 answer 数组，answer [0]=1；②计算前缀积：遍历 i 从 1 到 n-1：answer [i] = answer [i-1] * nums [i-1]；③初始化后缀积变量 suffix=1；④从后向前遍历 i 从 n-1 到 0：answer [i] *= suffix；suffix *= nums [i]；⑤返回 answer。时间复杂度 O (n)，空间复杂度 O (1)（输出数组不计入）。';productExceptSelf.hint = ' 关键是「拆分乘积为前缀 + 后缀」，用输出数组复用空间，避免额外存储 ';problems.push (productExceptSelf);
    // 4005. 插入区间
    const insertInterval = new ProblemModel ();insertInterval.id = 4005;insertInterval.title = ' 插入区间 ';insertInterval.description = ' 给你一个 无重叠的 ，按照区间起始端点排序的区间列表。在列表中插入一个新的区间，你需要确保列表中的区间仍然有序且不重叠（如果有必要的话，可以合并区间）。';insertInterval.difficulty = ProblemDifficulty.MEDIUM;insertInterval.category = ProblemCategory.ARRAY;insertInterval.choices = [{id: 'A', text: ' 遍历 + 合并：先加所有在新区间前的区间，再合并重叠区间，最后加剩余区间 ', isCorrect: true},{ id: 'B', text: ' 添加新区间后重新排序合并（时间 O (n log n)）', isCorrect: false },{ id: 'C', text: ' 二分查找新区间位置，再合并 ', isCorrect: false },{ id: 'D', text: ' 暴力比较所有区间，逐个合并 ', isCorrect: false }];insertInterval.explanation = ' 遍历解法：①初始化 result；②遍历 intervals：若当前区间 end < newInterval [0]（在新区间前）：加入 result；③else if 当前区间 start > newInterval [1]（在新区间后）：加入 newInterval 和剩余区间，返回 result；④else（重叠）：更新 newInterval = [min (start), max (end)]；⑤遍历结束后加入 newInterval；⑥返回 result。时间复杂度 O (n)，空间复杂度 O (n)。';insertInterval.hint = ' 利用原区间有序特性，分「前、重叠、后」三部分处理，避免全量排序 ';problems.push (insertInterval);
    // 4006. 搜索二维矩阵 II
    const searchMatrixII = new ProblemModel ();searchMatrixII.id = 4006;searchMatrixII.title = ' 搜索二维矩阵 II';searchMatrixII.description = ' 编写一个高效的算法来搜索 m x n 矩阵 matrix 中的一个目标值 target 。该矩阵具有以下特性：每行的元素从左到右升序排列；每列的元素从上到下升序排列。';searchMatrixII.difficulty = ProblemDifficulty.MEDIUM;searchMatrixII.category = ProblemCategory.ARRAY;searchMatrixII.choices = [{id: 'A', text: ' 从右上角开始：小于目标则下移，大于则左移，等于则返回 true', isCorrect: true},{ id: 'B', text: ' 逐行二分查找（时间 O (m log n)）', isCorrect: false },{ id: 'C', text: ' 暴力遍历所有元素（时间 O (mn)）', isCorrect: false },{ id: 'D', text: ' 从左上角开始，大于目标则右移或下移（无法确定方向）', isCorrect: false }];searchMatrixII.explanation = ' 右上角起点解法：①若 matrix 为空，返回 false；②m=matrix.length，n=matrix [0].length；③row=0，col=n-1；④循环 row<m 且 col>=0：current=matrix [row][col]；⑤若 current==target：return true；⑥else if current < target：row++（下方元素更大）；⑦else：col--（左侧元素更小）；⑧循环结束返回 false。时间复杂度 O (m+n)，空间复杂度 O (1)。';searchMatrixII.hint = ' 利用矩阵「行升序、列升序」特性，从右上角构建「二分」路径，每次排除一行或一列 ';problems.push (searchMatrixII);
    // 4008. 最小路径和
    const minPathSum = new ProblemModel ();minPathSum.id = 4008;minPathSum.title = ' 最小路径和 ';minPathSum.description = ' 给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。说明：每次只能向下或者向右移动一步。';minPathSum.difficulty = ProblemDifficulty.MEDIUM;minPathSum.category = ProblemCategory.ARRAY;minPathSum.choices = [{id: 'A', text: ' 动态规划：dp [i][j] = grid [i][j] + min (dp [i-1][j], dp [i][j-1])，边界单独处理 ', isCorrect: true },{ id: 'B', text: ' 深度优先搜索（时间 O (2^(m+n))，超时）', isCorrect: false },{ id: 'C', text: ' 广度优先搜索，记录每个位置的最小和 ', isCorrect: false },{ id: 'D', text: ' 贪心算法，每次选当前最小的方向（局部最优非全局）', isCorrect: false }];minPathSum.explanation = 'DP 解法（空间优化）：①直接在 grid 上修改（不额外开数组）；②第一行：grid [0][j] += grid [0][j-1]（只能从左来）；③第一列：grid [i][0] += grid [i-1][0]（只能从上来）；④遍历 i 从 1 到 m-1，j 从 1 到 n-1：grid [i][j] += min (grid [i-1][j], grid [i][j-1])；⑤返回 grid [m-1][n-1]。时间复杂度 O (mn)，空间复杂度 O (1)。';minPathSum.hint = ' 每个位置的最小路径和由上方或左方的最小路径和决定，利用原网格存储结果优化空间 ';problems.push (minPathSum);
    // 4009. 不同路径 II
    const uniquePathsWithObstacles = new ProblemModel ();uniquePathsWithObstacles.id = 4009;uniquePathsWithObstacles.title = ' 不同路径 II';uniquePathsWithObstacles.description = ' 一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish”）。现在考虑网格中有障碍物。那么从左上角到右下角将会有多少条不同的路径？网格中的障碍物和空位置分别用 1 和 0 来表示。';uniquePathsWithObstacles.difficulty = ProblemDifficulty.MEDIUM;uniquePathsWithObstacles.category = ProblemCategory.ARRAY;uniquePathsWithObstacles.choices = [{ id: 'A', text: ' 动态规划：dp [i][j] = 0（有障碍），否则 dp [i][j] = dp [i-1][j] + dp [i][j-1]', isCorrect: true },{ id: 'B', text: ' 递归 + 记忆化（障碍物处返回 0）', isCorrect: false },{ id: 'C', text: ' 组合数学（无法处理障碍物）', isCorrect: false },{ id: 'D', text: 'BFS 统计路径数（空间开销大）', isCorrect: false }];uniquePathsWithObstacles.explanation = 'DP 解法（空间优化）：①若起点或终点有障碍，返回 0；②初始化 dp 数组（长度 n）；③dp [0] = 1（第一行无障碍物时）；④遍历第一行：若 grid [0][j] 有障碍或 dp [j-1]==0：dp [j]=0；else：dp [j]=1；⑤遍历 i 从 1 到 m-1：更新 dp [0]（第一列有障碍则为 0，否则继承上方 dp [0]）；⑥遍历 j 从 1 到 n-1：若 grid [i][j] 有障碍：dp [j]=0；else：dp [j] = dp [j]（上方） + dp [j-1]（左方）；⑦返回 dp [n-1]。时间复杂度 O (mn)，空间复杂度 O (n)。';uniquePathsWithObstacles.hint = ' 障碍物处路径数为 0，需在初始化和状态转移中特殊处理，避免路径穿过障碍 ';problems.push (uniquePathsWithObstacles);
    // 4010. 区间列表的交集
    const intervalIntersection = new ProblemModel ();intervalIntersection.id = 4010;intervalIntersection.title = ' 区间列表的交集 ';intervalIntersection.description = ' 给定两个由一些 闭区间 组成的列表，firstList 和 secondList ，其中 firstList [i] = [starti, endi] 而 secondList [j] = [startj, endj] 。每个区间列表都是成对不相交的，并且已经排序。返回这两个区间列表的交集。';intervalIntersection.difficulty = ProblemDifficulty.MEDIUM;intervalIntersection.category = ProblemCategory.ARRAY;intervalIntersection.choices = [{ id: 'A', text: ' 双指针：遍历两个列表，计算当前区间的交集，移动区间 end 较小的指针 ', isCorrect: true },{ id: 'B', text: ' 暴力比较所有区间对（时间 O (mn)）', isCorrect: false },{ id: 'C', text: ' 将两个列表合并后找交集（冗余步骤）', isCorrect: false },{ id: 'D', text: ' 二分查找，对每个区间找另一列表中的重叠区间 ', isCorrect: false }];intervalIntersection.explanation = ' 双指针解法：①i=0，j=0，result=[]；②m=firstList.length，n=secondList.length；③循环 i<m 且 j<n：a=firstList [i]，b=secondList [j]；④start=max (a [0], b [0])，end=min (a [1], b [1])；⑤若 start<=end（有交集）：result.push ([start, end])；⑥若 a [1] < b [1]：i++（a 已无后续重叠）；else：j++；⑦返回 result。时间复杂度 O (m+n)，空间复杂度 O (1)（输出数组不计入）。';intervalIntersection.hint = ' 利用区间有序特性，双指针同步推进，每次仅需比较当前两个区间，避免冗余计算 ';problems.push (intervalIntersection);
    // 4011. 最小 K 个数
    const getLeastNumbers = new ProblemModel ();getLeastNumbers.id = 4011;getLeastNumbers.title = ' 最小 K 个数 ';getLeastNumbers.description = ' 设计一个算法，找出数组中最小的 k 个数。以任意顺序返回这 k 个数均可。';getLeastNumbers.difficulty = ProblemDifficulty.EASY;getLeastNumbers.category = ProblemCategory.ARRAY;getLeastNumbers.choices = [{id: 'A', text: ' 最大堆：维护大小为 k 的堆，遍历数组时大于堆顶则跳过，否则替换，最终堆内为最小 k 数 ', isCorrect: true},{ id: 'B', text: ' 排序后取前 k 个（时间 O (n log n)）', isCorrect: false },{ id: 'C', text: ' 快速选择算法（平均 O (n)，最坏 O (n²)）', isCorrect: false },{ id: 'D', text: ' 计数排序（仅适用于元素范围小的情况）', isCorrect: false }];getLeastNumbers.explanation = ' 最大堆解法：①若 k==0，返回空；②初始化大小为 k 的最大堆（JS 需用最小堆存负数模拟）；③遍历 nums：若堆大小 < k：入堆；④else：若当前数 < 堆顶（负数堆则 > 堆顶）：弹出堆顶，入堆；⑤遍历结束后，将堆元素转为正数（若用负数模拟），返回。时间复杂度 O (n log k)，空间复杂度 O (k)。';getLeastNumbers.hint = ' 最大堆始终保留当前最小的 k 个数，堆顶是这 k 个数中的最大值，新元素仅需与堆顶比较 ';problems.push (getLeastNumbers);
    // 4012. 被围绕的区域
    // 4013. 岛屿的最大面积
    const maxAreaOfIsland = new ProblemModel ();maxAreaOfIsland.id = 4013;maxAreaOfIsland.title = ' 岛屿的最大面积 ';maxAreaOfIsland.description = ' 给你一个大小为 m x n 的二进制矩阵 grid 。岛屿 是由一些相邻的 1 (代表土地) 构成的组合，这里的「相邻」要求两个 1 必须在 水平或者竖直的四个方向上 相邻。你可以假设 grid 的四个边缘都被 0（代表水）包围着。岛屿的面积是岛上值为 1 的单元格的数目。计算并返回 grid 中最大的岛屿面积。如果没有岛屿，则返回 0 。';maxAreaOfIsland.difficulty = ProblemDifficulty.MEDIUM;maxAreaOfIsland.category = ProblemCategory.ARRAY;maxAreaOfIsland.choices = [{ id: 'A', text: 'DFS：遍历网格，遇到 1 则递归计算连通面积，标记为 0 避免重复，更新最大面积 ', isCorrect: true },{ id: 'B', text: 'BFS：用队列处理每个岛屿的连通单元格，统计面积 ', isCorrect: false },{ id: 'C', text: ' 并查集：将相邻 1 合并，统计最大集合大小 ', isCorrect: false },{ id: 'D', text: ' 暴力遍历，每个 1 单独计算面积（重复计数）', isCorrect: false }];maxAreaOfIsland.explanation = 'DFS 解法：①maxArea=0；②定义 DFS 函数：若超出边界或为 0，返回 0；标记 grid [i][j]=0；返回 1 + DFS (i-1,j) + DFS (i+1,j) + DFS (i,j-1) + DFS (i,j+1)；③遍历每个单元格 (i,j)：若 grid [i][j]==1：area=DFS (i,j)；maxArea=max (maxArea, area)；④返回 maxArea。时间复杂度 O (mn)，空间复杂度 O (mn)（递归栈）。';maxAreaOfIsland.hint = ' 通过「淹没岛屿」（标记为 0）避免重复遍历，递归计算每个岛屿的连通单元格数 ';problems.push (maxAreaOfIsland);
    // 4014. 矩阵中的最长递增路径
    const longestIncreasingPath = new ProblemModel ();longestIncreasingPath.id = 4014;longestIncreasingPath.title = ' 矩阵中的最长递增路径 ';longestIncreasingPath.description = ' 给定一个 m x n 整数矩阵 matrix ，找出其中 最长递增路径 的长度。对于每个单元格，你可以往上，下，左，右四个方向移动。 你 不能 在对角线方向上移动或移动到边界外（即不允许环绕）。';longestIncreasingPath.difficulty = ProblemDifficulty.HARD;longestIncreasingPath.category = ProblemCategory.ARRAY;longestIncreasingPath.choices = [{id: 'A', text: 'DFS + 记忆化：dp [i][j] 记录以 (i,j) 为起点的最长路径，递归探索四个方向，取最大长度 + 1', isCorrect: true },{ id: 'B', text: ' 暴力 DFS（无记忆化，时间 O ((mn)²)）', isCorrect: false },{ id: 'C', text: 'BFS，按值从小到大处理，更新相邻单元格的最长路径 ', isCorrect: false },{ id: 'D', text: ' 动态规划，按行或列顺序更新（无法处理任意方向）', isCorrect: false }];longestIncreasingPath.explanation = ' 记忆化 DFS 解法：①m=matrix.length，n=matrix [0].length；②dp 二维数组初始化 0，存储每个单元格的最长路径；③定义 DFS (i,j)：若 dp [i][j]!=0，返回 dp [i][j]；初始化 len=1；④遍历四个方向：若邻居在边界内且值 > matrix [i][j]：len=max (len, 1+DFS (neighbor))；⑤dp [i][j]=len；return len；⑥遍历每个单元格：maxLen=max (maxLen, DFS (i,j))；⑦返回 maxLen。时间复杂度 O (mn)，空间复杂度 O (mn)。';longestIncreasingPath.hint = ' 利用记忆化缓存已计算的路径长度，避免重复递归，每个单元格仅计算一次 ';problems.push (longestIncreasingPath);
    // 4015. 最小体力消耗路径
    const minimumEffortPath = new ProblemModel ();minimumEffortPath.id = 4015;minimumEffortPath.title = ' 最小体力消耗路径 ';minimumEffortPath.description = ' 你准备参加一场远足活动。给你一个二维 rows x cols 的地图 heights ，其中 heights [row][col] 表示格子 (row, col) 的高度。一开始你在最左上角的格子 (0, 0) ，且你希望去最右下角的格子 (rows-1, cols-1) （注意下标从 0 开始）。你每次可以往 上，下，左，右 四个方向之一移动，你想要找到耗费体力最小的一条路径。一条路径耗费的体力是路径上相邻格子之间高度差的 最大值 决定的。请你返回从左上角走到右下角的最小体力消耗值。';minimumEffortPath.difficulty = ProblemDifficulty.MEDIUM;minimumEffortPath.category = ProblemCategory.ARRAY;minimumEffortPath.choices = [{ id: 'A', text: ' 二分查找 + DFS/BFS：二分体力值，判断是否存在路径所有相邻差 <= 该值 ', isCorrect: true },{ id: 'B', text: 'Dijkstra 算法：将体力消耗视为边权，找起点到终点的最小最大边权路径 ', isCorrect: false },{ id: 'C', text: ' 暴力 DFS（时间 O (4^(mn))）', isCorrect: false },{ id: 'D', text: ' 动态规划，dp [i][j] 表示到 (i,j) 的最小体力消耗（无法处理全局最优）', isCorrect: false }];minimumEffortPath.explanation = ' 二分 + DFS 解法：①left=0，right=1e6（最大可能高度差）；②定义 isPossible (limit)：DFS/BFS 判断是否存在路径，相邻差 <=limit；③循环 left<right：mid=(left+right)/2；④若 isPossible (mid)：right=mid；else：left=mid+1；⑤返回 left。时间复杂度 O (mn log H)（H 为最大高度差），空间复杂度 O (mn)（visited 数组）。';minimumEffortPath.hint = ' 二分查找最小可行体力值，用 DFS/BFS 验证可行性，将优化问题转化为判定问题 ';problems.push (minimumEffortPath);
    // 二、字符串类（15 题）// 4016. 最长回文子序列
    const longestPalindromeSubseq = new ProblemModel ();longestPalindromeSubseq.id = 4016;longestPalindromeSubseq.title = ' 最长回文子序列 ';longestPalindromeSubseq.description = ' 给你一个字符串 s ，找出其中最长的回文子序列，并返回该序列的长度。子序列定义为：不改变剩余字符顺序的情况下，删除某些字符或者不删除任何字符形成的一个序列。';longestPalindromeSubseq.difficulty = ProblemDifficulty.MEDIUM;longestPalindromeSubseq.category = ProblemCategory.STRING;longestPalindromeSubseq.choices = [{id: 'A', text: ' 动态规划：dp [i][j] 表示 s [i..j] 的最长回文子序列长度，s [i]==s [j] 则 dp [i][j]=dp [i+1][j-1]+2，否则取 max (dp [i+1][j], dp [i][j-1])', isCorrect: true },{ id: 'B', text: ' 递归 + 记忆化，逻辑同 DP', isCorrect: false },{ id: 'C', text: ' 暴力枚举所有子序列，判断是否回文（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: ' 将问题转为最长公共子序列（s 与反转 s 的 LCS）', isCorrect: false }];longestPalindromeSubseq.explanation = 'DP 解法（空间优化）：①n=s.length；②dp 数组（长度 n），存储当前 i 对应的 j 范围值；③遍历 i 从 n-1 到 0：temp 数组存储当前 i 的结果；temp [i]=1；④遍历 j 从 i+1 到 n-1：if s [i]==s [j]：temp [j] = dp [j-1] + 2；else：temp [j] = max (dp [j], temp [j-1])；⑤dp=temp；⑥返回 dp [n-1]。时间复杂度 O (n²)，空间复杂度 O (n)。';longestPalindromeSubseq.hint = ' 子序列不要求连续，DP 状态需覆盖所有子串范围，通过对角线方向填充表格 ';problems.push (longestPalindromeSubseq);
    // 4017. 字符串解码
    const decodeString = new ProblemModel ();decodeString.id = 4017;decodeString.title = ' 字符串解码 ';decodeString.description = ' 给定一个经过编码的字符串，返回它解码后的字符串。编码规则为: k [encoded_string]，表示其中方括号内部的 encoded_string 正好重复 k 次。注意 k 保证为正整数。你可以认为输入字符串总是有效的；输入字符串中没有额外的空格，且输入的方括号总是符合格式要求的。此外，你可以认为原始数据不包含数字，所有的数字只表示重复的次数 k ，例如不会出现像 3a 或 2 [4] 的输入。';decodeString.difficulty = ProblemDifficulty.MEDIUM;decodeString.category = ProblemCategory.STRING;decodeString.choices = [{ id: 'A', text: ' 栈：两个栈分别存数字和字符串，遇到] 时弹出数字和字符串，拼接后压回字符串栈 ', isCorrect: true },{ id: 'B', text: ' 递归：遇到 [递归处理内部字符串，返回解码结果与数字相乘 ', isCorrect: false },{ id: 'C', text: ' 暴力解析，逐字符处理（无法处理嵌套）', isCorrect: false },{ id: 'D', text: ' 正则表达式替换，逐步替换最内层的编码（需多次替换）', isCorrect: false }];decodeString.explanation = ' 栈解法：①numStack（存重复次数），strStack（存待拼接字符串）；②currentNum=0，currentStr=""；③遍历每个字符 c：④若 c 是数字：currentNum = currentNum*10 + (c-0)；⑤若 c 是字母：currentStr += c；⑥若 c 是 [：numStack.push (currentNum)；strStack.push (currentStr)；重置 currentNum=0，currentStr=""；⑦若 c 是]：num=numStack.pop ()；prevStr=strStack.pop ()；currentStr = prevStr + currentStr.repeat (num)；⑧遍历结束返回 currentStr。时间复杂度 O (n)（解码后长度），空间复杂度 O (n)。';decodeString.hint = ' 栈适合处理嵌套结构，数字栈记录外层重复次数，字符串栈记录外层待拼接内容 ';problems.push (decodeString);
    // 4019. 字符串的排列
    const checkInclusion = new ProblemModel ();checkInclusion.id = 4019;checkInclusion.title = ' 字符串的排列 ';checkInclusion.description = ' 给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。如果是，返回 true ；否则，返回 false 。换句话说，s1 的排列之一是 s2 的 子串 。';checkInclusion.difficulty = ProblemDifficulty.MEDIUM;checkInclusion.category = ProblemCategory.STRING;checkInclusion.choices = [{id: 'A', text: ' 滑动窗口（固定长度）：统计 s1 的字符频率，窗口长度为 s1.length，滑动比较频率是否一致 ', isCorrect: true},{ id: 'B', text: ' 生成 s1 的所有排列，检查是否为 s2 子串（时间 O (n!)）', isCorrect: false },{ id: 'C', text: ' 排序 s1 和 s2 的所有子串，比较是否相等（时间 O (n² log n)）', isCorrect: false },{ id: 'D', text: ' 哈希表记录 s1 字符，遍历 s2 子串检查（时间 O (nm)）', isCorrect: false }];checkInclusion.explanation = ' 固定窗口解法：①n=s1.length，m=s2.length；若 n>m 返回 false；②初始化 freq 数组（26 字母），count=0；③遍历 s1：freq [c.charCodeAt (0)-97]++；④遍历 s2 前 n 个字符：freq [c.charCodeAt (0)-97]--；若 freq [c.charCodeAt (0)-97]==0：count++；⑤若 count==26 返回 true；⑥遍历 s2 从 n 到 m-1：左移除字符 leftC：freq [leftC-97]++；若 freq [leftC-97]==1：count--；右加入字符 rightC：freq [rightC-97]--；若 freq [rightC-97]==0：count++；⑦若 count==26 返回 true；⑧返回 false。时间复杂度 O (m)，空间复杂度 O (1)。';checkInclusion.hint = ' 排列的本质是「字符种类和频率相同」，固定窗口长度为 s1 长度，通过频率数组和计数器快速比对 ';problems.push (checkInclusion);
    // 4020. 最长有效括号
    // 4023. 最短公共超序列
    const shortestCommonSupersequence = new ProblemModel ();shortestCommonSupersequence.id = 4023;shortestCommonSupersequence.title = ' 最短公共超序列 ';shortestCommonSupersequence.description = ' 给你两个字符串 str1 和 str2，返回同时以 str1 和 str2 作为子序列的最短字符串。如果答案不止一个，则可以返回其中任意一个。一个字符串 s 包含另一个字符串 t 作为子序列，指可以从 s 中删除一些字符，而不改变其余字符的相对顺序，得到 t 。';shortestCommonSupersequence.difficulty = ProblemDifficulty.HARD;shortestCommonSupersequence.category = ProblemCategory.STRING;shortestCommonSupersequence.choices = [{id: 'A', text: ' 先求最长公共子序列（LCS），再合并 str1 和 str2，LCS 部分仅保留一次 ', isCorrect: true},{ id: 'B', text: ' 动态规划直接构建最短超序列（空间开销大）', isCorrect: false },{ id: 'C', text: ' 暴力枚举所有超序列，找最短（时间 O (2^(m+n))）', isCorrect: false },{ id: 'D', text: ' 贪心选择当前较小的字符（局部最优非全局）', isCorrect: false }];shortestCommonSupersequence.explanation = 'LCS 合并解法：①求 str1 和 str2 的 LCS；②双指针 i=0（str1），j=0（str2），k=0（LCS）；③result=""；④循环 k<LCS.length：⑤while i<str1.length && str1 [i]!=LCS [k]：result+=str1 [i++]；⑥while j<str2.length && str2 [j]!=LCS [k]：result+=str2 [j++]；⑦result+=LCS [k]；i++；j++；k++；⑧添加剩余的 str1 和 str2；⑨返回 result。时间复杂度 O (mn)（求 LCS），空间复杂度 O (mn)。';shortestCommonSupersequence.hint = ' 最短超序列长度 = len (str1)+len (str2)-len (LCS)，核心是找到 LCS，避免重复存储公共部分 ';problems.push (shortestCommonSupersequence);
    // 4024. 验证回文串 II
    const validPalindrome = new ProblemModel ();validPalindrome.id = 4024;validPalindrome.title = ' 验证回文串 II';validPalindrome.description = ' 给你一个字符串 s，最多可以从中删除一个字符，请你判断是否能成为回文字符串。';validPalindrome.difficulty = ProblemDifficulty.EASY;validPalindrome.category = ProblemCategory.STRING;validPalindrome.choices = [{id: 'A', text: ' 双指针：左右指针对比，不相等时尝试删除左或右字符，递归 / 迭代判断剩余子串 ', isCorrect: true},{ id: 'B', text: ' 暴力删除每个字符，判断是否为回文（时间 O (n²)）', isCorrect: false },{ id: 'C', text: ' 反转字符串，比较差异位置是否仅一处（逻辑错误）', isCorrect: false },{ id: 'D', text: ' 动态规划判断是否存在回文子串（未利用删除一次的条件）', isCorrect: false }];validPalindrome.explanation = ' 双指针解法：①定义辅助函数 isPal (l, r)：while l<r：if s [l]!=s [r] return false；l++；r--；return true；②l=0，r=s.length-1；③while l<r：④if s [l]==s [r]：l++；r--；⑤else：return isPal (l+1, r) || isPal (l, r-1)；⑥return true。时间复杂度 O (n)，空间复杂度 O (1)。';validPalindrome.hint = ' 仅当首次遇到不相等字符时，才有两种删除选择（左或右），后续子串需严格回文 ';problems.push (validPalindrome);

    // 接字符串类（续）
    // 4026. 最长重复子串
    const longestDupSubstring = new ProblemModel();
    longestDupSubstring.id = 4026;
    longestDupSubstring.title = '最长重复子串';
    longestDupSubstring.description = '给你一个字符串 s ，返回 s 中最长的 重复子串 。如果 s 中没有重复子串，返回空字符串 "" 。';
    longestDupSubstring.difficulty = ProblemDifficulty.HARD;
    longestDupSubstring.category = ProblemCategory.STRING;
    longestDupSubstring.choices = [
      { id: 'A', text: '二分查找+滚动哈希：二分子串长度，用哈希判断是否存在重复子串，滚动哈希优化比较效率', isCorrect: true },
      { id: 'B', text: '后缀数组：构建后缀数组后找相邻后缀的最长公共前缀（实现复杂）', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子串，哈希表记录是否重复（时间O(n³)）', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i][j]表示以i和j结尾的最长重复子串长度（空间O(n²)）', isCorrect: false }
    ];
    longestDupSubstring.explanation = '二分+滚动哈希解法：①low=0，high=n-1，result=""；②定义check(L)：用哈希表存子串哈希值，遍历i从0到n-L：计算s[i..i+L-1]的哈希；若已存在则返回该子串；否则存入哈希表；返回""；③while low<=high：mid=(low+high)>>1；sub=check(mid)；④if sub：result=sub；low=mid+1；else：high=mid-1；⑤返回result。时间复杂度O(n log n)，空间复杂度O(n)。';
    longestDupSubstring.hint = '二分查找降低问题复杂度，滚动哈希避免子串比较的O(L)时间，核心是哈希冲突处理（可双哈希优化）';
    problems.push(longestDupSubstring);

    // 4027. 字符串压缩
    const compressString = new ProblemModel();
    compressString.id = 4027;
    compressString.title = '字符串压缩';
    compressString.description = '字符串压缩。利用字符重复出现的次数，编写一种方法，实现基本的字符串压缩功能。比如，字符串 aabcccccaaa 会变为 a2b1c5a3。若压缩后的字符串没有变短，则返回原先的字符串。你可以假设字符串中只包含大小写英文字母（a至z）。';
    compressString.difficulty = ProblemDifficulty.EASY;
    compressString.category = ProblemCategory.STRING;
    compressString.choices = [
      { id: 'A', text: '单指针遍历：记录当前字符和计数，不同字符时拼接结果，最后比较长度', isCorrect: true },
      { id: 'B', text: '双指针：左指针固定当前字符，右指针计数重复次数', isCorrect: false },
      { id: 'C', text: '正则表达式替换：匹配连续字符并替换为字符+次数（边界处理复杂）', isCorrect: false },
      { id: 'D', text: '栈：相同字符入栈计数，不同字符时弹出拼接（空间开销大）', isCorrect: false }
    ];
    compressString.explanation = '单指针解法：①若s长度<=1，返回s；②result=[s[0]]；count=1；③遍历i从1到s.length-1：④if s[i]==s[i-1]：count++；⑤else：result.push(count.toString(), s[i])；count=1；⑥遍历结束后push(count.toString())；⑦compressed=result.join("")；⑧return compressed.length < s.length ? compressed : s。时间复杂度O(n)，空间复杂度O(n)。';
    compressString.hint = '压缩的关键是「连续字符计数」，最后必须比较压缩前后长度，避免返回更长的字符串';
    problems.push(compressString);

    // 4028. 翻转字符串里的单词
    const reverseWords = new ProblemModel();
    reverseWords.id = 4028;
    reverseWords.title = '翻转字符串里的单词';
    reverseWords.description = '给你一个字符串 s ，逐个翻转字符串中的所有 单词 。单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。请你返回一个翻转 s 中单词顺序并用单个空格相连的字符串。说明：输入字符串 s 可以在前面、后面或者单词间包含多余的空格。翻转后单词间应当仅用一个空格分隔。翻转后的字符串中不应包含额外的空格。';
    reverseWords.difficulty = ProblemDifficulty.MEDIUM;
    reverseWords.category = ProblemCategory.STRING;
    reverseWords.choices = [
      { id: 'A', text: '双指针+反转：先去除多余空格，整体反转字符串，再逐个反转单词', isCorrect: true },
      { id: 'B', text: '分割+反转+拼接：split分割单词，reverse数组，join空格（处理空格需额外步骤）', isCorrect: false },
      { id: 'C', text: '栈：遍历字符串压入单词，弹出时拼接（需处理空格）', isCorrect: false },
      { id: 'D', text: '暴力遍历，从后向前收集单词（时间O(n)，空间O(n)）', isCorrect: false }
    ];
    reverseWords.explanation = '双指针解法：①去除多余空格：用快慢指针，跳过连续空格，仅保留单词间一个空格；②整体反转字符串；③遍历字符串，用指针标记单词边界，逐个反转单词；④返回处理后的字符串。时间复杂度O(n)，空间复杂度O(n)（存储结果）。';
    reverseWords.hint = '三次反转策略：先规范空格，再整体反转，最后局部反转单词，避免使用额外空间存储单词列表';
    problems.push(reverseWords);

    // 4029. 实现Trie(前缀树)
    const TrieImplementation = new ProblemModel();
    TrieImplementation.id = 4029;
    TrieImplementation.title = '实现Trie(前缀树)';
    TrieImplementation.description = 'Trie（发音类似 "try"）或者说 前缀树 是一种树形数据结构，用于高效地存储和检索字符串数据集中的键。这一数据结构有相当多的应用情景，例如自动补完和拼写检查。请实现 Trie 类：Trie() 初始化前缀树对象。void insert(String word) 向前缀树中插入字符串 word 。boolean search(String word) 如果字符串 word 在前缀树中，返回 true（即，在检索之前已经插入）；否则，返回 false 。boolean startsWith(String prefix) 如果之前已经插入的字符串 word 的前缀之一为 prefix ，返回 true ；否则，返回 false 。';
    TrieImplementation.difficulty = ProblemDifficulty.MEDIUM;
    TrieImplementation.category = ProblemCategory.STRING;
    TrieImplementation.choices = [
      { id: 'A', text: '字典树节点：每个节点含26个子节点数组和isEnd标记，插入时逐个字符创建节点，search检查路径存在且isEnd为true', isCorrect: true },
      { id: 'B', text: '哈希表存储所有前缀：插入时存储所有前缀，search直接查询（空间O(n²)）', isCorrect: false },
      { id: 'C', text: '二叉搜索树：按字符排序存储（检索效率低）', isCorrect: false },
      { id: 'D', text: '数组存储所有单词，search时遍历检查（时间O(nm)）', isCorrect: false }
    ];
    TrieImplementation.explanation = 'Trie实现：①节点结构：children数组（26个元素），isEnd布尔值；②insert：current=根节点；遍历word每个字符c：index=c.charCodeAt(0)-97；若children[index]不存在则创建新节点；current=children[index]；遍历结束后current.isEnd=true；③search：类似insert，若中途节点不存在返回false；最后返回current.isEnd；④startsWith：同search，但最后无需检查isEnd，存在路径即返回true。时间复杂度O(L)（L为字符串长度），空间复杂度O(L*N)（N为插入单词数）。';
    TrieImplementation.hint = '前缀树的核心是「共享前缀」，通过字符映射到数组索引实现高效插入和检索，适合前缀匹配场景';
    problems.push(TrieImplementation);

    // 4030. 单词拆分II
    const wordBreakII = new ProblemModel();
    wordBreakII.id = 4030;
    wordBreakII.title = '单词拆分II';
    wordBreakII.description = '给定一个字符串 s 和一个字符串字典 wordDict ，在字符串 s 中增加空格来构建一个句子，使得句子中所有的单词都在词典中。以任意顺序 返回所有这些可能的句子。注意：词典中的同一个单词可能在分段中被重复使用多次。';
    wordBreakII.difficulty = ProblemDifficulty.HARD;
    wordBreakII.category = ProblemCategory.STRING;
    wordBreakII.choices = [
      { id: 'A', text: '动态规划+回溯：先用DP判断是否可拆分并记录拆分点，再回溯生成所有可能句子', isCorrect: true },
      { id: 'B', text: '纯回溯：递归尝试所有拆分可能（无剪枝易超时）', isCorrect: false },
      { id: 'C', text: 'BFS：层序遍历记录拆分路径（空间开销大）', isCorrect: false },
      { id: 'D', text: '前缀树优化回溯：用Trie快速判断前缀是否在词典中', isCorrect: false }
    ];
    wordBreakII.explanation = 'DP+回溯解法：①用哈希集存储wordDict；②DP数组dp[i]记录s[0..i-1]的所有拆分方式；③dp[0]=[""]；④遍历i从1到s.length：⑤初始化dp[i]=[]；⑥遍历j从0到i-1：⑦if dp[j]非空且s[j..i-1]在词典中：⑧for each str in dp[j]：newStr = str + (str?" ":"") + s[j..i-1]；dp[i].push(newStr)；⑨返回dp[s.length]。时间复杂度O(n² + 2^n)（最坏情况），空间复杂度O(2^n)。';
    wordBreakII.hint = 'DP用于记录中间拆分结果避免重复计算，回溯过程通过拼接已有拆分结果生成完整句子，需注意空字符串处理';
    problems.push(wordBreakII);


    // 三、二叉树类（15题）
    // 4031. 二叉树的层序遍历
    const levelOrder = new ProblemModel();
    levelOrder.id = 4031;
    levelOrder.title = '二叉树的层序遍历';
    levelOrder.description = '给你二叉树的根节点 root ，返回其节点值的 层序遍历 。 （即逐层地，从左到右访问所有节点）。';
    levelOrder.difficulty = ProblemDifficulty.MEDIUM;
    levelOrder.category = ProblemCategory.BINARY_TREE;
    levelOrder.choices = [
      { id: 'A', text: '队列BFS：用队列存储每一层节点，遍历当前层时记录节点值并将子节点入队', isCorrect: true },
      { id: 'B', text: '递归DFS：记录当前深度，按深度存储节点值', isCorrect: false },
      { id: 'C', text: '栈模拟BFS（需标记层结束，复杂）', isCorrect: false },
      { id: 'D', text: '前序遍历后按层分组（逻辑错误）', isCorrect: false }
    ];
    levelOrder.explanation = '队列BFS解法：①若root为空，返回[]；②result=[], queue=[root]；③while queue非空：④levelSize=queue.length；currentLevel=[]；⑤for i从0到levelSize-1：node=queue.shift()；currentLevel.push(node.val)；⑥if node.left：queue.push(node.left)；if node.right：queue.push(node.right)；⑦result.push(currentLevel)；⑧返回result。时间复杂度O(n)，空间复杂度O(n)（队列最多存n/2节点）。';
    levelOrder.hint = '层序遍历的关键是「分层处理」，通过记录每层节点数量控制遍历范围，确保同一层节点值连续存储';
    problems.push(levelOrder);


    // 4033. 从前序与中序遍历序列构造二叉树
    const buildTreeFromPreIn = new ProblemModel();
    buildTreeFromPreIn.id = 4033;
    buildTreeFromPreIn.title = '从前序与中序遍历序列构造二叉树';
    buildTreeFromPreIn.description = '给定两个整数数组 preorder 和 inorder ，其中 preorder 是二叉树的先序遍历， inorder 是同一棵树的中序遍历，请构造二叉树并返回其根节点。';
    buildTreeFromPreIn.difficulty = ProblemDifficulty.MEDIUM;
    buildTreeFromPreIn.category = ProblemCategory.BINARY_TREE;
    buildTreeFromPreIn.choices = [
      { id: 'A', text: '递归：前序首元素为根，中序中根的位置分割左右子树，递归构建左右子树', isCorrect: true },
      { id: 'B', text: '迭代：用栈模拟前序遍历，通过中序确定左子树边界', isCorrect: false },
      { id: 'C', text: '哈希表存储中序索引，优化查找根位置（辅助递归）', isCorrect: false },
      { id: 'D', text: '先构造后序遍历，再从后序与中序构建（多步转换）', isCorrect: false }
    ];
    buildTreeFromPreIn.explanation = '递归+哈希解法：①若preorder为空，返回null；②rootVal=preorder[0]；root=new TreeNode(rootVal)；③在inorder中找rootVal的索引index（用哈希表预处理inorder的value->index）；④leftSize=index；⑤root.left=buildTree(preorder.slice(1,1+leftSize), inorder.slice(0,index))；⑥root.right=buildTree(preorder.slice(1+leftSize), inorder.slice(index+1))；⑦返回root。时间复杂度O(n)，空间复杂度O(n)（哈希表+递归栈）。';
    buildTreeFromPreIn.hint = '前序遍历「根左右」，中序遍历「左根右」，核心是通过中序确定左右子树大小，实现递归分割';
    problems.push(buildTreeFromPreIn);

    // 4034. 二叉树中的最大路径和
    const maxPathSum = new ProblemModel();
    maxPathSum.id = 4034;
    maxPathSum.title = '二叉树中的最大路径和';
    maxPathSum.description = '路径 被定义为一条从树中任意节点出发，沿父节点-子节点连接，达到任意节点的序列。同一个节点在一条路径序列中 至多出现一次 。该路径 至少包含一个 节点，且不一定经过根节点。路径和 是路径中各节点值的总和。给你一个二叉树的根节点 root ，返回其 最大路径和 。';
    maxPathSum.difficulty = ProblemDifficulty.HARD;
    maxPathSum.category = ProblemCategory.BINARY_TREE;
    maxPathSum.choices = [
      { id: 'A', text: '后序遍历：递归计算每个节点的最大贡献（单边路径和），更新全局最大路径和（左+右+当前值）', isCorrect: true },
      { id: 'B', text: '前序遍历：计算所有可能路径和（时间O(n²)）', isCorrect: false },
      { id: 'C', text: '层次遍历：记录每个节点的路径和（无法处理跨父节点路径）', isCorrect: false },
      { id: 'D', text: '动态规划：存储每个节点的左右路径和（本质同后序遍历）', isCorrect: false }
    ];
    maxPathSum.explanation = '后序遍历解法：①初始化maxSum为负无穷；②定义maxGain(node)：③if node为空，return 0；④leftGain = max(maxGain(node.left), 0)（舍弃负贡献）；⑤rightGain = max(maxGain(node.right), 0)；⑥currentSum = node.val + leftGain + rightGain；⑦maxSum = max(maxSum, currentSum)；⑧return node.val + max(leftGain, rightGain)（返回单边最大贡献）；⑨调用maxGain(root)；返回maxSum。时间复杂度O(n)，空间复杂度O(n)（递归栈）。';
    maxPathSum.hint = '路径和可能不经过根节点，需在递归中同时计算「当前节点为顶点的路径和」并更新全局最大值，返回值仅保留单边最大贡献';
    problems.push(maxPathSum);


    // 4036. 二叉树的序列化与反序列化
    const serializeDeserializeTree = new ProblemModel();
    serializeDeserializeTree.id = 4036;
    serializeDeserializeTree.title = '二叉树的序列化与反序列化';
    serializeDeserializeTree.description = '序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。';
    serializeDeserializeTree.difficulty = ProblemDifficulty.HARD;
    serializeDeserializeTree.category = ProblemCategory.BINARY_TREE;
    serializeDeserializeTree.choices = [
      { id: 'A', text: '前序遍历：序列化时记录节点值（空节点用特殊符号），反序列化时递归解析字符串', isCorrect: true },
      { id: 'B', text: '层序遍历：序列化按层记录节点（含空节点），反序列化用队列重建树', isCorrect: false },
      { id: 'C', text: '后序遍历：逻辑同前序，反序列化时从后向前解析', isCorrect: false },
      { id: 'D', text: '中序遍历：无法唯一确定树结构（同序列可能对应多棵树）', isCorrect: false }
    ];
    serializeDeserializeTree.explanation = '前序解法：①序列化：function serialize(root)：if root为空，return "null,"；str=root.val + "," + serialize(root.left) + serialize(root.right)；return str；②反序列化：将字符串split为数组，指针i=0；function deserialize()：if arr[i]=="null"：i++；return null；node=new TreeNode(arr[i++])；node.left=deserialize()；node.right=deserialize()；return node；调用deserialize()。时间复杂度O(n)，空间复杂度O(n)（递归栈/数组）。';
    serializeDeserializeTree.hint = '序列化必须包含空节点信息才能唯一重建树，前序遍历的递归结构便于反序列化时递归还原';
    problems.push(serializeDeserializeTree);

    // 4037. 验证二叉搜索树
    const isValidBST = new ProblemModel();
    isValidBST.id = 4037;
    isValidBST.title = '验证二叉搜索树';
    isValidBST.description = '给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。有效 二叉搜索树定义如下：节点的左子树只包含 小于 当前节点的数。节点的右子树只包含 大于 当前节点的数。所有左子树和右子树自身必须也是二叉搜索树。';
    isValidBST.difficulty = ProblemDifficulty.MEDIUM;
    isValidBST.category = ProblemCategory.BINARY_TREE;
    isValidBST.choices = [
      { id: 'A', text: '递归+范围限制：传递当前节点允许的最小值和最大值，左子树最大值为当前值，右子树最小值为当前值', isCorrect: true },
      { id: 'B', text: '中序遍历：BST的中序遍历为严格递增序列，检查序列是否递增', isCorrect: false },
      { id: 'C', text: '仅比较当前节点与左右子节点（错误，未考虑祖先节点限制）', isCorrect: false },
      { id: 'D', text: '迭代中序遍历，记录前一个节点值，判断是否递增', isCorrect: false }
    ];
    isValidBST.explanation = '递归范围解法：①定义helper(node, minVal, maxVal)：②if node为空，return true；③val=node.val；④if val<=minVal || val>=maxVal：return false；⑤return helper(node.left, minVal, val) && helper(node.right, val, maxVal)；⑥调用helper(root, -Infinity, Infinity)。时间复杂度O(n)，空间复杂度O(h)（递归栈）。';
    isValidBST.hint = 'BST的每个节点需满足「大于所有左祖先，小于所有右祖先」，递归时传递动态范围是关键，避免仅比较直接子节点';
    problems.push(isValidBST);



    // 4040. 寻找二叉树的最近公共祖先
    const lowestCommonAncestorBinaryTree = new ProblemModel();
    lowestCommonAncestorBinaryTree.id = 4040;
    lowestCommonAncestorBinaryTree.title = '寻找二叉树的最近公共祖先';
    lowestCommonAncestorBinaryTree.description = '给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”';
    lowestCommonAncestorBinaryTree.difficulty = ProblemDifficulty.MEDIUM;
    lowestCommonAncestorBinaryTree.category = ProblemCategory.BINARY_TREE;
    lowestCommonAncestorBinaryTree.choices = [
      { id: 'A', text: '递归：若当前节点是p或q，返回当前节点；否则递归左右子树，若左右均返回非空，则当前节点是LCA；否则返回非空的一方', isCorrect: true },
      { id: 'B', text: '记录父节点：遍历树记录每个节点的父节点，再向上追溯p和q的路径找交点', isCorrect: false },
      { id: 'C', text: '前序遍历标记路径，再找最后一个共同节点（空间O(n)）', isCorrect: false },
      { id: 'D', text: '层次遍历，对每层节点判断是否为LCA（时间O(n²)）', isCorrect: false }
    ];
    lowestCommonAncestorBinaryTree.explanation = '递归解法：①function lca(node, p, q)：②if node为空或node==p或node==q：return node；③left=lca(node.left, p, q)；④right=lca(node.right, p, q)；⑤if left && right：return node；⑥return left ? left : right；⑦调用lca(root, p, q)。时间复杂度O(n)，空间复杂度O(h)。';
    lowestCommonAncestorBinaryTree.hint = '递归的核心是「向上传递找到的目标节点」，当左右子树分别找到p和q时，当前节点即为最近公共祖先';
    problems.push(lowestCommonAncestorBinaryTree);

    // 4041. 二叉树的坡度
    const findTilt = new ProblemModel();
    findTilt.id = 4041;
    findTilt.title = '二叉树的坡度';
    findTilt.description = '给定一个二叉树，计算 整个树 的坡度 。一个树的 节点的坡度 定义为，该节点左子树的节点之和和右子树节点之和的 绝对差 。如果没有左子树，左子树的节点之和为 0 ；没有右子树同理。整个树的坡度就是所有节点的坡度之和。';
    findTilt.difficulty = ProblemDifficulty.EASY;
    findTilt.category = ProblemCategory.BINARY_TREE;
    findTilt.choices = [
      { id: 'A', text: '后序遍历：递归计算每个节点的子树和，同时累加当前节点的坡度', isCorrect: true },
      { id: 'B', text: '前序遍历：先计算当前节点坡度，再递归左右子树（需重复计算子树和）', isCorrect: false },
      { id: 'C', text: '层次遍历：对每个节点调用子树和函数（时间O(n²)）', isCorrect: false },
      { id: 'D', text: '中序遍历：无法同时获取左右子树和', isCorrect: false }
    ];
    findTilt.explanation = '后序解法：①totalTilt=0；②定义sum(node)：③if node为空，return 0；④leftSum=sum(node.left)；⑤rightSum=sum(node.right)；⑥tilt=Math.abs(leftSum - rightSum)；totalTilt += tilt；⑦return node.val + leftSum + rightSum；⑧调用sum(root)；返回totalTilt。时间复杂度O(n)，空间复杂度O(h)。';
    findTilt.hint = '子树和的计算与坡度累加可在一次后序遍历中完成，避免重复计算，提高效率';
    problems.push(findTilt);

    // 4042. 路径总和II
    const pathSumII = new ProblemModel();
    pathSumII.id = 4042;
    pathSumII.title = '路径总和II';
    pathSumII.description = '给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有 从根节点到叶子节点 路径总和等于给定目标和的路径。叶子节点 是指没有子节点的节点。';
    pathSumII.difficulty = ProblemDifficulty.MEDIUM;
    pathSumII.category = ProblemCategory.BINARY_TREE;
    pathSumII.choices = [
      { id: 'A', text: '回溯法：递归遍历路径，记录当前路径和节点值，到达叶子节点时判断是否等于目标和', isCorrect: true },
      { id: 'B', text: 'BFS：队列存储节点、当前和、路径（空间开销大）', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个节点的路径和（无法保存完整路径）', isCorrect: false },
      { id: 'D', text: '先计算所有路径和，再筛选目标路径（重复计算）', isCorrect: false }
    ];
    pathSumII.explanation = '回溯解法：①result=[], path=[]；②定义backtrack(node, currentSum)：③if node为空，return；④path.push(node.val)；currentSum += node.val；⑤if 是叶子节点且currentSum==targetSum：result.push([...path])；⑥else：backtrack(node.left, currentSum)；backtrack(node.right, currentSum)；⑦path.pop()；⑧调用backtrack(root, 0)；返回result。时间复杂度O(n)，空间复杂度O(h + k*m)（k为路径数，m为路径长度）。';
    pathSumII.hint = '回溯法通过「入栈-递归-出栈」维护当前路径，到达叶子节点时检查和是否符合，适合收集所有满足条件的路径';
    problems.push(pathSumII);

    // 4043. 二叉搜索树中的插入操作
    const insertIntoBST = new ProblemModel();
    insertIntoBST.id = 4043;
    insertIntoBST.title = '二叉搜索树中的插入操作';
    insertIntoBST.description = '给定二叉搜索树（BST）的根节点 root 和要插入树中的值 value ，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。 输入数据 保证 ，新值和原始二叉搜索树中的任意节点值都不同。注意，可能存在多种有效的插入方式，只要树在插入后仍保持为二叉搜索树即可。 你可以返回 任意有效的结果 。';
    insertIntoBST.difficulty = ProblemDifficulty.MEDIUM;
    insertIntoBST.category = ProblemCategory.BINARY_TREE;
    insertIntoBST.choices = [
      { id: 'A', text: '递归：若当前节点为空，返回新节点；若value小于当前值，递归插入左子树；否则插入右子树', isCorrect: true },
      { id: 'B', text: '迭代：找到适合插入的叶子节点位置，创建新节点并链接', isCorrect: false },
      { id: 'C', text: '重构BST：将新值加入节点列表，重新构建BST（效率低）', isCorrect: false },
      { id: 'D', text: '平衡插入：确保插入后树平衡（超出题目要求）', isCorrect: false }
    ];
    insertIntoBST.explanation = '递归解法：①if root为空，return new TreeNode(value)；②if value < root.val：root.left = insertIntoBST(root.left, value)；③else：root.right = insertIntoBST(root.right, value)；④return root。时间复杂度O(h)，空间复杂度O(h)（递归栈）。迭代解法：①if root为空，return new TreeNode(value)；②current=root；③while true：④if value < current.val：if current.left为空：current.left=new TreeNode(value)；break；else current=current.left；⑤else：if current.right为空：current.right=new TreeNode(value)；break；else current=current.right；⑥return root。时间复杂度O(h)，空间复杂度O(1)。';
    insertIntoBST.hint = '利用BST的「左小右大」特性，无需平衡，只需找到正确的叶子位置插入即可，递归实现简洁直观';
    problems.push(insertIntoBST);

    // 4044. 二叉树的层平均值
    const averageOfLevels = new ProblemModel();
    averageOfLevels.id = 4044;
    averageOfLevels.title = '二叉树的层平均值';
    averageOfLevels.description = '给定一个非空二叉树的根节点 root , 以数组的形式返回每一层节点的平均值。与实际答案相差 10^-5 以内的答案可以被接受。';
    averageOfLevels.difficulty = ProblemDifficulty.EASY;
    averageOfLevels.category = ProblemCategory.BINARY_TREE;
    averageOfLevels.choices = [
      { id: 'A', text: '层序遍历（BFS）：计算每层节点和与数量，求平均值', isCorrect: true },
      { id: 'B', text: '递归DFS：记录每层的节点值，最后计算平均值', isCorrect: false },
      { id: 'C', text: '先序遍历后按层分组计算（逻辑复杂）', isCorrect: false },
      { id: 'D', text: '利用二叉树的完全性（不适用于非完全二叉树）', isCorrect: false }
    ];
    averageOfLevels.explanation = 'BFS解法：①if root为空，return []；②result=[], queue=[root]；③while queue非空：④levelSize=queue.length；sum=0；⑤for i从0到levelSize-1：node=queue.shift()；sum += node.val；⑥if node.left：queue.push(node.left)；if node.right：queue.push(node.right)；⑦result.push(sum / levelSize)；⑧返回result。时间复杂度O(n)，空间复杂度O(n)。';
    averageOfLevels.hint = '层序遍历天然支持分层处理，只需在遍历每层时累加节点值并计数，即可轻松计算平均值';
    problems.push(averageOfLevels);

    // 4045. 二叉树的镜像
    const mirrorTree = new ProblemModel();
    mirrorTree.id = 4045;
    mirrorTree.title = '二叉树的镜像';
    mirrorTree.description = '请完成一个函数，输入一个二叉树，该函数输出它的镜像。';
    mirrorTree.difficulty = ProblemDifficulty.EASY;
    mirrorTree.category = ProblemCategory.BINARY_TREE;
    mirrorTree.choices = [
      { id: 'A', text: '递归：交换当前节点的左右子树，再递归处理左右子树', isCorrect: true },
      { id: 'B', text: '迭代（栈/队列）：遍历节点，交换其左右子树', isCorrect: false },
      { id: 'C', text: '层序遍历，交换每层节点的左右顺序（本质同迭代）', isCorrect: false },
      { id: 'D', text: '构造新树：按镜像结构复制节点（空间O(n)）', isCorrect: false }
    ];
    mirrorTree.explanation = '递归解法：①if root为空，return null；②交换root的left和right；③mirrorTree(root.left)；④mirrorTree(root.right)；⑤return root。时间复杂度O(n)，空间复杂度O(h)。迭代解法：①if root为空，return null；②stack=[root]；③while stack非空：node=stack.pop()；④交换node的left和right；⑤if node.left：stack.push(node.left)；⑥if node.right：stack.push(node.right)；⑦return root。时间复杂度O(n)，空间复杂度O(n)。';
    mirrorTree.hint = '镜像操作即「交换每个节点的左右子树」，递归或迭代均可实现，核心是遍历所有节点并执行交换';
    problems.push(mirrorTree);

    // 4047. 打家劫舍 II
    const robII = new ProblemModel ();robII.id = 4047;robII.title = ' 打家劫舍 II';robII.description = ' 你是一个专业的小偷，计划偷窃沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是相邻的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。给定一个代表每个房屋存放金额的非负整数数组，计算你 在不触动警报装置的情况下 ，今晚能够偷窃到的最高金额。';robII.difficulty = ProblemDifficulty.MEDIUM;robII.category = ProblemCategory.DYNAMIC_PROGRAMMING;robII.choices = [{id: 'A', text: ' 拆分问题：分别计算偷 [0..n-2] 和 [1..n-1] 的最大金额，取两者最大值 ', isCorrect: true },{ id: 'B', text: ' 直接在 I 的基础上修改 DP 状态，加入环形判断（逻辑复杂）', isCorrect: false },{ id: 'C', text: ' 贪心选择排除金额最小的房屋（无法保证全局最优）', isCorrect: false },{ id: 'D', text: ' 递归遍历所有可能（时间 O (2^n)，超时）', isCorrect: false }];robII.explanation = ' 拆分 DP 解法：①定义辅助函数 robRange (nums, start, end)：实现打家劫舍 I 的逻辑，返回该区间的最大金额；②n=nums.length；if n==0 return 0；if n==1 return nums [0]；③return Math.max (robRange (nums, 0, n-2), robRange (nums, 1, n-1))。时间复杂度 O (n)，空间复杂度 O (1)。';robII.hint = ' 环形问题的关键是「拆分无环子问题」，由于首尾相邻，只需排除首或尾其一，转化为线性打家劫舍问题 ';problems.push (robII);
    // 4048. 最长公共子序列
    const longestCommonSubsequence = new ProblemModel ();longestCommonSubsequence.id = 4048;longestCommonSubsequence.title = ' 最长公共子序列 ';longestCommonSubsequence.description = ' 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0 。一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。';longestCommonSubsequence.difficulty = ProblemDifficulty.MEDIUM;longestCommonSubsequence.category = ProblemCategory.DYNAMIC_PROGRAMMING;longestCommonSubsequence.choices = [{id: 'A', text: 'DP：dp [i][j] 表示 text1 前 i 个与 text2 前 j 个的 LCS 长度，text1 [i-1]==text2 [j-1] 则 dp [i][j]=dp [i-1][j-1]+1，否则取 max (dp [i-1][j], dp [i][j-1])', isCorrect: true },{ id: 'B', text: ' 递归 + 记忆化，逻辑同 DP（空间开销大）', isCorrect: false },{ id: 'C', text: ' 暴力枚举 text1 的所有子序列，检查是否在 text2 中（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: ' 哈希表存储 text2 的字符位置，再遍历 text1 匹配（无法处理顺序）', isCorrect: false }];longestCommonSubsequence.explanation = ' 空间优化 DP：①m=text1.length，n=text2.length；②dp 数组（长度 n+1）初始化 0；③for i 从 1 到 m：prev=0；④for j 从 1 到 n：temp=dp [j]；⑤if text1 [i-1]==text2 [j-1]：dp [j] = prev + 1；⑥else：dp [j] = Math.max (dp [j], dp [j-1])；⑦prev=temp；⑧return dp [n]。时间复杂度 O (mn)，空间复杂度 O (n)。';longestCommonSubsequence.hint = ' 子序列不要求连续，DP 状态需覆盖两个字符串的所有前缀组合，通过空间优化减少存储开销 ';problems.push (longestCommonSubsequence);
    // 4052. 最长递增子序列的个数
    const findNumberOfLIS = new ProblemModel ();findNumberOfLIS.id = 4052;findNumberOfLIS.title = ' 最长递增子序列的个数 ';findNumberOfLIS.description = ' 给定一个未排序的整数数组，找到最长递增子序列的个数。';findNumberOfLIS.difficulty = ProblemDifficulty.MEDIUM;findNumberOfLIS.category = ProblemCategory.DYNAMIC_PROGRAMMING;findNumberOfLIS.choices = [{id: 'A', text: 'DP：len [i] 表示以 i 结尾的 LIS 长度，cnt [i] 表示个数，遍历 j<i 更新 len 和 cnt，最后统计最长长度的总个数 ', isCorrect: true },{ id: 'B', text: ' 贪心 + 二分，记录每个长度的个数（实现复杂）', isCorrect: false },{ id: 'C', text: ' 暴力枚举所有子序列，统计最长的个数（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: ' 递归 + 记忆化，记录每个位置的 LIS 长度和个数（时间效率低）', isCorrect: false }];findNumberOfLIS.explanation = 'DP 解法：①n=nums.length；if n<=1 return n；②len 数组（长度 n）初始化 1，cnt 数组（长度 n）初始化 1；③maxLen=1；④for i from 1 to n-1：⑤for j from 0 to i-1：⑥if nums [j] < nums [i]：⑦if len [j]+1 > len [i]：len [i]=len [j]+1；cnt [i]=cnt [j]；⑧else if len [j]+1 == len [i]：cnt [i] += cnt [j]；⑨maxLen=Math.max (maxLen, len [i])；⑩result=0；for i from 0 to n-1：if len [i]==maxLen：result += cnt [i]；return result。时间复杂度 O (n²)，空间复杂度 O (n)。';findNumberOfLIS.hint = ' 在常规 LIS 的 DP 基础上，增加计数数组记录每个长度的子序列个数，最后汇总最长长度的总计数 ';problems.push (findNumberOfLIS);
    // 4053. 分割回文串 II
    const minCut = new ProblemModel ();minCut.id = 4053;minCut.title = ' 分割回文串 II';minCut.description = ' 给你一个字符串 s，请你将 s 分割成一些子串，使每个子串都是回文。返回符合要求的 最少分割次数 。';minCut.difficulty = ProblemDifficulty.HARD;minCut.category = ProblemCategory.DYNAMIC_PROGRAMMING;minCut.choices = [{id: 'A', text: ' 双 DP：①isPal [i][j] 标记 s [i..j] 是否回文；②dp [i] 表示 s [0..i] 的最少分割数，dp [i] = min (dp [j-1]+1)（j<=i 且 s [j..i] 回文）', isCorrect: true },{ id: 'B', text: ' 递归 + 记忆化，枚举所有分割点（时间 O (2^n)）', isCorrect: false },{ id: 'C', text: ' 贪心选择最短回文子串（无法保证全局最优）', isCorrect: false },{ id: 'D', text: 'BFS，按分割次数分层（空间开销大）', isCorrect: false }];minCut.explanation = ' 双 DP 解法：①n=s.length；②isPal 二维数组初始化 false；③for i from n-1 down to 0：④for j from i to n-1：⑤if s [i]==s [j] && (j-i<=1 || isPal [i+1][j-1])：isPal [i][j]=true；⑥dp 数组初始化 Infinity；dp [0]=0；⑦for i from 1 to n-1：⑧if isPal [0][i]：dp [i]=0；continue；⑨for j from 1 to i：⑩if isPal [j][i] && dp [j-1]+1 < dp [i]：dp [i] = dp [j-1]+1；⑪return dp [n-1]。时间复杂度 O (n²)，空间复杂度 O (n²)。';minCut.hint = ' 先预处理回文子串减少重复判断，再用 DP 枚举所有可能的分割点，逐步更新最少分割次数 ';problems.push (minCut);
    // 4055. 最长回文子串
    const longestPalindromeSubstring = new ProblemModel ();longestPalindromeSubstring.id = 4055;longestPalindromeSubstring.title = ' 最长回文子串 ';longestPalindromeSubstring.description = ' 给你一个字符串 s，找到 s 中最长的回文子串。';longestPalindromeSubstring.difficulty = ProblemDifficulty.MEDIUM;longestPalindromeSubstring.category = ProblemCategory.DYNAMIC_PROGRAMMING;longestPalindromeSubstring.choices = [{id: 'A', text: ' 中心扩展法：以每个字符 / 每对相邻字符为中心，扩展找最长回文，记录起始和长度 ', isCorrect: true},{ id: 'B', text: 'DP：dp [i][j] 标记 s [i..j] 是否回文，从短到长枚举子串长度 ', isCorrect: false },{ id: 'C', text: 'Manacher 算法，线性时间复杂度（实现复杂）', isCorrect: false },{ id: 'D', text: ' 暴力枚举所有子串，判断是否回文（时间 O (n³)）', isCorrect: false }];longestPalindromeSubstring.explanation = ' 中心扩展解法：①maxLen=1，start=0；②定义 expand (l, r)：while l>=0 且 r<s.length 且 s [l]==s [r]：l--；r++；return {len: r-l-1, start: l+1}；③for i from 0 to s.length-1：④{len1, start1}=expand (i,i)；{len2, start2}=expand (i,i+1)；⑤currentLen=Math.max (len1, len2)；⑥if currentLen>maxLen：maxLen=currentLen；start= len1>len2 ? start1 : start2；⑦return s.slice (start, start+maxLen)。时间复杂度 O (n²)，空间复杂度 O (1)。';longestPalindromeSubstring.hint = ' 回文具有对称性，中心扩展法通过遍历所有可能的中心，高效找到最长回文，空间复杂度最优 ';problems.push (longestPalindromeSubstring);
    // 4056. 编辑距离
    const minDistanceEdit = new ProblemModel ();minDistanceEdit.id = 4056;minDistanceEdit.title = ' 编辑距离 ';minDistanceEdit.description = ' 给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数 。你可以对一个单词进行如下三种操作：1. 插入一个字符；2. 删除一个字符；3. 替换一个字符。';minDistanceEdit.difficulty = ProblemDifficulty.HARD;minDistanceEdit.category = ProblemCategory.DYNAMIC_PROGRAMMING;minDistanceEdit.choices = [{id: 'A', text: 'DP：dp [i][j] 表示 word1 前 i 个转 word2 前 j 个的最少操作，相同则继承 dp [i-1][j-1]，否则取 min (插入 / 删除 / 替换)+1', isCorrect: true },{ id: 'B', text: ' 递归 + 记忆化，逻辑同 DP（时间效率低）', isCorrect: false },{ id: 'C', text: ' 贪心选择优先匹配相同字符（无法保证全局最优）', isCorrect: false },{ id: 'D', text: ' 字符串哈希，比较子串相似度（逻辑错误）', isCorrect: false }];minDistanceEdit.explanation = ' 空间优化 DP：①m=word1.length，n=word2.length；②dp 数组（长度 n+1）初始化 0..n；③for i from 1 to m：④prev=dp [0]；dp [0]=i；⑤for j from 1 to n：⑥temp=dp [j]；⑦if word1 [i-1]==word2 [j-1]：dp [j]=prev；⑧else：dp [j] = 1 + Math.min (dp [j], dp [j-1], prev)；⑨prev=temp；⑩return dp [n]。时间复杂度 O (mn)，空间复杂度 O (n)。';minDistanceEdit.hint = ' 编辑距离是经典 DP 问题，核心是「子问题分解」，每种操作对应不同的状态转移，空间优化后可降低存储开销 ';problems.push (minDistanceEdit);
    // 4059. 最长连续递增序列
    const findLengthOfLCIS = new ProblemModel ();findLengthOfLCIS.id = 4059;findLengthOfLCIS.title = ' 最长连续递增序列 ';findLengthOfLCIS.description = ' 给定一个未经排序的整数数组，找到最长且 连续递增的子序列，并返回该序列的长度。连续递增的子序列 可以由两个下标 l 和 r（l <r）确定，如果对于每个 l <= i < r，都有 nums [i] < nums [i + 1]，那么子序列 [nums [l], nums [l + 1], ..., nums [r]] 就是连续递增子序列。';findLengthOfLCIS.difficulty = ProblemDifficulty.EASY;findLengthOfLCIS.category = ProblemCategory.DYNAMIC_PROGRAMMING;findLengthOfLCIS.choices = [{ id: 'A', text: 'DP / 贪心：currentLen 记录当前连续长度，maxLen 记录最大值，递增则 currentLen++，否则重置为 1', isCorrect: true },{ id: 'B', text: ' 暴力枚举所有连续子序列，判断是否递增（时间 O (n²)）', isCorrect: false },{ id: 'C', text: ' 排序后找最长连续序列（破坏原顺序，错误）', isCorrect: false },{ id: 'D', text: ' 哈希表存储元素位置，计算连续长度（不适合连续递增场景）', isCorrect: false }];findLengthOfLCIS.explanation = ' 贪心解法：①n=nums.length；if n==0 return 0；②maxLen=1，currentLen=1；③for i from 1 to n-1：④if nums [i]>nums [i-1]：currentLen++；maxLen=Math.max (maxLen, currentLen)；⑤else：currentLen=1；⑥return maxLen。时间复杂度 O (n)，空间复杂度 O (1)。';findLengthOfLCIS.hint = ' 连续递增子序列的特点是「相邻元素严格递增」，只需一次遍历，用变量记录当前长度和最大值即可 ';problems.push (findLengthOfLCIS);
    // 4060. 分割等和子集
    const canPartitionSubset = new ProblemModel ();canPartitionSubset.id = 4060;canPartitionSubset.title = ' 分割等和子集 ';canPartitionSubset.description = ' 给你一个 只包含正整数 的 非空 数组 nums 。请你判断是否可以将这个数组分割成两个子集，使得两个子集的元素和相等。';canPartitionSubset.difficulty = ProblemDifficulty.MEDIUM;canPartitionSubset.category = ProblemCategory.DYNAMIC_PROGRAMMING;canPartitionSubset.choices = [{id: 'A', text: '0-1 背包：判断是否存在子集和等于总和的一半，dp [i] 表示能否凑成 i', isCorrect: true },{ id: 'B', text: ' 递归 + 剪枝，尝试所有子集划分（时间 O (2^n)）', isCorrect: false },{ id: 'C', text: ' 贪心选择，从大到小累加直到目标（无法保证全局最优）', isCorrect: false },{ id: 'D', text: ' 位运算，用二进制表示可能的子集和（空间开销大）', isCorrect: false }];canPartitionSubset.explanation = '0-1 背包解法：①sum = 数组总和；if sum 为奇数 return false；target=sum/2；②maxNum=Math.max (...nums)；if maxNum>target return false；③dp 数组（长度 target+1）初始化 false；dp [0]=true；④for num in nums：⑤for i from target down to num：⑥dp [i] = dp [i] || dp [i-num]；⑦return dp [target]。时间复杂度 O (n×target)，空间复杂度 O (target)。';canPartitionSubset.hint = ' 将分割问题转化为「子集和」问题，利用 0-1 背包的思路判断是否存在符合条件的子集，注意提前剪枝（如最大元素超过目标）';problems.push (canPartitionSubset);
    // 五、图论类（15 题）// 4061. 课程表
    const canFinishCourses = new ProblemModel ();canFinishCourses.id = 4061;canFinishCourses.title = ' 课程表 ';canFinishCourses.description = ' 你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1。在选修某些课程之前需要一些先修课程，例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示：[0,1]。给定课程总数以及它们的先决条件，请你判断是否可能完成所有课程的学习？';canFinishCourses.difficulty = ProblemDifficulty.MEDIUM;canFinishCourses.category = ProblemCategory.GRAPH;canFinishCourses.choices = [{ id: 'A', text: ' 拓扑排序（Kahn 算法）：计算入度，逐步删除入度为 0 的节点，最后判断删除数是否等于课程数 ', isCorrect: true },{ id: 'B', text: 'DFS 检测环：用访问状态（未访问 / 访问中 / 已访问）判断是否存在环 ', isCorrect: false },{ id: 'C', text: 'BFS 遍历所有节点，检查是否有可达路径（无法检测环）', isCorrect: false },{ id: 'D', text: ' 动态规划，记录每门课程的先修条件是否满足（逻辑错误）', isCorrect: false }];canFinishCourses.explanation = 'Kahn 算法：①构建邻接表 adj 和入度数组 inDegree；②队列存储入度为 0 的节点；count=0；③while 队列非空：u = 出队；count++；④for v in adj [u]：inDegree [v]--；if inDegree [v]==0：入队；⑤return count==numCourses。时间复杂度 O (n+m)（n 课程数，m 先修关系数），空间复杂度 O (n+m)。';canFinishCourses.hint = ' 核心是「判断有向图是否无环」，拓扑排序通过删除入度为 0 的节点，若最终所有节点都被删除则无环，可完成所有课程 ';problems.push (canFinishCourses);
    // 4062. 课程表 II
    const findOrderCourses = new ProblemModel ();findOrderCourses.id = 4062;findOrderCourses.title = ' 课程表 II';findOrderCourses.description = ' 现在你总共有 numCourses 门课需要学习，记为 0 到 numCourses - 1。给你一个数组 prerequisites ，其中 prerequisites [i] = [ai, bi] ，表示在选修课程 ai 之前必须先选修 bi 。请你返回一个可以学完所有课程的顺序。可能会有多个正确的顺序，你只要返回任意一个就可以了。如果不可能完成所有课程，返回一个空数组。';findOrderCourses.difficulty = ProblemDifficulty.MEDIUM;findOrderCourses.category = ProblemCategory.GRAPH;findOrderCourses.choices = [{ id: 'A', text: ' 拓扑排序（Kahn 算法）：删除入度为 0 的节点时记录顺序，最后判断长度是否等于课程数 ', isCorrect: true },{ id: 'B', text: 'DFS 后序遍历：检测环的同时记录节点，反转后为拓扑序 ', isCorrect: false },{ id: 'C', text: ' 贪心选择，每次选先修课程最少的（无法保证无环）', isCorrect: false },{ id: 'D', text: ' 并查集，合并先修课程关系（无法处理依赖顺序）', isCorrect: false }];findOrderCourses.explanation = 'Kahn 算法：①构建邻接表 adj 和入度数组 inDegree；②队列存储入度为 0 的节点；result=[]；③while 队列非空：u = 出队；result.push (u)；④for v in adj [u]：inDegree [v]--；if inDegree [v]==0：入队；⑤return result.length==numCourses ? result : []。时间复杂度 O (n+m)，空间复杂度 O (n+m)。';findOrderCourses.hint = ' 在课程表 I 的基础上，增加节点记录步骤，拓扑排序的结果即为合法的课程学习顺序 ';problems.push (findOrderCourses);
    // 4063. 网络延迟时间
    const networkDelayTime = new ProblemModel ();networkDelayTime.id = 4063;networkDelayTime.title = ' 网络延迟时间 ';networkDelayTime.description = ' 有 n 个网络节点，标记为 1 到 n。给你一个列表 times，表示信号经过 有向 边的传递时间。 times [i] = (u_i, v_i, w_i)，其中 u_i 是源节点，v_i 是目标节点，w_i 是一个信号从源节点传递到目标节点的时间。现在，从某个节点 k 发出一个信号。需要多久才能使所有节点都收到信号？如果不能使所有节点收到信号，返回 -1 。';networkDelayTime.difficulty = ProblemDifficulty.MEDIUM;networkDelayTime.category = ProblemCategory.GRAPH;networkDelayTime.choices = [{ id: 'A', text: 'Dijkstra 算法：求单源最短路径，所有节点最短路径的最大值即为答案 ', isCorrect: true },{ id: 'B', text: 'Floyd-Warshall 算法，计算所有节点对的最短路径（时间 O (n³)，效率低）', isCorrect: false },{ id: 'C', text: 'BFS，适用于边权为 1 的情况（无法处理加权边）', isCorrect: false },{ id: 'D', text: 'Bellman-Ford 算法，可处理负权边（此处无负权，效率低于 Dijkstra）', isCorrect: false }];networkDelayTime.explanation = 'Dijkstra 解法：①构建邻接表 adj；②dist 数组初始化 Infinity；dist [k]=0；③优先队列（最小堆）存入 (k, 0)；④while 队列非空：(u, t)= 出队；if t>dist [u]：跳过；⑤for (v, w) in adj [u]：if dist [v]>t+w：dist [v]=t+w；入队 (v, dist [v])；⑥maxDist=Math.max (...dist)；return maxDist===Infinity ? -1 : maxDist。时间复杂度 O (m log n)，空间复杂度 O (n+m)。';networkDelayTime.hint = ' 核心是「单源最短路径」，从 k 到所有节点的最短时间决定了整体延迟，取最大值即为所有节点收到信号的时间 ';problems.push (networkDelayTime);
    // 4064. 冗余连接
    const findRedundantConnection = new ProblemModel ();findRedundantConnection.id = 4064;findRedundantConnection.title = ' 冗余连接 ';findRedundantConnection.description = ' 树可以看成是一个连通且 无环 的 无向 图。给定往一棵 n 个节点 (节点值 1～n) 的树中添加一条边后的图。添加的这条边使得图中包含一个环，请找出这条多余的边。';findRedundantConnection.difficulty = ProblemDifficulty.MEDIUM;findRedundantConnection.category = ProblemCategory.GRAPH;findRedundantConnection.choices = [{ id: 'A', text: ' 并查集（Union-Find）：遍历边，若两点已连通则为冗余边，否则合并 ', isCorrect: true },{ id: 'B', text: 'DFS：遍历每条边，删除后判断是否无环（时间 O (mn)）', isCorrect: false },{ id: 'C', text: 'BFS：逻辑同 DFS，效率低 ', isCorrect: false },{ id: 'D', text: ' 拓扑排序，找无法删除的边（不适用于无向图）', isCorrect: false }];findRedundantConnection.explanation = ' 并查集解法：①初始化 parent 数组（1..n）；②定义 find (x)：路径压缩；③定义 union (x,y)：按秩合并；④for each edge (u,v) in edges：⑤if find (u)==find (v)：return edge；⑥else：union (u,v)；⑦return []。时间复杂度 O (m α(n))（α 为阿克曼函数反函数，接近常数），空间复杂度 O (n)。';findRedundantConnection.hint = ' 无向图的冗余边导致环的形成，并用查集可高效判断两点是否已连通，首次发现连通的边即为冗余边 ';problems.push (findRedundantConnection);
    // 4065. 岛屿数量
    const pacificAtlantic = new ProblemModel ();pacificAtlantic.id = 4066;pacificAtlantic.title = ' 太平洋大西洋水流问题 ';pacificAtlantic.description = ' 有一个 m x n 的矩形岛屿，与 太平洋 和 大西洋 相邻。 “太平洋” 处于大陆的左边界和上边界，而 “大西洋” 处于大陆的右边界和下边界。水流只能按照上、下、左、右四个方向流动，且只能从高到低或者在同等高度上流动。请找出那些水流既可以流动到 “太平洋”，又能流动到 “大西洋” 的陆地单元的坐标。';pacificAtlantic.difficulty = ProblemDifficulty.MEDIUM;pacificAtlantic.category = ProblemCategory.GRAPH;pacificAtlantic.choices = [{ id: 'A', text: ' 反向 DFS/BFS：分别从太平洋和大西洋边界出发，标记可到达的陆地，最后取交集 ', isCorrect: true },{ id: 'B', text: ' 正向 DFS/BFS：对每个陆地判断是否能到两个大洋（时间 O ((mn)²)）', isCorrect: false },{ id: 'C', text: ' 动态规划，记录每个陆地到两个大洋的可达性（边界处理复杂）', isCorrect: false },{ id: 'D', text: ' 贪心选择，优先判断边界陆地（无法覆盖内部陆地）', isCorrect: false }];pacificAtlantic.explanation = ' 反向 DFS 解法：①m=heights.length；if m==0 return []；n=heights [0].length；②定义两个布尔矩阵 pacific 和 atlantic；③定义 dfs (i,j,visited)：if visited [i][j]：return；visited [i][j]=true；④遍历四个方向：ni,nj；if ni、nj 在范围内且 heights [ni][nj]>=heights [i][j]：dfs (ni,nj,visited)；⑤初始化：上边界和左边界 DFS 标记 pacific；下边界和右边界 DFS 标记 atlantic；⑥遍历所有陆地，若 pacific [i][j] 且 atlantic [i][j]：加入结果。时间复杂度 O (mn)，空间复杂度 O (mn)。';pacificAtlantic.hint = ' 反向思维降低复杂度：从大洋边界（可直接到达大洋）出发，寻找可逆流到达的陆地，最后取两个大洋可达陆地的交集 ';problems.push (pacificAtlantic);
    // 4067. 腐烂的橘子
    const orangesRotting = new ProblemModel ();orangesRotting.id = 4067;orangesRotting.title = ' 腐烂的橘子 ';orangesRotting.description = ' 在给定的 m x n 网格中，每个单元格可以有以下三个值之一：值 0 代表空单元格；值 1 代表新鲜橘子；值 2 代表腐烂的橘子。每分钟，腐烂的橘子 周围 4 个方向上相邻 的新鲜橘子都会腐烂。返回直到单元格中没有新鲜橘子为止所必须经过的最小分钟数。如果不可能，返回 -1 。';orangesRotting.difficulty = ProblemDifficulty.MEDIUM;orangesRotting.category = ProblemCategory.GRAPH;orangesRotting.choices = [{id: 'A', text: 'BFS（多源）：初始将所有腐烂橘子入队，按层遍历，记录时间，最后检查是否有剩余新鲜橘子 ', isCorrect: true},{ id: 'B', text: 'DFS：递归处理腐烂过程（无法记录时间，错误）', isCorrect: false },{ id: 'C', text: ' 暴力模拟，每分钟遍历网格更新腐烂状态（时间 O ((mn)²)）', isCorrect: false },{ id: 'D', text: ' 动态规划，记录每个橘子腐烂的时间（边界处理复杂）', isCorrect: false }];orangesRotting.explanation = ' 多源 BFS 解法：①m=grid.length；n=grid [0].length；queue=[]；fresh=0；time=0；②for i from 0 to m-1：for j from 0 to n-1：if grid [i][j]==2：queue.push ([i,j])；else if grid [i][j]==1：fresh++；③directions=[[-1,0],[1,0],[0,-1],[0,1]]；④while queue.length>0 && fresh>0：levelSize=queue.length；time++；⑤for k from 0 to levelSize-1：[i,j]=queue.shift ()；⑥for [di,dj] in directions：ni=i+di；nj=j+dj；⑦if ni、nj 在范围内且 grid [ni][nj]==1：grid [ni][nj]=2；fresh--；queue.push ([ni,nj])；⑧return fresh==0 ? time : -1。时间复杂度 O (mn)，空间复杂度 O (mn)。';orangesRotting.hint = ' 多源 BFS 适合「多起点扩散」问题，按层遍历的层数即为时间，最后通过新鲜橘子数量判断是否完全腐烂 ';problems.push (orangesRotting);
    // 4068. 单词接龙
    const ladderLengthWord = new ProblemModel ();ladderLengthWord.id = 4068;ladderLengthWord.title = ' 单词接龙 ';ladderLengthWord.description = ' 字典 wordList 中从单词 beginWord 和 endWord 的转换序列是一个按下述规格形成的序列 beginWord -> s1 -> s2 -> ... -> sk：每一对相邻的单词只差一个字母；对于 1 <= i <= k 时，每个 si 都在 wordList 中；注意，beginWord 不需要在 wordList 中；sk == endWord。给你两个单词 beginWord 和 endWord 和一个字典 wordList，返回从 beginWord 到 endWord 的最短转换序列中的单词数目。如果不存在这样的转换序列，返回 0。';ladderLengthWord.difficulty = ProblemDifficulty.HARD;ladderLengthWord.category = ProblemCategory.GRAPH;ladderLengthWord.choices = [{id: 'A', text: 'BFS（双向优化）：从 beginWord 和 endWord 同时出发，相遇时返回步数和 ', isCorrect: true},{ id: 'B', text: ' 单向 BFS：从 beginWord 出发，逐层遍历（时间 O (L×26×n)，n 为 wordList 大小）', isCorrect: false },{ id: 'C', text: 'DFS：尝试所有转换路径，记录最短长度（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: ' 构建单词图，求最短路径（空间开销大）', isCorrect: false }];ladderLengthWord.explanation = ' 双向 BFS 解法：①wordSet = 新集合 (wordList)；if !wordSet.has (endWord) return 0；②beginSet={beginWord}，endSet={endWord}；visited=new Set ()；length=1；③while beginSet.size>0 && endSet.size>0：④if beginSet.size>endSet.size：交换 beginSet 和 endSet；⑤nextSet=new Set ()；length++；⑥for word in beginSet：⑦for i from 0 to word.length-1：⑧for c from \'a\' to \'z\'：⑨if c==word [i] continue；⑩newWord=word.slice (0,i)+c+word.slice (i+1)；⑪if endSet.has (newWord) return length；⑫if wordSet.has (newWord) && !visited.has (newWord)：visited.add (newWord)；nextSet.add (newWord)；⑬beginSet=nextSet；⑭return 0。时间复杂度 O (L×26×n)，空间复杂度 O (n)。';ladderLengthWord.hint = ' 双向 BFS 通过从两端同时扩散，减少遍历的节点数，大幅提升效率，核心是「每次选择较小的集合遍历」';problems.push (ladderLengthWord);
    // 4069. 最小基因变化
    const minMutation = new ProblemModel ();minMutation.id = 4069;minMutation.title = ' 最小基因变化 ';minMutation.description = ' 基因序列可以表示为一条由 8 个字符组成的字符串，其中每个字符都是 \'A\'、\'C\'、\'G\' 和 \'T\' 之一。假设我们需要调查从基因序列 start 变为 end 所发生的基因变化。一次基因变化就意味着这个基因序列中的一个字符发生了变化。此外，还有一个基因库 bank 记录了所有有效的基因变化，只有基因库中的基因才是有效的基因序列。请找出从 start 到 end 所需的最少变化次数。如果无法完成此基因变化，返回 -1。注意：起始基因序列 start 默认是有效的，但是它并不一定会出现在基因库中。';minMutation.difficulty = ProblemDifficulty.MEDIUM;minMutation.category = ProblemCategory.GRAPH;minMutation.choices = [{id: 'A', text: 'BFS：将基因视为节点，一次变化的基因视为相邻节点，求 start 到 end 的最短路径 ', isCorrect: true},{ id: 'B', text: 'DFS：递归尝试所有变化路径，记录最小次数（时间 O (4^8)）', isCorrect: false },{ id: 'C', text: ' 动态规划，记录每个基因的最小变化次数（基因数量少，无需 DP）', isCorrect: false },{ id: 'D', text: ' 贪心选择，每次选择与 end 差异最小的基因（无法保证全局最优）', isCorrect: false }];minMutation.explanation = 'BFS 解法：①bankSet = 新集合 (bank)；if !bankSet.has (end) return -1；②queue=[[start, 0]]；visited=new Set ([start])；③chars=[\'A\',\'C\',\'G\',\'T\']；④while queue.length>0：[gene, step]=queue.shift ()；⑤if gene==end return step；⑥for i from 0 to 7：⑦for c in chars：⑧if c==gene [i] continue；⑨newGene=gene.slice (0,i)+c+gene.slice (i+1)；⑩if bankSet.has (newGene) && !visited.has (newGene)：visited.add (newGene)；queue.push ([newGene, step+1])；⑪return -1。时间复杂度 O (8×4×n)（n 为 bank 大小），空间复杂度 O (n)。';minMutation.hint = ' 与单词接龙类似，属于「最短路径」问题，BFS 按步骤遍历所有可能的基因变化，首次到达 end 的步数即为最小值 ';problems.push (minMutation);
    // 4070. 克隆图
    const cloneGraph = new ProblemModel ();cloneGraph.id = 4070;cloneGraph.title = ' 克隆图 ';cloneGraph.description = ' 给你无向连通图中一个节点的引用，请你返回该图的 深拷贝（克隆）。图中的每个节点都包含它的值 val（int） 和其邻居的列表（list [Node]）。';cloneGraph.difficulty = ProblemDifficulty.MEDIUM;cloneGraph.category = ProblemCategory.GRAPH;cloneGraph.choices = [{ id: 'A', text: 'DFS/BFS：用哈希表记录原节点到克隆节点的映射，避免重复克隆，递归 / 迭代克隆邻居 ', isCorrect: true },{ id: 'B', text: ' 暴力克隆，不处理重复节点（导致循环引用）', isCorrect: false },{ id: 'C', text: ' 拓扑排序后克隆（无向图无需拓扑排序）', isCorrect: false },{ id: 'D', text: ' 序列化图后反序列化（实现复杂）', isCorrect: false }];cloneGraph.explanation = 'DFS 解法：①if node 为空 return null；②map=new Map ()；③function dfs (n)：④if map.has (n) return map.get (n)；⑤clone=new Node (n.val)；map.set (n, clone)；⑥for neighbor in n.neighbors：clone.neighbors.push (dfs (neighbor))；⑦return clone；⑧return dfs (node)。时间复杂度 O (n)（n 为节点数），空间复杂度 O (n)（哈希表 + 递归栈）。';cloneGraph.hint = ' 深拷贝的关键是「避免重复克隆节点」，用哈希表建立原节点与克隆节点的映射，确保每个节点只克隆一次 ';problems.push (cloneGraph);
    // 4071. 寻找最短路径的条数
    const findShortestPathNum = new ProblemModel ();findShortestPathNum.id = 4071;findShortestPathNum.title = ' 寻找最短路径的条数 ';findShortestPathNum.description = ' 给定一个有向无环图（DAG），图中有 n 个节点，编号从 0 到 n-1。请找出从节点 0 到节点 n-1 的最短路径的条数。';findShortestPathNum.difficulty = ProblemDifficulty.MEDIUM;findShortestPathNum.category = ProblemCategory.GRAPH;findShortestPathNum.choices = [{id: 'A', text: ' 拓扑排序 + DP：拓扑序遍历节点，dist [i] 记录 0 到 i 的最短距离，cnt [i] 记录条数，更新 dist 和 cnt', isCorrect: true },{ id: 'B', text: 'BFS：按层记录距离，统计到达终点的路径数（无法处理加权边）', isCorrect: false },{ id: 'C', text: 'DFS + 记忆化，统计所有路径的长度和条数（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: 'Floyd-Warshall 算法，计算最短距离后统计路径（效率低）', isCorrect: false }];findShortestPathNum.explanation = ' 拓扑 + DP 解法：①构建邻接表 adj（每个节点存储 (邻居，边权)）；②计算入度数组 inDegree；③拓扑排序得到 order；④dist 数组初始化 Infinity；dist [0]=0；cnt 数组初始化 0；cnt [0]=1；⑤for u in order：⑥if dist [u]==Infinity continue；⑦for (v, w) in adj [u]：⑧if dist [v] > dist [u]+w：dist [v] = dist [u]+w；cnt [v] = cnt [u]；⑨else if dist [v] == dist [u]+w：cnt [v] += cnt [u]；⑩return cnt [n-1]。时间复杂度 O (n+m)，空间复杂度 O (n+m)。';findShortestPathNum.hint = 'DAG 的特性适合拓扑排序，按拓扑序更新最短距离和路径数，确保处理节点 u 时其前驱节点已处理完毕 ';problems.push (findShortestPathNum);
    // 4072. 冗余连接 II
    const findRedundantDirectedConnection = new ProblemModel ();findRedundantDirectedConnection.id = 4072;findRedundantDirectedConnection.title = ' 冗余连接 II';findRedundantDirectedConnection.description = ' 在本问题中，有根树指满足以下条件的 有向 图。该树只有一个根节点，所有其他节点都是该根节点的后继。该树除了根节点之外的每一个节点都有且只有一个父节点，而根节点没有父节点。输入一个有向图，该图由一个有着 n 个节点（节点值不重复，从 1 到 n）的树及一条附加的有向边构成。附加的边包含在 1 到 n 中的两个不同顶点间，这条附加的边不属于树中已存在的边。请找出这条附加的边，使删除它之后，剩余的图是一个有着 n 个节点的有根树。';findRedundantDirectedConnection.difficulty = ProblemDifficulty.HARD;findRedundantDirectedConnection.category = ProblemCategory.GRAPH;findRedundantDirectedConnection.choices = [{id: 'A', text: ' 并查集 + 异常边检测：先找有两个父节点的节点（冲突边），再找导致环的边，优先删除冲突边 ', isCorrect: true},{ id: 'B', text: 'DFS 检测环和冲突（实现复杂）', isCorrect: false },{ id: 'C', text: ' 暴力删除每条边，判断是否为有根树（时间 O (mn)）', isCorrect: false },{ id: 'D', text: ' 拓扑排序，找无法删除的边（不适用于有根树判断）', isCorrect: false }];findRedundantDirectedConnection.explanation = ' 并查集解法：①n=edges.length；parent 数组（1..n）记录父节点；conflict=[-1,-1]；cycle=[-1,-1]；②for i from 0 to n-1：[u,v]=edges [i]；③if parent [v]!=-1：conflict=[parent [v],v, edges [i]]；④else：parent [v]=u；⑤用并查集找导致环的边 cycle；⑥if conflict [0]==-1：return cycle；⑦else：检查 conflict 中的某条边是否在环中，不在则删除该边，否则删除另一条。时间复杂度 O (n α(n))，空间复杂度 O (n)。';findRedundantDirectedConnection.hint = ' 有向图的冗余边可能导致「节点有两个父节点」或「环」，需先检测冲突边和环边，按规则优先删除冲突边 ';problems.push (findRedundantDirectedConnection);
    // 4073. 所有可能的路径
    const allPathsSourceTarget = new ProblemModel ();allPathsSourceTarget.id = 4073;allPathsSourceTarget.title = ' 所有可能的路径 ';allPathsSourceTarget.description = ' 给你一个有向无环图（DAG），图中有 n 个节点，编号从 0 到 n-1，请你找出所有从节点 0 到节点 n-1 的路径。';allPathsSourceTarget.difficulty = ProblemDifficulty.MEDIUM;allPathsSourceTarget.category = ProblemCategory.GRAPH;allPathsSourceTarget.choices = [{id: 'A', text: 'DFS 回溯：从 0 出发，递归遍历邻居，到达 n-1 时记录路径，回溯继续探索 ', isCorrect: true},{ id: 'B', text: 'BFS：记录每个节点的路径，到达终点时收集（空间开销大）', isCorrect: false },{ id: 'C', text: ' 动态规划，记录每个节点的所有路径（空间开销大）', isCorrect: false },{ id: 'D', text: ' 拓扑排序后反向构建路径（逻辑复杂）', isCorrect: false }];allPathsSourceTarget.explanation = 'DFS 回溯解法：①result=[]；path=[0]；n=graph.length；②function dfs (node)：③if node==n-1：result.push ([...path])；return；④for neighbor in graph [node]：path.push (neighbor)；dfs (neighbor)；path.pop ()；⑤dfs (0)；return result。时间复杂度 O (2^n)（最坏情况每个节点有两个邻居），空间复杂度 O (n)（递归栈 + 路径）。';allPathsSourceTarget.hint = 'DAG 无环，适合 DFS 回溯，通过「入栈 - 递归 - 出栈」维护当前路径，到达终点即收集完整路径 ';problems.push (allPathsSourceTarget);
    // 4074. 课程表 III
    const scheduleCourse = new ProblemModel ();scheduleCourse.id = 4074;scheduleCourse.title = ' 课程表 III';scheduleCourse.description = ' 这里有 n 门不同的在线课程，按从 1 到 n 编号。给你一个数组 courses ，其中 courses [i] = [duration_i, lastDay_i] 表示第 i 门课将会持续上 duration_i 天课，并且必须在不晚于 lastDay_i 的时候完成。你的学期从第 1 天开始。如果你同一天开始上多门课程，那么它们会重叠。返回你最多可以修读的课程数目。';scheduleCourse.difficulty = ProblemDifficulty.HARD;scheduleCourse.category = ProblemCategory.GRAPH;scheduleCourse.choices = [{ id: 'A', text: ' 贪心 + 最大堆：按 lastDay 排序，选课时累加时间，超时则替换堆中最长 duration 的课程 ', isCorrect: true },{ id: 'B', text: ' 动态规划，dp [i] 表示修 i 门课的最少时间（空间 O (n)）', isCorrect: false },{ id: 'C', text: 'DFS 枚举所有课程组合（时间 O (2^n)）', isCorrect: false },{ id: 'D', text: ' 拓扑排序，按 lastDay 顺序选课（无法处理超时替换）', isCorrect: false }];scheduleCourse.explanation = ' 贪心 + 堆解法：①courses 按 lastDay 升序排序；②maxHeap（存储 duration，用最大堆）；totalTime=0；③for [dur, last] in courses：④if totalTime + dur <= last：totalTime += dur；heap.push (dur)；⑤else if heap.size>0 && heap.peek ()>dur：totalTime += dur - heap.pop ()；heap.push (dur)；⑥return heap.size。时间复杂度 O (n log n)，空间复杂度 O (n)。';scheduleCourse.hint = ' 核心是「优先选结束早的课程，超时则替换耗时最长的课程」，用最大堆维护已选课程的耗时，确保总时间最小 ';problems.push (scheduleCourse);
    // 4075. 最大网络秩
    const maximalNetworkRank = new ProblemModel ();maximalNetworkRank.id = 4075;maximalNetworkRank.title = ' 最大网络秩 ';maximalNetworkRank.description = 'n 座城市和一些连接它们的道路 roads 共同组成一个基础设施网络。每个 roads [i] = [ai, bi] 表示在城市 ai 和 bi 之间有一条双向道路。两座不同城市构成的城市对的 网络秩 定义为：与这两座城市 直接 相连的道路总数。如果存在一条道路直接连接这两座城市，则这条道路只计算 一次 。给你这座城市的数量 n 和道路数组 roads，返回整个基础设施网络中最大的网络秩。';maximalNetworkRank.difficulty = ProblemDifficulty.MEDIUM;maximalNetworkRank.category = ProblemCategory.GRAPH;maximalNetworkRank.choices = [{ id: 'A', text: ' 统计度数 + 邻接矩阵：计算每个城市的度数，枚举所有城市对，秩 = 度数和 - 是否直接相连（1 或 0）', isCorrect: true },{ id: 'B', text: ' 暴力枚举所有城市对，遍历道路统计秩（时间 O (n²m)）', isCorrect: false },{ id: 'C', text: 'BFS 计算每个城市的连接数（重复计算，效率低）', isCorrect: false },{ id: 'D', text: ' 并查集，统计每个连通分量的道路数（无法计算城市对秩）', isCorrect: false }];maximalNetworkRank.explanation = ' 度数 + 邻接矩阵解法：①degree 数组（长度 n）初始化 0；adj 矩阵（n×n）初始化 false；②for [a,b] in roads：degree [a]++；degree [b]++；adj [a][b]=true；adj [b][a]=true；③maxRank=0；④for i from 0 to n-1：for j from i+1 to n-1：⑤current=degree [i]+degree [j] - (adj [i][j] ? 1 : 0)；maxRank=Math.max (maxRank, current)；⑥return maxRank。时间复杂度 O (n²)，空间复杂度 O (n²)。';maximalNetworkRank.hint = ' 网络秩的关键是「避免重复计算直接相连的道路」，通过度数数组快速获取连接数，邻接矩阵判断是否直接相连 ';problems.push (maximalNetworkRank);

    // 续4077. 三数之和
    threeSum.choices = [
      { id: 'A', text: '排序+双指针：排序数组，固定第一个数，双指针找另外两个数，跳过重复元素', isCorrect: true },
      { id: 'B', text: '哈希表去重，固定两个数找第三个数（时间O(n²)，去重复杂）', isCorrect: false },
      { id: 'C', text: '暴力三重循环，枚举所有三元组（时间O(n³)，超时）', isCorrect: false },
      { id: 'D', text: '二分查找，固定两个数找第三个数（时间O(n² log n)，去重困难）', isCorrect: false }
    ];
    threeSum.explanation = '排序+双指针解法：①nums排序；result=[]；n=nums.length；②for i from 0 to n-3：③if nums[i]>0：break（三数和不可能为0）；④if i>0且nums[i]==nums[i-1]：continue（去重）；⑤left=i+1；right=n-1；⑥while left<right：sum=nums[i]+nums[left]+nums[right]；⑦if sum==0：result.push([nums[i],nums[left],nums[right]])；⑧while left<right且nums[left]==nums[left+1]：left++（去重）；⑨while left<right且nums[right]==nums[right-1]：right--（去重）；⑩left++；right--；⑪else if sum<0：left++；⑫else：right--；⑬return result。时间复杂度O(n²)，空间复杂度O(log n)（排序开销）。';
    threeSum.hint = '排序是去重的基础，双指针将三重循环降为二重，关键是「固定一个数，用双指针找另外两个数」并跳过重复元素';
    problems.push(threeSum);

    // 4078. 四数之和
    const fourSum = new ProblemModel();
    fourSum.id = 4078;
    fourSum.title = '四数之和';
    fourSum.description = '给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回所有满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为是重复的四元组）：0 <= a, b, c, d < n；a、b、c、d 互不相同；nums[a] + nums[b] + nums[c] + nums[d] == target。';
    fourSum.difficulty = ProblemDifficulty.MEDIUM;
    fourSum.category = ProblemCategory.HASH_TABLE;
    fourSum.choices = [
      { id: 'A', text: '排序+双层循环+双指针：固定前两个数，双指针找后两个数，多层去重', isCorrect: true },
      { id: 'B', text: '哈希表存储两数和，再找互补对（去重复杂）', isCorrect: false },
      { id: 'C', text: '暴力四重循环（时间O(n⁴)，超时）', isCorrect: false },
      { id: 'D', text: '递归回溯（时间复杂度高，去重困难）', isCorrect: false }
    ];
    fourSum.explanation = '排序+双指针解法：①nums排序；result=[]；n=nums.length；②for i from 0 to n-4：③if i>0且nums[i]==nums[i-1]：continue；④for j from i+1 to n-3：⑤if j>i+1且nums[j]==nums[j-1]：continue；⑥left=j+1；right=n-1；⑦while left<right：sum=nums[i]+nums[j]+nums[left]+nums[right]；⑧if sum==target：result.push([nums[i],nums[j],nums[left],nums[right]])；⑨while left<right且nums[left]==nums[left+1]：left++；⑩while left<right且nums[right]==nums[right-1]：right--；⑪left++；right--；⑫else if sum<target：left++；⑬else：right--；⑭return result。时间复杂度O(n³)，空间复杂度O(log n)。';
    fourSum.hint = '在三数之和基础上增加一层循环，注意「多层去重」和边界条件（如数组长度不足4）';
    problems.push(fourSum);

    // 4079. 存在重复元素
    const containsDuplicate = new ProblemModel();
    containsDuplicate.id = 4079;
    containsDuplicate.title = '存在重复元素';
    containsDuplicate.description = '给你一个整数数组 nums 。如果任一值在数组中出现 至少两次 ，返回 true ；如果数组中每个元素都不相同，返回 false 。';
    containsDuplicate.difficulty = ProblemDifficulty.EASY;
    containsDuplicate.category = ProblemCategory.HASH_TABLE;
    containsDuplicate.choices = [
      { id: 'A', text: '哈希表/集合：遍历数组，存在则返回true，否则加入集合，最后返回false', isCorrect: true },
      { id: 'B', text: '排序：排序后检查相邻元素是否相等（时间O(n log n)）', isCorrect: false },
      { id: 'C', text: '暴力双重循环，检查每个元素是否重复（时间O(n²)）', isCorrect: false },
      { id: 'D', text: '位运算，标记出现的数字（不适合大范围整数）', isCorrect: false }
    ];
    containsDuplicate.explanation = '哈希表解法：①set=new Set()；②for num in nums：③if set.has(num)：return true；④set.add(num)；⑤return false。时间复杂度O(n)，空间复杂度O(n)。';
    containsDuplicate.hint = '利用哈希表的O(1)查找特性，一次遍历即可判断是否有重复元素';
    problems.push(containsDuplicate);

    // 4080. 有效的字母异位词
    const isAnagram = new ProblemModel();
    isAnagram.id = 4080;
    isAnagram.title = '有效的字母异位词';
    isAnagram.description = '给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。';
    isAnagram.difficulty = ProblemDifficulty.EASY;
    isAnagram.category = ProblemCategory.HASH_TABLE;
    isAnagram.choices = [
      { id: 'A', text: '哈希表计数：统计s和t中每个字符的出现次数，比较是否完全相同', isCorrect: true },
      { id: 'B', text: '排序：将两字符串排序后比较是否相等（时间O(n log n)）', isCorrect: false },
      { id: 'C', text: '暴力枚举，逐个删除字符（时间O(n²)）', isCorrect: false },
      { id: 'D', text: 'ASCII码累加，比较总和（无法区分不同字符组合，错误）', isCorrect: false }
    ];
    isAnagram.explanation = '哈希表解法：①if s.length != t.length：return false；②count数组（长度26）初始化0；③for i from 0 to s.length-1：count[s.charCodeAt(i)-97]++；count[t.charCodeAt(i)-97]--；④for num in count：if num!=0：return false；⑤return true。时间复杂度O(n)，空间复杂度O(1)（固定大小数组）。';
    isAnagram.hint = '核心是「字符出现次数完全一致」，用固定大小的数组（针对小写字母）比哈希表更高效';
    problems.push(isAnagram);

    // 4081. 字母异位词分组
    const groupAnagrams = new ProblemModel();
    groupAnagrams.id = 4081;
    groupAnagrams.title = '字母异位词分组';
    groupAnagrams.description = '给你一个字符串数组，请你将 字母异位词 组合在一起。可以按任意顺序返回结果列表。字母异位词 是由重新排列源单词的字母得到的一个新单词，所有源单词中的字母通常恰好只用一次。';
    groupAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    groupAnagrams.category = ProblemCategory.HASH_TABLE;
    groupAnagrams.choices = [
      { id: 'A', text: '哈希表+排序：将每个字符串排序作为键，字母异位词排序后相同，归为同一组', isCorrect: true },
      { id: 'B', text: '哈希表+计数：用字符计数数组作为键（如"a2b1c0..."），分组异位词', isCorrect: false },
      { id: 'C', text: '暴力比较，两两判断是否为异位词（时间O(n²k)，k为字符串长度）', isCorrect: false },
      { id: 'D', text: '按字符串长度分组后再比较（无法区分同长度非异位词）', isCorrect: false }
    ];
    groupAnagrams.explanation = '排序键解法：①map=new Map()；②for str in strs：③sortedStr=str.split(\'\').sort().join(\'\')；④if map.has(sortedStr)：map.get(sortedStr).push(str)；⑤else：map.set(sortedStr, [str])；⑥return Array.from(map.values())。时间复杂度O(nk log k)（n为字符串数，k为最长字符串长度），空间复杂度O(nk)。';
    groupAnagrams.hint = '字母异位词的核心特征是「排序后字符串相同」，用排序结果作为哈希表的键，高效分组';
    problems.push(groupAnagrams);

    // 4082. 最长连续序列
    const longestConsecutive = new ProblemModel();
    longestConsecutive.id = 4082;
    longestConsecutive.title = '最长连续序列';
    longestConsecutive.description = '给定一个未排序的整数数组 nums ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。请你设计并实现时间复杂度为 O(n) 的算法解决此问题。';
    longestConsecutive.difficulty = ProblemDifficulty.HARD;
    longestConsecutive.category = ProblemCategory.HASH_TABLE;
    longestConsecutive.choices = [
      { id: 'A', text: '哈希表去重+遍历起点：用集合存储元素，对每个可能的起点（无前驱的元素），计算连续长度', isCorrect: true },
      { id: 'B', text: '排序后遍历，统计连续序列（时间O(n log n)，不满足要求）', isCorrect: false },
      { id: 'C', text: '暴力枚举每个元素的连续序列（时间O(n²)）', isCorrect: false },
      { id: 'D', text: '并查集，合并相邻元素后统计最大集合（实现复杂）', isCorrect: false }
    ];
    longestConsecutive.explanation = '哈希表解法：①numSet=new Set(nums)；maxLen=0；②for num in numSet：③if !numSet.has(num-1)：// 找到序列起点④currentNum=num；currentLen=1；⑤while numSet.has(currentNum+1)：currentNum++；currentLen++；⑥maxLen=Math.max(maxLen, currentLen)；⑦return maxLen。时间复杂度O(n)（每个元素最多访问两次），空间复杂度O(n)。';
    longestConsecutive.hint = '关键是「只对序列起点计算连续长度」，避免重复计算，用集合实现O(1)的存在性判断';
    problems.push(longestConsecutive);

    // 4083. 同构字符串
    const isIsomorphic = new ProblemModel();
    isIsomorphic.id = 4083;
    isIsomorphic.title = '同构字符串';
    isIsomorphic.description = '给定两个字符串 s 和 t，判断它们是否是同构的。如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。';
    isIsomorphic.difficulty = ProblemDifficulty.EASY;
    isIsomorphic.category = ProblemCategory.HASH_TABLE;
    isIsomorphic.choices = [
      { id: 'A', text: '双哈希表：记录s到t和t到s的映射，确保双向唯一映射', isCorrect: true },
      { id: 'B', text: '单哈希表，只记录s到t的映射（无法检测t到s的冲突）', isCorrect: false },
      { id: 'C', text: '替换为字符首次出现位置，比较转换后的序列（逻辑等价双哈希）', isCorrect: false },
      { id: 'D', text: '比较字符出现次数（无法区分映射关系，错误）', isCorrect: false }
    ];
    isIsomorphic.explanation = '双哈希解法：①if s.length != t.length：return false；②mapS=new Map()；mapT=new Map()；③for i from 0 to s.length-1：④c1=s[i]；c2=t[i]；⑤if (mapS.has(c1) && mapS.get(c1)!=c2) || (mapT.has(c2) && mapT.get(c2)!=c1)：return false；⑥mapS.set(c1, c2)；mapT.set(c2, c1)；⑦return true。时间复杂度O(n)，空间复杂度O(n)。';
    isIsomorphic.hint = '同构要求「双向唯一映射」，需同时验证s→t和t→s的映射关系，避免多对一或一对多';
    problems.push(isIsomorphic);

    // 4084. 两个数组的交集
    const intersection = new ProblemModel();
    intersection.id = 4084;
    intersection.title = '两个数组的交集';
    intersection.description = '给定两个数组 nums1 和 nums2 ，返回它们的交集。输出结果中的每个元素一定是 唯一 的。我们可以 不考虑输出结果的顺序 。';
    intersection.difficulty = ProblemDifficulty.EASY;
    intersection.category = ProblemCategory.HASH_TABLE;
    intersection.choices = [
      { id: 'A', text: '哈希表/集合：将nums1转为集合，遍历nums2检查是否存在，收集结果去重', isCorrect: true },
      { id: 'B', text: '排序+双指针：排序后双指针遍历，收集相同元素并去重', isCorrect: false },
      { id: 'C', text: '暴力双重循环，检查元素是否存在（时间O(nm)）', isCorrect: false },
      { id: 'D', text: '二分查找，对nums2中的元素在nums1中查找（时间O(n log n)）', isCorrect: false }
    ];
    intersection.explanation = '集合解法：①set1=new Set(nums1)；resultSet=new Set()；②for num in nums2：③if set1.has(num)：resultSet.add(num)；④return Array.from(resultSet)。时间复杂度O(n+m)，空间复杂度O(n)。';
    intersection.hint = '利用集合的去重和O(1)查找特性，高效获取两个数组的交集元素';
    problems.push(intersection);

    // 4085. 两个数组的交集II
    const intersectII = new ProblemModel();
    intersectII.id = 4085;
    intersectII.title = '两个数组的交集II';
    intersectII.description = '给你两个整数数组 nums1 和 nums2 ，请你以数组形式返回两数组的交集。返回结果中每个元素出现的次数，应与元素在两个数组中都出现的次数一致（如果出现次数不一致，则取较小值）。可以不考虑输出结果的顺序。';
    intersectII.difficulty = ProblemDifficulty.EASY;
    intersectII.category = ProblemCategory.HASH_TABLE;
    intersectII.choices = [
      { id: 'A', text: '哈希表计数：统计nums1中元素频率，遍历nums2匹配并减少计数，收集结果', isCorrect: true },
      { id: 'B', text: '排序+双指针：排序后双指针遍历，相同则收集，指针同移，否则移动较小值指针', isCorrect: false },
      { id: 'C', text: '暴力查找并删除，每次找到后从nums1中移除元素（时间O(nm)）', isCorrect: false },
      { id: 'D', text: '集合求交后扩展次数（无法处理次数差异，错误）', isCorrect: false }
    ];
    intersectII.explanation = '哈希表解法：①if nums1.length > nums2.length：交换nums1和nums2（优化空间）；②countMap=new Map()；③for num in nums1：countMap.set(num, (countMap.get(num)||0)+1)；④result=[]；⑤for num in nums2：⑥if countMap.has(num) && countMap.get(num)>0：⑦result.push(num)；countMap.set(num, countMap.get(num)-1)；⑧return result。时间复杂度O(n+m)，空间复杂度O(min(n,m))。';
    intersectII.hint = '与交集I的区别是「保留出现次数的最小值」，用哈希表记录次数，匹配时递减计数';
    problems.push(intersectII);

    // 4086. 快乐数
    const isHappy = new ProblemModel();
    isHappy.id = 4086;
    isHappy.title = '快乐数';
    isHappy.description = '编写一个算法来判断一个数 n 是不是快乐数。「快乐数」定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。如果 可以变为 1，那么这个数就是快乐数。';
    isHappy.difficulty = ProblemDifficulty.EASY;
    isHappy.category = ProblemCategory.HASH_TABLE;
    isHappy.choices = [
      { id: 'A', text: '哈希表检测循环：记录出现过的数，若重复则非快乐数，直到1或循环', isCorrect: true },
      { id: 'B', text: '快慢指针：快指针每次走两步，慢指针走一步，相遇则循环，等于1则快乐', isCorrect: false },
      { id: 'C', text: '数学规律：非快乐数最终会进入4→16→...→4的循环，检查是否出现4', isCorrect: false },
      { id: 'D', text: '递归计算，无循环检测（可能无限递归，错误）', isCorrect: false }
    ];
    isHappy.explanation = '哈希表解法：①function getNext(n)：sum=0；while n>0：digit=n%10；sum+=digit*digit；n=Math.floor(n/10)；return sum；②seen=new Set()；③while n!=1 && !seen.has(n)：④seen.add(n)；n=getNext(n)；⑤return n==1。时间复杂度O(log n)（每次计算位数减少），空间复杂度O(log n)。';
    isHappy.hint = '核心是「检测是否进入循环」，哈希表可记录所有出现过的数，避免无限计算';
    problems.push(isHappy);


    // 4089. 跳跃游戏II
    const jump = new ProblemModel();
    jump.id = 4089;
    jump.title = '跳跃游戏II';
    jump.description = '给你一个非负整数数组 nums ，你最初位于数组的第一个位置。数组中的每个元素代表你在该位置可以跳跃的最大长度。你的目标是使用最少的跳跃次数到达数组的最后一个位置。假设你总是可以到达数组的最后一个位置。';
    jump.difficulty = ProblemDifficulty.HARD;
    jump.category = ProblemCategory.GREEDY;
    jump.choices = [
      { id: 'A', text: '贪心分层跳跃：记录当前层终点、下一层终点，到达当前终点时步数+1并更新当前终点', isCorrect: true },
      { id: 'B', text: '动态规划，dp[i]表示到i的最少步数（时间O(n²)）', isCorrect: false },
      { id: 'C', text: 'BFS，层序遍历记录步数（空间O(n)）', isCorrect: false },
      { id: 'D', text: '每次跳最大步（无法保证最少步数，错误）', isCorrect: false }
    ];
    jump.explanation = '分层贪心解法：①n=nums.length；if n<=1 return 0；②steps=0；currentEnd=0；farthest=0；③for i from 0 to n-2：④farthest=Math.max(farthest, i + nums[i])；⑤if i==currentEnd：// 到达当前层终点⑥steps++；currentEnd=farthest；⑦if currentEnd >=n-1：break；⑧return steps。时间复杂度O(n)，空间复杂度O(1)。';
    jump.hint = '关键是「按跳跃范围分层」，每次到达当前层的终点时，步数加1并更新下一层的终点，确保最少步数';
    problems.push(jump);

    // 4090. 买卖股票的最佳时机
    const maxProfitStock = new ProblemModel();
    maxProfitStock.id = 4090;
    maxProfitStock.title = '买卖股票的最佳时机';
    maxProfitStock.description = '给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。';
    maxProfitStock.difficulty = ProblemDifficulty.EASY;
    maxProfitStock.category = ProblemCategory.GREEDY;
    maxProfitStock.choices = [
      { id: 'A', text: '贪心跟踪最低价格：遍历数组，记录最低买入价，计算当前卖出利润，更新最大值', isCorrect: true },
      { id: 'B', text: '暴力双重循环，计算所有可能的利润（时间O(n²)）', isCorrect: false },
      { id: 'C', text: '动态规划，记录每天的最大利润（空间O(n)，不如贪心）', isCorrect: false },
      { id: 'D', text: '寻找最大差值，不考虑先后顺序（可能买在卖之后，错误）', isCorrect: false }
    ];
    maxProfitStock.explanation = '贪心解法：①if prices.length<2 return 0；②minPrice=prices[0]；maxProfit=0；③for i from 1 to prices.length-1：④if prices[i]<minPrice：minPrice=prices[i]；⑤else：maxProfit=Math.max(maxProfit, prices[i]-minPrice)；⑥return maxProfit。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfitStock.hint = '核心是「低买高卖」，遍历中始终保留最低买入价，当前价格减去最低价即为可能的最大利润';
    problems.push(maxProfitStock);

    // 4091. 买卖股票的最佳时机II
    const maxProfitStockII = new ProblemModel();
    maxProfitStockII.id = 4091;
    maxProfitStockII.title = '买卖股票的最佳时机II';
    maxProfitStockII.description = '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候 最多 只能持有 一股 股票。你也可以先购买，然后在 同一天 出售。返回 你能获得的 最大 利润 。';
    maxProfitStockII.difficulty = ProblemDifficulty.EASY;
    maxProfitStockII.category = ProblemCategory.GREEDY;
    maxProfitStockII.choices = [
      { id: 'A', text: '贪心累加正收益：只要当天价格高于前一天，就累加差值（等价于所有上涨段收益和）', isCorrect: true },
      { id: 'B', text: '动态规划，记录持有/不持有股票的最大利润（空间O(n)）', isCorrect: false },
      { id: 'C', text: '暴力枚举所有交易组合（时间O(2^n)）', isCorrect: false },
      { id: 'D', text: '寻找所有波峰波谷，低买高卖（逻辑等价贪心，实现稍复杂）', isCorrect: false }
    ];
    maxProfitStockII.explanation = '贪心解法：①profit=0；②for i from 1 to prices.length-1：③if prices[i]>prices[i-1]：profit += prices[i]-prices[i-1]；④return profit。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfitStockII.hint = '多次交易的最大利润等于「所有上涨区间的收益总和」，贪心策略是只赚每天的正差价';
    problems.push(maxProfitStockII);

    // 4092. 用最少数量的箭引爆气球
    const findMinArrowShots = new ProblemModel();
    findMinArrowShots.id = 4092;
    findMinArrowShots.title = '用最少数量的箭引爆气球';
    findMinArrowShots.description = '有一些球形气球贴在一堵用 XY 平面表示的墙面上。墙面上的气球记录在整数数组 points ，其中points[i] = [xstart, xend] 表示水平直径在 xstart 和 xend 之间的气球。你不知道气球的确切 y 坐标。一支弓箭可以沿着 x 轴从不同点 完全垂直 地射出。在坐标 x 处射出一支箭，若有一个气球的直径的开始和结束坐标为 xstart，xend， 且满足  xstart ≤ x ≤ xend，则该气球会被引爆。可以射出的弓箭的数量没有限制。 弓箭一旦被射出之后，可以无限地前进。我们想找到使得所有气球全部被引爆，所需的弓箭的 最小数量 。';
    findMinArrowShots.difficulty = ProblemDifficulty.MEDIUM;
    findMinArrowShots.category = ProblemCategory.GREEDY;
    findMinArrowShots.choices = [
      { id: 'A', text: '排序+贪心：按气球右边界排序，箭射在当前右边界，跳过所有被引爆的气球', isCorrect: true },
      { id: 'B', text: '按左边界排序，类似区间合并（可能需要更多箭）', isCorrect: false },
      { id: 'C', text: '暴力枚举，每次选最早结束的气球射箭（逻辑等价A，实现不同）', isCorrect: false },
      { id: 'D', text: '动态规划，记录射前i个气球的最少箭数（时间O(n²)）', isCorrect: false }
    ];
    findMinArrowShots.explanation = '右边界排序解法：①if points.length==0 return 0；②points.sort((a,b)=>a[1]-b[1])；③arrows=1；end=points[0][1]；④for i from 1 to points.length-1：⑤if points[i][0]>end：// 当前气球不被之前的箭引爆⑥arrows++；end=points[i][1]；⑦return arrows。时间复杂度O(n log n)，空间复杂度O(log n)。';
    findMinArrowShots.hint = '贪心策略：「每次射在当前气球的右边界」，这样能最大限度覆盖后续气球，减少箭的数量';
    problems.push(findMinArrowShots);

    // 4093. 无重叠区间
    const eraseOverlapIntervals = new ProblemModel();
    eraseOverlapIntervals.id = 4093;
    eraseOverlapIntervals.title = '无重叠区间';
    eraseOverlapIntervals.description = '给定一个区间的集合 intervals ，其中 intervals[i] = [starti, endi] 。返回 需要移除区间的最小数量，使剩余区间互不重叠 。';
    eraseOverlapIntervals.difficulty = ProblemDifficulty.MEDIUM;
    eraseOverlapIntervals.category = ProblemCategory.GREEDY;
    eraseOverlapIntervals.choices = [
      { id: 'A', text: '排序+贪心：按右边界排序，保留最早结束的区间，统计需移除的重叠区间', isCorrect: true },
      { id: 'B', text: '按左边界排序，类似处理（可能保留更多区间）', isCorrect: false },
      { id: 'C', text: '动态规划，dp[i]表示前i个区间的最大保留数（时间O(n²)）', isCorrect: false },
      { id: 'D', text: '暴力枚举所有可能的保留组合（时间O(2^n)）', isCorrect: false }
    ];
    eraseOverlapIntervals.explanation = '右边界排序解法：①if intervals.length==0 return 0；②intervals.sort((a,b)=>a[1]-b[1])；③count=0；end=intervals[0][1]；④for i from 1 to intervals.length-1：⑤if intervals[i][0]<end：// 重叠，需移除⑥count++；⑦else：// 不重叠，更新end⑧end=intervals[i][1]；⑨return count。时间复杂度O(n log n)，空间复杂度O(log n)。';
    eraseOverlapIntervals.hint = '等价于「保留最多的不重叠区间」，贪心选择最早结束的区间，为后续留出更多空间';
    problems.push(eraseOverlapIntervals);

    // 4094. 划分字母区间
    const partitionLabels = new ProblemModel();
    partitionLabels.id = 4094;
    partitionLabels.title = '划分字母区间';
    partitionLabels.description = '字符串 S 由小写字母组成。我们要把这个字符串划分为尽可能多的片段，同一字母最多出现在一个片段中。返回一个表示每个字符串片段的长度的列表。';
    partitionLabels.difficulty = ProblemDifficulty.MEDIUM;
    partitionLabels.category = ProblemCategory.GREEDY;
    partitionLabels.choices = [
      { id: 'A', text: '贪心+最后位置：记录每个字母最后出现的位置，扩展当前区间到最大所需位置', isCorrect: true },
      { id: 'B', text: '暴力划分，每次找最小的符合条件的区间（时间O(n²)）', isCorrect: false },
      { id: 'C', text: '动态规划，记录每个位置的最大划分（逻辑复杂）', isCorrect: false },
      { id: 'D', text: '哈希表统计每个字母的所有位置，再合并区间（实现复杂）', isCorrect: false }
    ];
    partitionLabels.explanation = '最后位置解法：①last=new Array(26).fill(0)；②for i from 0 to S.length-1：last[S.charCodeAt(i)-97] = i；③result=[]；start=0；end=0；④for i from 0 to S.length-1：⑤end=Math.max(end, last[S.charCodeAt(i)-97])；⑥if i==end：// 到达当前区间终点⑦result.push(end - start + 1)；start=end+1；⑧return result。时间复杂度O(n)，空间复杂度O(1)。';
    partitionLabels.hint = '核心是「当前区间必须包含所有已出现字母的最后位置」，当遍历到该位置时，即可划分区间';
    problems.push(partitionLabels);

    // 4095. 合并区间
    const mergeIntervals = new ProblemModel();
    mergeIntervals.id = 4095;
    mergeIntervals.title = '合并区间';
    mergeIntervals.description = '以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。';
    mergeIntervals.difficulty = ProblemDifficulty.MEDIUM;
    mergeIntervals.category = ProblemCategory.GREEDY;
    mergeIntervals.choices = [
      { id: 'A', text: '排序+贪心：按区间起点排序，遍历合并重叠区间（当前区间终点取最大值）', isCorrect: true },
      { id: 'B', text: '按区间终点排序，类似合并（实现稍复杂）', isCorrect: false },
      { id: 'C', text: '暴力合并，两两检查是否重叠（时间O(n²)）', isCorrect: false },
      { id: 'D', text: '哈希表存储区间，再合并（无法处理交叉重叠）', isCorrect: false }
    ];
    mergeIntervals.explanation = '排序合并解法：①if intervals.length==0 return []；②intervals.sort((a,b)=>a[0]-b[0])；③merged=[intervals[0]]；④for i from 1 to intervals.length-1：⑤last=merged[merged.length-1]；current=intervals[i]；⑥if current[0]<=last[1]：// 重叠，合并⑦last[1]=Math.max(last[1], current[1])；⑧else：// 不重叠，加入新区间⑨merged.push(current)；⑩return merged。时间复杂度O(n log n)，空间复杂度O(log n)。';
    mergeIntervals.hint = '排序后区间重叠具有连续性，只需遍历一次，通过比较当前区间起点与上一区间终点判断是否合并';
    problems.push(mergeIntervals);

    // 4096. 加油站
    const canCompleteCircuit = new ProblemModel();
    canCompleteCircuit.id = 4096;
    canCompleteCircuit.title = '加油站';
    canCompleteCircuit.description = '在一条环路上有 n 个加油站，其中第 i 个加油站有汽油 gas[i] 升。你有一辆油箱容量无限的的汽车，从第 i 个加油站开往第 i+1 个加油站需要消耗汽油 cost[i] 升。你从其中的一个加油站出发，开始时油箱为空。给定两个整数数组 gas 和 cost ，如果你可以绕环路行驶一周，则返回出发时加油站的编号，否则返回 -1 。如果存在解，则 保证 它是 唯一 的。';
    canCompleteCircuit.difficulty = ProblemDifficulty.MEDIUM;
    canCompleteCircuit.category = ProblemCategory.GREEDY;
    canCompleteCircuit.choices = [
      { id: 'A', text: '贪心累计剩余：计算每个站的剩余油量，累计总剩余，若为负则无解；否则找第一个能累计到终点的起点', isCorrect: true },
      { id: 'B', text: '暴力枚举每个起点，模拟行驶（时间O(n²)）', isCorrect: false },
      { id: 'C', text: '动态规划，记录每个站的最大剩余油量（逻辑复杂）', isCorrect: false },
      { id: 'D', text: '找剩余油量最大的站作为起点（无法保证能绕圈）', isCorrect: false }
    ];
    canCompleteCircuit.explanation = '贪心解法：①totalGas=0；totalCost=0；currentTank=0；start=0；②for i from 0 to gas.length-1：③totalGas += gas[i]；totalCost += cost[i]；currentTank += gas[i] - cost[i]；④if currentTank <0：// 从start到i无法到达，重置起点⑤start=i+1；currentTank=0；⑥return totalGas >= totalCost ? start : -1。时间复杂度O(n)，空间复杂度O(1)。';
    canCompleteCircuit.hint = '关键是「总油量>=总消耗则一定有解」，且解为第一个能连续累计到终点的起点，之前的起点都无法到达该起点';
    problems.push(canCompleteCircuit);


    // 八、链表类（10题）
    // 4097. 反转链表
    const reverseList = new ProblemModel();
    reverseList.id = 4097;
    reverseList.title = '反转链表';
    reverseList.description = '给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。';
    reverseList.difficulty = ProblemDifficulty.EASY;
    reverseList.category = ProblemCategory.LINKED_LIST;
    reverseList.choices = [
      { id: 'A', text: '迭代法：用prev、current、next三个指针，逐个反转节点指向', isCorrect: true },
      { id: 'B', text: '递归法：递归反转后续节点，再调整当前节点指向（空间O(n)）', isCorrect: false },
      { id: 'C', text: '栈：压入所有节点再弹出构建反转链表（空间O(n)）', isCorrect: false },
      { id: 'D', text: '复制值到数组，反转后写回（破坏原链表结构，错误）', isCorrect: false }
    ];
    reverseList.explanation = '迭代解法：①prev=null；current=head；②while current!=null：③next=current.next；// 保存下一个节点④current.next=prev；// 反转指针⑤prev=current；// 移动prev⑥current=next；// 移动current⑦return prev。时间复杂度O(n)，空间复杂度O(1)。';
    reverseList.hint = '迭代法通过三个指针原地反转，只需一次遍历，空间复杂度最优';
    problems.push(reverseList);

    // 4099. 链表的中间结点
    const middleNode = new ProblemModel();
    middleNode.id = 4099;
    middleNode.title = '链表的中间结点';
    middleNode.description = '给定一个头结点为 head 的非空单链表，返回链表的中间结点。如果有两个中间结点，则返回第二个中间结点。';
    middleNode.difficulty = ProblemDifficulty.EASY;
    middleNode.category = ProblemCategory.LINKED_LIST;
    middleNode.choices = [
      { id: 'A', text: '快慢指针：快指针每次走两步，慢指针走一步，快指针到尾时慢指针在中间', isCorrect: true },
      { id: 'B', text: '计算长度后遍历到中间（两次遍历，时间O(n)）', isCorrect: false },
      { id: 'C', text: '转为数组，取中间索引（空间O(n)）', isCorrect: false },
      { id: 'D', text: '递归记录深度，返回中间层节点（空间O(n)）', isCorrect: false }
    ];
    middleNode.explanation = '快慢指针解法：①slow=head；fast=head；②while fast!=null && fast.next!=null：③slow=slow.next；④fast=fast.next.next；⑤return slow。时间复杂度O(n)，空间复杂度O(1)。';
    middleNode.hint = '快慢指针一次遍历即可找到中间节点，快指针速度是慢指针的两倍，天然满足中间位置条件';
    problems.push(middleNode);

    // 4103. 删除链表的倒数第 N 个结点
    const removeNthFromEnd = new ProblemModel();
    removeNthFromEnd.id = 4103;
    removeNthFromEnd.title = '删除链表的倒数第 N 个结点';
    removeNthFromEnd.description = '给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。';
    removeNthFromEnd.difficulty = ProblemDifficulty.MEDIUM;
    removeNthFromEnd.category = ProblemCategory.LINKED_LIST;
    removeNthFromEnd.choices = [
      { id: 'A', text: '双指针：快指针先走n步，然后快慢指针同速前进，快指针到尾时慢指针在待删节点前', isCorrect: true },
      { id: 'B', text: '计算长度后遍历到倒数第n+1个节点（两次遍历）', isCorrect: false },
      { id: 'C', text: '栈：压入所有节点，弹出n个后栈顶为待删节点的前驱（空间O(n)）', isCorrect: false },
      { id: 'D', text: '递归回溯，计数删除（空间O(n)）', isCorrect: false }
    ];
    removeNthFromEnd.explanation = '双指针解法：①dummy=new ListNode(0, head)；②fast=dummy；slow=dummy；③// 快指针先走n步④for i from 0 to n-1：fast=fast.next；⑤// 快慢指针同速前进⑥while fast.next!=null：fast=fast.next；slow=slow.next；⑦// 删除节点⑧slow.next=slow.next.next；⑨return dummy.next。时间复杂度O(n)，空间复杂度O(1)。';
    removeNthFromEnd.hint = '哑节点处理头节点删除的特殊情况，双指针一次遍历定位到待删节点的前驱，高效删除';
    problems.push(removeNthFromEnd);

    // 4104. 两两交换链表中的节点
    const swapPairs = new ProblemModel();
    swapPairs.id = 4104;
    swapPairs.title = '两两交换链表中的节点';
    swapPairs.description = '给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。';
    swapPairs.difficulty = ProblemDifficulty.MEDIUM;
    swapPairs.category = ProblemCategory.LINKED_LIST;
    swapPairs.choices = [
      { id: 'A', text: '迭代法：用prev、first、second指针，每次交换一对节点，更新指针', isCorrect: true },
      { id: 'B', text: '递归法：交换前两个节点，递归处理剩余链表（空间O(n)）', isCorrect: false },
      { id: 'C', text: '转为数组，交换元素后重建链表（空间O(n)）', isCorrect: false },
      { id: 'D', text: '修改节点值（不符合题意）', isCorrect: false }
    ];
    swapPairs.explanation = '迭代解法：①dummy=new ListNode(0, head)；prev=dummy；②while prev.next!=null && prev.next.next!=null：③first=prev.next；④second=prev.next.next；⑤// 交换⑥first.next=second.next；⑦second.next=first；⑧prev.next=second；⑨// 移动prev到下一对前⑩prev=first；⑪return dummy.next。时间复杂度O(n)，空间复杂度O(1)。';
    swapPairs.hint = '关键是「保存前驱节点」，每次交换一对节点后，前驱指针更新为交换后的第二个节点（原第一个节点）';
    problems.push(swapPairs);

    // 4105. K 个一组翻转链表
    const reverseKGroup = new ProblemModel();
    reverseKGroup.id = 4105;
    reverseKGroup.title = 'K 个一组翻转链表';
    reverseKGroup.description = '给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。';
    reverseKGroup.difficulty = ProblemDifficulty.HARD;
    reverseKGroup.category = ProblemCategory.LINKED_LIST;
    reverseKGroup.choices = [
      { id: 'A', text: '迭代+反转子链表：分组检查长度，足够则反转，连接前后部分，循环处理', isCorrect: true },
      { id: 'B', text: '递归：反转前k个，递归处理剩余（空间O(n/k)）', isCorrect: false },
      { id: 'C', text: '转为数组，分组反转后重建（空间O(n)）', isCorrect: false },
      { id: 'D', text: '暴力翻转，逐个移动节点（实现复杂）', isCorrect: false }
    ];
    reverseKGroup.explanation = '迭代解法：①dummy=new ListNode(0, head)；prev=dummy；②while true：③// 检查剩余节点是否够k个④end=prev；⑤for i from 0 to k-1：end=end.next；if end==null：break；⑥// 记录下一组起点⑦nextGroup=end.next；⑧// 反转当前k个节点⑨start=prev.next；end.next=null；// 断开⑩prev.next=reverseList(start)；// 反转后start变尾，end变头⑪// 连接下一组⑫start.next=nextGroup；⑬// 移动prev到下一组前⑭prev=start；⑮return dummy.next。时间复杂度O(n)，空间复杂度O(1)。';
    reverseKGroup.hint = '在两两交换基础上扩展，先检查每组长度，反转后正确连接前后部分，prev始终指向每组的前驱';
    problems.push(reverseKGroup);

    // 4106. 随机链表的复制
    const copyRandomList = new ProblemModel();
    copyRandomList.id = 4106;
    copyRandomList.title = '随机链表的复制';
    copyRandomList.description = '给你一个长度为 n 的链表，每个节点包含一个额外增加的随机指针 random ，该指针可以指向链表中的任何节点或空节点。构造这个链表的 深拷贝 。 深拷贝应该正好由 n 个 全新 节点组成，其中每个新节点的值都设为其对应的原节点的值。新节点的 next 指针和 random 指针也都应指向复制链表中的新节点，并使原链表和复制链表中的这些指针能够表示相同的链表状态。复制链表中的指针都不应指向原链表中的节点 。例如，如果原链表中有 X 和 Y 两个节点，其中 X.random --> Y ，那么在复制链表中对应的两个节点 x 和 y ，同样有 x.random --> y 。返回复制链表的头节点。';
    copyRandomList.difficulty = ProblemDifficulty.MEDIUM;
    copyRandomList.category = ProblemCategory.LINKED_LIST;
    copyRandomList.choices = [
      { id: 'A', text: '哈希表+两次遍历：第一次复制节点并存储映射，第二次设置next和random指针', isCorrect: true },
      { id: 'B', text: '原地插入+拆分：复制节点插入原节点后，设置random，再拆分链表（空间O(1)）', isCorrect: false },
      { id: 'C', text: '递归+哈希表，记录已复制节点（空间O(n)）', isCorrect: false },
      { id: 'D', text: '只复制next指针，再复制random（无法处理random指向未复制节点）', isCorrect: false }
    ];
    copyRandomList.explanation = '哈希表解法：①if head==null return null；②map=new Map()；③// 第一次遍历：复制节点并存储映射④current=head；⑤while current!=null：⑥map.set(current, new ListNode(current.val))；⑦current=current.next；⑧// 第二次遍历：设置next和random⑨current=head；⑩while current!=null：⑪map.get(current).next = map.get(current.next) || null；⑫map.get(current).random = map.get(current.random) || null；⑬current=current.next；⑭return map.get(head)。时间复杂度O(n)，空间复杂度O(n)。';
    copyRandomList.hint = '核心是「建立原节点到复制节点的映射」，确保random指针能正确指向复制链表中的对应节点';
    problems.push(copyRandomList);

    // 九、树类（10题）
    // 4107. 二叉树的前序遍历
    const preorderTraversal = new ProblemModel();
    preorderTraversal.id = 4107;
    preorderTraversal.title = '二叉树的前序遍历';
    preorderTraversal.description = '给你二叉树的根节点 root ，返回它节点值的 前序 遍历。前序遍历是指按照根-左-右的顺序遍历二叉树。';
    preorderTraversal.difficulty = ProblemDifficulty.EASY;
    preorderTraversal.category = ProblemCategory.BINARY_TREE;
    preorderTraversal.choices = [
      { id: 'A', text: '迭代法：用栈存储节点，先压右子树再压左子树，弹出时访问节点', isCorrect: true },
      { id: 'B', text: '递归法：递归访问根节点，再递归左子树，最后递归右子树（空间O(n)）', isCorrect: false },
      { id: 'C', text: ' Morris遍历：线索化二叉树，实现常数空间遍历（逻辑复杂）', isCorrect: false },
      { id: 'D', text: '层序遍历改编（不符合前序遍历顺序，错误）', isCorrect: false }
    ];
    preorderTraversal.explanation = '迭代解法：①if root==null return []；②result=[]；stack=[root]；③while stack.length>0：④node=stack.pop()；⑤result.push(node.val)；⑥// 先压右子树，后压左子树（栈先进后出）⑦if node.right!=null：stack.push(node.right)；⑧if node.left!=null：stack.push(node.left)；⑨return result。时间复杂度O(n)，空间复杂度O(n)。';
    preorderTraversal.hint = '前序遍历顺序为「根-左-右」，栈的特性是先进后出，因此需先推入右子树再推入左子树';
    problems.push(preorderTraversal);


    // 十、动态规划类（10题）
    // 4117. 斐波那契数
    const fib = new ProblemModel();
    fib.id = 4117;
    fib.title = '斐波那契数';
    fib.description = '斐波那契数 （通常用 F(n) 表示）形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：F(0) = 0，F(1) = 1；F(n) = F(n - 1) + F(n - 2)，其中 n > 1。给你 n ，请计算 F(n)。';
    fib.difficulty = ProblemDifficulty.EASY;
    fib.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    fib.choices = [
      { id: 'A', text: '动态规划（迭代）：用变量存储前两项，迭代计算到第n项（空间O(1)）', isCorrect: true },
      { id: 'B', text: '递归（时间O(2^n)，存在大量重复计算，低效）', isCorrect: false },
      { id: 'C', text: '递归+记忆化：缓存已计算结果（空间O(n)）', isCorrect: false },
      { id: 'D', text: '矩阵快速幂（时间O(log n)，实现复杂）', isCorrect: false }
    ];
    fib.explanation = '迭代DP解法：①if n<=1 return n；②a=0；b=1；③for i from 2 to n：④c=a+b；a=b；b=c；⑤return b。时间复杂度O(n)，空间复杂度O(1)。';
    fib.hint = '斐波那契数的递推关系明确，迭代法通过滚动变量存储中间结果，优化空间复杂度至常数级';
    problems.push(fib);


    // 4133. 外观数列
    const countAndSay = new ProblemModel();
    countAndSay.id = 4133;
    countAndSay.title = '外观数列';
    countAndSay.description = '给定一个正整数 n ，输出外观数列的第 n 项。外观数列是一个整数序列，从数字 1 开始，序列中的每一项都是对前一项的描述。你可以将其视作是由递归公式定义的数字字符串序列：countAndSay(1) = "1"；countAndSay(n) 是对 countAndSay(n-1) 的描述，然后转换成另一个数字字符串。前五项如下：1.     1；2.     11；3.     21；4.     1211；5.     111221；解释：第一项是数字 1；描述前一项，这个数是 1 即 “ 一 个 1 ”，记作 "11"；描述前一项，这个数是 11 即 “ 二 个 1 ” ，记作 "21"；描述前一项，这个数是 21 即 “ 一 个 2 + 一 个 1 ” ，记作 "1211"；描述前一项，这个数是 1211 即 “ 一 个 1 + 一 个 2 + 二 个 1 ” ，记作 "111221"。';
    countAndSay.difficulty = ProblemDifficulty.EASY;
    countAndSay.category = ProblemCategory.STRING;
    countAndSay.choices = [
      { id: 'A', text: '迭代生成：从n=1开始，逐个生成到第n项，每次遍历前一项统计连续数字', isCorrect: true },
      { id: 'B', text: '递归生成：递归获取前一项，再处理生成当前项（空间O(n)）', isCorrect: false },
      { id: 'C', text: '正则表达式：用正则匹配连续相同数字（实现简洁，效率略低）', isCorrect: false },
      { id: 'D', text: '暴力拼接（逻辑混乱，易出错）', isCorrect: false }
    ];
    countAndSay.explanation = '迭代解法：①if (n === 1) return "1"；②let prev = "1"；③for (let i=2; i <=n; i++) {④let curr = ""；let count = 1；⑤for (let j=1; j < prev.length; j++) {⑥if (prev[j] === prev[j-1]) {⑦count++；⑧} else {⑨curr += count + prev[j-1]；⑩count = 1；⑪}⑫}⑬// 处理最后一组数字⑭curr += count + prev[prev.length-1]；⑮prev = curr；⑯}⑰return prev。时间复杂度O(n*m)（m为第n项长度），空间复杂度O(m)。';
    countAndSay.hint = '核心是「描述前一项」：遍历前一项字符串，统计连续相同数字的个数和数字本身，拼接成新的字符串';
    problems.push(countAndSay);

    // 4134. 最长公共前缀
    const longestCommonPrefix = new ProblemModel();
    longestCommonPrefix.id = 4134;
    longestCommonPrefix.title = '最长公共前缀';
    longestCommonPrefix.description = '编写一个函数来查找字符串数组中的最长公共前缀。如果不存在公共前缀，返回空字符串 ""。';
    longestCommonPrefix.difficulty = ProblemDifficulty.EASY;
    longestCommonPrefix.category = ProblemCategory.STRING;
    longestCommonPrefix.choices = [
      { id: 'A', text: '横向扫描：依次比较两个字符串的公共前缀，更新结果', isCorrect: true },
      { id: 'B', text: '纵向扫描：按列比较所有字符串的相同位置字符，直到不匹配', isCorrect: false },
      { id: 'C', text: '排序后比较：排序后只需比较第一个和最后一个字符串的公共前缀', isCorrect: false },
      { id: 'D', text: '分治法：将数组分成两部分，分别求前缀再合并（实现复杂）', isCorrect: false }
    ];
    longestCommonPrefix.explanation = '横向扫描解法：①if (strs.length === 0) return ""；②let prefix = strs[0]；③for (let i=1; i < strs.length; i++) {④let j=0；⑤while (j < prefix.length && j < strs[i].length && prefix[j] === strs[i][j]) {⑥j++；⑦}⑧prefix = prefix.substring(0, j)；⑨if (prefix === "") break；// 提前退出⑩}⑪return prefix。时间复杂度O(S)（S为所有字符总数），空间复杂度O(1)。';
    longestCommonPrefix.hint = '以第一个字符串为初始前缀，逐步与其他字符串比较并缩短前缀，直到找到所有字符串的公共部分';
    problems.push(longestCommonPrefix);


    // 4143. 搜索插入位置
    const searchInsert = new ProblemModel();
    searchInsert.id = 4143;
    searchInsert.title = '搜索插入位置';
    searchInsert.description = '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。请必须使用时间复杂度为 O(log n) 的算法。';
    searchInsert.difficulty = ProblemDifficulty.EASY;
    searchInsert.category = ProblemCategory.ARRAY;
    searchInsert.choices = [
      { id: 'A', text: '二分查找：查找目标值，未找到则返回左指针位置', isCorrect: true },
      { id: 'B', text: '线性查找（时间O(n)，不符合要求）', isCorrect: false },
      { id: 'C', text: '内置方法（如indexOf，时间O(n)）', isCorrect: false },
      { id: 'D', text: '排序后查找（数组已排序，无需再次排序）', isCorrect: false }
    ];
    searchInsert.explanation = '二分查找解法：①let left = 0；right = nums.length - 1；②while (left <= right) {③const mid = Math.floor((left + right) / 2)；④if (nums[mid] === target) {⑤return mid；⑥} else if (nums[mid] < target) {⑦left = mid + 1；⑧} else {⑨right = mid - 1；⑩}⑪}⑫// 未找到，返回插入位置left⑬return left。时间复杂度O(log n)，空间复杂度O(1)。';
    searchInsert.hint = '二分查找不仅能找到目标值的位置，当循环结束时，left指针恰好是目标值应插入的位置';
    problems.push(searchInsert);

    // 4146. 杨辉三角
    const generate = new ProblemModel();
    generate.id = 4146;
    generate.title = '杨辉三角';
    generate.description = '给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。在「杨辉三角」中，每个数是它左上方和右上方的数的和。';
    generate.difficulty = ProblemDifficulty.EASY;
    generate.category = ProblemCategory.ARRAY;
    generate.choices = [
      { id: 'A', text: '迭代生成：第i行的第j个数等于i-1行的j-1和j个数之和（边界为1）', isCorrect: true },
      { id: 'B', text: '递归生成：递归获取前i-1行，再计算第i行（空间O(n)）', isCorrect: false },
      { id: 'C', text: '数学公式：利用组合数C(n,k)计算（可能有精度问题）', isCorrect: false },
      { id: 'D', text: '暴力填充（逻辑混乱）', isCorrect: false }
    ];
    generate.explanation = '迭代解法：①if (numRows === 0) return []；②const result = [[1]]；③for (let i=1; i < numRows; i++) {④const row = [1]；// 第一个元素⑤const prevRow = result[i-1]；⑥for (let j=1; j < i; j++) {⑦row.push(prevRow[j-1] + prevRow[j])；⑧}⑨row.push(1)；// 最后一个元素⑩result.push(row)；⑪}⑫return result。时间复杂度O(n²)，空间复杂度O(n²)（存储结果）。';
    generate.hint = '杨辉三角的每行首尾都是1，中间元素由上一行相邻两个元素相加得到，通过迭代逐行生成';
    problems.push(generate);


    // 4150. 链表中倒数第k个节点
    const getKthFromEnd = new ProblemModel();
    getKthFromEnd.id = 4150;
    getKthFromEnd.title = '链表中倒数第k个节点';
    getKthFromEnd.description = '输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。例如，一个链表有 6 个节点，从头节点开始，它们的值依次是 1、2、3、4、5、6。这个链表的倒数第 3 个节点是值为 4 的节点。';
    getKthFromEnd.difficulty = ProblemDifficulty.EASY;
    getKthFromEnd.category = ProblemCategory.LINKED_LIST;
    getKthFromEnd.choices = [
      { id: 'A', text: '快慢指针：快指针先走k步，然后两指针一起走，快指针到尾时慢指针即为目标', isCorrect: true },
      { id: 'B', text: '计算长度后查找：先求长度n，再找第n-k+1个节点（两次遍历）', isCorrect: false },
      { id: 'C', text: '栈辅助：将所有节点入栈，弹出k个（空间O(n)）', isCorrect: false },
      { id: 'D', text: '递归回溯计数（空间O(n)）', isCorrect: false }
    ];
    getKthFromEnd.explanation = '快慢指针解法：①let fast = head；②let slow = head；③// 快指针先走k步④for (let i=0; i < k; i++) {⑤if (fast === null) return null；// k大于链表长度⑥fast = fast.next；⑦}⑧// 两指针一起走⑨while (fast !== null) {⑩fast = fast.next；⑪slow = slow.next；⑫}⑬return slow；。时间复杂度O(n)，空间复杂度O(1)。';
    getKthFromEnd.hint = '快慢指针保持k步距离，当快指针到达末尾时，慢指针正好指向倒数第k个节点，注意处理k大于链表长度的情况';
    problems.push(getKthFromEnd);

    // 4156. 分隔链表
    const partition = new ProblemModel();
    partition.id = 4156;
    partition.title = '分隔链表';
    partition.description = '给你一个链表的头节点 head 和一个特定值 x ，请你对链表进行分隔，使得所有 小于 x 的节点都出现在 大于或等于 x 的节点之前。你应当 保留 两个分区中每个节点的初始相对位置。';
    partition.difficulty = ProblemDifficulty.MEDIUM;
    partition.category = ProblemCategory.LINKED_LIST;
    partition.choices = [
      { id: 'A', text: '双链表法：创建两个哑节点，分别收集小于x和大于等于x的节点，最后连接', isCorrect: true },
      { id: 'B', text: '插入法：遍历链表，将大于等于x的节点移到后面（时间O(n)）', isCorrect: false },
      { id: 'C', text: '数组存储后重建（空间O(n)）', isCorrect: false },
      { id: 'D', text: '递归法（实现复杂）', isCorrect: false }
    ];
    partition.explanation = '双链表解法：①const dummy1 = new ListNode(0)；// 小于x的链表②const dummy2 = new ListNode(0)；// 大于等于x的链表③let p1 = dummy1；let p2 = dummy2；④let current = head；⑤while (current !== null) {⑥if (current.val < x) {⑦p1.next = current；⑧p1 = p1.next；⑨} else {⑩p2.next = current；⑪p2 = p2.next；⑫}⑬current = current.next；⑭}⑮// 连接两个链表，注意末尾置空⑯p2.next = null；⑰p1.next = dummy2.next；⑱return dummy1.next；。时间复杂度O(n)，空间复杂度O(1)。';
    partition.hint = '通过两个链表分别收集符合条件的节点，最后拼接，能保持原有相对顺序且高效';
    problems.push(partition);

    // 4158. 被围绕的区域
    const solve = new ProblemModel();
    solve.id = 4158;
    solve.title = '被围绕的区域';
    solve.description = '给你一个 m x n 的矩阵 board ，由若干字符 \'X\' 和 \'O\' ，找到所有被 \'X\' 围绕的区域，并将这些区域里所有的 \'O\' 用 \'X\' 填充。';
    solve.difficulty = ProblemDifficulty.MEDIUM;
    solve.category = ProblemCategory.GRAPH;
    solve.choices = [
      { id: 'A', text: 'DFS/BFS：从边界的\'O\'开始，标记所有可达的\'O\'为临时字符，最后将未标记的\'O\'改为\'X\'，恢复临时字符', isCorrect: true },
      { id: 'B', text: '并查集：将边界\'O\'与一个虚拟节点相连，内部\'O\'与相邻\'O\'相连，最后未与虚拟节点相连的\'O\'改为\'X\'', isCorrect: false },
      { id: 'C', text: '暴力检查每个\'O\'是否被包围（时间O((mn)^2)）', isCorrect: false },
      { id: 'D', text: '动态规划（难以定义状态）', isCorrect: false }
    ];
    solve.explanation = 'DFS解法：①if (board.length === 0) return；②const m = board.length；const n = board[0].length；③// DFS标记与边界相连的O为A④function dfs(i, j) {⑤if (i < 0 || i >= m || j < 0 || j >= n || board[i][j] !== \'O\') return；⑥board[i][j] = \'A\'；// 临时标记⑦dfs(i+1, j)；dfs(i-1, j)；dfs(i, j+1)；dfs(i, j-1)；⑧}⑨// 处理边界O⑩for (let i=0; i < m; i++) {⑪dfs(i, 0)；dfs(i, n-1)；⑫}⑬for (let j=0; j < n; j++) {⑭dfs(0, j)；dfs(m-1, j)；⑮}⑯// 替换：A恢复为O，O改为X⑰for (let i=0; i < m; i++) {⑱for (let j=0; j < n; j++) {⑲if (board[i][j] === \'O\') {⑳board[i][j] = \'X\'；㉑} else if (board[i][j] === \'A\') {㉒board[i][j] = \'O\'；㉓}㉔}㉕}。时间复杂度O(mn)，空间复杂度O(mn)（递归栈）。';
    solve.hint = '被围绕的区域无法到达边界，因此先标记所有能到达边界的O，剩余的O就是被围绕的，可安全替换';
    problems.push(solve);

    // 十五、排序与查找类（10题）
    // 4167. 排序数组
    const sortArray = new ProblemModel();
    sortArray.id = 4167;
    sortArray.title = '排序数组';
    sortArray.description = '给你一个整数数组 nums，请你将该数组升序排列。';
    sortArray.difficulty = ProblemDifficulty.MEDIUM;
    sortArray.category = ProblemCategory.SORT;
    sortArray.choices = [
      { id: 'A', text: '快速排序：选择基准，分区，递归排序左右（平均O(n log n)，最坏O(n²)）', isCorrect: true },
      { id: 'B', text: '归并排序：分治思想，合并两个有序子数组（稳定，O(n log n)）', isCorrect: false },
      { id: 'C', text: '堆排序：利用堆的特性，构建大顶堆后逐个提取最大值（O(n log n)）', isCorrect: false },
      { id: 'D', text: '内置排序函数（如Array.sort，通常基于快排或TimSort）', isCorrect: false }
    ];
    sortArray.explanation = '快速排序解法：①function quickSort(nums, left, right) {②if (left >= right) return；③// 选择基准（这里用中间元素）④const pivotIndex = Math.floor((left + right) / 2)；⑤const pivot = nums[pivotIndex]；⑥// 交换基准到末尾⑦[nums[pivotIndex], nums[right]] = [nums[right], nums[pivotIndex]]；⑧let i = left；⑨for (let j=left; j < right; j++) {⑩if (nums[j] < pivot) {⑪[nums[i], nums[j]] = [nums[j], nums[i]]；⑫i++；⑬}⑭}⑮// 将基准放到正确位置⑯[nums[i], nums[right]] = [nums[right], nums[i]]；⑰// 递归排序左右⑱quickSort(nums, left, i-1)；⑲quickSort(nums, i+1, right)；⑳}㉑if (nums.length === 0) return []；㉒quickSort(nums, 0, nums.length-1)；㉓return nums；。平均时间复杂度O(n log n)，空间复杂度O(log n)（递归栈）。';
    sortArray.hint = '快速排序的核心是分区操作：选择一个基准，将小于基准的元素放左边，大于的放右边，递归处理子数组';
    problems.push(sortArray);

    // 排序算法类题目
    const sortColors = new ProblemModel();
    sortColors.id = 1001;
    sortColors.title = '颜色分类';
    sortColors.description = '给定一个包含红色、白色和蓝色，一共 n 个元素的数组，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。此题中，我们使用整数 0、1 和 2 分别表示红色、白色和蓝色。';
    sortColors.difficulty = ProblemDifficulty.MEDIUM;
    sortColors.category = ProblemCategory.SORT;
    sortColors.choices = [
      { id: 'A', text: '单指针两次遍历：先移动所有0到前端，再移动所有1到0之后', isCorrect: false },
      { id: 'B', text: '双指针一次遍历：分别追踪0的右边界和2的左边界，遇到0交换到左区，遇到2交换到右区', isCorrect: true },
      { id: 'C', text: '快速排序：选择1作为 pivot 进行分区', isCorrect: false },
      { id: 'D', text: '计数排序：统计0、1、2的个数后重新构造数组', isCorrect: false }
    ];
    sortColors.explanation = '双指针解法：①初始化p0=0（0的右边界），p2=n-1（2的左边界），当前指针i=0；②遍历数组：若nums[i]=0，交换nums[i]与nums[p0]，p0++和i++；若nums[i]=2，交换nums[i]与nums[p2]，p2--；若nums[i]=1，i++；③直至i>p2。时间O(n)，空间O(1)。';
    sortColors.hint = '利用0、1、2的有限性，通过双指针划分三个区域，实现一次遍历完成排序';
    problems.push(sortColors);

    // 前缀和类题目
    const subarraySum = new ProblemModel();
    subarraySum.id = 2001;
    subarraySum.title = '和为K的子数组';
    subarraySum.description = '给定一个整数数组和一个整数 k，你需要找到该数组中和为 k 的连续子数组的个数。';
    subarraySum.difficulty = ProblemDifficulty.MEDIUM;
    subarraySum.category = ProblemCategory.PREFIX_SUM;
    subarraySum.choices = [
      { id: 'A', text: '前缀和+哈希表：用哈希表存储前缀和出现次数，通过前缀和差值计算目标和', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算和并判断', isCorrect: false },
      { id: 'C', text: '滑动窗口：双指针移动计算子数组和（仅适用于非负数）', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]表示以i结尾的子数组和', isCorrect: false }
    ];
    subarraySum.explanation = '前缀和解法：①计算前缀和数组prefixSum，其中prefixSum[i] = sum(nums[0..i-1])；②子数组nums[j..i-1]和为k 等价于 prefixSum[i] - prefixSum[j] = k；③用哈希表map存储prefixSum出现次数，遍历中累计map[prefixSum[i]-k]的次数。时间O(n)，空间O(n)。';
    subarraySum.hint = '前缀和的差值对应子数组和，哈希表可快速查询需要的前缀和出现次数';
    problems.push(subarraySum);

    const rangeSumQuery = new ProblemModel();
    rangeSumQuery.id = 2002;
    rangeSumQuery.title = '区域和检索 - 数组不可变';
    rangeSumQuery.description = '给定一个整数数组 nums，处理以下类型的多个查询:计算索引 left 和 right （包含 left 和 right）之间的 nums 元素的和，其中 left <= right。实现 NumArray 类：NumArray(int[] nums) 使用数组 nums 初始化对象；int sumRange(int left, int right) 返回数组 nums 中索引 left 和 right 之间的元素的总和。';
    rangeSumQuery.difficulty = ProblemDifficulty.EASY;
    rangeSumQuery.category = ProblemCategory.PREFIX_SUM;
    rangeSumQuery.choices = [
      { id: 'A', text: '前缀和预处理：初始化时计算前缀和数组，查询时用差值计算', isCorrect: true },
      { id: 'B', text: '每次查询遍历计算：直接从left到right累加', isCorrect: false },
      { id: 'C', text: '线段树：构建线段树支持区间查询', isCorrect: false },
      { id: 'D', text: '树状数组：适用于动态更新的区间和查询', isCorrect: false }
    ];
    rangeSumQuery.explanation = '前缀和解法：①初始化前缀和数组prefix，prefix[0]=0，prefix[i] = prefix[i-1] + nums[i-1]；②sumRange(left, right) = prefix[right+1] - prefix[left]。初始化时间O(n)，每次查询O(1)，空间O(n)。';
    rangeSumQuery.hint = '前缀和数组可以将多次区间和查询的时间从O(n)优化到O(1)';
    problems.push(rangeSumQuery);

    const minSubArrayLen = new ProblemModel();
    minSubArrayLen.id = 3002;
    minSubArrayLen.title = '长度最小的子数组';
    minSubArrayLen.description = '给定一个含有 n 个正整数的数组和一个正整数 target 。找出该数组中满足其和 ≥ target 的长度最小的 连续子数组 [numsl, numsl+1, ..., numsr-1, numsr] ，并返回其长度。如果不存在符合条件的子数组，返回 0 。';
    minSubArrayLen.difficulty = ProblemDifficulty.MEDIUM;
    minSubArrayLen.category = ProblemCategory.SLIDING_WINDOW;
    minSubArrayLen.choices = [
      { id: 'A', text: '滑动窗口：双指针维护窗口，右指针扩展，左指针收缩优化长度', isCorrect: true },
      { id: 'B', text: '前缀和+二分查找：计算前缀和后，对每个起点二分查找最小终点', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子数组计算和并判断', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]表示以i结尾的最小子数组长度', isCorrect: false }
    ];
    minSubArrayLen.explanation = '滑动窗口解法：①初始化left=0，当前和sum=0，最小长度infinity；②遍历右指针right：sum += nums[right]；③当sum >= target时，更新最小长度为min(当前长度, right-left+1)，并减去nums[left]同时left++，直到sum < target；④最终返回最小长度（若仍为infinity则返回0）。时间O(n)，空间O(1)。';
    minSubArrayLen.hint = '利用数组元素为正整数的特性，窗口和随右移递增，左移递减，可高效收缩窗口';
    problems.push(minSubArrayLen);

    // 排序算法类（续）
    const findKthLargest = new ProblemModel();
    findKthLargest.id = 1003;
    findKthLargest.title = '数组中的第K个最大元素';
    findKthLargest.description = '给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。';
    findKthLargest.difficulty = ProblemDifficulty.MEDIUM;
    findKthLargest.category = ProblemCategory.SORT;
    findKthLargest.choices = [
      { id: 'A', text: '快速选择算法：基于快速排序的分区思想，平均时间O(n)', isCorrect: true },
      { id: 'B', text: '堆排序：维护大小为k的小顶堆，最终堆顶即为结果', isCorrect: false },
      { id: 'C', text: '全排序后取第k个元素：时间O(n log n)', isCorrect: false },
      { id: 'D', text: '冒泡排序优化：只排序前k轮，取第k个元素', isCorrect: false }
    ];
    findKthLargest.explanation = '快速选择解法：①随机选择基准元素，将数组分区为小于、等于、大于基准的三部分；②若大于基准的部分长度≥k，则目标在该区域；若大于+等于部分长度<k，则目标在小于区域且k更新；否则返回基准。平均时间O(n)，最坏O(n²)（可通过随机基准优化）。';
    findKthLargest.hint = '利用快速排序的分区特性，无需完全排序即可定位第k大元素';
    problems.push(findKthLargest);

    const maximumGap = new ProblemModel();
    maximumGap.id = 1004;
    maximumGap.title = '最大间距';
    maximumGap.description = '给定一个无序的数组，找出数组在排序之后，相邻元素之间最大的差值。如果数组元素个数小于 2，则返回 0。要求时间复杂度为O(n)。';
    maximumGap.difficulty = ProblemDifficulty.HARD;
    maximumGap.category = ProblemCategory.SORT;
    maximumGap.choices = [
      { id: 'A', text: '基数排序：按位排序后计算相邻差值', isCorrect: false },
      { id: 'B', text: '桶排序：根据最大值和最小值划分桶，最大间距必在桶间', isCorrect: true },
      { id: 'C', text: '快速排序后遍历计算：时间O(n log n)，不满足要求', isCorrect: false },
      { id: 'D', text: '堆排序后遍历计算：时间O(n log n)，不满足要求', isCorrect: false }
    ];
    maximumGap.explanation = '桶排序解法：①计算数组max、min，若元素相同返回0；②创建n-1个桶，每个桶大小为d=(max-min)/(n-1)；③将元素放入对应桶，记录每个桶的最大最小值；④最大间距为相邻桶（前桶max与后桶min的差）的最大值。时间O(n)，空间O(n)。';
    maximumGap.hint = '桶内元素最大间距不会超过桶大小，最大间距一定出现在不同桶之间';
    problems.push(maximumGap);

    // 前缀和类（续）
    const subarraySumEqualsKII = new ProblemModel();
    subarraySumEqualsKII.id = 2003;
    subarraySumEqualsKII.title = '连续的子数组和';
    subarraySumEqualsKII.description = '给你一个整数数组 nums 和一个整数 k ，编写一个函数来判断该数组中是否存在连续的子数组，其大小至少为 2，且总和为 k 的倍数（即总和为 n*k ，其中 n 也是一个整数）。';
    subarraySumEqualsKII.difficulty = ProblemDifficulty.MEDIUM;
    subarraySumEqualsKII.category = ProblemCategory.PREFIX_SUM;
    subarraySumEqualsKII.choices = [
      { id: 'A', text: '前缀和+哈希表存余数：若两个前缀和余数相同且间距≥2则存在', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有长度≥2的子数组计算和', isCorrect: false },
      { id: 'C', text: '滑动窗口：双指针移动计算子数组和（不适用于负数）', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]存储以i结尾的子数组和', isCorrect: false }
    ];
    subarraySumEqualsKII.explanation = '前缀和余数解法：①计算前缀和mod k（处理k=0的特殊情况）；②哈希表存首次出现的余数索引，初始存入{0: -1}；③若当前余数已存在且当前索引-首次索引≥2，返回true；否则存入新余数。时间O(n)，空间O(min(n,k))。';
    subarraySumEqualsKII.hint = '若两个前缀和的差是k的倍数，则它们的余数相同，通过哈希表记录首次出现位置判断间距';
    problems.push(subarraySumEqualsKII);

    // 滑动窗口类（续）
    const slidingWindowMaximum = new ProblemModel();
    slidingWindowMaximum.id = 3003;
    slidingWindowMaximum.title = '滑动窗口最大值';
    slidingWindowMaximum.description = '给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。返回 滑动窗口中的最大值 。';
    slidingWindowMaximum.difficulty = ProblemDifficulty.HARD;
    slidingWindowMaximum.category = ProblemCategory.SLIDING_WINDOW;
    slidingWindowMaximum.choices = [
      { id: 'A', text: '单调队列：维护一个存储索引的双端队列，队首始终为窗口最大值', isCorrect: true },
      { id: 'B', text: '暴力法：每个窗口遍历找最大值', isCorrect: false },
      { id: 'C', text: '优先队列（堆）：每次取堆顶最大值，需处理过期元素', isCorrect: false },
      { id: 'D', text: '分块预处理：将数组分块，预处理块内前后缀最大值', isCorrect: false }
    ];
    slidingWindowMaximum.explanation = '单调队列解法：①队列存储nums索引，保持对应值递减；②入队前移除所有小于当前值的元素；③移除窗口外的索引；④当窗口形成（i≥k-1），队首即为当前窗口最大值。时间O(n)，空间O(k)。';
    slidingWindowMaximum.hint = '单调队列能在O(1)时间获取最大值，同时高效维护窗口内元素顺序';
    problems.push(slidingWindowMaximum);
    // 一、排序算法类（10题）
    // 1005
    const sortList = new ProblemModel();
    sortList.id = 1005;
    sortList.title = '排序链表';
    sortList.description = '给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。要求时间复杂度为 O(n log n) ，空间复杂度为 O(log n) 。';
    sortList.difficulty = ProblemDifficulty.MEDIUM;
    sortList.category = ProblemCategory.SORT;
    sortList.choices = [
      { id: 'A', text: '归并排序：递归拆分链表为两半，排序后合并', isCorrect: true },
      { id: 'B', text: '快速排序：选择基准分割链表，递归排序', isCorrect: false },
      { id: 'C', text: '转换为数组排序后重建链表：空间O(n)，不满足要求', isCorrect: false },
      { id: 'D', text: '冒泡排序：时间O(n²)，不满足要求', isCorrect: false }
    ];
    sortList.explanation = '归并排序解法：①找到链表中点（快慢指针），拆分左右子链表；②递归排序左右子链表；③合并两个有序子链表（双指针）。时间O(n log n)，空间O(log n)（递归栈）。';
    sortList.hint = '链表的归并排序无需额外空间存储元素，通过指针操作实现合并';
    problems.push(sortList);

    // 1007
    const reversePairs = new ProblemModel();
    reversePairs.id = 1007;
    reversePairs.title = '数组中的逆序对';
    reversePairs.description = '在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。';
    reversePairs.difficulty = ProblemDifficulty.HARD;
    reversePairs.category = ProblemCategory.SORT;
    reversePairs.choices = [
      { id: 'A', text: '归并排序：合并时统计逆序对数量', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有数对判断', isCorrect: false },
      { id: 'C', text: '快速排序：分区时统计逆序对', isCorrect: false },
      { id: 'D', text: '树状数组：通过离散化和前缀和统计', isCorrect: false }
    ];
    reversePairs.explanation = '归并排序解法：①递归拆分数组为左右两半；②分别计算左右逆序对，再计算跨左右的逆序对；③合并时，若左[i]>右[j]，则左[i..mid]均与右[j]构成逆序对。时间O(n log n)，空间O(n)。';
    reversePairs.hint = '归并排序的合并过程可高效统计逆序对，避免暴力法的O(n²)时间';
    problems.push(reversePairs);

    // 1009
    const sortByBits = new ProblemModel();
    sortByBits.id = 1009;
    sortByBits.title = '根据数字二进制下1的数目排序';
    sortByBits.description = '给你一个整数数组 arr ，请你将数组中的元素按照其二进制表示中数字 1 的数目升序排序。如果存在多个数字二进制中 1 的数目相同，则必须将它们按照数值大小升序排列。';
    sortByBits.difficulty = ProblemDifficulty.EASY;
    sortByBits.category = ProblemCategory.SORT;
    sortByBits.choices = [
      { id: 'A', text: '自定义排序：先按1的个数排序，再按数值排序', isCorrect: true },
      { id: 'B', text: '计数排序：按1的个数分组后组内排序', isCorrect: false },
      { id: 'C', text: '基数排序：按二进制位依次排序', isCorrect: false },
      { id: 'D', text: '冒泡排序：自定义比较规则', isCorrect: false }
    ];
    sortByBits.explanation = '自定义排序解法：①定义比较函数：比较两数二进制1的个数，个数相同则比较数值；②用该函数对数组排序。时间O(n log n)，空间O(1)。';
    sortByBits.hint = '利用语言内置排序函数，自定义比较器实现双重排序逻辑';
    problems.push(sortByBits);

    // 1011
    const relativeSortArray = new ProblemModel();
    relativeSortArray.id = 1011;
    relativeSortArray.title = '相对排序';
    relativeSortArray.description = '给你两个数组，arr1 和 arr2，arr2 中的元素各不相同，arr2 中的每个元素都出现在 arr1 中。对 arr1 中的元素进行排序，使 arr1 中项的相对顺序和 arr2 中的相对顺序相同。未在 arr2 中出现过的元素需要按照升序放在 arr1 的末尾。';
    relativeSortArray.difficulty = ProblemDifficulty.EASY;
    relativeSortArray.category = ProblemCategory.SORT;
    relativeSortArray.choices = [
      { id: 'A', text: '自定义排序：按元素在arr2中的索引排序，无索引则按值排序', isCorrect: true },
      { id: 'B', text: '计数排序：统计arr1元素频率，按arr2顺序和剩余元素升序输出', isCorrect: false },
      { id: 'C', text: '插入排序：参照arr2顺序插入', isCorrect: false },
      { id: 'D', text: '快速排序：修改基准选择逻辑', isCorrect: false }
    ];
    relativeSortArray.explanation = '自定义排序解法：①创建arr2元素到索引的映射；②自定义比较函数：若两元素都在映射中，比较索引；若仅一个在，在映射中的靠前；都不在则比较值。时间O(n log n)，空间O(m)（m为arr2长度）。';
    relativeSortArray.hint = '通过映射将相对顺序转化为可比较的索引值，简化排序逻辑';
    problems.push(relativeSortArray);

    // 1012
    const arrayPairSum = new ProblemModel();
    arrayPairSum.id = 1012;
    arrayPairSum.title = '数组拆分';
    arrayPairSum.description = '给定长度为 2n 的整数数组 nums ，你的任务是将这些数分成 n 对, 例如 (a1, b1), (a2, b2), ..., (an, bn) ，使得从 1 到 n 的 min(ai, bi) 总和最大。返回该最大总和。';
    arrayPairSum.difficulty = ProblemDifficulty.EASY;
    arrayPairSum.category = ProblemCategory.SORT;
    arrayPairSum.choices = [
      { id: 'A', text: '排序后取偶数索引元素和：排序后相邻两数为一对，取前一个', isCorrect: true },
      { id: 'B', text: '贪心算法：每次取最小的两个数配对', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示前i对数的最大和', isCorrect: false },
      { id: 'D', text: '暴力枚举：所有可能配对方式计算总和', isCorrect: false }
    ];
    arrayPairSum.explanation = '排序解法：①将数组升序排序；②每两个相邻元素为一对，取每对的第一个元素（较小值）求和。时间O(n log n)（排序），空间O(1)。原理：排序后相邻配对可避免大值被当作最小值，最大化总和。';
    arrayPairSum.hint = '排序后相邻元素配对，能保证较小值尽可能大，从而最大化总和';
    problems.push(arrayPairSum);

    // 1013
    const maxFrequency = new ProblemModel();
    maxFrequency.id = 1013;
    maxFrequency.title = '最大频率元素的频数';
    maxFrequency.description = '元素的 频数 是该元素在一个数组中出现的次数。给你一个整数数组 nums 和一个整数 k 。在一步操作中，你可以选择 nums 的一个元素，并将其递增 1 。返回数组中最高频元素的最大可能频数。';
    maxFrequency.difficulty = ProblemDifficulty.MEDIUM;
    maxFrequency.category = ProblemCategory.SORT;
    maxFrequency.choices = [
      { id: 'A', text: '排序+滑动窗口：排序后用窗口计算可提升到当前元素的最大频数', isCorrect: true },
      { id: 'B', text: '哈希表计数：统计频率后尝试提升低频元素', isCorrect: false },
      { id: 'C', text: '暴力法：对每个元素计算可达到的最大频率', isCorrect: false },
      { id: 'D', text: '堆排序：用堆维护最大元素及可提升次数', isCorrect: false }
    ];
    maxFrequency.explanation = '排序+滑动窗口解法：①排序数组；②滑动窗口[left, right]，计算将窗口内元素都提升到nums[right]的成本；③若成本≤k，扩大窗口；否则左移left。最大窗口长度即为结果。时间O(n log n)，空间O(1)。';
    maxFrequency.hint = '排序后，只有连续元素可通过递增操作变为相同值，用窗口计算最小成本';
    problems.push(maxFrequency);

    // 1014
    const findTarget = new ProblemModel();
    findTarget.id = 1014;
    findTarget.title = '两数之和 IV - 输入有序数组';
    findTarget.description = '给定一个已按照 升序排列 的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 1 开始计数 ，所以答案数组应当满足 1 <= answer[0] < answer[1] <= numbers.length 。';
    findTarget.difficulty = ProblemDifficulty.EASY;
    findTarget.category = ProblemCategory.SORT;
    findTarget.choices = [
      { id: 'A', text: '双指针：左右指针向中间移动，和大于目标则左移右指针，反之右移左指针', isCorrect: true },
      { id: 'B', text: '哈希表：存储元素值和索引，查找target-当前元素', isCorrect: false },
      { id: 'C', text: '二分查找：对每个元素，二分查找target-当前元素', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有数对', isCorrect: false }
    ];
    findTarget.explanation = '双指针解法：①初始化left=0，right=numbers.length-1；②计算sum=numbers[left]+numbers[right]；③sum=target返回[left+1, right+1]；sum>target则right--；sum<target则left++。时间O(n)，空间O(1)。';
    findTarget.hint = '利用数组有序性，双指针可一次遍历找到目标，无需额外空间';
    problems.push(findTarget);


    // 二、前缀和类（10题）
    // 2005
    const NumMatrix = new ProblemModel();
    NumMatrix.id = 2005;
    NumMatrix.title = '二维区域和检索 - 矩阵不可变';
    NumMatrix.description = '给定一个二维矩阵 matrix，以下类型的多个请求：计算其子矩形范围内元素的总和，该子矩阵的 左上角 为 (row1, col1) ，右下角 为 (row2, col2) 。实现 NumMatrix 类：NumMatrix(int[][] matrix) 给定整数矩阵 matrix 进行初始化；int sumRegion(int row1, int col1, int row2, int col2) 返回子矩阵总和。';
    NumMatrix.difficulty = ProblemDifficulty.MEDIUM;
    NumMatrix.category = ProblemCategory.PREFIX_SUM;
    NumMatrix.choices = [
      { id: 'A', text: '二维前缀和：预处理前缀和矩阵，用容斥原理计算区域和', isCorrect: true },
      { id: 'B', text: '逐行计算：对每行计算一维前缀和，查询时累加行和', isCorrect: false },
      { id: 'C', text: '暴力计算：每次查询遍历子矩阵累加', isCorrect: false },
      { id: 'D', text: '线段树：构建二维线段树支持区域查询', isCorrect: false }
    ];
    NumMatrix.explanation = '二维前缀和解法：①prefix[i][j]表示(0,0)到(i-1,j-1)的区域和；②prefix[i][j] = matrix[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]；③sumRegion = prefix[row2+1][col2+1] - prefix[row1][col2+1] - prefix[row2+1][col1] + prefix[row1][col1]。时间O(1)查询，空间O(mn)。';
    NumMatrix.hint = '二维前缀和通过容斥原理，将区域和转化为四个前缀和的加减运算';
    problems.push(NumMatrix);

    // 2006
    const productExceptSelfOptimized = new ProblemModel();
    productExceptSelfOptimized.id = 2006;
    productExceptSelfOptimized.title = '除自身以外数组的乘积（空间优化）';
    productExceptSelfOptimized.description = '给你一个整数数组 nums，返回 数组 answer ，其中 answer[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积。要求在 O(n) 时间复杂度和 O(1) 额外空间（除结果数组）内完成。';
    productExceptSelfOptimized.difficulty = ProblemDifficulty.MEDIUM;
    productExceptSelfOptimized.category = ProblemCategory.PREFIX_SUM;
    productExceptSelfOptimized.choices = [
      { id: 'A', text: '单数组优化：用结果数组先存前缀积，再反向计算后缀积', isCorrect: true },
      { id: 'B', text: '前缀积+后缀积：两个数组分别存储，空间O(n)', isCorrect: false },
      { id: 'C', text: '总乘积/当前元素：无法处理0的情况', isCorrect: false },
      { id: 'D', text: '暴力法：时间O(n²)，不满足要求', isCorrect: false }
    ];
    productExceptSelfOptimized.explanation = '空间优化解法：①初始化answer数组，answer[i]存储nums[0..i-1]的乘积；②用变量suffix记录右侧乘积，从后往前遍历，answer[i] *= suffix，同时更新suffix *= nums[i]。时间O(n)，空间O(1)（除结果）。';
    productExceptSelfOptimized.hint = '复用结果数组存储前缀积，用变量替代后缀积数组，实现空间优化';
    problems.push(productExceptSelfOptimized);

    // 2007
    const subarraysDivByK = new ProblemModel();
    subarraysDivByK.id = 2007;
    subarraysDivByK.title = '和可被 K 整除的子数组';
    subarraysDivByK.description = '给定一个整数数组 A，返回其中元素之和可被 K 整除的（连续、非空）子数组的数目。';
    subarraysDivByK.difficulty = ProblemDifficulty.MEDIUM;
    subarraysDivByK.category = ProblemCategory.PREFIX_SUM;
    subarraysDivByK.choices = [
      { id: 'A', text: '前缀和+哈希表：统计前缀和余数出现次数，相同余数的前缀和差值可被K整除', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算和', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的符合条件的子数组数', isCorrect: false },
      { id: 'D', text: '滑动窗口：仅适用于非负数，且K固定场景', isCorrect: false }
    ];
    subarraysDivByK.explanation = '前缀和余数解法：①计算前缀和mod K（处理负余数：(sum % K + K) % K）；②哈希表count记录余数出现次数，初始count[0]=1；③遍历中累计count[当前余数]，并更新count[当前余数]++。时间O(n)，空间O(K)。';
    subarraysDivByK.hint = '若两个前缀和的余数相同，则它们的差是K的倍数，注意处理负余数';
    problems.push(subarraysDivByK);

    // 2008
    const numberOfSubarrays = new ProblemModel();
    numberOfSubarrays.id = 2008;
    numberOfSubarrays.title = '统计「优美子数组」';
    numberOfSubarrays.description = '给你一个整数数组 nums 和一个整数 k。如果某个子数组中恰好有 k 个奇数数字，我们就认为这个子数组是「优美子数组」。请返回这个数组中 「优美子数组」 的数目。';
    numberOfSubarrays.difficulty = ProblemDifficulty.MEDIUM;
    numberOfSubarrays.category = ProblemCategory.PREFIX_SUM;
    numberOfSubarrays.choices = [
      { id: 'A', text: '前缀奇数计数+哈希表：统计前缀奇数个数，寻找差值为k的次数', isCorrect: true },
      { id: 'B', text: '滑动窗口：维护包含k个奇数的窗口，计算左右可能的扩展数', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子数组统计奇数个数', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i][j]表示前i个元素中含j个奇数的子数组数', isCorrect: false }
    ];
    numberOfSubarrays.explanation = '前缀奇数计数解法：①将数组转为0（偶数）和1（奇数）；②计算前缀和sum[i]（前i个元素的奇数个数）；③子数组[j..i]有k个奇数等价于sum[i]-sum[j] = k；④哈希表记录sum出现次数，累计count[sum[i]-k]。时间O(n)，空间O(n)。';
    numberOfSubarrays.hint = '将问题转化为「和为k的子数组数目」，用前缀和哈希表思想解决';
    problems.push(numberOfSubarrays);

    // 2009
    const maxTurbulenceSize = new ProblemModel();
    maxTurbulenceSize.id = 2009;
    maxTurbulenceSize.title = '最长湍流子数组';
    maxTurbulenceSize.description = '当 A 的子数组 A[i..j] 满足下列条件时，我们称其为湍流子数组：若 i <= k < j，当 k 为奇数时，A[k] > A[k+1]，且当 k 为偶数时，A[k] < A[k+1]；或 若 i <= k < j，当 k 为偶数时，A[k] > A[k+1]，且当 k 为奇数时，A[k] < A[k+1]。返回 A 的最大湍流子数组的长度。';
    maxTurbulenceSize.difficulty = ProblemDifficulty.MEDIUM;
    maxTurbulenceSize.category = ProblemCategory.PREFIX_SUM;
    maxTurbulenceSize.choices = [
      { id: 'A', text: '前缀状态标记：标记相邻元素的大小关系，统计连续交替的最大长度', isCorrect: true },
      { id: 'B', text: '滑动窗口：维护符合湍流条件的窗口', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的最长湍流子数组长度', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有子数组判断', isCorrect: false }
    ];
    maxTurbulenceSize.explanation = '前缀状态解法：①定义比较数组cmp，cmp[i]=1（A[i]>A[i+1]）、-1（A[i]<A[i+1]）、0（相等）；②遍历cmp，统计连续交替（1和-1交替）的最大长度，加1即为子数组长度。时间O(n)，空间O(n)（可优化为O(1)）。';
    maxTurbulenceSize.hint = '将数组转为状态序列，问题简化为寻找最长的交替状态序列';
    problems.push(maxTurbulenceSize);

    // 2011
    const xorQueries = new ProblemModel();
    xorQueries.id = 2011;
    xorQueries.title = '子数组异或查询';
    xorQueries.description = '有一个正整数数组 arr，现给你一个对应的查询数组 queries，其中 queries[i] = [L[i], R[i]]。对于每个查询 i，请你计算从 arr[L[i]] 到 arr[R[i]] 的 XOR 值（即 arr[L[i]] XOR arr[L[i]+1] XOR ... XOR arr[R[i]]）作为返回值。';
    xorQueries.difficulty = ProblemDifficulty.MEDIUM;
    xorQueries.category = ProblemCategory.PREFIX_SUM;
    xorQueries.choices = [
      { id: 'A', text: '前缀异或：预处理前缀异或数组，查询时用前缀异或[R+1] XOR 前缀异或[L]', isCorrect: true },
      { id: 'B', text: '暴力法：每个查询遍历计算异或', isCorrect: false },
      { id: 'C', text: '线段树：构建线段树支持区间异或查询', isCorrect: false },
      { id: 'D', text: '动态规划：预处理所有可能区间的异或值', isCorrect: false }
    ];
    xorQueries.explanation = '前缀异或解法：①prefix[0] = 0，prefix[i] = prefix[i-1] XOR arr[i-1]；②区间[L, R]的异或 = prefix[R+1] XOR prefix[L]（因x XOR x = 0，中间部分抵消）。时间O(n + m)（n为arr长度，m为查询数），空间O(n)。';
    xorQueries.hint = '异或运算的性质：x XOR x = 0，x XOR 0 = x，可像前缀和一样简化区间计算';
    problems.push(xorQueries);

    // 2012
    const maxFrequencyII = new ProblemModel();
    maxFrequencyII.id = 2012;
    maxFrequencyII.title = '最高频元素的频数（前缀和辅助）';
    maxFrequencyII.description = '元素的 频数 是该元素在一个数组中出现的次数。给你一个整数数组 nums 和一个整数 k 。在一步操作中，你可以选择 nums 的一个元素，并将其递增 1 。返回数组中最高频元素的最大可能频数。';
    maxFrequencyII.difficulty = ProblemDifficulty.MEDIUM;
    maxFrequencyII.category = ProblemCategory.PREFIX_SUM;
    maxFrequencyII.choices = [
      { id: 'A', text: '排序+前缀和+滑动窗口：用前缀和快速计算窗口内提升成本', isCorrect: true },
      { id: 'B', text: '哈希表计数：直接统计频率', isCorrect: false },
      { id: 'C', text: '暴力法：枚举每个元素计算可提升次数', isCorrect: false },
      { id: 'D', text: '堆：维护最大元素及可分配的k值', isCorrect: false }
    ];
    maxFrequencyII.explanation = '前缀和+滑动窗口解法：①排序数组并计算前缀和；②窗口[left, right]中，成本 = nums[right]*(right-left+1) - (prefix[right+1]-prefix[left])；③成本≤k时扩大窗口，否则左移left。最大窗口长度为结果。时间O(n log n)，空间O(n)。';
    maxFrequencyII.hint = '前缀和可快速计算窗口内元素总和，结合排序后窗口，高效计算提升成本';
    problems.push(maxFrequencyII);

    // 2013
    const largestAltitude = new ProblemModel();
    largestAltitude.id = 2013;
    largestAltitude.title = '找到最高海拔';
    largestAltitude.description = '有一个自行车手打算进行一场公路骑行，这条路线总共由 n + 1 个不同海拔的点组成。自行车手从海拔为 0 的点 0 开始骑行。给你一个长度为 n 的整数数组 gain ，其中 gain[i] 是点 i 到点 i + 1 的净海拔变化（i 从 0 开始）。请你返回最高点的海拔。';
    largestAltitude.difficulty = ProblemDifficulty.EASY;
    largestAltitude.category = ProblemCategory.PREFIX_SUM;
    largestAltitude.choices = [
      { id: 'A', text: '前缀和：计算每个点的海拔，跟踪最大值', isCorrect: true },
      { id: 'B', text: '遍历累加：边累加边记录最大值', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示第i点的海拔', isCorrect: false },
      { id: 'D', text: '暴力法：计算所有点海拔后找最大', isCorrect: false }
    ];
    largestAltitude.explanation = '前缀和解法：①初始化currentAltitude=0，maxAltitude=0；②遍历gain，currentAltitude += gain[i]；③更新maxAltitude为currentAltitude和自身的最大值。时间O(n)，空间O(1)。';
    largestAltitude.hint = '每个点的海拔是前序净变化的累加和，边计算边跟踪最大值即可';
    problems.push(largestAltitude);

    // 2014
    const findNUniqueIntegersSumUpToZero = new ProblemModel();
    findNUniqueIntegersSumUpToZero.id = 2014;
    findNUniqueIntegersSumUpToZero.title = '和为零的N个唯一整数';
    findNUniqueIntegersSumUpToZero.description = '给你一个整数 n，请你返回 任意 一个由 n 个 各不相同 的整数组成的数组，并且这 n 个数相加和为 0 。';
    findNUniqueIntegersSumUpToZero.difficulty = ProblemDifficulty.EASY;
    findNUniqueIntegersSumUpToZero.category = ProblemCategory.PREFIX_SUM;
    findNUniqueIntegersSumUpToZero.choices = [
      { id: 'A', text: '对称构造：1到n-1和-(1到n-1)，n为奇数时加0', isCorrect: true },
      { id: 'B', text: '前缀和调整：生成序列后调整最后一个数使总和为0', isCorrect: false },
      { id: 'C', text: '随机生成：随机生成n-1个数，最后一个数为相反数', isCorrect: false },
      { id: 'D', text: '暴力枚举：尝试所有可能的唯一整数组合', isCorrect: false }
    ];
    findNUniqueIntegersSumUpToZero.explanation = '对称构造解法：①若n为偶数，返回[1,2,...,n/2, -1,-2,...,-n/2]；②若n为奇数，返回[0,1,2,...,(n-1)/2, -1,-2,...,-(n-1)/2]。总和必然为0，且元素唯一。时间O(n)，空间O(n)。';
    findNUniqueIntegersSumUpToZero.hint = '利用正数和负数的对称性构造，确保总和为零且元素唯一';
    problems.push(findNUniqueIntegersSumUpToZero);


    // 三、滑动窗口类（10题）
    // 3005
    const findAnagrams = new ProblemModel();
    findAnagrams.id = 3005;
    findAnagrams.title = '找到字符串中所有字母异位词';
    findAnagrams.description = '给定两个字符串 s 和 p，找到 s 中所有 p 的 异位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。异位词 指由相同字母重排列形成的字符串（包括相同的字符串）。';
    findAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    findAnagrams.category = ProblemCategory.SLIDING_WINDOW;
    findAnagrams.choices = [
      { id: 'A', text: '滑动窗口+字符计数：维护p长度的窗口，比较字符频率与p是否一致', isCorrect: true },
      { id: 'B', text: '排序比较：对每个p长度子串排序后与排序的p比较', isCorrect: false },
      { id: 'C', text: '哈希表单次匹配：仅匹配一次后移动窗口', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有可能子串判断', isCorrect: false }
    ];
    findAnagrams.explanation = '滑动窗口解法：①统计p的字符频率；②在s上维护长度为p.length的窗口，统计窗口频率；③频率匹配时记录起始索引；④窗口滑动时更新频率（移除左字符，添加右字符）。时间O(n)（n为s长度），空间O(1)。';
    findAnagrams.hint = '与"字符串的排列"类似，但需要收集所有符合条件的起始索引';
    problems.push(findAnagrams);

    // 3007
    const movingAverage = new ProblemModel();
    movingAverage.id = 3007;
    movingAverage.title = '滑动窗口平均值';
    movingAverage.description = '给定一个整数数据流和一个窗口大小，根据该滑动窗口的大小，计算滑动窗口里所有数字的平均值。实现 MovingAverage 类：MovingAverage(int size) 用窗口大小 size 初始化对象；double next(int val) 成员函数 next 每次调用的时候都会往滑动窗口增加一个整数，请计算并返回数据流中最后 size 个值的移动平均值。';
    movingAverage.difficulty = ProblemDifficulty.EASY;
    movingAverage.category = ProblemCategory.SLIDING_WINDOW;
    movingAverage.choices = [
      { id: 'A', text: '队列+总和维护：用队列存储窗口元素，超过大小则移除头部，实时计算总和', isCorrect: true },
      { id: 'B', text: '数组存储：每次调用时计算最后size个元素的和', isCorrect: false },
      { id: 'C', text: '前缀和：维护前缀和数组，每次计算最近size个元素的和', isCorrect: false },
      { id: 'D', text: '暴力法：每次重新计算窗口和', isCorrect: false }
    ];
    movingAverage.explanation = '队列解法：①初始化队列和当前总和sum；②next(val)时，sum += val，队列加入val；③若队列大小>size，sum -= 队列头部并移除；④返回sum/队列大小。时间O(1)每次调用，空间O(size)。';
    movingAverage.hint = '用队列维护窗口元素，通过总和的增量更新避免重复计算，提高效率';
    problems.push(movingAverage);

    // 3009
    const longestOnes = new ProblemModel();
    longestOnes.id = 3009;
    longestOnes.title = '最大连续1的个数 III';
    longestOnes.description = '给定一个二进制数组 nums 和一个整数 k，如果可以翻转最多 k 个 0 ，则返回 数组中连续 1 的最大个数 。';
    longestOnes.difficulty = ProblemDifficulty.MEDIUM;
    longestOnes.category = ProblemCategory.SLIDING_WINDOW;
    longestOnes.choices = [
      { id: 'A', text: '滑动窗口：维护最多含k个0的窗口，窗口长度即为连续1的最大可能数', isCorrect: true },
      { id: 'B', text: '前缀和：计算前缀0的个数，用二分查找最大窗口', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i][j]表示前i个元素翻转j个0的最大连续1', isCorrect: false },
      { id: 'D', text: '暴力法：枚举每个位置计算可翻转k个0的最大长度', isCorrect: false }
    ];
    longestOnes.explanation = '滑动窗口解法：①left=0，zeroCount=0，maxLen=0；②右指针遍历：若nums[right]=0则zeroCount++；③当zeroCount>k时，若nums[left]=0则zeroCount--，left++；④更新maxLen为right-left+1。时间O(n)，空间O(1)。';
    longestOnes.hint = '窗口内允许最多k个0，通过调整左右指针维护窗口合法性，窗口长度即为结果';
    problems.push(longestOnes);

    // 3010
    const totalFruit = new ProblemModel();
    totalFruit.id = 3010;
    totalFruit.title = '水果成篮';
    totalFruit.description = '你正在探访一家农场，农场从左到右种植了一排果树。这些树用一个整数数组 fruits 表示，其中 fruits[i] 是第 i 棵树上的水果种类。你想要尽可能多地收集水果。然而，农场的主人设定了一些严格的规矩：你只有 两个 篮子，并且每个篮子只能装 单一类型 的水果。每个篮子能够装的水果总量没有限制。你可以选择任意一棵树开始采摘，你必须从 每棵 树（包括开始采摘的树）上 恰好摘一个水果 。采摘的水果应当符合篮子中的水果类型。一旦你走到某棵树前，但这棵树的水果不能放进你的篮子，那么你必须停止采摘。给你一个整数数组 fruits ，返回你可以收集的水果的 最大 数目。';
    totalFruit.difficulty = ProblemDifficulty.MEDIUM;
    totalFruit.category = ProblemCategory.SLIDING_WINDOW;
    totalFruit.choices = [
      { id: 'A', text: '滑动窗口+哈希表：维护包含最多两种水果的窗口，记录最大长度', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有可能的起始位置，统计可收集的水果数', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的最大收集数', isCorrect: false },
      { id: 'D', text: '哈希表计数：统计所有可能的两种水果组合的最大连续长度', isCorrect: false }
    ];
    totalFruit.explanation = '滑动窗口解法：①哈希表记录窗口内水果种类及数量；②右指针扩展窗口，加入水果；③当种类>2时，左指针移动并减少对应水果数量，移除数量为0的种类；④更新最大窗口长度。时间O(n)，空间O(1)（最多两种水果）。';
    totalFruit.hint = '问题等价于寻找包含最多两种元素的最长连续子数组，用滑动窗口高效求解';
    problems.push(totalFruit);

    // 3011
    const equalSubstring = new ProblemModel();
    equalSubstring.id = 3011;
    equalSubstring.title = '尽可能使字符串相等';
    equalSubstring.description = '给你两个长度相同的字符串，s 和 t。将 s 中的第 i 个字符变到 t 中的第 i 个字符需要 |s[i] - t[i]| 的开销（开销可能为 0）。用于变更字符串的最大预算是 maxCost。在转化字符串时，总开销应当小于等于该预算，这也意味着字符串的转化可能是不完全的。如果你可以将 s 的子字符串转化为它在 t 中对应的子字符串，则返回可以转化的最大长度。如果 s 中没有子字符串可以转化成 t 中对应的子字符串，则返回 0。';
    equalSubstring.difficulty = ProblemDifficulty.MEDIUM;
    equalSubstring.category = ProblemCategory.SLIDING_WINDOW;
    equalSubstring.choices = [
      { id: 'A', text: '滑动窗口：计算每个位置的开销，维护总开销≤maxCost的最大窗口', isCorrect: true },
      { id: 'B', text: '前缀和+二分：计算前缀和后，二分查找每个起点的最大窗口', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子字符串计算总开销', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]表示以i结尾的最大长度', isCorrect: false }
    ];
    equalSubstring.explanation = '滑动窗口解法：①计算开销数组cost[i] = |s[i]-t[i]|；②left=0，currentCost=0，maxLen=0；③右指针遍历：currentCost += cost[right]；④当currentCost>maxCost，currentCost -= cost[left]，left++；⑤更新maxLen。时间O(n)，空间O(n)（可优化为O(1)）。';
    equalSubstring.hint = '将问题转化为"总开销不超过maxCost的最长子数组"，用滑动窗口实时维护总开销';
    problems.push(equalSubstring);

    // 3012
    const containsNearbyDuplicate = new ProblemModel();
    containsNearbyDuplicate.id = 3012;
    containsNearbyDuplicate.title = '存在重复元素 II';
    containsNearbyDuplicate.description = '给你一个整数数组 nums 和一个整数 k ，判断数组中是否存在两个 不同的索引 i 和 j ，满足 nums[i] == nums[j] 且 abs(i - j) <= k 。如果存在，返回 true ；否则，返回 false 。';
    containsNearbyDuplicate.difficulty = ProblemDifficulty.EASY;
    containsNearbyDuplicate.category = ProblemCategory.SLIDING_WINDOW;
    containsNearbyDuplicate.choices = [
      { id: 'A', text: '滑动窗口+哈希表：维护大小为k的窗口，记录元素是否在窗口中出现', isCorrect: true },
      { id: 'B', text: '哈希表存最后索引：遍历记录每个元素最后出现的索引，判断当前索引差', isCorrect: false },
      { id: 'C', text: '暴力法：对每个元素检查后续k个元素', isCorrect: false },
      { id: 'D', text: '排序+双指针：排序后比较相邻元素的索引差', isCorrect: false }
    ];
    containsNearbyDuplicate.explanation = '滑动窗口解法：①哈希表存储窗口内的元素；②右指针遍历：若nums[right]在哈希表中，返回true；③加入nums[right]到哈希表；④若窗口大小>k，移除nums[right-k]。时间O(n)，空间O(k)。';
    containsNearbyDuplicate.hint = '窗口大小固定为k+1，只需判断当前元素是否在窗口内出现过';
    problems.push(containsNearbyDuplicate);

    // 3013
    const maxSubarraySumCircular = new ProblemModel();
    maxSubarraySumCircular.id = 3013;
    maxSubarraySumCircular.title = '环形子数组的最大和';
    maxSubarraySumCircular.description = '给定一个长度为 n 的环形整数数组 nums ，返回 nums 的非空 子数组 的最大可能和 。环形数组 意味着数组的末端将会与开头相连呈环状。形式上， nums[i] 的下一个元素是 nums[(i + 1) % n] ， nums[i] 的前一个元素是 nums[(i - 1 + n) % n] 。子数组 最多只能包含固定缓冲区 nums 中的每个元素一次。';
    maxSubarraySumCircular.difficulty = ProblemDifficulty.MEDIUM;
    maxSubarraySumCircular.category = ProblemCategory.SLIDING_WINDOW;
    maxSubarraySumCircular.choices = [
      { id: 'A', text: '滑动窗口+总扣最小：最大环形和=max(最大子数组和, 总 sum-最小子数组和)', isCorrect: true },
      { id: 'B', text: '动态规划：分别计算最大子数组和与环形情况', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有可能的环形子数组', isCorrect: false },
      { id: 'D', text: '前缀和：计算前缀和后找最大差值', isCorrect: false }
    ];
    maxSubarraySumCircular.explanation = '滑动窗口变种解法：①计算非环形的最大子数组和（用Kadane算法）；②计算非环形的最小子数组和；③环形最大和 = max(非环形最大和, 总sum - 最小子数组和)（需排除全负情况）。时间O(n)，空间O(1)。';
    maxSubarraySumCircular.hint = '环形子数组的最大和要么是普通最大子数组和，要么是总和减去最小子数组和';
    problems.push(maxSubarraySumCircular);

    // 3014
    const maxSumOfThreeSubarrays = new ProblemModel();
    maxSumOfThreeSubarrays.id = 3014;
    maxSumOfThreeSubarrays.title = '三个无重叠子数组的最大和';
    maxSumOfThreeSubarrays.description = '给你一个整数数组 nums 和一个整数 k ，找出并返回长度为 k 的三个非重叠子数组的最大和。以下标的数组形式返回这三个子数组，返回的下标从左到右必须按顺序排列，即第一个子数组的下标 i ，第二个子数组的下标 j 满足 i + k <= j ，第三个子数组的下标 l 满足 j + k <= l 。如果有多个结果，返回字典序最小的一个。';
    maxSumOfThreeSubarrays.difficulty = ProblemDifficulty.HARD;
    maxSumOfThreeSubarrays.category = ProblemCategory.SLIDING_WINDOW;
    maxSumOfThreeSubarrays.choices = [
      { id: 'A', text: '滑动窗口+前缀和+左右最值：预计算子数组和，左存左侧最大和索引，右存右侧最大和索引', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有可能的三个子数组', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i][j]表示前i个元素中j个子数组的最大和', isCorrect: false },
      { id: 'D', text: '贪心算法：每次选择当前最大的子数组', isCorrect: false }
    ];
    maxSumOfThreeSubarrays.explanation = '前缀和+左右最值解法：①计算每个长度k的子数组和sums；②left数组：left[i]是sums[0..i]的最大和索引；③right数组：right[i]是sums[i..n-1]的最大和索引；④遍历中间子数组位置，计算三者和的最大值。时间O(n)，空间O(n)。';
    maxSumOfThreeSubarrays.hint = '通过预处理左右侧的最大子数组和索引，将三重循环优化为单重循环';
    problems.push(maxSumOfThreeSubarrays);

    // 一、排序算法类（10题）
    // 1015
    const insertionSortList = new ProblemModel();
    insertionSortList.id = 1015;
    insertionSortList.title = '对链表进行插入排序';
    insertionSortList.description = '给定单个链表的头 head ，使用 插入排序 对链表进行排序，并返回 排序后链表的头 。插入排序 算法的步骤：1. 插入排序是迭代的，每次只移动一个元素，直到所有元素可以形成一个有序的输出列表。2. 每次迭代中，插入排序只从输入数据中移除一个待排序的元素，找到它在序列中适当的位置，并将其插入。3. 重复直到所有输入数据插入完为止。';
    insertionSortList.difficulty = ProblemDifficulty.MEDIUM;
    insertionSortList.category = ProblemCategory.SORT;
    insertionSortList.choices = [
      { id: 'A', text: '链表插入排序：维护已排序部分，将未排序节点插入正确位置', isCorrect: true },
      { id: 'B', text: '转换为数组排序后重建链表：空间O(n)，非原地排序', isCorrect: false },
      { id: 'C', text: '归并排序：时间更优但非插入排序', isCorrect: false },
      { id: 'D', text: '快速排序：不适用于链表插入排序场景', isCorrect: false }
    ];
    insertionSortList.explanation = '插入排序解法：①创建哑节点作为已排序部分的头；②current指向待排序节点，prev指向已排序部分的最后；③每次从待排序节点中取一个，从已排序头部开始找到插入位置（prev.next.val > current.val）；④插入current到prev之后。时间O(n²)，空间O(1)。';
    insertionSortList.hint = '链表插入排序需维护已排序部分的指针，通过指针调整实现元素插入，无需额外空间';
    problems.push(insertionSortList);

    // 1016
    const findMissingNumber = new ProblemModel();
    findMissingNumber.id = 1016;
    findMissingNumber.title = '寻找丢失的数字';
    findMissingNumber.description = '给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。';
    findMissingNumber.difficulty = ProblemDifficulty.EASY;
    findMissingNumber.category = ProblemCategory.SORT;
    findMissingNumber.choices = [
      { id: 'A', text: '排序后遍历：排序数组，检查索引与值是否一致，不一致则为缺失数', isCorrect: true },
      { id: 'B', text: '数学公式：n*(n+1)/2 - 数组和', isCorrect: false },
      { id: 'C', text: '哈希表：存储出现的数字，再检查0~n中缺失的', isCorrect: false },
      { id: 'D', text: '位运算：异或所有索引和值，结果为缺失数', isCorrect: false }
    ];
    findMissingNumber.explanation = '排序解法：①对数组排序；②遍历数组，若nums[i] != i，则返回i；③遍历结束后返回n（最后一个数缺失）。时间O(n log n)（排序耗时），空间O(1)（忽略排序栈空间）。';
    findMissingNumber.hint = '排序后数组应满足nums[i] = i，通过一次遍历即可找到缺失的数字';
    problems.push(findMissingNumber);

    // 1018
    const sortTransformedArray = new ProblemModel();
    sortTransformedArray.id = 1018;
    sortTransformedArray.title = '有序转化数组';
    sortTransformedArray.description = '给你一个已经 排好序 的整数数组 nums 和整数 a、b、c。请你按照函数 f(x) = ax² + bx + c 来转化数组中的每个元素。请你返回转换后的数组，要求转换后的数组仍然是有序的。';
    sortTransformedArray.difficulty = ProblemDifficulty.MEDIUM;
    sortTransformedArray.category = ProblemCategory.SORT;
    sortTransformedArray.choices = [
      { id: 'A', text: '双指针：根据抛物线开口方向（a的符号），从两端向中间合并', isCorrect: true },
      { id: 'B', text: '直接转换后排序：时间O(n log n)，未利用原有序性', isCorrect: false },
      { id: 'C', text: '归并排序：转换后对两半分别排序再合并', isCorrect: false },
      { id: 'D', text: '插入排序：逐个转换并插入到正确位置', isCorrect: false }
    ];
    sortTransformedArray.explanation = '双指针解法：①a>0时抛物线开口向上，两端值较大，从后往前填充结果；②a<0时开口向下，两端值较小，从前往后填充；③比较两端点的函数值，选择较大（或较小）的放入结果，推进对应指针。时间O(n)，空间O(n)。';
    sortTransformedArray.hint = '二次函数的对称性使转换后数组呈现两端大中间小或两端小中间大的特性，可双指针高效合并';
    problems.push(sortTransformedArray);

    // 1019
    const customSortString = new ProblemModel();
    customSortString.id = 1019;
    customSortString.title = '自定义字符串排序';
    customSortString.description = '给定两个字符串 order 和 s。order 的所有字符都是 唯一 的。s 中的每个字符在 order 中都存在。请根据 order 中字符的顺序对 s 中的字符进行排序。更具体地说，如果 order 中字符 x 位于字符 y 之前，那么在排序后的字符串中，x 也应位于 y 之前。';
    customSortString.difficulty = ProblemDifficulty.MEDIUM;
    customSortString.category = ProblemCategory.SORT;
    customSortString.choices = [
      { id: 'A', text: '自定义排序：根据字符在order中的索引定义比较规则', isCorrect: true },
      { id: 'B', text: '计数排序：统计s中字符频率，按order顺序输出', isCorrect: false },
      { id: 'C', text: '插入排序：参照order顺序插入字符', isCorrect: false },
      { id: 'D', text: '哈希映射：直接映射字符到目标位置', isCorrect: false }
    ];
    customSortString.explanation = '自定义排序解法：①创建order的字符到索引的映射；②将s转为字符数组，按映射的索引排序；③将排序后的数组转为字符串。时间O(n log n)（n为s长度），空间O(1)（字符集固定）。';
    customSortString.hint = '通过映射将自定义顺序转化为可比较的索引值，利用内置排序函数实现';
    problems.push(customSortString);

    // 1021
    const mergeSortedArray = new ProblemModel();
    mergeSortedArray.id = 1021;
    mergeSortedArray.title = '合并两个有序数组';
    mergeSortedArray.description = '给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。';
    mergeSortedArray.difficulty = ProblemDifficulty.EASY;
    mergeSortedArray.category = ProblemCategory.SORT;
    mergeSortedArray.choices = [
      { id: 'A', text: '双指针从后往前：比较两数组末尾元素，较大者放入nums1末尾', isCorrect: true },
      { id: 'B', text: '双指针从前往后：需额外空间存储nums1元素', isCorrect: false },
      { id: 'C', text: '合并后排序：直接将nums2放入nums1后排序，时间O((m+n)log(m+n))', isCorrect: false },
      { id: 'D', text: '插入排序：将nums2元素逐个插入nums1', isCorrect: false }
    ];
    mergeSortedArray.explanation = '后向双指针解法：①i=m-1，j=n-1，k=m+n-1；②当i≥0且j≥0时，若nums1[i]≥nums2[j]，则nums1[k--]=nums1[i--]，否则nums1[k--]=nums2[j--]；③将剩余nums2元素放入nums1。时间O(m+n)，空间O(1)。';
    mergeSortedArray.hint = '利用nums1的额外空间，从后往前填充可避免覆盖未处理的元素';
    problems.push(mergeSortedArray);

    // 1022
    const sortArrayByParity = new ProblemModel();
    sortArrayByParity.id = 1022;
    sortArrayByParity.title = '按奇偶排序数组';
    sortArrayByParity.description = '给你一个整数数组 nums，将数组中的元素按奇偶性进行排序，使得所有偶数元素都位于奇数元素之前。返回排序后的数组。你可以返回满足此条件的 任何 一个数组作为答案。';
    sortArrayByParity.difficulty = ProblemDifficulty.EASY;
    sortArrayByParity.category = ProblemCategory.SORT;
    sortArrayByParity.choices = [
      { id: 'A', text: '双指针：左指针找奇数，右指针找偶数，交换位置', isCorrect: true },
      { id: 'B', text: '两次遍历：先收集偶数，再收集奇数', isCorrect: false },
      { id: 'C', text: '自定义排序：偶数在前，奇数在后', isCorrect: false },
      { id: 'D', text: '插入排序：将偶数插入前端', isCorrect: false }
    ];
    sortArrayByParity.explanation = '双指针解法：①left=0，right=nums.length-1；②left向右找奇数（nums[left]%2!==0），right向左找偶数（nums[right]%2===0）；③交换nums[left]和nums[right]，重复直到left≥right。时间O(n)，空间O(1)。';
    sortArrayByParity.hint = '双指针一次遍历即可完成奇偶分离，无需额外空间存储元素';
    problems.push(sortArrayByParity);

    // 1023
    const largestPerimeter = new ProblemModel();
    largestPerimeter.id = 1023;
    largestPerimeter.title = '三角形的最大周长';
    largestPerimeter.description = '给定由一些正数（代表长度）组成的数组 nums ，返回 由其中三个长度组成的、面积不为零的三角形的最大周长 。如果不能形成任何面积不为零的三角形，返回 0 。';
    largestPerimeter.difficulty = ProblemDifficulty.EASY;
    largestPerimeter.category = ProblemCategory.SORT;
    largestPerimeter.choices = [
      { id: 'A', text: '排序后贪心：排序数组，从大到小检查连续三个数是否满足a < b + c', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有三元组判断能否组成三角形', isCorrect: false },
      { id: 'C', text: '动态规划：记录最大可能的周长', isCorrect: false },
      { id: 'D', text: '堆：维护最大的三个元素', isCorrect: false }
    ];
    largestPerimeter.explanation = '排序贪心解法：①将数组降序排序；②遍历数组，对每个i（从0到n-3），检查nums[i] < nums[i+1] + nums[i+2]；③第一个满足条件的三元组和为最大周长，返回sum；④无则返回0。时间O(n log n)，空间O(1)。';
    largestPerimeter.hint = '三角形两边之和大于第三边，排序后只需检查连续三个最大数即可高效找到最大周长';
    problems.push(largestPerimeter);

    // 1024
    const maximumProduct = new ProblemModel();
    maximumProduct.id = 1024;
    maximumProduct.title = '三个数的最大乘积';
    maximumProduct.description = '给你一个整型数组 nums ，在数组中找出由三个数组成的最大乘积，并输出这个乘积。';
    maximumProduct.difficulty = ProblemDifficulty.EASY;
    maximumProduct.category = ProblemCategory.SORT;
    maximumProduct.choices = [
      { id: 'A', text: '排序后取最值：最大乘积为max(前两负*最后正, 最后三正)', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有三元组乘积', isCorrect: false },
      { id: 'C', text: '堆：找出最大的三个数和最小的两个数', isCorrect: false },
      { id: 'D', text: '动态规划：记录最大乘积组合', isCorrect: false }
    ];
    maximumProduct.explanation = '排序解法：①排序数组；②可能的最大乘积来自两种情况：最大的三个正数相乘，或最小的两个负数（乘积为正）与最大的正数相乘；③返回两种情况的最大值。时间O(n log n)，空间O(1)。';
    maximumProduct.hint = '负数的存在可能影响结果，排序后只需比较两种关键组合即可';
    problems.push(maximumProduct);


    // 二、前缀和类（10题）
    // 2015
    const matrixBlockSum = new ProblemModel();
    matrixBlockSum.id = 2015;
    matrixBlockSum.title = '矩阵区域和';
    matrixBlockSum.description = '给你一个 m x n 的矩阵 mat 和一个整数 k ，请你返回一个矩阵 answer ，其中每个 answer[i][j] 是所有满足下述条件的元素 mat[r][c] 的和：i - k <= r <= i + k，j - k <= c <= j + k 且 (r, c) 在矩阵内。';
    matrixBlockSum.difficulty = ProblemDifficulty.MEDIUM;
    matrixBlockSum.category = ProblemCategory.PREFIX_SUM;
    matrixBlockSum.choices = [
      { id: 'A', text: '二维前缀和：预处理前缀和矩阵，用容斥原理计算每个区域和', isCorrect: true },
      { id: 'B', text: '暴力法：对每个位置遍历其k范围内的元素求和', isCorrect: false },
      { id: 'C', text: '逐行前缀和：每行计算前缀和，再按行累加区域', isCorrect: false },
      { id: 'D', text: '滑动窗口：在二维矩阵上滑动窗口计算和', isCorrect: false }
    ];
    matrixBlockSum.explanation = '二维前缀和解法：①计算前缀和矩阵prefix，prefix[i][j]为(0,0)到(i-1,j-1)的和；②对每个(i,j)，确定区域边界r1=max(0,i-k), r2=min(m-1,i+k), c1=max(0,j-k), c2=min(n-1,j+k)；③answer[i][j] = prefix[r2+1][c2+1] - prefix[r1][c2+1] - prefix[r2+1][c1] + prefix[r1][c1]。时间O(mn)，空间O(mn)。';
    matrixBlockSum.hint = '二维前缀和结合边界处理，可在O(1)时间计算任意矩形区域的和';
    problems.push(matrixBlockSum);

    // 2016
    const findPivotIndex = new ProblemModel();
    findPivotIndex.id = 2016;
    findPivotIndex.title = '寻找数组的中心下标';
    findPivotIndex.description = '给你一个整数数组 nums ，请计算数组的 中心下标 。数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。';
    findPivotIndex.difficulty = ProblemDifficulty.EASY;
    findPivotIndex.category = ProblemCategory.PREFIX_SUM;
    findPivotIndex.choices = [
      { id: 'A', text: '前缀和：计算总 sum，遍历中左侧和 leftSum，右侧和为 sum - leftSum - nums[i]', isCorrect: true },
      { id: 'B', text: '暴力法：对每个下标计算左右和', isCorrect: false },
      { id: 'C', text: '动态规划：记录左右和数组', isCorrect: false },
      { id: 'D', text: '双指针：从两端向中间移动，调整左右和', isCorrect: false }
    ];
    findPivotIndex.explanation = '前缀和解法：①计算数组总和 total；②遍历数组，leftSum 累加左侧元素和；③右侧和 = total - leftSum - nums[i]，若 leftSum == 右侧和，返回当前索引；④遍历结束返回-1。时间O(n)，空间O(1)。';
    findPivotIndex.hint = '利用总 sum 快速计算右侧和，避免重复累加，优化时间复杂度';
    problems.push(findPivotIndex);

    // 2017
    const subarraySumsDivisibleByKII = new ProblemModel();
    subarraySumsDivisibleByKII.id = 2017;
    subarraySumsDivisibleByKII.title = '和可被 K 整除的子数组（扩展）';
    subarraySumsDivisibleByKII.description = '给定一个整数数组 A 和整数 K，返回其中元素之和可被 K 整除的 最长 连续子数组的长度。如果不存在这样的子数组，返回 0。';
    subarraySumsDivisibleByKII.difficulty = ProblemDifficulty.MEDIUM;
    subarraySumsDivisibleByKII.category = ProblemCategory.PREFIX_SUM;
    subarraySumsDivisibleByKII.choices = [
      { id: 'A', text: '前缀和+哈希表：记录每个余数首次出现的索引，相同余数的最大间距为最长子数组', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算和并判断', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的最长符合条件的子数组', isCorrect: false },
      { id: 'D', text: '滑动窗口：仅适用于非负数场景', isCorrect: false }
    ];
    subarraySumsDivisibleByKII.explanation = '前缀和余数解法：①计算前缀和mod K（处理负余数）；②哈希表firstOccurrence记录余数首次出现的索引，初始{0: -1}；③遍历中，若余数已存在，计算当前索引-首次索引，更新最大长度；否则记录首次出现索引。时间O(n)，空间O(K)。';
    subarraySumsDivisibleByKII.hint = '相同余数的前缀和之差可被K整除，通过记录首次出现索引计算最大间距';
    problems.push(subarraySumsDivisibleByKII);

    // 2018
    const maxSumTwoNoOverlap = new ProblemModel();
    maxSumTwoNoOverlap.id = 2018;
    maxSumTwoNoOverlap.title = '两个非重叠子数组的最大和';
    maxSumTwoNoOverlap.description = '给你一个整数数组 nums 和两个整数 firstLen 和 secondLen，请你找出并返回两个非重叠 子数组 中元素的最大和，长度分别为 firstLen 和 secondLen 。长度为 firstLen 的子数组可以出现在长度为 secondLen 的子数组之前或之后，但二者必须是不重叠的。子数组是数组的 连续 部分。';
    maxSumTwoNoOverlap.difficulty = ProblemDifficulty.MEDIUM;
    maxSumTwoNoOverlap.category = ProblemCategory.PREFIX_SUM;
    maxSumTwoNoOverlap.choices = [
      { id: 'A', text: '前缀和+左右最值：预计算子数组和，左存左侧最大和，右存右侧最大和', isCorrect: true },
      { id: 'B', text: '暴力法：枚举两个子数组的位置', isCorrect: false },
      { id: 'C', text: '滑动窗口：分别滑动两个窗口计算和', isCorrect: false },
      { id: 'D', text: '动态规划：记录不同位置的最大和', isCorrect: false }
    ];
    maxSumTwoNoOverlap.explanation = '前缀和+左右最值解法：①计算前缀和，预先生成长度为L和M的子数组和；②分两种情况：L在左M在右，或M在左L在右；③对每种情况，计算左侧最大和+右侧当前和的最大值。时间O(n)，空间O(n)。';
    maxSumTwoNoOverlap.hint = '通过预处理左右侧的最大子数组和，避免重复计算，高效找到最优组合';
    problems.push(maxSumTwoNoOverlap);

    // 2019
    const xorOperation = new ProblemModel();
    xorOperation.id = 2019;
    xorOperation.title = '数组异或操作';
    xorOperation.description = '给你两个整数，n 和 start 。数组 nums 定义为：nums[i] = start + 2*i（下标从 0 开始）且 n == nums.length 。请返回 nums 中所有元素按位异或（XOR）后得到的结果。';
    xorOperation.difficulty = ProblemDifficulty.EASY;
    xorOperation.category = ProblemCategory.PREFIX_SUM;
    xorOperation.choices = [
      { id: 'A', text: '前缀异或：遍历数组，累计异或结果', isCorrect: true },
      { id: 'B', text: '数学公式：利用异或的周期性规律计算', isCorrect: false },
      { id: 'C', text: '暴力法：生成数组后计算异或', isCorrect: false },
      { id: 'D', text: '递归：递归计算前n-1个元素的异或', isCorrect: false }
    ];
    xorOperation.explanation = '前缀异或解法：①初始化result=0；②遍历i从0到n-1，result ^= (start + 2*i)；③返回result。时间O(n)，空间O(1)。';
    xorOperation.hint = '异或操作具有累积性，可边生成元素边计算结果，无需额外存储数组';
    problems.push(xorOperation);

    // 2020
    const countTriplets = new ProblemModel();
    countTriplets.id = 2020;
    countTriplets.title = '统计异或值在范围内的三元组数目';
    countTriplets.description = '给你一个整数数组 arr 和两个整数 a 和 b ，请你统计其中满足 0 <= i < j < k < arr.length 且 a <= (arr[i] XOR arr[j] XOR arr[k]) <= b 的三元组 (i, j, k) 的数目。';
    countTriplets.difficulty = ProblemDifficulty.HARD;
    countTriplets.category = ProblemCategory.PREFIX_SUM;
    countTriplets.choices = [
      { id: 'A', text: '前缀异或+哈希表：利用x^y^z = prefix[k+1]^prefix[i]，统计符合范围的对数', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有三元组计算异或', isCorrect: false },
      { id: 'C', text: '动态规划：记录不同位置的异或结果', isCorrect: false },
      { id: 'D', text: '前缀和：转化为和的范围问题', isCorrect: false }
    ];
    countTriplets.explanation = '前缀异或解法：①计算前缀异或prefix，prefix[0]=0，prefix[k+1]=arr[0]^...^arr[k]；②三元组异或=prefix[k+1]^prefix[i]；③对每个k，统计i<k中满足a<=prefix[k+1]^prefix[i]<=b的i的数量，累加总和。时间O(n²)，空间O(n)。';
    countTriplets.hint = '利用异或性质将三元组异或转化为两个前缀异或的异或，简化问题复杂度';
    problems.push(countTriplets);

    // 2021
    const numSubarraysWithSum = new ProblemModel();
    numSubarraysWithSum.id = 2021;
    numSubarraysWithSum.title = '和为S的子数组数目';
    numSubarraysWithSum.description = '给你一个二元数组 nums 和一个整数 goal ，请你统计并返回有多少个和为 goal 的 非空 子数组。';
    numSubarraysWithSum.difficulty = ProblemDifficulty.MEDIUM;
    numSubarraysWithSum.category = ProblemCategory.PREFIX_SUM;
    numSubarraysWithSum.choices = [
      { id: 'A', text: '前缀和+哈希表：统计前缀和出现次数，sum[i]-sum[j]=goal即count+=map[sum[i]-goal]', isCorrect: true },
      { id: 'B', text: '滑动窗口：利用数组元素为0/1的特性，维护窗口和', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子数组计算和', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]表示以i结尾的和为goal的子数组数', isCorrect: false }
    ];
    numSubarraysWithSum.explanation = '前缀和解法：①计算前缀和sum，map记录sum出现次数，初始map[0]=1；②遍历数组，sum += nums[i]；③若sum-goal在map中，累加map[sum-goal]；④更新map[sum]++。时间O(n)，空间O(n)。';
    numSubarraysWithSum.hint = '二元数组的和问题可直接用前缀和哈希表解决，无需特殊优化';
    problems.push(numSubarraysWithSum);

    // 2022
    const minimumAverageDifference = new ProblemModel();
    minimumAverageDifference.id = 2022;
    minimumAverageDifference.title = '最小平均差';
    minimumAverageDifference.description = '给你一个下标从 0 开始长度为 n 的整数数组 nums 。平均差 是指数组中一个下标 i 对应的 绝对 差值：左边部分的平均值与右边部分的平均值之差。左边部分为 nums[0..i] ，右边部分为 nums[i+1..n-1] 。两个部分都可能为空。两个部分的平均值都是 整数除法 。请你返回产生 最小平均差 的下标。如果有多个下标最小平均差相同，则返回 最小 的一个下标。';
    minimumAverageDifference.difficulty = ProblemDifficulty.MEDIUM;
    minimumAverageDifference.category = ProblemCategory.PREFIX_SUM;
    minimumAverageDifference.choices = [
      { id: 'A', text: '前缀和：计算前缀和数组，遍历计算左右平均差', isCorrect: true },
      { id: 'B', text: '暴力法：每次计算左右和并求平均差', isCorrect: false },
      { id: 'C', text: '滑动窗口：动态更新左右和', isCorrect: false },
      { id: 'D', text: '动态规划：记录左右和的变化', isCorrect: false }
    ];
    minimumAverageDifference.explanation = '前缀和解法：①计算前缀和数组prefix，prefix[i]为前i个元素和；②总sum=prefix[n]；③遍历i从0到n-1，左平均=prefix[i+1]/(i+1)，右平均=(sum-prefix[i+1])/(n-i-1)（处理i=n-1时右平均为0）；④计算绝对差，记录最小值及对应索引。时间O(n)，空间O(n)。';
    minimumAverageDifference.hint = '前缀和可快速获取左右部分的和，避免重复计算，降低时间复杂度';
    problems.push(minimumAverageDifference);

    // 2023
    const waysToSplitArray = new ProblemModel();
    waysToSplitArray.id = 2023;
    waysToSplitArray.title = '分割数组的方案数';
    waysToSplitArray.description = '给你一个下标从 0 开始长度为 n 的整数数组 nums 。如果以下描述为真，那么 nums 在下标 i 处有一个 合法的分割 ：左部分 nums[0..i] 和右部分 nums[i+1..n-1] 的和相等。同时，左部分和右部分都至少有一个元素。请你返回 nums 中的 合法分割 方案数。';
    waysToSplitArray.difficulty = ProblemDifficulty.EASY;
    waysToSplitArray.category = ProblemCategory.PREFIX_SUM;
    waysToSplitArray.choices = [
      { id: 'A', text: '前缀和：计算总 sum，遍历检查前缀和是否等于 sum/2（sum需为偶数）', isCorrect: true },
      { id: 'B', text: '暴力法：每次分割计算左右和', isCorrect: false },
      { id: 'C', text: '双指针：从两端向中间移动，调整左右和', isCorrect: false },
      { id: 'D', text: '动态规划：记录左侧和是否等于右侧和', isCorrect: false }
    ];
    waysToSplitArray.explanation = '前缀和解法：①计算总 sum = sum(nums)；②若sum为奇数，返回0；③目标leftSum = sum/2；④计算前缀和，遍历i从0到n-2，若前缀和等于leftSum，计数+1；⑤返回计数。时间O(n)，空间O(1)（可不用前缀和数组，边累加边判断）。';
    waysToSplitArray.hint = '合法分割的左右和相等，即都等于总和的一半，总和必须为偶数';
    problems.push(waysToSplitArray);

    // 2024
    const getAverages = new ProblemModel();
    getAverages.id = 2024;
    getAverages.title = '子数组平均值';
    getAverages.description = '给你一个下标从 0 开始的数组 nums ，数组中有 n 个整数，另给你一个整数 k 。半径为 k 的子数组平均值 是指：nums 中一个以下标 i 为 中心 且 半径 为 k 的子数组中所有元素的平均值，即下标在 i - k 和 i + k 范围（含 i - k 和 i + k）内所有元素的平均值。如果 i - k < 0 或 i + k >= n ，则 不存在 这样的子数组。请你返回一个长度为 n 的数组 avgs ，其中 avgs[i] 是以下标 i 为中心的子数组的 半径为 k 的子数组平均值 。如果不存在这样的子数组，则 avgs[i] = -1 。';
    getAverages.difficulty = ProblemDifficulty.MEDIUM;
    getAverages.category = ProblemCategory.PREFIX_SUM;
    getAverages.choices = [
      { id: 'A', text: '前缀和：计算前缀和数组，对合法中心i计算区间和并求平均', isCorrect: true },
      { id: 'B', text: '暴力法：对每个i计算范围内的元素和', isCorrect: false },
      { id: 'C', text: '滑动窗口：维护大小为2k+1的窗口，计算平均值', isCorrect: false },
      { id: 'D', text: '动态规划：记录区间和的变化', isCorrect: false }
    ];
    getAverages.explanation = '前缀和解法：①计算前缀和数组prefix；②窗口大小为2k+1，对i从0到n-1：若i-k<0或i+k>=n，avgs[i]=-1；否则区间和=prefix[i+k+1]-prefix[i-k]，avgs[i]=区间和/(2k+1)；③返回avgs。时间O(n)，空间O(n)。';
    getAverages.hint = '前缀和可快速计算任意区间的和，结合边界判断即可高效求解';
    problems.push(getAverages);


    // 三、滑动窗口类（10题）
    // 3015
    const lengthOfLongestSubstringTwoDistinct = new ProblemModel();
    lengthOfLongestSubstringTwoDistinct.id = 3015;
    lengthOfLongestSubstringTwoDistinct.title = '至多包含两个不同字符的最长子串';
    lengthOfLongestSubstringTwoDistinct.description = '给定一个字符串 s ，找出 至多 包含两个不同字符的最长子串 t ，并返回该子串的长度。';
    lengthOfLongestSubstringTwoDistinct.difficulty = ProblemDifficulty.MEDIUM;
    lengthOfLongestSubstringTwoDistinct.category = ProblemCategory.SLIDING_WINDOW;
    lengthOfLongestSubstringTwoDistinct.choices = [
      { id: 'A', text: '滑动窗口+哈希表：维护包含至多两个不同字符的窗口，记录最大长度', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子串统计不同字符数', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的最长符合条件子串长度', isCorrect: false },
      { id: 'D', text: '哈希表+双指针：记录每个字符的最后位置', isCorrect: false }
    ];
    lengthOfLongestSubstringTwoDistinct.explanation = '滑动窗口解法：①left=0，maxLen=0，map记录字符最后出现索引；②右指针遍历：map[s[right]]=right；③当map.size>2时，找到最左的索引并移除，left更新为该索引+1；④更新maxLen。时间O(n)，空间O(1)（最多两种字符）。';
    lengthOfLongestSubstringTwoDistinct.hint = '与"水果成篮"问题类似，窗口内允许最多两个不同字符，通过哈希表维护字符位置';
    problems.push(lengthOfLongestSubstringTwoDistinct);

    // 3016
    const numKLenSubstrNoRepeats = new ProblemModel();
    numKLenSubstrNoRepeats.id = 3016;
    numKLenSubstrNoRepeats.title = '长度为K的无重复字符子串';
    numKLenSubstrNoRepeats.description = '给你一个字符串 S，找出所有长度为 K 且不含重复字符的子串，请返回其数目。';
    numKLenSubstrNoRepeats.difficulty = ProblemDifficulty.MEDIUM;
    numKLenSubstrNoRepeats.category = ProblemCategory.SLIDING_WINDOW;
    numKLenSubstrNoRepeats.choices = [
      { id: 'A', text: '滑动窗口+哈希表：维护大小为K的窗口，检查窗口内是否有重复字符', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有长度为K的子串判断', isCorrect: false },
      { id: 'C', text: '滑动窗口+数组计数：用数组代替哈希表记录字符出现次数', isCorrect: false },
      { id: 'D', text: '前缀和：记录字符出现位置', isCorrect: false }
    ];
    numKLenSubstrNoRepeats.explanation = '滑动窗口解法：①若K>s.length，返回0；②left=0，count=0，map记录窗口内字符频率；③右指针遍历到K-1，初始化窗口；④若窗口无重复（map.size=K），count++；⑤滑动窗口：移除left字符，添加right+1字符，重复检查。时间O(n)，空间O(1)（字符集固定）。';
    numKLenSubstrNoRepeats.hint = '固定窗口大小为K，通过哈希表实时维护字符频率，快速判断是否有重复';
    problems.push(numKLenSubstrNoRepeats);

    // 3017
    const maxConsecutiveAnswers = new ProblemModel();
    maxConsecutiveAnswers.id = 3017;
    maxConsecutiveAnswers.title = '最大连续1的个数 IV（扩展）';
    maxConsecutiveAnswers.description = '给你一个二进制字符串 s 和一个整数 k 。你可以最多翻转 k 个 0 到 1 ，返回 经过翻转后，最长连续 1 的数目 。';
    maxConsecutiveAnswers.difficulty = ProblemDifficulty.MEDIUM;
    maxConsecutiveAnswers.category = ProblemCategory.SLIDING_WINDOW;
    maxConsecutiveAnswers.choices = [
      { id: 'A', text: '滑动窗口：维护最多含k个0的窗口，窗口长度即为最长连续1', isCorrect: true },
      { id: 'B', text: '前缀和+二分：计算前缀0的个数，二分查找最大窗口', isCorrect: false },
      { id: 'C', text: '动态规划：记录翻转j个0的最大长度', isCorrect: false },
      { id: 'D', text: '暴力法：枚举每个位置计算可翻转k个0的最大长度', isCorrect: false }
    ];
    maxConsecutiveAnswers.explanation = '滑动窗口解法：①left=0，zeroCount=0，maxLen=0；②右指针遍历：若s[right]为0则zeroCount++；③当zeroCount>k时，若s[left]为0则zeroCount--，left++；④更新maxLen为right-left+1。时间O(n)，空间O(1)。';
    maxConsecutiveAnswers.hint = '与"最大连续1的个数III"相同，将字符串视为0和1的数组处理';
    problems.push(maxConsecutiveAnswers);

    // 3018
    const longestRepeatingCharacterReplacement = new ProblemModel();
    longestRepeatingCharacterReplacement.id = 3018;
    longestRepeatingCharacterReplacement.title = '替换后的最长重复字符';
    longestRepeatingCharacterReplacement.description = '给你一个字符串 s 和一个整数 k 。你可以选择字符串中的任一字符，并将其更改为任何其他大写英文字符。该操作最多可执行 k 次。在执行上述操作后，找到包含相同字母的最长子串的长度。';
    longestRepeatingCharacterReplacement.difficulty = ProblemDifficulty.MEDIUM;
    longestRepeatingCharacterReplacement.category = ProblemCategory.SLIDING_WINDOW;
    longestRepeatingCharacterReplacement.choices = [
      { id: 'A', text: '滑动窗口+字符计数：维护窗口内出现最多的字符数，窗口长度- maxCount ≤k', isCorrect: true },
      { id: 'B', text: '暴力法：枚举每个字符和每个位置计算最大长度', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个位置的最大可能长度', isCorrect: false },
      { id: 'D', text: '前缀和：统计每个字符的前缀出现次数', isCorrect: false }
    ];
    longestRepeatingCharacterReplacement.explanation = '滑动窗口解法：①left=0，maxCount=0，count数组记录字符频率；②右指针遍历：更新count[s[right]]并记录maxCount；③当窗口长度- maxCount >k时，左移left并更新count；④更新maxLen。时间O(n)，空间O(1)（26个字母）。';
    longestRepeatingCharacterReplacement.hint = '窗口内需要替换的字符数为窗口长度减最多字符数，以此判断窗口合法性';
    problems.push(longestRepeatingCharacterReplacement);

    // 3019
    const minimumWindowSubsequence = new ProblemModel();
    minimumWindowSubsequence.id = 3019;
    minimumWindowSubsequence.title = '最小窗口子序列';
    minimumWindowSubsequence.description = '给定字符串 S 和 T，找出 S 中最短的（连续）子串 W ，使得 T 是 W 的子序列 。如果 S 中没有窗口可以包含 T 作为子序列，则返回空字符串 ""。如果有多个最短长度的窗口，返回开始位置最靠左的那个。';
    minimumWindowSubsequence.difficulty = ProblemDifficulty.HARD;
    minimumWindowSubsequence.category = ProblemCategory.SLIDING_WINDOW;
    minimumWindowSubsequence.choices = [
      { id: 'A', text: '滑动窗口+双指针：先找到包含T的窗口，再收缩左边界优化', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子串判断是否包含T', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i][j]表示S前i个字符包含T前j个字符的最小窗口', isCorrect: false },
      { id: 'D', text: '前缀和：记录字符位置信息', isCorrect: false }
    ];
    minimumWindowSubsequence.explanation = '滑动窗口解法：①i=0（T的指针），left=0，minLen=∞；②遍历S的right指针，若S[right]==T[i]则i++；③当i==T.length时，记录当前right，从right向左找T的最后一个字符，调整left到最小位置；④更新minLen和结果。时间O(n*m)（n为S长度，m为T长度），空间O(1)。';
    minimumWindowSubsequence.hint = '先扩展窗口包含整个T，再从右向左收缩左边界，找到最小窗口';
    problems.push(minimumWindowSubsequence);

    // 3020
    const numSubarraysWithSumII = new ProblemModel();
    numSubarraysWithSumII.id = 3020;
    numSubarraysWithSumII.title = '和在[lower, upper]范围内的子数组数目';
    numSubarraysWithSumII.description = '给定一个整数数组 nums ，返回满足 子数组元素之和 在 [lower, upper] 范围内的 非空 子数组的数目。';
    numSubarraysWithSumII.difficulty = ProblemDifficulty.HARD;
    numSubarraysWithSumII.category = ProblemCategory.SLIDING_WINDOW;
    numSubarraysWithSumII.choices = [
      { id: 'A', text: '前缀和+有序集合：前缀和存入有序集合，查询[sum-upper, sum-lower]的数量', isCorrect: true },
      { id: 'B', text: '滑动窗口：仅适用于非负数数组', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子数组计算和', isCorrect: false },
      { id: 'D', text: '动态规划：记录不同和的子数组数', isCorrect: false }
    ];
    numSubarraysWithSumII.explanation = '前缀和+有序集合解法：①计算前缀和sum，初始化有序集合含0；②对每个sum，查询集合中在[sum-upper, sum-lower]范围内的元素个数，累加计数；③将sum加入集合。时间O(n log n)，空间O(n)。';
    numSubarraysWithSumII.hint = '利用有序集合快速查询符合条件的前缀和数量，处理含负数的情况';
    problems.push(numSubarraysWithSumII);

    // 3021
    const findMaxConsecutiveOnes = new ProblemModel();
    findMaxConsecutiveOnes.id = 3021;
    findMaxConsecutiveOnes.title = '最大连续1的个数';
    findMaxConsecutiveOnes.description = '给定一个二进制数组 nums ， 计算其中最大连续 1 的个数。';
    findMaxConsecutiveOnes.difficulty = ProblemDifficulty.EASY;
    findMaxConsecutiveOnes.category = ProblemCategory.SLIDING_WINDOW;
    findMaxConsecutiveOnes.choices = [
      { id: 'A', text: '滑动窗口：遇到1扩展窗口，遇到0重置窗口，记录最大长度', isCorrect: true },
      { id: 'B', text: '前缀和：计算前缀和后找最长的1序列', isCorrect: false },
      { id: 'C', text: '暴力法：遍历记录每个连续1的长度', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i]表示以i结尾的连续1的长度', isCorrect: false }
    ];
    findMaxConsecutiveOnes.explanation = '滑动窗口解法：①current=0，maxLen=0；②遍历nums：若num=1则current++，并更新maxLen；否则current=0；③返回maxLen。时间O(n)，空间O(1)。';
    findMaxConsecutiveOnes.hint = '简单的单指针滑动窗口，无需复杂判断，直接累计连续1的长度';
    problems.push(findMaxConsecutiveOnes);

    // 3022
    const countGoodSubstrings = new ProblemModel();
    countGoodSubstrings.id = 3022;
    countGoodSubstrings.title = '统计好子字符串';
    countGoodSubstrings.description = '给你一个字符串 s ，请你返回长度为 3 的 好子字符串 的数量。注意，如果 s 的长度小于 3 ，则返回 0 。一个字符串是 好 的，如果这个字符串中所有字符都不相同。';
    countGoodSubstrings.difficulty = ProblemDifficulty.EASY;
    countGoodSubstrings.category = ProblemCategory.SLIDING_WINDOW;
    countGoodSubstrings.choices = [
      { id: 'A', text: '滑动窗口：固定窗口大小为3，检查窗口内字符是否全不同', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有长度为3的子串判断', isCorrect: false },
      { id: 'C', text: '哈希表：记录每个字符的位置', isCorrect: false },
      { id: 'D', text: '前缀和：统计字符出现次数', isCorrect: false }
    ];
    countGoodSubstrings.explanation = '滑动窗口解法：①若s.length<3，返回0；②count=0；③遍历i从0到s.length-3：检查s[i]、s[i+1]、s[i+2]是否互不相同，是则count++；④返回count。时间O(n)，空间O(1)。';
    countGoodSubstrings.hint = '固定窗口大小为3，一次遍历即可完成检查，无需复杂数据结构';
    problems.push(countGoodSubstrings);

    // 3023
    const maxVowels = new ProblemModel();
    maxVowels.id = 3023;
    maxVowels.title = '字符串中元音的最大数目';
    maxVowels.description = '给你字符串 s 和整数 k 。请返回字符串 s 中长度为 k 的单个子字符串中可能包含的最大元音字母数。元音字母包括 a、e、i、o、u。';
    maxVowels.difficulty = ProblemDifficulty.MEDIUM;
    maxVowels.category = ProblemCategory.SLIDING_WINDOW;
    maxVowels.choices = [
      { id: 'A', text: '滑动窗口：计算初始窗口元音数，滑动时更新并记录最大值', isCorrect: true },
      { id: 'B', text: '暴力法：计算每个长度为k的子串的元音数', isCorrect: false },
      { id: 'C', text: '前缀和：计算前缀元音数，差值即为窗口元音数', isCorrect: false },
      { id: 'D', text: '动态规划：记录每个位置的最大元音数', isCorrect: false }
    ];
    maxVowels.explanation = '滑动窗口解法：①初始化当前窗口元音数current=0，遍历前k个字符计算current；②maxVowels=current；③滑动窗口：移除左字符（若为元音则current--），添加右字符（若为元音则current++），更新maxVowels；④返回maxVowels。时间O(n)，空间O(1)。';
    maxVowels.hint = '固定窗口大小为k，通过增量更新元音数，避免重复计算';
    problems.push(maxVowels);

    // 3024
    const maxSatisfied = new ProblemModel();
    maxSatisfied.id = 3024;
    maxSatisfied.title = '爱生气的书店老板';
    maxSatisfied.description = '有一个书店老板，他的书店开了 n 分钟。每分钟都有一些顾客进入这家商店。给定一个数组 customers ，其中 customers[i] 是在第 i 分钟开始时进入商店的顾客数量，所有这些顾客在第 i 分钟结束后离开。在某些分钟内，书店老板会生气。如果书店老板在第 i 分钟生气，那么那一分钟的顾客就会不满意，否则他们就会满意。给定一个数组 grumpy ，其中 grumpy[i] 是 1 表示书店老板在第 i 分钟生气，0 表示不生气。书店老板知道一个秘密技巧，能让自己连续 m 分钟不生气，但只能使用一次。请你返回这一天营业下来，最多有多少顾客能够感到满意。';
    maxSatisfied.difficulty = ProblemDifficulty.MEDIUM;
    maxSatisfied.category = ProblemCategory.SLIDING_WINDOW;
    maxSatisfied.choices = [
      { id: 'A', text: '滑动窗口：计算基础满意顾客数，再找m分钟内最多的额外满意顾客', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有m分钟窗口计算总满意数', isCorrect: false },
      { id: 'C', text: '前缀和：计算前缀满意数和前缀生气时的顾客数', isCorrect: false },
      { id: 'D', text: '动态规划：记录使用技巧后的最大满意数', isCorrect: false }
    ];
    maxSatisfied.explanation = '滑动窗口解法：①计算基础满意数（grumpy[i]=0时的customers[i]）；②计算初始窗口（前m分钟）的额外满意数（grumpy[i]=1时的customers[i]）；③滑动窗口找最大额外满意数；④总满意数=基础满意数+最大额外满意数。时间O(n)，空间O(1)。';
    maxSatisfied.hint = '将问题拆分为基础满意数和可挽回的满意数，用滑动窗口找可挽回的最大值';
    problems.push(maxSatisfied);


    // 1026
    const reconstructQueue = new ProblemModel();
    reconstructQueue.id = 1026;
    reconstructQueue.title = '根据身高重建队列';
    reconstructQueue.description = '假设有打乱顺序的一群人站成一个队列，数组 people 表示队列中一些人的属性（不一定按顺序）。每个 people[i] = [h, k] 表示第 i 个人的身高为 h ，前面 正好 有 k 个身高大于或等于 h 的人。请你重新构造并返回输入数组 people 所表示的队列。返回的队列应该格式化为数组 queue ，其中 queue[j] = [hj, kj] 是队列中第 j 个人的属性（queue[0] 是排在队列前面的人）。';
    reconstructQueue.difficulty = ProblemDifficulty.MEDIUM;
    reconstructQueue.category = ProblemCategory.SORT;
    reconstructQueue.choices = [
      { id: 'A', text: '贪心+排序：先按身高降序排序（同身高按k升序），再按k插入对应位置', isCorrect: true },
      { id: 'B', text: '暴力法：逐个插入并维护k的正确性', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个位置的最优排列', isCorrect: false },
      { id: 'D', text: '哈希表：存储身高与位置的映射', isCorrect: false }
    ];
    reconstructQueue.explanation = '贪心排序解法：①按身高h降序排序，h相同则按k升序；②创建结果数组，遍历排序后的people，将每个人插入到索引k的位置；③插入时，由于前面的人都≥当前身高，k值即为正确位置。时间O(n²)（插入操作耗时），空间O(n)。';
    reconstructQueue.hint = '先处理高个子，再插入矮个子时不会影响已插入者的k值，确保每次插入位置正确';
    problems.push(reconstructQueue);



    // 1031
    const findDuplicates = new ProblemModel();
    findDuplicates.id = 1031;
    findDuplicates.title = '找到所有数组中消失的数字 II';
    findDuplicates.description = '给你一个长度为 n 的整数数组 nums ，其中 nums 的所有整数都在范围 [1, n] 内，且每个整数出现 一次 或 两次 。请你找出所有出现 两次 的整数。你必须设计并实现一个时间复杂度为 O(n) 且仅使用常量额外空间的算法解决此问题。';
    findDuplicates.difficulty = ProblemDifficulty.MEDIUM;
    findDuplicates.category = ProblemCategory.SORT;
    findDuplicates.choices = [
      { id: 'A', text: '原地标记：通过正负号标记数字是否出现过，第二次出现时加入结果', isCorrect: true },
      { id: 'B', text: '哈希表：统计出现次数，需额外O(n)空间', isCorrect: false },
      { id: 'C', text: '排序后遍历：相邻元素相等则为重复，时间O(n log n)', isCorrect: false },
      { id: 'D', text: '暴力法：对每个数字检查是否存在重复', isCorrect: false }
    ];
    findDuplicates.explanation = '原地标记解法：①遍历数组，对每个num=abs(nums[i])；②若nums[num-1]为正，标记为负；③若nums[num-1]为负，说明已出现过，加入结果。时间O(n)，空间O(1)。';
    findDuplicates.hint = '利用数组索引与数字范围的对应关系，通过正负号实现原地计数';
    problems.push(findDuplicates);

    // 1032
    const hIndex = new ProblemModel();
    hIndex.id = 1032;
    hIndex.title = 'H 指数';
    hIndex.description = '给你一个整数数组 citations ，其中 citations[i] 表示研究者的第 i 篇论文被引用的次数。计算并返回该研究者的 h 指数。h 指数的定义：h 代表"高引用次数"（high citations），一名科研人员的 h 指数是指他（她）的 （n 篇论文中）总共有 h 篇论文分别被引用了至少 h 次。且其余的 n - h 篇论文每篇被引用次数 不超过 h 次。';
    hIndex.difficulty = ProblemDifficulty.MEDIUM;
    hIndex.category = ProblemCategory.SORT;
    hIndex.choices = [
      { id: 'A', text: '排序+遍历：降序排序后，找到最大h满足citations[h-1]≥h', isCorrect: true },
      { id: 'B', text: '计数排序：统计各引用次数的论文数，从高到低累计找到h', isCorrect: false },
      { id: 'C', text: '暴力法：从n到0检查是否满足h指数条件', isCorrect: false },
      { id: 'D', text: '二分查找：在可能的h值范围内二分查找', isCorrect: false }
    ];
    hIndex.explanation = '排序解法：①将数组降序排序；②遍历i从0到n-1，若citations[i] > i，则h至少为i+1；③最大的i+1即为h指数（若所有citations[i]≤i，则h=0）。时间O(n log n)，空间O(1)。';
    hIndex.hint = '排序后，论文按引用次数从高到低排列，h指数是满足"第h篇论文引用≥h"的最大值';
    problems.push(hIndex);

    // 2026
    const rangeSumQuery2DImmutable = new ProblemModel();
    rangeSumQuery2DImmutable.id = 2026;
    rangeSumQuery2DImmutable.title = '二维区域和检索 - Immutable';
    rangeSumQuery2DImmutable.description = '给定一个二维矩阵 matrix，以下类型的多个请求：计算其子矩形范围内元素的总和，该子矩阵的 左上角 为 (row1, col1) ，右下角 为 (row2, col2) 。实现 NumMatrix 类：NumMatrix(int[][] matrix) 给定整数矩阵 matrix 进行初始化。int sumRegion(int row1, int col1, int row2, int col2) 返回 左上角 (row1, col1) 、右下角 (row2, col2) 所描述的子矩阵的元素 总和 。';
    rangeSumQuery2DImmutable.difficulty = ProblemDifficulty.MEDIUM;
    rangeSumQuery2DImmutable.category = ProblemCategory.PREFIX_SUM;
    rangeSumQuery2DImmutable.choices = [
      { id: 'A', text: '二维前缀和：预处理前缀和矩阵，用容斥原理计算区域和', isCorrect: true },
      { id: 'B', text: '逐行前缀和：每行计算前缀和，查询时逐行累加', isCorrect: false },
      { id: 'C', text: '暴力法：每次查询遍历子矩阵计算和', isCorrect: false },
      { id: 'D', text: '哈希表：存储所有可能子矩阵的和', isCorrect: false }
    ];
    rangeSumQuery2DImmutable.explanation = '二维前缀和解法：①前缀和矩阵prefix[i][j]表示(0,0)到(i-1,j-1)的和；②prefix[i][j] = matrix[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]；③查询时sum = prefix[row2+1][col2+1] - prefix[row1][col2+1] - prefix[row2+1][col1] + prefix[row1][col1]。初始化O(mn)，查询O(1)。';
    rangeSumQuery2DImmutable.hint = '二维前缀和通过容斥原理消除重叠区域的重复计算，实现快速查询';
    problems.push(rangeSumQuery2DImmutable);

    // 2027
    const findTheLongestSubstring = new ProblemModel();
    findTheLongestSubstring.id = 2027;
    findTheLongestSubstring.title = '每个元音包含偶数次的最长子字符串';
    findTheLongestSubstring.description = '给你一个字符串 s ，请你返回满足以下条件的最长子字符串的长度：每个元音字母（a, e, i, o, u）在子字符串中都恰好出现了偶数次。';
    findTheLongestSubstring.difficulty = ProblemDifficulty.MEDIUM;
    findTheLongestSubstring.category = ProblemCategory.PREFIX_SUM;
    findTheLongestSubstring.choices = [
      { id: 'A', text: '前缀异或+哈希表：用二进制记录元音奇偶状态，相同状态的最大间距为结果', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子串统计元音次数', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个位置的元音状态', isCorrect: false },
      { id: 'D', text: '滑动窗口：维护元音偶数次的窗口', isCorrect: false }
    ];
    findTheLongestSubstring.explanation = '前缀异或解法：①用5位二进制mask表示元音a/e/i/o/u的奇偶（0偶数，1奇数）；②map记录mask首次出现的索引，初始{0: -1}；③遍历字符，更新mask；④若mask已存在，计算当前索引-首次索引，更新最大长度；否则记录首次索引。时间O(n)，空间O(1)（mask最多32种）。';
    findTheLongestSubstring.hint = '元音的奇偶状态可压缩为二进制掩码，相同掩码的前缀意味着中间子串元音均为偶数次';
    problems.push(findTheLongestSubstring);

    // 2028
    const pivotIndex = new ProblemModel();
    pivotIndex.id = 2028;
    pivotIndex.title = '寻找数组的中心索引 II';
    pivotIndex.description = '给你一个整数数组 nums ，请计算数组的 中心下标 。数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。（进阶：数组可能包含负数）';
    pivotIndex.difficulty = ProblemDifficulty.EASY;
    pivotIndex.category = ProblemCategory.PREFIX_SUM;
    pivotIndex.choices = [
      { id: 'A', text: '前缀和：计算总 sum，遍历中左侧和 leftSum，右侧和为 sum - leftSum - nums[i]', isCorrect: true },
      { id: 'B', text: '双指针：从两端向中间移动，调整左右和（不适用于负数）', isCorrect: false },
      { id: 'C', text: '暴力法：对每个下标计算左右和', isCorrect: false },
      { id: 'D', text: '动态规划：记录左右和数组', isCorrect: false }
    ];
    pivotIndex.explanation = '前缀和解法：①计算数组总和 total；②遍历数组，leftSum 累加左侧元素和；③右侧和 = total - leftSum - nums[i]，若 leftSum == 右侧和，返回当前索引；④遍历结束返回-1。时间O(n)，空间O(1)。';
    pivotIndex.hint = '即使包含负数，前缀和方法依然适用，核心是用总 sum 快速计算右侧和';
    problems.push(pivotIndex);

    // 2029
    const subarraySumsDivisibleByK = new ProblemModel();
    subarraySumsDivisibleByK.id = 2029;
    subarraySumsDivisibleByK.title = '和可被 K 整除的子数组';
    subarraySumsDivisibleByK.description = '给定一个整数数组 A 和一个整数 K，返回其中元素之和可被 K 整除的（连续、非空）子数组的数目。';
    subarraySumsDivisibleByK.difficulty = ProblemDifficulty.MEDIUM;
    subarraySumsDivisibleByK.category = ProblemCategory.PREFIX_SUM;
    subarraySumsDivisibleByK.choices = [
      { id: 'A', text: '前缀和+哈希表：记录前缀和余数出现次数，相同余数的组合数为C(n,2)', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算和', isCorrect: false },
      { id: 'C', text: '滑动窗口：仅适用于非负数场景', isCorrect: false },
      { id: 'D', text: '动态规划：记录每个位置的余数', isCorrect: false }
    ];
    subarraySumsDivisibleByK.explanation = '前缀和余数解法：①计算前缀和mod K（处理负余数：(sum % K + K) % K）；②map记录余数出现次数，初始{0: 1}；③遍历中，count += map[remainder]，再更新map[remainder]++。时间O(n)，空间O(K)。';
    subarraySumsDivisibleByK.hint = '若两个前缀和的余数相同，则它们的差可被K整除，利用组合数计算子数组数量';
    problems.push(subarraySumsDivisibleByK);

    // 2030
    const checkSubarraySum = new ProblemModel();
    checkSubarraySum.id = 2030;
    checkSubarraySum.title = '连续的子数组和';
    checkSubarraySum.description = '给你一个整数数组 nums 和一个整数 k ，编写一个函数来判断该数组是否含有同时满足下述条件的连续子数组：子数组长度 至少为 2 ，且子数组元素总和为 k 的倍数。如果存在，返回 true ；否则，返回 false 。';
    checkSubarraySum.difficulty = ProblemDifficulty.MEDIUM;
    checkSubarraySum.category = ProblemCategory.PREFIX_SUM;
    checkSubarraySum.choices = [
      { id: 'A', text: '前缀和+哈希表：记录余数首次出现索引，若相同余数索引差≥2则返回true', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有长度≥2的子数组', isCorrect: false },
      { id: 'C', text: '滑动窗口：不适用于含负数和k=0的情况', isCorrect: false },
      { id: 'D', text: '动态规划：记录子数组和', isCorrect: false }
    ];
    checkSubarraySum.explanation = '前缀和余数解法：①计算前缀和mod k（k=0时特殊处理）；②map记录余数首次出现的索引，初始{0: -1}；③遍历中，若余数已存在且当前索引-首次索引≥2，返回true；否则记录首次索引。时间O(n)，空间O(min(n,k))。';
    checkSubarraySum.hint = '关键是判断是否存在两个前缀和余数相同且索引差≥2，需特别处理k=0的情况';
    problems.push(checkSubarraySum);

    // 2032
    const sumOfSubarrayMinimums = new ProblemModel();
    sumOfSubarrayMinimums.id = 2032;
    sumOfSubarrayMinimums.title = '子数组的最小值之和';
    sumOfSubarrayMinimums.description = '给定一个整数数组 arr，找到子数组中每个元素作为最小值的总和。一个子数组定义为原数组中的一个连续子序列。请你返回这个总和。由于答案可能很大，所以请返回 10^9 + 7 的模。';
    sumOfSubarrayMinimums.difficulty = ProblemDifficulty.MEDIUM;
    sumOfSubarrayMinimums.category = ProblemCategory.PREFIX_SUM;
    sumOfSubarrayMinimums.choices = [
      { id: 'A', text: '单调栈+前缀和：找到每个元素作为最小值的左右边界，计算贡献', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组找最小值并累加', isCorrect: false },
      { id: 'C', text: '动态规划：dp[i]表示以i结尾的子数组最小值之和', isCorrect: false },
      { id: 'D', text: '前缀和：直接计算子数组和的最小值', isCorrect: false }
    ];
    sumOfSubarrayMinimums.explanation = '单调栈解法：①用单调栈找到每个元素左侧第一个更小元素left[i]和右侧第一个更小或等于元素right[i]；②元素arr[i]的贡献为arr[i] * (i - left[i]) * (right[i] - i)；③累加所有贡献。时间O(n)，空间O(n)。';
    sumOfSubarrayMinimums.hint = '每个元素的贡献取决于它能作为最小值的子数组数量，通过单调栈高效找到边界';
    problems.push(sumOfSubarrayMinimums);

    // 2033
    const countRangeSum = new ProblemModel();
    countRangeSum.id = 2033;
    countRangeSum.title = '区间和的个数';
    countRangeSum.description = '给你一个整数数组 nums 以及两个整数 lower 和 upper 。求数组中，值位于范围 [lower, upper] （包含 lower 和 upper）之内的 区间和的个数 。区间和 S(i, j) 表示在 nums 中，位置从 i 到 j 的元素之和，包含 i 和 j (i ≤ j)。';
    countRangeSum.difficulty = ProblemDifficulty.HARD;
    countRangeSum.category = ProblemCategory.PREFIX_SUM;
    countRangeSum.choices = [
      { id: 'A', text: '前缀和+归并排序：在归并过程中统计符合条件的前缀和对', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算和', isCorrect: false },
      { id: 'C', text: '前缀和+有序集合：查询[sum-upper, sum-lower]的数量', isCorrect: false },
      { id: 'D', text: '动态规划：记录区间和的数量', isCorrect: false }
    ];
    countRangeSum.explanation = '归并排序解法：①计算前缀和数组；②在归并排序过程中，对右半部分每个sum[j]，在左半部分找满足sum[j]-upper ≤ sum[i] ≤ sum[j]-lower的i的数量；③累加计数并完成排序。时间O(n log n)，空间O(n)。';
    countRangeSum.hint = '利用归并排序的分治思想，在排序过程中高效统计符合条件的前缀和对，避免O(n²)时间';
    problems.push(countRangeSum);


    // 3030
    const numSubarrayProductLessThanK = new ProblemModel();
    numSubarrayProductLessThanK.id = 3030;
    numSubarrayProductLessThanK.title = '乘积小于K的子数组';
    numSubarrayProductLessThanK.description = '给你一个整数数组 nums 和一个整数 k ，请你返回子数组内所有元素的乘积严格小于 k 的连续子数组的数目。';
    numSubarrayProductLessThanK.difficulty = ProblemDifficulty.MEDIUM;
    numSubarrayProductLessThanK.category = ProblemCategory.SLIDING_WINDOW;
    numSubarrayProductLessThanK.choices = [
      { id: 'A', text: '滑动窗口：维护乘积小于k的窗口，右移时累加窗口长度到结果', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有子数组计算乘积', isCorrect: false },
      { id: 'C', text: '前缀积：乘积可能溢出且无法直接相除', isCorrect: false },
      { id: 'D', text: '动态规划：记录以i结尾的子数组乘积', isCorrect: false }
    ];
    numSubarrayProductLessThanK.explanation = '滑动窗口解法：①若k≤1，返回0；②left=0，product=1，count=0；③遍历right：product *= nums[right]；④当product≥k时，product /= nums[left]，left++；⑤count += right - left + 1（新增的以right结尾的子数组）。时间O(n)，空间O(1)。';
    numSubarrayProductLessThanK.hint = '窗口内所有子数组的乘积都小于k，右移时新增的子数组数量等于窗口长度';
    problems.push(numSubarrayProductLessThanK);


    // 3032
    const minOperations = new ProblemModel();
    minOperations.id = 3032;
    minOperations.title = '最少交换次数来组合所有的1 II';
    minOperations.description = '交换 定义为选中一个数组中的两个 不同 位置并交换二者的值。环形 数组是一个数组，可以认为 第一个 元素和 最后一个 元素 相邻 。给你一个 二进制环形 数组 nums ，返回在 任意位置 将数组中的所有 1 聚集在一起需要的最少交换次数。';
    minOperations.id = 3032;
    minOperations.difficulty = ProblemDifficulty.HARD;
    minOperations.category = ProblemCategory.SLIDING_WINDOW;
    minOperations.choices = [
      { id: 'A', text: '滑动窗口：将环形转为线性（双倍长度），找含最多1的窗口，交换次数=总1数-窗口1数', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有可能的聚集位置', isCorrect: false },
      { id: 'C', text: '前缀和：计算环形数组中1的分布', isCorrect: false },
      { id: 'D', text: '动态规划：记录不同位置的交换次数', isCorrect: false }
    ];
    minOperations.explanation = '滑动窗口解法：①计算总1数totalOnes，若为0返回0；②将nums复制一份拼接（处理环形）；③滑动窗口大小为totalOnes，计算窗口内1的最大数maxOnes；④最少交换次数=totalOnes - maxOnes。时间O(n)，空间O(n)。';
    minOperations.hint = '环形数组可通过双倍长度转为线性问题，核心是找到包含最多1的窗口以减少交换次数';
    problems.push(minOperations);

    // 3033
    const maxSatisfiedII = new ProblemModel();
    maxSatisfiedII.id = 3033;
    maxSatisfiedII.title = '爱生气的书店老板 II';
    maxSatisfiedII.description = '有一个书店老板，他的书店开了 n 分钟。每分钟都有一些顾客进入这家商店。给定一个数组 customers ，其中 customers[i] 是在第 i 分钟开始时进入商店的顾客数量，所有这些顾客在第 i 分钟结束后离开。在某些分钟内，书店老板会生气。如果书店老板在第 i 分钟生气，那么那一分钟的顾客就会不满意，否则他们就会满意。给定一个数组 grumpy ，其中 grumpy[i] 是 1 表示书店老板在第 i 分钟生气，0 表示不生气。书店老板知道一个秘密技巧，能让自己连续 m 分钟不生气，但可以使用 多次 （可重叠）。请你返回这一天营业下来，最多有多少顾客能够感到满意。';
    maxSatisfiedII.difficulty = ProblemDifficulty.MEDIUM;
    maxSatisfiedII.category = ProblemCategory.SLIDING_WINDOW;
    maxSatisfiedII.choices = [
      { id: 'A', text: '滑动窗口：计算基础满意数，再找所有m分钟窗口的额外满意数之和（可重叠）', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有可能的m分钟窗口组合', isCorrect: false },
      { id: 'C', text: '前缀和：计算每个窗口的额外满意数', isCorrect: false },
      { id: 'D', text: '动态规划：记录使用技巧次数的最大满意数', isCorrect: false }
    ];
    maxSatisfiedII.explanation = '滑动窗口解法：①计算基础满意数（grumpy[i]=0时的customers[i]）；②计算每个m分钟窗口的额外满意数（grumpy[i]=1时的customers[i]）；③由于可多次使用，累加所有窗口的额外满意数（注意重叠部分不重复计算）；④总满意数=基础满意数+累加的额外满意数。时间O(n)，空间O(1)。';
    maxSatisfiedII.hint = '多次使用技巧时，重叠窗口的额外满意数只需计算一次，本质是收集所有生气时的顾客';
    problems.push(maxSatisfiedII);

    // 3034
    const characterReplacementII = new ProblemModel();
    characterReplacementII.id = 3034;
    characterReplacementII.title = '替换后的最长重复字符 II';
    characterReplacementII.description = '给你一个字符串 s 和一个整数 k 。你可以选择字符串中的任一字符，并将其更改为任何其他大写英文字符。该操作最多可执行 任意次 ，但每次操作后必须保证替换后的子串是 连续的 。返回包含相同字母的最长子串的长度。';
    characterReplacementII.difficulty = ProblemDifficulty.MEDIUM;
    characterReplacementII.category = ProblemCategory.SLIDING_WINDOW;
    characterReplacementII.choices = [
      { id: 'A', text: '滑动窗口+字符计数：与原版相同，允许任意次替换时窗口可无限扩展（返回字符串长度）', isCorrect: true },
      { id: 'B', text: '暴力法：枚举每个字符和替换次数', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个位置的最大可能长度', isCorrect: false },
      { id: 'D', text: '前缀和：统计每个字符的前缀出现次数', isCorrect: false }
    ];
    characterReplacementII.explanation = '特殊情况处理：①当k≥s.length时，可将所有字符替换为同一字符，返回s.length；②否则与原版解法相同：维护窗口内出现最多的字符数，窗口长度- maxCount ≤k时扩展，否则收缩。时间O(n)，空间O(1)。';
    characterReplacementII.hint = '当允许任意次替换时，最长子串即为字符串本身长度，需特殊处理此边界条件';
    problems.push(characterReplacementII);

    // 6. 不同的二叉搜索树 II
    const generateTrees = new ProblemModel();
    generateTrees.id = 1006;
    generateTrees.title = '不同的二叉搜索树 II';
    generateTrees.description = '给你一个整数 n ，请你生成并返回所有由 n 个节点组成且节点值从 1 到 n 互不相同的不同 二叉搜索树 。可以按 任意顺序 返回答案。';
    generateTrees.difficulty = ProblemDifficulty.MEDIUM;
    generateTrees.category = ProblemCategory.DIVIDE_CONQUER;
    generateTrees.choices = [
      { id: 'A', text: '分治：以i为根，递归生成左子树（1~i-1）和右子树（i+1~n），组合所有可能', isCorrect: true },
      { id: 'B', text: '动态规划：记录n-1的结果推导n的结果', isCorrect: false },
      { id: 'C', text: '回溯法：尝试所有节点组合', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有可能结构', isCorrect: false }
    ];
    generateTrees.explanation = '分治解法：①若n=0，返回空列表；②定义递归函数生成[start, end]的所有BST；③遍历i从start到end，作为根节点；④递归生成左子树[start, i-1]和右子树[i+1, end]；⑤组合根节点与所有左右子树的可能配对。时间O(4^n / n^(1/2))（卡特兰数），空间O(4^n / n^(1/2))。';
    generateTrees.hint = '利用BST的性质（左小右大），通过根节点分割左右子树区间，递归组合所有可能';
    problems.push(generateTrees);


    // 10. 为运算表达式设计优先级
    const diffWaysToCompute = new ProblemModel();
    diffWaysToCompute.id = 1010;
    diffWaysToCompute.title = '为运算表达式设计优先级';
    diffWaysToCompute.description = '给你一个由数字和运算符组成的字符串 expression ，按不同优先级组合数字和运算符，计算并返回所有可能的结果。你可以 按任意顺序 返回答案。';
    diffWaysToCompute.difficulty = ProblemDifficulty.MEDIUM;
    diffWaysToCompute.category = ProblemCategory.DIVIDE_CONQUER;
    diffWaysToCompute.choices = [
      { id: 'A', text: '分治：以每个运算符为分割点，递归计算左右表达式结果，再组合运算', isCorrect: true },
      { id: 'B', text: '动态规划：记录子表达式的所有可能结果', isCorrect: false },
      { id: 'C', text: '栈：模拟运算优先级', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有括号组合', isCorrect: false }
    ];
    diffWaysToCompute.explanation = '分治解法：①若表达式为纯数字，返回该数字；②遍历表达式，遇运算符则分割为左右子表达式；③递归计算左右子表达式的所有可能结果；④对左右结果的每个组合应用当前运算符，收集所有结果。时间O(2^n)，空间O(2^n)。';
    diffWaysToCompute.hint = '每个运算符都可以作为最后一步运算，通过递归分解问题并组合结果';
    problems.push(diffWaysToCompute);

    // 13. 给表达式添加括号
    const generateParenthesisDivide = new ProblemModel();
    generateParenthesisDivide.id = 1013;
    generateParenthesisDivide.title = '给表达式添加括号';
    generateParenthesisDivide.description = '数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。';
    generateParenthesisDivide.difficulty = ProblemDifficulty.MEDIUM;
    generateParenthesisDivide.category = ProblemCategory.DIVIDE_CONQUER;
    generateParenthesisDivide.choices = [
      { id: 'A', text: '分治：有效括号组合可表示为"(A)B"，其中A和B为有效组合（可能为空）', isCorrect: true },
      { id: 'B', text: '回溯：递归过程中保证左括号数≥右括号数', isCorrect: false },
      { id: 'C', text: '动态规划：dp[n]基于dp[0..n-1]组合生成', isCorrect: false },
      { id: 'D', text: '暴力法：生成所有可能再筛选有效组合', isCorrect: false }
    ];
    generateParenthesisDivide.explanation = '分治解法：①基线条件：n=0返回[""]；②对每个i从0到n-1，递归生成A=dp[i]和B=dp[n-1-i]；③组合所有"(a)b"形式（a∈A，b∈B）。时间O(4^n / n^(1/2))，空间O(4^n / n^(1/2))。';
    generateParenthesisDivide.hint = '将问题分解为子问题，利用有效括号的结构递归构建所有可能组合';
    problems.push(generateParenthesisDivide);

    // 14. 区间子数组个数
    const numSubarrayBoundedMax = new ProblemModel();
    numSubarrayBoundedMax.id = 1014;
    numSubarrayBoundedMax.title = '区间子数组个数';
    numSubarrayBoundedMax.description = '给你一个整数数组 nums 和两个整数 left 和 right 。找出 nums 中连续、非空且其中最大元素在范围 [left, right] 内的子数组数目。';
    numSubarrayBoundedMax.difficulty = ProblemDifficulty.MEDIUM;
    numSubarrayBoundedMax.category = ProblemCategory.DIVIDE_CONQUER;
    numSubarrayBoundedMax.choices = [
      { id: 'A', text: '分治：找到数组最大值位置，分左右子数组计算，再处理跨区间的有效子数组', isCorrect: true },
      { id: 'B', text: '动态规划：记录以i结尾的有效子数组数', isCorrect: false },
      { id: 'C', text: '暴力法：枚举所有子数组并检查最大值', isCorrect: false },
      { id: 'D', text: '滑动窗口：维护最大值在区间内的窗口', isCorrect: false }
    ];
    numSubarrayBoundedMax.explanation = '分治解法：①若数组为空，返回0；②找到数组最大值位置mid；③若最大值<left，返回左右子数组结果之和；④若最大值>right，返回左右子数组结果之和；⑤否则返回左结果+右结果+左长度*右长度+1（跨区间的子数组）。时间O(n log n)，空间O(log n)。';
    numSubarrayBoundedMax.hint = '通过最大值位置分割数组，根据最大值与区间的关系决定是否计入跨区间子数组';
    problems.push(numSubarrayBoundedMax);

    // 15. 最大二叉树
    const constructMaximumBinaryTree = new ProblemModel();
    constructMaximumBinaryTree.id = 1015;
    constructMaximumBinaryTree.title = '最大二叉树';
    constructMaximumBinaryTree.description = '给定一个不重复的整数数组 nums 。 最大二叉树 可以用下面的算法从 nums 递归地构建:创建一个根节点，其值为 nums 中的最大值。递归地在最大值 左边 的 子数组前缀上 构建左子树。递归地在最大值 右边 的 子数组后缀上 构建右子树。返回 nums 构建的 最大二叉树 。';
    constructMaximumBinaryTree.difficulty = ProblemDifficulty.MEDIUM;
    constructMaximumBinaryTree.category = ProblemCategory.DIVIDE_CONQUER;
    constructMaximumBinaryTree.choices = [
      { id: 'A', text: '分治：找到数组最大值作为根，递归构建左右子树', isCorrect: true },
      { id: 'B', text: '栈：单调栈寻找每个元素的左右边界', isCorrect: false },
      { id: 'C', text: '暴力法：每次扫描找最大值', isCorrect: false },
      { id: 'D', text: '动态规划：记录子数组的最大值位置', isCorrect: false }
    ];
    constructMaximumBinaryTree.explanation = '分治解法：①若数组为空，返回null；②找到数组最大值及其索引maxIdx；③创建根节点，值为最大值；④递归构建左子树（nums[0..maxIdx-1]）和右子树（nums[maxIdx+1..end]）；⑤返回根节点。时间O(n²)（最坏情况），空间O(n)。';
    constructMaximumBinaryTree.hint = '直接按照题目描述的递归构建方法实现，利用分治思想将数组分割为左右子区间';
    problems.push(constructMaximumBinaryTree);


    // 18. 计算右侧小于当前元素的个数
    const countSmaller = new ProblemModel();
    countSmaller.id = 1018;
    countSmaller.title = '计算右侧小于当前元素的个数';
    countSmaller.description = '给你一个整数数组 nums ，按要求返回一个新数组 counts 。数组 counts 有该性质： counts[i] 的值是 nums[i] 右侧小于 nums[i] 的元素的数量。';
    countSmaller.difficulty = ProblemDifficulty.HARD;
    countSmaller.category = ProblemCategory.DIVIDE_CONQUER;
    countSmaller.choices = [
      { id: 'A', text: '分治（归并排序）：合并时统计右侧小于左侧元素的数量', isCorrect: true },
      { id: 'B', text: 'Fenwick树：通过坐标压缩和前缀和统计', isCorrect: false },
      { id: 'C', text: '暴力法：对每个元素遍历右侧计数', isCorrect: false },
      { id: 'D', text: '二叉搜索树：插入时统计小于当前值的节点数', isCorrect: false }
    ];
    countSmaller.explanation = '归并解法：①将数组元素与索引绑定；②归并排序过程中，当右元素<左元素时，累加右数组剩余元素数到左元素的计数；③合并有序数组；④最终按原索引返回计数。时间O(n log n)，空间O(n)。';
    countSmaller.hint = '利用归并排序的合并阶段，高效统计右侧较小元素的数量，避免重复比较';
    problems.push(countSmaller);

    // 2. 2的幂
    const isPowerOfTwo = new ProblemModel();
    isPowerOfTwo.id = 2002;
    isPowerOfTwo.title = '2的幂';
    isPowerOfTwo.description = '给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true ；否则，返回 false 。如果存在一个整数 x 使得 n == 2^x ，则认为 n 是 2 的幂次方。';
    isPowerOfTwo.difficulty = ProblemDifficulty.EASY;
    isPowerOfTwo.category = ProblemCategory.BIT_MANIPULATION;
    isPowerOfTwo.choices = [
      { id: 'A', text: '位运算：n > 0 且 n & (n-1) == 0（二进制只有一个1）', isCorrect: true },
      { id: 'B', text: '循环除法：反复除以2，检查是否有余数', isCorrect: false },
      { id: 'C', text: '数学对数：计算log2(n)是否为整数', isCorrect: false },
      { id: 'D', text: '查表法：预存2的幂值', isCorrect: false }
    ];
    isPowerOfTwo.explanation = '位运算解法：①若n≤0，返回false；②检查n & (n-1)是否为0。2的幂的二进制表示只有一个1，n-1则全为1，与运算结果为0。时间O(1)，空间O(1)。';
    isPowerOfTwo.hint = '2的幂在二进制中具有唯一的1，利用此特性通过一次位运算即可判断';
    problems.push(isPowerOfTwo);

    // 3. 两整数之和
    const getSum = new ProblemModel();
    getSum.id = 2003;
    getSum.title = '两整数之和';
    getSum.description = '给你两个整数 a 和 b ，不使用 运算符 + 和 -，计算并返回两整数之和。';
    getSum.difficulty = ProblemDifficulty.MEDIUM;
    getSum.category = ProblemCategory.BIT_MANIPULATION;
    getSum.choices = [
      { id: 'A', text: '位运算：异或求无进位和，与运算左移求进位，递归直到无进位', isCorrect: true },
      { id: 'B', text: '库函数：使用Math.add()（实际不存在）', isCorrect: false },
      { id: 'C', text: '自增自减：循环累加', isCorrect: false },
      { id: 'D', text: '字符串转换：模拟加法运算', isCorrect: false }
    ];
    getSum.explanation = '位运算解法：①a ^ b 得到无进位的和；②(a & b) << 1 得到进位；③递归计算无进位和与进位的和，直到进位为0。时间O(log(max(a,b)))，空间O(log(max(a,b)))。';
    getSum.hint = '将加法分解为无进位相加和进位两部分，通过位运算分别计算并组合';
    problems.push(getSum);

    // 4. 只出现一次的数字
    const singleNumber = new ProblemModel();
    singleNumber.id = 2004;
    singleNumber.title = '只出现一次的数字';
    singleNumber.description = '给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。说明：你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？';
    singleNumber.difficulty = ProblemDifficulty.EASY;
    singleNumber.category = ProblemCategory.BIT_MANIPULATION;
    singleNumber.choices = [
      { id: 'A', text: '异或运算：x ^ x = 0，x ^ 0 = x，所有元素异或结果即为目标', isCorrect: true },
      { id: 'B', text: '哈希表：统计出现次数', isCorrect: false },
      { id: 'C', text: '排序：遍历找单独的元素', isCorrect: false },
      { id: 'D', text: '数学公式：2*(a+b+c) - (a+a+b+b+c) = c', isCorrect: false }
    ];
    singleNumber.explanation = '异或解法：①初始化result=0；②遍历数组，result ^= num；③返回result。异或满足交换律和结合律，成对元素抵消，剩余即为单独元素。时间O(n)，空间O(1)。';
    singleNumber.hint = '利用异或的特性（自反性和恒等性），无需额外空间即可找到唯一出现一次的元素';
    problems.push(singleNumber);

    // 5. 数字范围按位与
    const rangeBitwiseAnd = new ProblemModel();
    rangeBitwiseAnd.id = 2005;
    rangeBitwiseAnd.title = '数字范围按位与';
    rangeBitwiseAnd.description = '给你两个整数 left 和 right ，表示区间 [left, right] ，返回此区间内所有数字 按位与 的结果（包含 left 和 right 端点）。';
    rangeBitwiseAnd.difficulty = ProblemDifficulty.MEDIUM;
    rangeBitwiseAnd.category = ProblemCategory.BIT_MANIPULATION;
    rangeBitwiseAnd.choices = [
      { id: 'A', text: '位运算：找到left和right的公共前缀，其余位补0', isCorrect: true },
      { id: 'B', text: '暴力法：遍历区间所有数字依次按位与', isCorrect: false },
      { id: 'C', text: '数学公式：计算区间内所有数字的与', isCorrect: false },
      { id: 'D', text: '动态规划：记录每个位的状态', isCorrect: false }
    ];
    rangeBitwiseAnd.explanation = '公共前缀解法：①当left < right时，移除right的最后一位（right &= right-1）；②重复直到left == right，此时的值即为公共前缀；③返回该值。时间O(log n)，空间O(1)。';
    rangeBitwiseAnd.hint = '区间内数字按位与的结果是所有数字的公共前缀，通过右移消除不同的低位';
    problems.push(rangeBitwiseAnd);

    // 6. 颠倒二进制位
    const reverseBits = new ProblemModel();
    reverseBits.id = 2006;
    reverseBits.title = '颠倒二进制位';
    reverseBits.description = '颠倒给定的 32 位无符号整数的二进制位。';
    reverseBits.difficulty = ProblemDifficulty.EASY;
    reverseBits.category = ProblemCategory.BIT_MANIPULATION;
    reverseBits.choices = [
      { id: 'A', text: '位运算：循环取出n的最低位，拼接到结果的最高位', isCorrect: true },
      { id: 'B', text: '转为字符串：反转后转为整数', isCorrect: false },
      { id: 'C', text: '查表法：预计算8位反转结果，分4段处理', isCorrect: false },
      { id: 'D', text: '数学公式：计算反转后的数值', isCorrect: false }
    ];
    reverseBits.explanation = '位运算解法：①初始化result=0；②循环32次：result <<= 1（腾出低位），result |= n & 1（取n的最低位），n >>= 1；③返回result。时间O(1)，空间O(1)。';
    reverseBits.hint = '通过循环逐位处理，将原数字的低位依次移到结果的高位';
    problems.push(reverseBits);

    // 7. 只出现一次的数字 II
    const singleNumberII = new ProblemModel();
    singleNumberII.id = 2007;
    singleNumberII.title = '只出现一次的数字 II';
    singleNumberII.description = '给你一个整数数组 nums ，除某个元素仅出现 一次 外，其余每个元素都恰出现 三次 。请你找出并返回那个只出现了一次的元素。';
    singleNumberII.difficulty = ProblemDifficulty.MEDIUM;
    singleNumberII.category = ProblemCategory.BIT_MANIPULATION;
    singleNumberII.choices = [
      { id: 'A', text: '位运算：统计每个位出现的次数，模3后剩余的位组成目标数字', isCorrect: true },
      { id: 'B', text: '哈希表：统计出现次数', isCorrect: false },
      { id: 'C', text: '排序：遍历找单独的元素', isCorrect: false },
      { id: 'D', text: '数学公式：(3*(a+b+c) - (a+a+a+b+b+b+c)) / 2 = c', isCorrect: false }
    ];
    singleNumberII.explanation = '位统计解法：①初始化result=0；②对每个位（0-31）：统计数组中该位为1的次数；③若次数模3为1，将该位设为1（result |= 1 << i）；④返回result。时间O(n)，空间O(1)。';
    singleNumberII.hint = '每个位出现的总次数若为3的倍数则目标数字该位为0，否则为1';
    problems.push(singleNumberII);

    // 9. 子集
    const subsetsBit = new ProblemModel();
    subsetsBit.id = 2009;
    subsetsBit.title = '子集';
    subsetsBit.description = '给你一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集）。解集 不能 包含重复的子集。你可以按 任意顺序 返回答案。';
    subsetsBit.difficulty = ProblemDifficulty.MEDIUM;
    subsetsBit.category = ProblemCategory.BIT_MANIPULATION;
    subsetsBit.choices = [
      { id: 'A', text: '位运算：每个子集对应一个二进制数，位为1表示包含对应元素', isCorrect: true },
      { id: 'B', text: '回溯法：递归选择或不选择每个元素', isCorrect: false },
      { id: 'C', text: '动态规划：从空集开始，逐步添加元素生成新子集', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有可能组合', isCorrect: false }
    ];
    subsetsBit.explanation = '位运算解法：①n = nums.length，子集总数为2^n；②对每个mask从0到2^n-1：遍历bit位，若第i位为1则包含nums[i]；③收集所有子集。时间O(n*2^n)，空间O(n)。';
    subsetsBit.hint = '每个元素的存在与否可用二进制位表示，通过遍历所有可能的位组合生成子集';
    problems.push(subsetsBit);

    // 10. 格雷编码
    const grayCode = new ProblemModel();
    grayCode.id = 2010;
    grayCode.title = '格雷编码';
    grayCode.description = 'n 位格雷码序列 是一个由 2^n 个整数组成的序列，其中：每个整数都在范围 [0, 2^n - 1] 内（含 0 和 2^n - 1）。第一个整数是 0。一个整数在序列中出现 不超过一次 。每对 相邻 整数的二进制表示 恰好一位不同 。 第一个 和 最后一个 整数的二进制表示 恰好一位不同 。给你一个整数 n ，返回任一有效的 n 位格雷码序列 。';
    grayCode.difficulty = ProblemDifficulty.MEDIUM;
    grayCode.category = ProblemCategory.BIT_MANIPULATION;
    grayCode.choices = [
      { id: 'A', text: '位运算：i ^ (i >> 1) 生成第i个格雷码', isCorrect: true },
      { id: 'B', text: '递归：n+1的格雷码基于n的结果生成', isCorrect: false },
      { id: 'C', text: '回溯：尝试生成满足条件的序列', isCorrect: false },
      { id: 'D', text: '数学公式：转换二进制为格雷码', isCorrect: false }
    ];
    grayCode.explanation = '位运算解法：①初始化结果数组；②对i从0到2^n - 1：计算i ^ (i >> 1)，加入结果；③返回结果。该公式确保相邻格雷码只有一位不同。时间O(2^n)，空间O(2^n)。';
    grayCode.hint = '利用格雷码的生成公式，通过简单的位运算即可直接计算每个位置的格雷码';
    problems.push(grayCode);

    // 11. 缺失的数字
    const missingNumber = new ProblemModel();
    missingNumber.id = 2011;
    missingNumber.title = '缺失的数字';
    missingNumber.description = '给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。';
    missingNumber.difficulty = ProblemDifficulty.EASY;
    missingNumber.category = ProblemCategory.BIT_MANIPULATION;
    missingNumber.choices = [
      { id: 'A', text: '异或运算：将数组元素与0~n异或，结果即为缺失的数字', isCorrect: true },
      { id: 'B', text: '数学公式：n*(n+1)/2 - 数组和', isCorrect: false },
      { id: 'C', text: '哈希表：记录出现的数字，再查找缺失的', isCorrect: false },
      { id: 'D', text: '排序：遍历找不连续的数字', isCorrect: false }
    ];
    missingNumber.explanation = '异或解法：①初始化result = n；②遍历i从0到n-1：result ^= i ^ nums[i]；③返回result。成对的数字异或为0，剩余即为缺失数字。时间O(n)，空间O(1)。';
    missingNumber.hint = '利用异或的性质，将所有存在的数字与其索引异或，最终剩余的就是缺失数字';
    problems.push(missingNumber);

    // 12. 只出现一次的数字 III
    const singleNumberIII = new ProblemModel();
    singleNumberIII.id = 2012;
    singleNumberIII.title = '只出现一次的数字 III';
    singleNumberIII.description = '给定一个整数数组 nums，其中恰好有两个元素只出现一次，其余所有元素均出现两次。 找出只出现一次的那两个元素。你可以按 任意顺序 返回答案。';
    singleNumberIII.difficulty = ProblemDifficulty.MEDIUM;
    singleNumberIII.category = ProblemCategory.BIT_MANIPULATION;
    singleNumberIII.choices = [
      { id: 'A', text: '位运算：先异或所有元素得x，找x中任意为1的位，按该位将数组分为两组，分别异或得结果', isCorrect: true },
      { id: 'B', text: '哈希表：统计出现次数', isCorrect: false },
      { id: 'C', text: '排序：遍历找单独的元素', isCorrect: false },
      { id: 'D', text: '暴力法：逐个检查每个元素是否出现两次', isCorrect: false }
    ];
    singleNumberIII.explanation = '分组异或解法：①所有元素异或得x（两个目标元素的异或）；②找到x中最低位的1（diff = x & -x）；③遍历数组，按num & diff是否为0分为两组；④每组内异或得到一个目标元素。时间O(n)，空间O(1)。';
    singleNumberIII.hint = '通过两个目标元素的异或结果找到区分它们的位，分组后分别求解';
    problems.push(singleNumberIII);

    // 13. 整数替换
    const integerReplacement = new ProblemModel();
    integerReplacement.id = 2013;
    integerReplacement.title = '整数替换';
    integerReplacement.description = '给定一个正整数 n ，你可以做如下操作：如果 n 是偶数，则用 n / 2替换 n 。如果 n 是奇数，则可以用 n + 1或n - 1替换 n 。返回使 n 变为 1 所需的 最小替换次数 。';
    integerReplacement.difficulty = ProblemDifficulty.MEDIUM;
    integerReplacement.category = ProblemCategory.BIT_MANIPULATION;
    integerReplacement.choices = [
      { id: 'A', text: '位运算+贪心：奇数时，若末两位为11则+1（除n=3外），否则-1', isCorrect: true },
      { id: 'B', text: '递归：尝试两种操作取最小值', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个n的最小次数', isCorrect: false },
      { id: 'D', text: '暴力法：BFS寻找最短路径', isCorrect: false }
    ];
    integerReplacement.explanation = '贪心解法：①初始化count=0；②while n>1：若n为奇数，若n=3或(n&2)==0则n--，否则n++，count++；③若n为偶数，n>>=1，count++；④返回count。时间O(log n)，空间O(1)。';
    integerReplacement.hint = '奇数时通过末两位判断最优操作，尽量减少后续步骤的次数';
    problems.push(integerReplacement);

    // 14. 两数相除
    const divide = new ProblemModel();
    divide.id = 2014;
    divide.title = '两数相除';
    divide.description = '给定两个整数，被除数 dividend 和除数 divisor。将两数相除，要求不使用乘法、除法和 mod 运算符。返回被除数 dividend 除以除数 divisor 得到的商。整数除法的结果应当截去（truncate）其小数部分，例如：truncate(8.345) = 8 以及 truncate(-2.7335) = -2。';
    divide.difficulty = ProblemDifficulty.MEDIUM;
    divide.category = ProblemCategory.BIT_MANIPULATION;
    divide.choices = [
      { id: 'A', text: '位运算：通过左移找到最大的倍数，累减计算商', isCorrect: true },
      { id: 'B', text: '暴力法：循环减去除数计数', isCorrect: false },
      { id: 'C', text: '数学公式：使用指数函数转换', isCorrect: false },
      { id: 'D', text: '二分查找：查找最大的商使得除数*商≤被除数', isCorrect: false }
    ];
    divide.explanation = '位运算解法：①处理符号和边界（如溢出）；②将被除数和除数转为正数；③找到最大的shift使得divisor << shift ≤ dividend；④商 += 1 << shift，被除数 -= divisor << shift；⑤重复直到被除数<除数。时间O(log n)，空间O(1)。';
    divide.hint = '利用左移等价于乘以2的特性，快速找到最大可能的倍数，减少减法次数';
    problems.push(divide);

    // 15. 最大单词长度乘积
    const maxProduct = new ProblemModel();
    maxProduct.id = 2015;
    maxProduct.title = '最大单词长度乘积';
    maxProduct.description = '给你一个字符串数组 words ，找出并返回 length(words[i]) * length(words[j]) 的最大值，并且这两个单词不含有公共字母。如果不存在这样的两个单词，返回 0 。';
    maxProduct.difficulty = ProblemDifficulty.MEDIUM;
    maxProduct.category = ProblemCategory.BIT_MANIPULATION;
    maxProduct.choices = [
      { id: 'A', text: '位运算：用二进制表示单词含有的字母，通过与运算判断是否有公共字母', isCorrect: true },
      { id: 'B', text: '哈希表：记录每个单词的字母集合，比较集合交集', isCorrect: false },
      { id: 'C', text: '暴力法：逐个比较单词的字母', isCorrect: false },
      { id: 'D', text: '排序：按长度排序后优先比较长单词', isCorrect: false }
    ];
    maxProduct.explanation = '位运算解法：①预处理每个单词为bitmask（每个字母对应一位）；②遍历所有单词对，若mask[i] & mask[j] == 0，计算长度乘积；③记录最大值。时间O(n² + L)（L为总字符数），空间O(n)。';
    maxProduct.hint = '用26位二进制数表示单词的字母集合，通过与运算快速判断是否有公共字母';
    problems.push(maxProduct);

    // 16. 二进制手表
    const readBinaryWatchBit = new ProblemModel();
    readBinaryWatchBit.id = 2016;
    readBinaryWatchBit.title = '二进制手表';
    readBinaryWatchBit.description = '二进制手表顶部有 4 个 LED 代表 小时（0-11），底部的 6 个 LED 代表 分钟（0-59）。每个 LED 代表一个 0 或 1，最低位在右侧。例如，下面的二进制手表读取 "3:25" 。给你一个整数 turnedOn ，表示当前亮着的 LED 的数量，返回二进制手表可以表示的所有可能时间。你可以 按任意顺序 返回答案。小时不会以零开头：例如，"01:00" 是无效的，正确的写法应该是 "1:00" 。分钟必须由两位数组成，可能会以零开头：例如，"10:2" 是无效的，正确的写法应该是 "10:02" 。';
    readBinaryWatchBit.difficulty = ProblemDifficulty.EASY;
    readBinaryWatchBit.category = ProblemCategory.BIT_MANIPULATION;
    readBinaryWatchBit.choices = [
      { id: 'A', text: '位运算：枚举所有可能的小时和分钟，统计1的总数是否等于turnedOn', isCorrect: true },
      { id: 'B', text: '回溯法：递归选择LED是否点亮', isCorrect: false },
      { id: 'C', text: '暴力法：生成所有可能时间并检查', isCorrect: false },
      { id: 'D', text: '数学公式：计算可能的组合', isCorrect: false }
    ];
    readBinaryWatchBit.explanation = '位运算解法：①遍历小时0-11，分钟0-59；②对每个小时h和分钟m，计算二进制中1的总数；③若总数=turnedOn，格式化时间并加入结果。时间O(1)（范围固定），空间O(1)。';
    readBinaryWatchBit.hint = '利用位运算统计小时和分钟中亮着的LED数量（1的个数），筛选符合条件的时间';
    problems.push(readBinaryWatchBit);

    // 17. 数字的补数
    const findComplement = new ProblemModel();
    findComplement.id = 2017;
    findComplement.title = '数字的补数';
    findComplement.description = '对整数的二进制表示取反（0 变 1 ，1 变 0）后，再转换为十进制表示，可以得到这个整数的补数。例如，整数 5 的二进制表示是 "101" ，取反后得到 "010" ，再转回十进制是 2 ，所以 5 的补数是 2 。给你一个整数 num ，输出它的补数。';
    findComplement.difficulty = ProblemDifficulty.EASY;
    findComplement.category = ProblemCategory.BIT_MANIPULATION;
    findComplement.choices = [
      { id: 'A', text: '位运算：创建与num二进制位数相同的全1掩码，与num异或', isCorrect: true },
      { id: 'B', text: '字符串转换：反转二进制字符串后转为整数', isCorrect: false },
      { id: 'C', text: '数学计算：计算2^n - 1 - num（n为二进制位数）', isCorrect: false },
      { id: 'D', text: '循环：逐位取反', isCorrect: false }
    ];
    findComplement.explanation = '掩码异或解法：①若num=0，返回1；②计算掩码mask=1，直到mask>num；③mask减1得到全1掩码；④返回num ^ mask。时间O(log num)，空间O(1)。';
    findComplement.hint = '通过掩码确保只对有效二进制位取反，避免前导零的影响';
    problems.push(findComplement);

    // 18. 交换数字
    const swapNumbers = new ProblemModel();
    swapNumbers.id = 2018;
    swapNumbers.title = '交换数字';
    swapNumbers.description = '编写一个函数，不用临时变量，直接交换numbers = [a, b]中a与b的值。';
    swapNumbers.difficulty = ProblemDifficulty.EASY;
    swapNumbers.category = ProblemCategory.BIT_MANIPULATION;
    swapNumbers.choices = [
      { id: 'A', text: '位运算：a ^= b; b ^= a; a ^= b;', isCorrect: true },
      { id: 'B', text: '算术运算：a = a + b; b = a - b; a = a - b;', isCorrect: false },
      { id: 'C', text: 'ES6解构：[a, b] = [b, a]', isCorrect: false },
      { id: 'D', text: '数组方法：使用splice交换', isCorrect: false }
    ];
    swapNumbers.explanation = '位运算解法：①a ^= b（a变为a^b）；②b ^= a（b变为b^(a^b)=a）；③a ^= b（a变为(a^b)^a=b）。无需额外变量，且避免算术运算的溢出问题。时间O(1)，空间O(1)。';
    swapNumbers.hint = '利用异或的特性（x^x=0和x^0=x），通过三次异或操作完成交换';
    problems.push(swapNumbers);

    // 19. 翻转数位
    const reverseBitsMax = new ProblemModel();
    reverseBitsMax.id = 2019;
    reverseBitsMax.title = '翻转数位';
    reverseBitsMax.description = '给定一个32位整数 num，你可以将一个数位从0变为1。请编写一个程序，找出你能够获得的最长的一串1的长度。';
    reverseBitsMax.difficulty = ProblemDifficulty.MEDIUM;
    reverseBitsMax.category = ProblemCategory.BIT_MANIPULATION;
    reverseBitsMax.choices = [
      { id: 'A', text: '位运算+滑动窗口：记录前一段1的长度，遇到0时更新当前长度', isCorrect: true },
      { id: 'B', text: '暴力法：尝试翻转每个0后计算最长1', isCorrect: false },
      { id: 'C', text: '动态规划：记录翻转和未翻转状态的最长1', isCorrect: false },
      { id: 'D', text: '字符串：转为二进制字符串后处理', isCorrect: false }
    ];
    reverseBitsMax.explanation = '滑动窗口解法：①prev=0, curr=0, maxLen=0；②遍历32位：若当前位为1，curr++；③若为0，prev = curr, curr=0；④maxLen = max(maxLen, prev + curr + 1)；⑤返回min(maxLen, 32)。时间O(1)，空间O(1)。';
    reverseBitsMax.hint = '通过记录前一段连续1的长度，结合当前段1的长度，计算翻转一个0后的最大长度';
    problems.push(reverseBitsMax);

    // 20. 交替位二进制数
    const hasAlternatingBits = new ProblemModel();
    hasAlternatingBits.id = 2020;
    hasAlternatingBits.title = '交替位二进制数';
    hasAlternatingBits.description = '给定一个正整数，检查它的二进制表示是否总是 0、1 交替出现：换句话说，就是二进制表示中相邻两位的数字永不相同。';
    hasAlternatingBits.difficulty = ProblemDifficulty.EASY;
    hasAlternatingBits.category = ProblemCategory.BIT_MANIPULATION;
    hasAlternatingBits.choices = [
      { id: 'A', text: '位运算：n ^ (n >> 1) 结果应为全1，再检查加1是否为2的幂', isCorrect: true },
      { id: 'B', text: '循环：检查相邻位是否相同', isCorrect: false },
      { id: 'C', text: '字符串：检查相邻字符是否相同', isCorrect: false },
      { id: 'D', text: '数学公式：判断是否符合交替模式', isCorrect: false }
    ];
    hasAlternatingBits.explanation = '位运算解法：①x = n ^ (n >> 1)；②若x & (x + 1) == 0，则返回true；否则false。交替位的数右移后异或原数结果为全1，加1后为2的幂。时间O(1)，空间O(1)。';
    hasAlternatingBits.hint = '交替位的二进制数具有特殊的异或性质，可通过一次位运算判断';
    problems.push(hasAlternatingBits);



    // 3. 子集
    const subsetsBacktrack = new ProblemModel();
    subsetsBacktrack.id = 3003;
    subsetsBacktrack.title = '子集（回溯法）';
    subsetsBacktrack.description = '给你一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集）。解集 不能 包含重复的子集。你可以按 任意顺序 返回答案。';
    subsetsBacktrack.difficulty = ProblemDifficulty.MEDIUM;
    subsetsBacktrack.category = ProblemCategory.BACKTRACKING;
    subsetsBacktrack.choices = [
      { id: 'A', text: '回溯：递归选择或不选择每个元素，通过索引控制顺序避免重复', isCorrect: true },
      { id: 'B', text: '位运算：每个子集对应一个二进制数', isCorrect: false },
      { id: 'C', text: '动态规划：从空集开始逐步添加元素', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有可能', isCorrect: false }
    ];
    subsetsBacktrack.explanation = '回溯解法：①定义递归函数，参数为当前子集和起始索引；②将当前子集加入结果；③从起始索引遍历nums，加入元素到子集，递归（索引+1），再移除元素。时间O(n*2^n)，空间O(n)。';
    subsetsBacktrack.hint = '通过起始索引确保每个元素只被考虑一次，避免生成重复子集';
    problems.push(subsetsBacktrack);

    // 4. N 皇后
    const solveNQueens = new ProblemModel();
    solveNQueens.id = 3004;
    solveNQueens.title = 'N 皇后';
    solveNQueens.description = '按照国际象棋的规则，皇后可以攻击与之处在同一行或同一列或同一斜线上的棋子。n 皇后问题 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。每一种解法包含一个不同的 n 皇后问题 的棋子放置方案，该方案中 \'Q\' 和 \'.\' 分别代表了皇后和空位。';
    solveNQueens.difficulty = ProblemDifficulty.HARD;
    solveNQueens.category = ProblemCategory.BACKTRACKING;
    solveNQueens.choices = [
      { id: 'A', text: '回溯+剪枝：按行放置皇后，记录列、主对角线、副对角线占用情况', isCorrect: true },
      { id: 'B', text: '暴力法：尝试所有放置组合', isCorrect: false },
      { id: 'C', text: '动态规划：记录每行的有效位置', isCorrect: false },
      { id: 'D', text: '数学公式：直接计算位置', isCorrect: false }
    ];
    solveNQueens.explanation = '回溯解法：①用三个集合记录列、主对角线（行-列）、副对角线（行+列）的占用；②递归函数按行放置皇后，对每行尝试所有列；③若列和对角线未占用，标记占用，递归下一行，回溯时解除标记；④生成棋盘格式的结果。时间O(n!)，空间O(n)。';
    solveNQueens.hint = '利用集合快速判断皇后放置是否合法，按行递归减少搜索空间';
    problems.push(solveNQueens);

    // 6. 括号生成
    const generateParenthesisBacktrack = new ProblemModel();
    generateParenthesisBacktrack.id = 3006;
    generateParenthesisBacktrack.title = '括号生成（回溯法）';
    generateParenthesisBacktrack.description = '数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。';
    generateParenthesisBacktrack.difficulty = ProblemDifficulty.MEDIUM;
    generateParenthesisBacktrack.category = ProblemCategory.BACKTRACKING;
    generateParenthesisBacktrack.choices = [
      { id: 'A', text: '回溯+剪枝：记录左右括号数量，左括号数≤n且右括号数≤左括号时继续', isCorrect: true },
      { id: 'B', text: '分治：基于子问题组合生成', isCorrect: false },
      { id: 'C', text: '动态规划：dp[n]基于dp[0..n-1]生成', isCorrect: false },
      { id: 'D', text: '暴力法：生成所有可能再筛选', isCorrect: false }
    ];
    generateParenthesisBacktrack.explanation = '回溯解法：①定义递归函数，参数为当前字符串、左括号数、右括号数；②若长度为2n，加入结果；③若左括号数<n，添加\'(\'并递归；④若右括号数<左括号数，添加\')\'并递归。时间O(4^n / n^(1/2))，空间O(n)。';
    generateParenthesisBacktrack.hint = '通过控制左右括号的数量和顺序，确保生成的括号组合有效，避免无效尝试';
    problems.push(generateParenthesisBacktrack);
    // 11. 复原 IP 地址
    const restoreIpAddresses = new ProblemModel();
    restoreIpAddresses.id = 3011;
    restoreIpAddresses.title = '复原 IP 地址';
    restoreIpAddresses.description = '有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 \'.\' 分隔。例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能的有效 IP 地址，这些地址可以通过在 s 中插入 \'.\' 来形成。你 不能 重新排序或删除 s 中的任何数字。你可以按 任何 顺序返回答案。';
    restoreIpAddresses.difficulty = ProblemDifficulty.MEDIUM;
    restoreIpAddresses.category = ProblemCategory.BACKTRACKING;
    restoreIpAddresses.choices = [
      { id: 'A', text: '回溯+剪枝：递归分割字符串为4段，每段满足IP段规则', isCorrect: true },
      { id: 'B', text: '暴力法：枚举所有可能的分割点', isCorrect: false },
      { id: 'C', text: '动态规划：记录分割为i段的有效方案', isCorrect: false },
      { id: 'D', text: '正则表达式：匹配所有可能的IP格式', isCorrect: false }
    ];
    restoreIpAddresses.explanation = '回溯解法：①定义递归函数，参数为当前IP、起始索引、段数；②若段数=4且起始索引=s长度，加入结果；③否则遍历可能的段长度（1-3），检查是否越界；④截取子串，检查是否为有效IP段（0-255，无前置0）；⑤递归下一段，回溯。时间O(1)（最多27种可能），空间O(1)。';
    restoreIpAddresses.hint = '通过限制每段的长度和内容规则，剪枝掉无效的分割方式';
    problems.push(restoreIpAddresses);

    // 12. 解数独
    const solveSudoku = new ProblemModel();
    solveSudoku.id = 3012;
    solveSudoku.title = '解数独';
    solveSudoku.description = '编写一个程序，通过填充空格来解决数独问题。数独的解法需 遵循如下规则：数字 1-9 在每一行只能出现一次。数字 1-9 在每一列只能出现一次。数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。空白格用 \'.\' 表示。';
    solveSudoku.difficulty = ProblemDifficulty.HARD;
    solveSudoku.category = ProblemCategory.BACKTRACKING;
    solveSudoku.choices = [
      { id: 'A', text: '回溯+优化：记录每行、列、九宫格的可用数字，递归尝试填充', isCorrect: true },
      { id: 'B', text: '暴力法：尝试所有可能数字', isCorrect: false },
      { id: 'C', text: '启发式算法：选择空格最少的行或列优先填充', isCorrect: false },
      { id: 'D', text: '动态规划：记录每个位置的可能数字', isCorrect: false }
    ];
    solveSudoku.explanation = '回溯解法：①用三个二维数组记录行、列、九宫格的数字使用情况；②找到第一个空白格；③遍历1-9，若数字可用则填充，标记使用，递归；④若递归成功返回true，否则回溯（恢复空白和标记）；⑤若填满所有格子返回true。时间O(9^m)（m为空白格数），空间O(1)。';
    solveSudoku.hint = '通过记录数字使用情况快速判断合法性，递归填充每个空白格并回溯';
    problems.push(solveSudoku);

    // 14. 路径总和 II
    const pathSum = new ProblemModel();
    pathSum.id = 3014;
    pathSum.title = '路径总和 II';
    pathSum.description = '给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有 从根节点到叶子节点 路径总和等于给定目标和的路径。叶子节点 是指没有子节点的节点。';
    pathSum.difficulty = ProblemDifficulty.MEDIUM;
    pathSum.category = ProblemCategory.BACKTRACKING;
    pathSum.choices = [
      { id: 'A', text: '回溯+DFS：递归遍历树，记录路径和当前和，到达叶子时检查是否等于目标', isCorrect: true },
      { id: 'B', text: 'BFS：层序遍历记录路径', isCorrect: false },
      { id: 'C', text: '动态规划：记录每个节点的路径和', isCorrect: false },
      { id: 'D', text: '暴力法：枚举所有路径', isCorrect: false }
    ];
    pathSum.explanation = '回溯解法：①定义递归函数，参数为当前节点、当前路径、当前和；②若节点为null，返回；③将节点值加入路径和当前和；④若为叶子节点且当前和=targetSum，加入结果；⑤否则递归左右子树；⑥回溯时移除节点值。时间O(n)，空间O(h)（h为树高）。';
    pathSum.hint = '通过深度优先搜索遍历所有根到叶子的路径，记录路径和并在叶子节点处检查';
    problems.push(pathSum);


    // 16. 二进制手表
    const readBinaryWatchBacktrack = new ProblemModel();
    readBinaryWatchBacktrack.id = 3016;
    readBinaryWatchBacktrack.title = '二进制手表（回溯法）';
    readBinaryWatchBacktrack.description = '二进制手表顶部有 4 个 LED 代表 小时（0-11），底部的 6 个 LED 代表 分钟（0-59）。每个 LED 代表一个 0 或 1，最低位在右侧。例如，下面的二进制手表读取 "3:25" 。给你一个整数 turnedOn ，表示当前亮着的 LED 的数量，返回二进制手表可以表示的所有可能时间。你可以 按任意顺序 返回答案。小时不会以零开头：例如，"01:00" 是无效的，正确的写法应该是 "1:00" 。分钟必须由两位数组成，可能会以零开头：例如，"10:2" 是无效的，正确的写法应该是 "10:02" 。';
    readBinaryWatchBacktrack.difficulty = ProblemDifficulty.EASY;
    readBinaryWatchBacktrack.category = ProblemCategory.BACKTRACKING;
    readBinaryWatchBacktrack.choices = [
      { id: 'A', text: '回溯：递归选择LED是否点亮，统计小时和分钟的有效性', isCorrect: true },
      { id: 'B', text: '位运算：枚举所有可能的小时和分钟', isCorrect: false },
      { id: 'C', text: '暴力法：生成所有可能时间并检查', isCorrect: false },
      { id: 'D', text: '数学公式：计算可能的组合', isCorrect: false }
    ];
    readBinaryWatchBacktrack.explanation = '回溯解法：①定义递归函数，参数为已点亮的LED数、当前位置（0-9）、小时、分钟；②若位置=10，检查LED数是否等于turnedOn和时间有效性，有效则加入结果；③否则尝试不点亮当前LED，递归下一位；④若LED数<turnedOn，尝试点亮当前LED（更新小时或分钟），递归下一位。时间O(2^10)，空间O(1)。';
    readBinaryWatchBacktrack.hint = '通过递归选择每个LED的状态，控制点亮总数并检查时间有效性';
    problems.push(readBinaryWatchBacktrack);

    // 18. 优美的排列
    const countArrangement = new ProblemModel();
    countArrangement.id = 3018;
    countArrangement.title = '优美的排列';
    countArrangement.description = '假设有从 1 到 n 的 n 个整数。用这些整数构造一个数组 perm（下标从 1 开始），只要满足下述条件 之一 ，该数组就是一个 优美的排列 ：perm[i] 能够被 i 整除。i 能够被 perm[i] 整除。给你一个整数 n ，返回可以构造的 优美排列 的 数量 。';
    countArrangement.difficulty = ProblemDifficulty.MEDIUM;
    countArrangement.category = ProblemCategory.BACKTRACKING;
    countArrangement.choices = [
      { id: 'A', text: '回溯：递归填充每个位置，尝试所有符合条件的未使用数字', isCorrect: true },
      { id: 'B', text: '动态规划：状态压缩记录使用的数字', isCorrect: false },
      { id: 'C', text: '数学公式：计算排列数', isCorrect: false },
      { id: 'D', text: '暴力法：生成所有排列并检查', isCorrect: false }
    ];
    countArrangement.explanation = '回溯解法：①定义递归函数，参数为当前位置和已使用标记；②若位置>n，计数+1；③否则遍历1-n，若未使用且满足整除条件，标记使用，递归下一个位置，回溯时解除标记。时间O(k)（k为优美排列数量），空间O(n)。';
    countArrangement.hint = '通过递归为每个位置选择符合条件的数字，利用标记避免重复使用';
    problems.push(countArrangement);

    // 19. 字母大小写全排列
    const letterCasePermutation = new ProblemModel();
    letterCasePermutation.id = 3019;
    letterCasePermutation.title = '字母大小写全排列';
    letterCasePermutation.description = '给定一个字符串 s ，通过将字符串 s 中的每个字母转变大小写，我们可以获得一个新的字符串。返回 所有可能得到的字符串集合 。以 任意顺序 返回输出。';
    letterCasePermutation.difficulty = ProblemDifficulty.MEDIUM;
    letterCasePermutation.category = ProblemCategory.BACKTRACKING;
    letterCasePermutation.choices = [
      { id: 'A', text: '回溯：递归处理每个字符，字母则尝试大小写两种情况，数字直接添加', isCorrect: true },
      { id: 'B', text: '位运算：用二进制表示字母的大小写选择', isCorrect: false },
      { id: 'C', text: '动态规划：基于前i个字符的结果生成', isCorrect: false },
      { id: 'D', text: '暴力法：生成所有可能组合', isCorrect: false }
    ];
    letterCasePermutation.explanation = '回溯解法：①定义递归函数，参数为当前字符串和索引；②若索引=s长度，加入结果；③否则获取当前字符，若为数字，添加后递归下一位；④若为字母，分别添加小写和大写形式，递归下一位，回溯。时间O(n*2^k)（k为字母数），空间O(n)。';
    letterCasePermutation.hint = '对每个字母递归尝试两种大小写状态，数字则直接处理，生成所有可能组合';
    problems.push(letterCasePermutation);

    return problems;
  }
}