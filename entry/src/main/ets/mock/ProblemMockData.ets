import { ProblemModel, ProblemDifficulty, ProblemCategory, ChoiceOption } from '../model/ProblemModel';

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
    twoSum.description = '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。\n\n你可以按任意顺序返回答案。';
    twoSum.difficulty = ProblemDifficulty.EASY;
    twoSum.category = ProblemCategory.ARRAY;
    twoSum.choices = [
      { id: 'A', text: '使用两层循环遍历数组，时间复杂度O(n²)', isCorrect: false },
      { id: 'B', text: '使用哈希表存储数组值和索引，一次遍历完成，时间复杂度O(n)', isCorrect: true },
      { id: 'C', text: '先排序再使用双指针，时间复杂度O(nlogn)', isCorrect: false },
      { id: 'D', text: '使用递归分治算法，时间复杂度O(nlogn)', isCorrect: false }
    ];
    twoSum.explanation = '最优解法是使用哈希表。遍历数组时，对于每个元素nums[i]，计算target - nums[i]，然后在哈希表中查找这个值。如果找到，返回两个索引；如果没找到，将当前元素和索引存入哈希表。这样只需要一次遍历，时间复杂度为O(n)，空间复杂度为O(n)。';
    twoSum.hint = '考虑使用哈希表来存储已经遍历过的元素及其索引';
    problems.push(twoSum);
    
    // 三数之和
    const threeSum = new ProblemModel();
    threeSum.id = 2;
    threeSum.title = '三数之和';
    threeSum.description = '给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。\n\n注意：答案中不可以包含重复的三元组。';
    threeSum.difficulty = ProblemDifficulty.MEDIUM;
    threeSum.category = ProblemCategory.ARRAY;
    threeSum.choices = [
      { id: 'A', text: '使用三层循环暴力求解，时间复杂度O(n³)', isCorrect: false },
      { id: 'B', text: '先排序，然后固定一个数，用双指针找另外两个数，时间复杂度O(n²)', isCorrect: true },
      { id: 'C', text: '使用哈希表存储所有两数之和，时间复杂度O(n²)', isCorrect: false },
      { id: 'D', text: '使用递归回溯算法，时间复杂度O(2^n)', isCorrect: false }
    ];
    threeSum.explanation = '最优解法是排序+双指针。首先对数组排序，然后遍历数组，对于每个元素nums[i]，使用双指针在剩余数组中寻找两个数使得三数之和为0。排序后可以很容易跳过重复元素，避免重复的三元组。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSum.hint = '先排序，然后固定一个数，用双指针技巧找另外两个数';
    problems.push(threeSum);
    
    // 最大子数组和
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 3;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description = '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。\n\n子数组是数组中的一个连续部分。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.ARRAY;
    maxSubArray.choices = [
      { id: 'A', text: '使用两层循环枚举所有子数组，时间复杂度O(n²)', isCorrect: false },
      { id: 'B', text: '使用动态规划（Kadane算法），时间复杂度O(n)', isCorrect: true },
      { id: 'C', text: '使用分治算法，时间复杂度O(nlogn)', isCorrect: false },
      { id: 'D', text: '使用贪心算法，时间复杂度O(nlogn)', isCorrect: false }
    ];
    maxSubArray.explanation = 'Kadane算法是最优解法。维护两个变量：当前子数组的最大和(currentSum)和全局最大和(maxSum)。遍历数组，对于每个元素，选择是加入当前子数组还是重新开始一个新的子数组。状态转移方程：currentSum = max(nums[i], currentSum + nums[i])。时间复杂度O(n)，空间复杂度O(1)。';
    maxSubArray.hint = '考虑动态规划，当前位置的最大子数组和只依赖于前一个位置';
    problems.push(maxSubArray);
    
    // 合并两个有序数组
    const mergeSortedArray = new ProblemModel();
    mergeSortedArray.id = 21;
    mergeSortedArray.title = '合并两个有序数组';
    mergeSortedArray.description = '给你两个按非递减顺序排列的整数数组nums1和nums2，另有两个整数m和n，分别表示nums1和nums2中元素的数目。请你合并nums2到nums1中，使合并后的数组同样按非递减顺序排列。';
    mergeSortedArray.difficulty = ProblemDifficulty.EASY;
    mergeSortedArray.category = ProblemCategory.ARRAY;
    mergeSortedArray.choices = [
      { id: 'A', text: '从前往后合并，需要额外空间', isCorrect: false },
      { id: 'B', text: '从后往前合并，利用nums1的额外空间', isCorrect: true },
      { id: 'C', text: '先合并再排序', isCorrect: false },
      { id: 'D', text: '使用归并排序算法', isCorrect: false }
    ];
    mergeSortedArray.explanation = '从后往前合并是最优解法。由于nums1有足够的空间，从两个数组的末尾开始比较，将较大的元素放到nums1的末尾。这样避免了覆盖nums1中未处理的元素。时间复杂度O(m+n)，空间复杂度O(1)。';
    mergeSortedArray.hint = '从后往前合并，避免覆盖未处理的元素';
    problems.push(mergeSortedArray);
    
    // 移除元素
    const removeElement = new ProblemModel();
    removeElement.id = 22;
    removeElement.title = '移除元素';
    removeElement.description = '给你一个数组nums和一个值val，你需要原地移除所有数值等于val的元素，并返回移除后数组的新长度。';
    removeElement.difficulty = ProblemDifficulty.EASY;
    removeElement.category = ProblemCategory.ARRAY;
    removeElement.choices = [
      { id: 'A', text: '使用双指针，快指针遍历，慢指针记录有效位置', isCorrect: true },
      { id: 'B', text: '创建新数组存储不等于val的元素', isCorrect: false },
      { id: 'C', text: '使用额外的标记数组', isCorrect: false },
      { id: 'D', text: '从后往前遍历并删除元素', isCorrect: false }
    ];
    removeElement.explanation = '双指针是最优解法。使用快慢指针，快指针遍历数组，当快指针指向的元素不等于val时，将其复制到慢指针位置，然后慢指针前进。最终慢指针的位置就是新数组的长度。时间复杂度O(n)，空间复杂度O(1)。';
    removeElement.hint = '使用双指针技巧，原地修改数组';
    problems.push(removeElement);
    
    // 搜索插入位置
    const searchInsert = new ProblemModel();
    searchInsert.id = 23;
    searchInsert.title = '搜索插入位置';
    searchInsert.description = '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。';
    searchInsert.difficulty = ProblemDifficulty.EASY;
    searchInsert.category = ProblemCategory.ARRAY;
    searchInsert.choices = [
      { id: 'A', text: '线性搜索，时间复杂度O(n)', isCorrect: false },
      { id: 'B', text: '二分搜索，时间复杂度O(logn)', isCorrect: true },
      { id: 'C', text: '从后往前搜索', isCorrect: false },
      { id: 'D', text: '使用哈希表存储索引', isCorrect: false }
    ];
    searchInsert.explanation = '由于数组已排序，使用二分搜索是最优解法。如果找到目标值，返回其索引；如果没找到，left指针的位置就是插入位置。时间复杂度O(logn)，空间复杂度O(1)。';
    searchInsert.hint = '利用数组已排序的特性，使用二分搜索';
    problems.push(searchInsert);
    
    // 加一
    const plusOne = new ProblemModel();
    plusOne.id = 24;
    plusOne.title = '加一';
    plusOne.description = '给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。最高位数字存放在数组的首位，数组中每个元素只存储单个数字。';
    plusOne.difficulty = ProblemDifficulty.EASY;
    plusOne.category = ProblemCategory.ARRAY;
    plusOne.choices = [
      { id: 'A', text: '从后往前处理进位，特殊处理全9的情况', isCorrect: true },
      { id: 'B', text: '转换为整数加一再转回数组', isCorrect: false },
      { id: 'C', text: '使用字符串处理', isCorrect: false },
      { id: 'D', text: '递归处理每一位', isCorrect: false }
    ];
    plusOne.explanation = '从数组末尾开始处理进位。如果当前位小于9，直接加一返回；如果等于9，设为0继续处理前一位。如果所有位都是9，需要创建新数组，首位为1，其余为0。时间复杂度O(n)，空间复杂度O(1)或O(n)。';
    plusOne.hint = '从后往前处理，注意进位和全9的特殊情况';
    problems.push(plusOne);
    
    // 两数之和II
    const twoSumII = new ProblemModel();
    twoSumII.id = 25;
    twoSumII.title = '两数之和II - 输入有序数组';
    twoSumII.description = '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。';
    twoSumII.difficulty = ProblemDifficulty.MEDIUM;
    twoSumII.category = ProblemCategory.ARRAY;
    twoSumII.choices = [
      { id: 'A', text: '使用哈希表，时间复杂度O(n)', isCorrect: false },
      { id: 'B', text: '使用双指针，时间复杂度O(n)', isCorrect: true },
      { id: 'C', text: '二重循环暴力搜索', isCorrect: false },
      { id: 'D', text: '二分搜索每个元素的补数', isCorrect: false }
    ];
    twoSumII.explanation = '由于数组已排序，使用双指针是最优解法。左指针指向开头，右指针指向末尾。如果两数之和等于目标值，返回索引；如果小于目标值，左指针右移；如果大于目标值，右指针左移。时间复杂度O(n)，空间复杂度O(1)。';
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
      { id: 'B', text: '三次反转：整体反转，前k个反转，后n-k个反转', isCorrect: true },
      { id: 'C', text: '逐个移动元素k次', isCorrect: false },
      { id: 'D', text: '使用环形替换', isCorrect: false }
    ];
    rotateArray.explanation = '三次反转是最优的原地算法。首先反转整个数组，然后反转前k个元素，最后反转后n-k个元素。这样就完成了向右旋转k位。时间复杂度O(n)，空间复杂度O(1)。';
    rotateArray.hint = '考虑三次反转的技巧：整体反转，然后分段反转';
    problems.push(rotateArray);
    
    // 存在重复元素
    const containsDuplicate = new ProblemModel();
    containsDuplicate.id = 27;
    containsDuplicate.title = '存在重复元素';
    containsDuplicate.description = '给你一个整数数组nums。如果任一值在数组中出现至少两次，返回true；如果数组中每个元素都不相同，则返回false。';
    containsDuplicate.difficulty = ProblemDifficulty.EASY;
    containsDuplicate.category = ProblemCategory.ARRAY;
    containsDuplicate.choices = [
      { id: 'A', text: '使用哈希表记录出现过的元素', isCorrect: true },
      { id: 'B', text: '先排序再检查相邻元素', isCorrect: false },
      { id: 'C', text: '双重循环比较所有元素对', isCorrect: false },
      { id: 'D', text: '使用位运算标记', isCorrect: false }
    ];
    containsDuplicate.explanation = '使用哈希表是最直接的解法。遍历数组，如果元素已在哈希表中，返回true；否则将元素加入哈希表。时间复杂度O(n)，空间复杂度O(n)。排序方法时间复杂度为O(nlogn)，但空间复杂度为O(1)。';
    containsDuplicate.hint = '使用哈希表快速检查元素是否已出现';
    problems.push(containsDuplicate);
    
    // 只出现一次的数字
    const singleNumber = new ProblemModel();
    singleNumber.id = 28;
    singleNumber.title = '只出现一次的数字';
    singleNumber.description = '给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。';
    singleNumber.difficulty = ProblemDifficulty.EASY;
    singleNumber.category = ProblemCategory.ARRAY;
    singleNumber.choices = [
      { id: 'A', text: '使用哈希表统计每个元素的出现次数', isCorrect: false },
      { id: 'B', text: '使用异或运算，相同数字异或为0', isCorrect: true },
      { id: 'C', text: '先排序再查找单独的元素', isCorrect: false },
      { id: 'D', text: '使用集合存储，重复则删除', isCorrect: false }
    ];
    singleNumber.explanation = '异或运算是最优解法。利用异或运算的性质：a⊕a=0，a⊕0=a，以及异或运算满足交换律和结合律。将所有数字进行异或运算，相同的数字会相互抵消，最终结果就是只出现一次的数字。时间复杂度O(n)，空间复杂度O(1)。';
    singleNumber.hint = '利用异或运算的性质：相同数字异或为0';
    problems.push(singleNumber);
    
    // 移动零
    const moveZeroes = new ProblemModel();
    moveZeroes.id = 29;
    moveZeroes.title = '移动零';
    moveZeroes.description = '给定一个数组nums，编写一个函数将所有0移动到数组的末尾，同时保持非零元素的相对顺序。请注意，必须在不复制数组的情况下原地对数组进行操作。';
    moveZeroes.difficulty = ProblemDifficulty.EASY;
    moveZeroes.category = ProblemCategory.ARRAY;
    moveZeroes.choices = [
      { id: 'A', text: '使用双指针，一个记录非零元素位置，一个遍历数组', isCorrect: true },
      { id: 'B', text: '创建新数组，先放非零元素再放零', isCorrect: false },
      { id: 'C', text: '从后往前遍历，遇到零就删除并在末尾添加', isCorrect: false },
      { id: 'D', text: '使用冒泡排序将零移到末尾', isCorrect: false }
    ];
    moveZeroes.explanation = '双指针是最优解法。使用慢指针记录下一个非零元素应该放置的位置，快指针遍历数组。当快指针遇到非零元素时，将其移动到慢指针位置，然后慢指针前进。最后将慢指针后面的位置都设为0。时间复杂度O(n)，空间复杂度O(1)。';
    moveZeroes.hint = '使用双指针，保持非零元素的相对顺序';
    problems.push(moveZeroes);
    
    // 买卖股票的最佳时机
    const maxProfit = new ProblemModel();
    maxProfit.id = 30;
    maxProfit.title = '买卖股票的最佳时机';
    maxProfit.description = '给定一个数组prices，它的第i个元素prices[i]表示一支给定股票第i天的价格。你只能选择某一天买入这只股票，并选择在未来的某一天卖出该股票。设计一个算法来计算你所能获取的最大利润。';
    maxProfit.difficulty = ProblemDifficulty.EASY;
    maxProfit.category = ProblemCategory.ARRAY;
    maxProfit.choices = [
      { id: 'A', text: '双重循环枚举所有买卖组合', isCorrect: false },
      { id: 'B', text: '一次遍历，记录最低价格和最大利润', isCorrect: true },
      { id: 'C', text: '使用动态规划，状态表示持有/不持有股票', isCorrect: false },
      { id: 'D', text: '先找到最低点和最高点', isCorrect: false }
    ];
    maxProfit.explanation = '一次遍历是最优解法。维护两个变量：到目前为止的最低价格和最大利润。遍历价格数组，更新最低价格，并计算当前价格减去最低价格的利润，更新最大利润。时间复杂度O(n)，空间复杂度O(1)。';
    maxProfit.hint = '记录历史最低价格，计算当前价格的最大利润';
    problems.push(maxProfit);
    
    // 多数元素
    const majorityElement = new ProblemModel();
    majorityElement.id = 31;
    majorityElement.title = '多数元素';
    majorityElement.description = '给定一个大小为n的数组nums，返回其中的多数元素。多数元素是指在数组中出现次数大于⌊n/2⌋的元素。';
    majorityElement.difficulty = ProblemDifficulty.EASY;
    majorityElement.category = ProblemCategory.ARRAY;
    majorityElement.choices = [
      { id: 'A', text: '使用哈希表统计每个元素的出现次数', isCorrect: false },
      { id: 'B', text: '使用Boyer-Moore投票算法', isCorrect: true },
      { id: 'C', text: '先排序，中间元素就是多数元素', isCorrect: false },
      { id: 'D', text: '随机选择元素并验证', isCorrect: false }
    ];
    majorityElement.explanation = 'Boyer-Moore投票算法是最优解法。维护一个候选元素和计数器，遍历数组时，如果当前元素等于候选元素则计数器加1，否则减1。当计数器为0时，更换候选元素。由于多数元素出现次数超过一半，最终的候选元素就是多数元素。时间复杂度O(n)，空间复杂度O(1)。';
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
    missingNumber.explanation = '数学方法是最直观的解法。计算0到n的期望和：n*(n+1)/2，然后减去数组中所有元素的和，差值就是缺失的数字。时间复杂度O(n)，空间复杂度O(1)。异或方法也可以，但数学方法更容易理解。';
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
    thirdMax.explanation = '维护三个变量是最优解法。遍历数组，维护first（最大）、second（第二大）、third（第三大）三个变量。遇到更大的数时更新这些变量。注意处理重复数字和边界情况。时间复杂度O(n)，空间复杂度O(1)。';
    thirdMax.hint = '维护三个变量记录最大、第二大、第三大的数';
    problems.push(thirdMax);
    
    // 找到所有数组中消失的数字
    const findDisappearedNumbers = new ProblemModel();
    findDisappearedNumbers.id = 34;
    findDisappearedNumbers.title = '找到所有数组中消失的数字';
    findDisappearedNumbers.description = '给你一个含n个整数的数组nums，其中nums[i]在区间[1,n]内。请你找出所有在[1,n]范围内但没有出现在nums中的数字，并以数组的形式返回结果。';
    findDisappearedNumbers.difficulty = ProblemDifficulty.EASY;
    findDisappearedNumbers.category = ProblemCategory.ARRAY;
    findDisappearedNumbers.choices = [
      { id: 'A', text: '使用哈希表记录出现的数字', isCorrect: false },
      { id: 'B', text: '原地修改：将nums[i]-1位置的数字标记为负数', isCorrect: true },
      { id: 'C', text: '使用额外数组标记', isCorrect: false },
      { id: 'D', text: '先排序再查找缺失数字', isCorrect: false }
    ];
    findDisappearedNumbers.explanation = '原地修改是最优解法。遍历数组，对于每个数字nums[i]，将nums[|nums[i]|-1]标记为负数（如果还不是负数的话）。第二次遍历时，如果nums[i]是正数，说明i+1这个数字缺失。时间复杂度O(n)，空间复杂度O(1)。';
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
    findMaxConsecutiveOnes.explanation = '一次遍历是最直接的解法。维护两个变量：当前连续1的长度和历史最大长度。遇到1时增加当前长度，遇到0时重置当前长度为0，同时更新最大长度。时间复杂度O(n)，空间复杂度O(1)。';
    findMaxConsecutiveOnes.hint = '遍历数组，记录当前连续1的长度和历史最大值';
    problems.push(findMaxConsecutiveOnes);
    
    // 数组的度
    const findShortestSubArray = new ProblemModel();
    findShortestSubArray.id = 36;
    findShortestSubArray.title = '数组的度';
    findShortestSubArray.description = '给定一个非空且只包含非负数字的数组nums，数组的度的定义是指数组里任一元素出现频数的最大值。你的任务是在nums中找到与nums拥有相同大小的度的最短连续子数组，返回其长度。';
    findShortestSubArray.difficulty = ProblemDifficulty.EASY;
    findShortestSubArray.category = ProblemCategory.ARRAY;
    findShortestSubArray.choices = [
      { id: 'A', text: '使用哈希表记录每个元素的出现次数、首次和最后出现位置', isCorrect: true },
      { id: 'B', text: '枚举所有子数组，计算每个的度', isCorrect: false },
      { id: 'C', text: '先找到度，再用滑动窗口找最短子数组', isCorrect: false },
      { id: 'D', text: '使用双指针扩展窗口', isCorrect: false }
    ];
    findShortestSubArray.explanation = '使用哈希表是最优解法。遍历数组，记录每个元素的出现次数、首次出现位置和最后出现位置。然后找出出现次数最多的元素（可能有多个），计算它们对应的子数组长度（最后位置-首次位置+1），返回最小长度。时间复杂度O(n)，空间复杂度O(n)。';
    findShortestSubArray.hint = '记录每个元素的频次和首末位置，找出度最大且长度最短的子数组';
    problems.push(findShortestSubArray);
    
    // 托普利茨矩阵
    const isToeplitzMatrix = new ProblemModel();
    isToeplitzMatrix.id = 37;
    isToeplitzMatrix.title = '托普利茨矩阵';
    isToeplitzMatrix.description = '给你一个m x n的矩阵matrix。如果这个矩阵是托普利茨矩阵，返回true；否则，返回false。如果矩阵上每一条由左上到右下的对角线上的元素都相同，那么这个矩阵是托普利茨矩阵。';
    isToeplitzMatrix.difficulty = ProblemDifficulty.EASY;
    isToeplitzMatrix.category = ProblemCategory.ARRAY;
    isToeplitzMatrix.choices = [
      { id: 'A', text: '检查每个元素是否等于其左上角的元素', isCorrect: true },
      { id: 'B', text: '遍历每条对角线，检查元素是否相同', isCorrect: false },
      { id: 'C', text: '使用哈希表记录每条对角线的元素', isCorrect: false },
      { id: 'D', text: '转置矩阵后检查', isCorrect: false }
    ];
    isToeplitzMatrix.explanation = '检查相邻元素是最简单的方法。对于每个元素matrix[i][j]（除了第一行和第一列），检查它是否等于matrix[i-1][j-1]。如果所有这样的元素都相等，则矩阵是托普利茨矩阵。时间复杂度O(mn)，空间复杂度O(1)。';
    isToeplitzMatrix.hint = '检查每个元素是否等于其左上角的元素';
    problems.push(isToeplitzMatrix);
    
    // 重塑矩阵
    const matrixReshape = new ProblemModel();
    matrixReshape.id = 38;
    matrixReshape.title = '重塑矩阵';
    matrixReshape.description = '在MATLAB中，有一个非常有用的函数reshape，它可以将一个m x n矩阵重塑为另一个大小不同（r x c）的新矩阵，但保留其原始数据。给你一个由二维数组mat表示的m x n矩阵，以及两个正整数r和c，分别表示想要的重构的矩阵的行数和列数。';
    matrixReshape.difficulty = ProblemDifficulty.EASY;
    matrixReshape.category = ProblemCategory.ARRAY;
    matrixReshape.choices = [
      { id: 'A', text: '先检查元素总数是否匹配，然后按行优先顺序重新排列', isCorrect: true },
      { id: 'B', text: '使用数学公式直接计算新位置', isCorrect: false },
      { id: 'C', text: '先转换为一维数组，再重新构造二维数组', isCorrect: false },
      { id: 'D', text: '使用递归分治重塑', isCorrect: false }
    ];
    matrixReshape.explanation = '按行优先顺序重排是标准做法。首先检查m*n是否等于r*c，如果不等则返回原矩阵。然后创建新矩阵，按行优先顺序遍历原矩阵，将元素依次填入新矩阵。可以使用一个计数器或者数学公式来计算新位置。时间复杂度O(mn)，空间复杂度O(rc)。';
    matrixReshape.hint = '检查元素总数，按行优先顺序重新排列元素';
    problems.push(matrixReshape);
    
    // 杨辉三角
    const generate = new ProblemModel();
    generate.id = 39;
    generate.title = '杨辉三角';
    generate.description = '给定一个非负整数numRows，生成杨辉三角的前numRows行。在杨辉三角中，每个数是它左上方和右上方的数的和。';
    generate.difficulty = ProblemDifficulty.EASY;
    generate.category = ProblemCategory.ARRAY;
    generate.choices = [
      { id: 'A', text: '逐行生成，每行首尾为1，中间元素为上一行相邻两元素之和', isCorrect: true },
      { id: 'B', text: '使用组合数公式C(n,k)直接计算每个位置', isCorrect: false },
      { id: 'C', text: '使用递归生成每一行', isCorrect: false },
      { id: 'D', text: '使用动态规划自底向上构建', isCorrect: false }
    ];
    generate.explanation = '逐行生成是最直观的方法。第一行只有一个1，从第二行开始，每行的首尾都是1，中间的元素等于上一行对应位置和前一个位置的元素之和。时间复杂度O(numRows²)，空间复杂度O(1)（不计算结果数组）。';
    generate.hint = '每行首尾为1，中间元素等于上一行相邻两元素之和';
    problems.push(generate);
    
    // 有效的数独
    const isValidSudoku = new ProblemModel();
    isValidSudoku.id = 40;
    isValidSudoku.title = '有效的数独';
    isValidSudoku.description = '请你判断一个9x9的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。数字1-9在每一行只能出现一次。数字1-9在每一列只能出现一次。数字1-9在每一个以粗实线分隔的3x3宫内只能出现一次。';
    isValidSudoku.difficulty = ProblemDifficulty.MEDIUM;
    isValidSudoku.category = ProblemCategory.ARRAY;
    isValidSudoku.choices = [
      { id: 'A', text: '使用三个哈希表分别记录行、列、3x3宫格中出现的数字', isCorrect: true },
      { id: 'B', text: '对每个数字，检查其所在行、列、宫格是否有重复', isCorrect: false },
      { id: 'C', text: '使用位运算标记每行、列、宫格的数字状态', isCorrect: false },
      { id: 'D', text: '递归验证每个位置的合法性', isCorrect: false }
    ];
    isValidSudoku.explanation = '使用哈希表是最清晰的解法。创建三个哈希表数组，分别记录9行、9列、9个3x3宫格中出现的数字。遍历数独，对于每个非空格子，检查该数字是否已在对应的行、列、宫格中出现过。宫格索引可以用(i/3)*3+j/3计算。时间复杂度O(1)，空间复杂度O(1)。';
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
    validParentheses.description = '给定一个只包括 \'(\'，\')\'，\'[\'，\']\'，\'{\'，\'}\' 的字符串 s ，判断字符串是否有效。\n\n有效字符串需满足：\n1. 左括号必须用相同类型的右括号闭合。\n2. 左括号必须以正确的顺序闭合。';
    validParentheses.difficulty = ProblemDifficulty.EASY;
    validParentheses.category = ProblemCategory.STRING;
    validParentheses.choices = [
      { id: 'A', text: '使用栈数据结构，遇到左括号入栈，遇到右括号出栈匹配', isCorrect: true },
      { id: 'B', text: '使用计数器分别统计各种括号的数量', isCorrect: false },
      { id: 'C', text: '使用递归算法逐个匹配括号', isCorrect: false },
      { id: 'D', text: '使用双指针从两端向中间匹配', isCorrect: false }
    ];
    validParentheses.explanation = '使用栈是最直观的解法。遍历字符串，遇到左括号就入栈，遇到右括号就检查栈顶是否为对应的左括号，如果是则出栈，否则返回false。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validParentheses.hint = '考虑使用栈来匹配括号的配对关系';
    problems.push(validParentheses);
    
    // 最长回文子串
    const longestPalindrome = new ProblemModel();
    longestPalindrome.id = 5;
    longestPalindrome.title = '最长回文子串';
    longestPalindrome.description = '给你一个字符串 s，找到 s 中最长的回文子串。\n\n回文字符串是正着读和倒着读都一样的字符串。';
    longestPalindrome.difficulty = ProblemDifficulty.MEDIUM;
    longestPalindrome.category = ProblemCategory.STRING;
    longestPalindrome.choices = [
      { id: 'A', text: '暴力法：枚举所有子串并检查是否为回文，时间复杂度O(n³)', isCorrect: false },
      { id: 'B', text: '中心扩展法：以每个字符为中心向两边扩展，时间复杂度O(n²)', isCorrect: true },
      { id: 'C', text: 'Manacher算法：线性时间复杂度O(n)', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i][j]表示s[i:j]是否为回文，时间复杂度O(n²)', isCorrect: false }
    ];
    longestPalindrome.explanation = '中心扩展法是较优的解法。对于每个可能的回文中心（包括字符和字符间的位置），向两边扩展直到不能构成回文为止。需要考虑奇数长度和偶数长度的回文。时间复杂度O(n²)，空间复杂度O(1)。虽然Manacher算法可以达到O(n)，但实现复杂度较高。';
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
    longestCommonPrefix.explanation = '垂直扫描是最直观的方法。从第一个字符开始，逐个字符比较所有字符串的对应位置。一旦发现不匹配或某个字符串结束，就返回当前的公共前缀。时间复杂度O(S)，其中S是所有字符串的字符总数。';
    longestCommonPrefix.hint = '垂直扫描，逐个字符比较所有字符串';
    problems.push(longestCommonPrefix);
    
    // 反转字符串
    const reverseString = new ProblemModel();
    reverseString.id = 62;
    reverseString.title = '反转字符串';
    reverseString.description = '编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组char[]的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用O(1)的额外空间解决这一问题。';
    reverseString.difficulty = ProblemDifficulty.EASY;
    reverseString.category = ProblemCategory.STRING;
    reverseString.choices = [
      { id: 'A', text: '使用双指针，头尾交换字符', isCorrect: true },
      { id: 'B', text: '使用递归反转', isCorrect: false },
      { id: 'C', text: '创建新数组存储反转结果', isCorrect: false },
      { id: 'D', text: '使用栈结构', isCorrect: false }
    ];
    reverseString.explanation = '双指针是最优解法。使用左右两个指针，分别指向数组的开头和结尾，交换两个指针指向的字符，然后左指针右移，右指针左移，直到两指针相遇。时间复杂度O(n)，空间复杂度O(1)。';
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
    firstUniqChar.explanation = '哈希表是最优解法。第一次遍历字符串，使用哈希表统计每个字符的出现次数。第二次遍历字符串，找到第一个在哈希表中频次为1的字符，返回其索引。时间复杂度O(n)，空间复杂度O(1)（字符集大小固定）。';
    firstUniqChar.hint = '两次遍历：先统计频次，再找第一个唯一字符';
    problems.push(firstUniqChar);
    
    // 有效的字母异位词
    const isAnagram = new ProblemModel();
    isAnagram.id = 64;
    isAnagram.title = '有效的字母异位词';
    isAnagram.description = '给定两个字符串s和t，编写一个函数来判断t是否是s的字母异位词。注意：若s和t中每个字符出现的次数都相同，则称s和t互为字母异位词。';
    isAnagram.difficulty = ProblemDifficulty.EASY;
    isAnagram.category = ProblemCategory.STRING;
    isAnagram.choices = [
      { id: 'A', text: '排序两个字符串，比较是否相等', isCorrect: false },
      { id: 'B', text: '使用哈希表统计字符频次，比较两个字符串的字符频次', isCorrect: true },
      { id: 'C', text: '使用数组统计26个字母的出现次数', isCorrect: false },
      { id: 'D', text: '逐个字符比较', isCorrect: false }
    ];
    isAnagram.explanation = '哈希表统计是最通用的解法。分别统计两个字符串中每个字符的出现次数，然后比较两个哈希表是否相等。如果只包含小写字母，也可以使用长度为26的数组。时间复杂度O(n)，空间复杂度O(1)。';
    isAnagram.hint = '统计两个字符串的字符频次，比较是否相同';
    problems.push(isAnagram);
    
    // 验证回文串
    const isPalindrome = new ProblemModel();
    isPalindrome.id = 65;
    isPalindrome.title = '验证回文串';
    isPalindrome.description = '如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样。则可以认为该短语是一个回文串。给你一个字符串s，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。';
    isPalindrome.difficulty = ProblemDifficulty.EASY;
    isPalindrome.category = ProblemCategory.STRING;
    isPalindrome.choices = [
      { id: 'A', text: '预处理字符串，然后使用双指针验证', isCorrect: false },
      { id: 'B', text: '使用双指针，跳过非字母数字字符，比较字符', isCorrect: true },
      { id: 'C', text: '反转字符串后比较', isCorrect: false },
      { id: 'D', text: '使用递归验证', isCorrect: false }
    ];
    isPalindrome.explanation = '双指针是最优解法。使用左右两个指针，跳过非字母数字字符，将字符转换为小写后比较。如果所有对应字符都相等，则是回文串。时间复杂度O(n)，空间复杂度O(1)。';
    isPalindrome.hint = '使用双指针，跳过非字母数字字符进行比较';
    problems.push(isPalindrome);
    
    // 字符串转换整数
    const myAtoi = new ProblemModel();
    myAtoi.id = 66;
    myAtoi.title = '字符串转换整数(atoi)';
    myAtoi.description = '请你来实现一个myAtoi(string s)函数，使其能将字符串转换成一个32位有符号整数（类似C/C++中的atoi函数）。';
    myAtoi.difficulty = ProblemDifficulty.MEDIUM;
    myAtoi.category = ProblemCategory.STRING;
    myAtoi.choices = [
      { id: 'A', text: '按步骤处理：去空格、判断符号、转换数字、处理溢出', isCorrect: true },
      { id: 'B', text: '使用正则表达式匹配数字', isCorrect: false },
      { id: 'C', text: '直接使用内置转换函数', isCorrect: false },
      { id: 'D', text: '逐字符处理，不考虑边界情况', isCorrect: false }
    ];
    myAtoi.explanation = '按步骤处理是标准做法。1)跳过前导空格；2)检查正负号；3)逐个字符转换数字，遇到非数字字符停止；4)检查整数溢出，超出范围则返回边界值。时间复杂度O(n)，空间复杂度O(1)。';
    myAtoi.hint = '按步骤处理：空格、符号、数字转换、溢出检查';
    problems.push(myAtoi);
    
    // 实现strStr()
    const strStr = new ProblemModel();
    strStr.id = 67;
    strStr.title = '实现strStr()';
    strStr.description = '实现strStr()函数。给你两个字符串haystack和needle，请你在haystack字符串中找出needle字符串出现的第一个位置（下标从0开始）。如果不存在，则返回-1。';
    strStr.difficulty = ProblemDifficulty.EASY;
    strStr.category = ProblemCategory.STRING;
    strStr.choices = [
      { id: 'A', text: '暴力匹配，双重循环', isCorrect: false },
      { id: 'B', text: 'KMP算法，构建部分匹配表', isCorrect: true },
      { id: 'C', text: 'Boyer-Moore算法', isCorrect: false },
      { id: 'D', text: 'Rabin-Karp算法，使用哈希', isCorrect: false }
    ];
    strStr.explanation = 'KMP算法是最优解法。构建needle的部分匹配表（前缀函数），然后在haystack中进行匹配。当匹配失败时，利用部分匹配表跳过一些不必要的比较。时间复杂度O(m+n)，空间复杂度O(m)。暴力方法时间复杂度为O(mn)。';
    strStr.hint = '使用KMP算法，构建部分匹配表优化匹配过程';
    problems.push(strStr);
    
    // 外观数列
    const countAndSay = new ProblemModel();
    countAndSay.id = 68;
    countAndSay.title = '外观数列';
    countAndSay.description = '给定一个正整数n，输出外观数列的第n项。外观数列是一个整数序列，从数字1开始，序列中的每一项都是对前一项的描述。';
    countAndSay.difficulty = ProblemDifficulty.MEDIUM;
    countAndSay.category = ProblemCategory.STRING;
    countAndSay.choices = [
      { id: 'A', text: '递归生成每一项', isCorrect: false },
      { id: 'B', text: '迭代生成，逐个字符统计连续相同字符的个数', isCorrect: true },
      { id: 'C', text: '使用动态规划存储中间结果', isCorrect: false },
      { id: 'D', text: '使用正则表达式匹配模式', isCorrect: false }
    ];
    countAndSay.explanation = '迭代生成是最直接的方法。从"1"开始，对于每一项，遍历字符串统计连续相同字符的个数，然后构造下一项的描述。重复这个过程n-1次得到第n项。时间复杂度O(n*m)，其中m是字符串的平均长度。';
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
    lengthOfLongestSubstring.explanation = '滑动窗口是最优解法。使用左右两个指针维护一个窗口，用哈希表记录字符的最新位置。当遇到重复字符时，将左指针移动到重复字符的下一个位置。时间复杂度O(n)，空间复杂度O(min(m,n))，其中m是字符集大小。';
    lengthOfLongestSubstring.hint = '使用滑动窗口和哈希表记录字符位置';
    problems.push(lengthOfLongestSubstring);
    
    // 字符串的排列
    const checkInclusion = new ProblemModel();
    checkInclusion.id = 70;
    checkInclusion.title = '字符串的排列';
    checkInclusion.description = '给你两个字符串s1和s2，写一个函数来判断s2是否包含s1的排列。换句话说，s1的排列之一是s2的子串。';
    checkInclusion.difficulty = ProblemDifficulty.MEDIUM;
    checkInclusion.category = ProblemCategory.STRING;
    checkInclusion.choices = [
      { id: 'A', text: '生成s1的所有排列，检查是否在s2中', isCorrect: false },
      { id: 'B', text: '滑动窗口：维护固定长度窗口，比较字符频次', isCorrect: true },
      { id: 'C', text: '使用哈希表记录s1的字符，遍历s2检查', isCorrect: false },
      { id: 'D', text: '排序s1，然后在s2中查找所有长度相等的子串', isCorrect: false }
    ];
    checkInclusion.explanation = '滑动窗口是最优解法。维护一个长度为s1.length的滑动窗口，统计窗口内字符的频次。如果窗口内字符频次与s1的字符频次完全相同，则找到了s1的排列。时间复杂度O(n)，空间复杂度O(1)。';
    checkInclusion.hint = '使用固定长度的滑动窗口，比较字符频次';
    problems.push(checkInclusion);
    
    // 找到字符串中所有字母异位词
    const findAnagrams = new ProblemModel();
    findAnagrams.id = 71;
    findAnagrams.title = '找到字符串中所有字母异位词';
    findAnagrams.description = '给定两个字符串s和p，找到s中所有p的异位词的子串，返回这些子串的起始索引。不考虑答案输出的顺序。';
    findAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    findAnagrams.category = ProblemCategory.STRING;
    findAnagrams.choices = [
      { id: 'A', text: '对每个长度为p.length的子串，检查是否为p的异位词', isCorrect: false },
      { id: 'B', text: '滑动窗口：维护固定长度窗口，比较字符频次', isCorrect: true },
      { id: 'C', text: '使用哈希表存储p的所有异位词', isCorrect: false },
      { id: 'D', text: '排序p，然后查找所有排序后相等的子串', isCorrect: false }
    ];
    findAnagrams.explanation = '滑动窗口是最优解法。类似于"字符串的排列"问题，维护一个长度为p.length的滑动窗口，统计窗口内字符频次。当窗口内字符频次与p的字符频次相同时，记录起始索引。时间复杂度O(n)，空间复杂度O(1)。';
    findAnagrams.hint = '使用滑动窗口，记录所有字符频次匹配的起始位置';
    problems.push(findAnagrams);
    
    // 最小覆盖子串
    const minWindow = new ProblemModel();
    minWindow.id = 72;
    minWindow.title = '最小覆盖子串';
    minWindow.description = '给你一个字符串s、一个字符串t。返回s中涵盖t所有字符的最小子串。如果s中不存在涵盖t所有字符的子串，则返回空字符串""。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.STRING;
    minWindow.choices = [
      { id: 'A', text: '暴力法：枚举所有子串，检查是否包含t的所有字符', isCorrect: false },
      { id: 'B', text: '滑动窗口：扩展右边界直到包含所有字符，然后收缩左边界', isCorrect: true },
      { id: 'C', text: '双指针：固定左边界，移动右边界', isCorrect: false },
      { id: 'D', text: '分治法：递归处理子问题', isCorrect: false }
    ];
    minWindow.explanation = '滑动窗口是最优解法。使用双指针维护窗口，先扩展右边界直到窗口包含t的所有字符，然后收缩左边界直到不再满足条件，记录最小窗口。重复这个过程直到右边界到达末尾。时间复杂度O(m+n)，空间复杂度O(m+n)。';
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
    partition.explanation = '回溯法是标准解法。对于每个位置，尝试以该位置为结尾的所有回文子串，然后递归处理剩余部分。可以预处理回文判断结果优化性能。时间复杂度O(n*2^n)，空间复杂度O(n²)。';
    partition.hint = '使用回溯法，递归尝试所有可能的回文分割';
    problems.push(partition);
    
    // 单词拆分
    const wordBreak = new ProblemModel();
    wordBreak.id = 74;
    wordBreak.title = '单词拆分';
    wordBreak.description = '给你一个字符串s和一个字符串列表wordDict，判断是否可以利用字典中出现的单词拼接出s。注意：不要求字典中出现的单词全部都使用，并且字典中的单词可以重复使用。';
    wordBreak.difficulty = ProblemDifficulty.MEDIUM;
    wordBreak.category = ProblemCategory.STRING;
    wordBreak.choices = [
      { id: 'A', text: '回溯法：递归尝试所有可能的单词组合', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i]表示s[0:i]是否可以被拆分', isCorrect: true },
      { id: 'C', text: 'BFS：将字符串看作图，寻找路径', isCorrect: false },
      { id: 'D', text: '贪心法：优先选择最长的匹配单词', isCorrect: false }
    ];
    wordBreak.explanation = '动态规划是最优解法。dp[i]表示字符串s[0:i]是否可以被字典中的单词拆分。对于每个位置i，检查所有可能的单词结尾位置j，如果s[j:i]在字典中且dp[j]为true，则dp[i]为true。时间复杂度O(n²)，空间复杂度O(n)。';
    wordBreak.hint = '使用动态规划，dp[i]表示前i个字符是否可以被拆分';
    problems.push(wordBreak);
    
    // 编辑距离
    const minDistance = new ProblemModel();
    minDistance.id = 75;
    minDistance.title = '编辑距离';
    minDistance.description = '给你两个单词word1和word2，请返回将word1转换成word2所使用的最少操作数。你可以对一个单词进行如下三种操作：插入一个字符、删除一个字符、替换一个字符。';
    minDistance.difficulty = ProblemDifficulty.HARD;
    minDistance.category = ProblemCategory.STRING;
    minDistance.choices = [
      { id: 'A', text: '回溯法：递归尝试所有可能的操作序列', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示word1[0:i]转换为word2[0:j]的最少操作数', isCorrect: true },
      { id: 'C', text: '贪心法：优先进行代价最小的操作', isCorrect: false },
      { id: 'D', text: 'BFS：将字符串转换看作图搜索', isCorrect: false }
    ];
    minDistance.explanation = '动态规划是经典解法。dp[i][j]表示word1的前i个字符转换为word2的前j个字符所需的最少操作数。状态转移：如果字符相同则dp[i][j]=dp[i-1][j-1]，否则取插入、删除、替换三种操作的最小值加1。时间复杂度O(mn)，空间复杂度O(mn)。';
    minDistance.hint = '使用二维动态规划，考虑插入、删除、替换三种操作';
    problems.push(minDistance);
    
    // 正则表达式匹配
    const isMatch = new ProblemModel();
    isMatch.id = 76;
    isMatch.title = '正则表达式匹配';
    isMatch.description = '给你一个字符串s和一个字符规律p，请你来实现一个支持"."和"*"的正则表达式匹配。"."匹配任意单个字符，"*"匹配零个或多个前面的那一个元素。';
    isMatch.difficulty = ProblemDifficulty.HARD;
    isMatch.category = ProblemCategory.STRING;
    isMatch.choices = [
      { id: 'A', text: '递归：分情况讨论字符和*的匹配', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]和p[0:j]是否匹配', isCorrect: true },
      { id: 'C', text: '有限状态自动机', isCorrect: false },
      { id: 'D', text: '回溯法：尝试所有可能的匹配方式', isCorrect: false }
    ];
    isMatch.explanation = '动态规划是最清晰的解法。dp[i][j]表示s的前i个字符和p的前j个字符是否匹配。需要分情况讨论：普通字符匹配、.匹配、*匹配0次、*匹配多次等。时间复杂度O(mn)，空间复杂度O(mn)。';
    isMatch.hint = '使用动态规划，分情况讨论字符、.和*的匹配规则';
    problems.push(isMatch);
    
    // 通配符匹配
    const isMatchWildcard = new ProblemModel();
    isMatchWildcard.id = 77;
    isMatchWildcard.title = '通配符匹配';
    isMatchWildcard.description = '给定一个字符串(s)和一个字符模式(p)，实现一个支持"?"和"*"的通配符匹配。"?"可以匹配任何单个字符，"*"可以匹配任意字符串（包括空字符串）。';
    isMatchWildcard.difficulty = ProblemDifficulty.HARD;
    isMatchWildcard.category = ProblemCategory.STRING;
    isMatchWildcard.choices = [
      { id: 'A', text: '递归：分情况讨论字符和通配符的匹配', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]和p[0:j]是否匹配', isCorrect: true },
      { id: 'C', text: '贪心法：*尽可能匹配更多字符', isCorrect: false },
      { id: 'D', text: '双指针：记录*的位置进行回溯', isCorrect: false }
    ];
    isMatchWildcard.explanation = '动态规划是标准解法。dp[i][j]表示s的前i个字符和p的前j个字符是否匹配。状态转移：普通字符和?需要精确匹配，*可以匹配0个或多个字符。时间复杂度O(mn)，空间复杂度O(mn)。';
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
    longestValidParentheses.explanation = '动态规划是最优解法。dp[i]表示以索引i结尾的最长有效括号子串长度。当s[i]为")"时，如果s[i-1]为"("，则dp[i]=dp[i-2]+2；如果s[i-1]为")"且s[i-dp[i-1]-1]为"("，则dp[i]=dp[i-1]+2+dp[i-dp[i-1]-2]。时间复杂度O(n)，空间复杂度O(n)。';
    longestValidParentheses.hint = '使用动态规划，dp[i]表示以i结尾的最长有效括号长度';
    problems.push(longestValidParentheses);
    
    // 不同的子序列
    const numDistinct = new ProblemModel();
    numDistinct.id = 79;
    numDistinct.title = '不同的子序列';
    numDistinct.description = '给定一个字符串s和一个字符串t，计算在s的子序列中t出现的个数。字符串的一个子序列是指，通过删除一些（也可以不删除）字符且不干扰剩余字符相对位置所组成的新字符串。';
    numDistinct.difficulty = ProblemDifficulty.HARD;
    numDistinct.category = ProblemCategory.STRING;
    numDistinct.choices = [
      { id: 'A', text: '回溯法：递归枚举所有可能的子序列', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s[0:i]中t[0:j]的出现次数', isCorrect: true },
      { id: 'C', text: '贪心法：优先匹配靠前的字符', isCorrect: false },
      { id: 'D', text: '双指针：同时遍历两个字符串', isCorrect: false }
    ];
    numDistinct.explanation = '动态规划是标准解法。dp[i][j]表示s的前i个字符中包含t的前j个字符的子序列个数。状态转移：如果s[i-1]==t[j-1]，则dp[i][j]=dp[i-1][j-1]+dp[i-1][j]；否则dp[i][j]=dp[i-1][j]。时间复杂度O(mn)，空间复杂度O(mn)。';
    numDistinct.hint = '使用动态规划，考虑字符匹配和不匹配两种情况';
    problems.push(numDistinct);
    
    // 交错字符串
    const isInterleave = new ProblemModel();
    isInterleave.id = 80;
    isInterleave.title = '交错字符串';
    isInterleave.description = '给定三个字符串s1、s2、s3，请你帮忙验证s3是否是由s1和s2交错组成的。两个字符串s和t交错的定义与过程如下，其中每个字符串都会被分割成若干非空子字符串。';
    isInterleave.difficulty = ProblemDifficulty.MEDIUM;
    isInterleave.category = ProblemCategory.STRING;
    isInterleave.choices = [
      { id: 'A', text: '回溯法：递归尝试从s1或s2中选择字符', isCorrect: false },
      { id: 'B', text: '动态规划：dp[i][j]表示s1[0:i]和s2[0:j]能否交错组成s3[0:i+j]', isCorrect: true },
      { id: 'C', text: 'BFS：将问题看作图搜索', isCorrect: false },
      { id: 'D', text: '贪心法：优先选择匹配的字符串', isCorrect: false }
    ];
    isInterleave.explanation = '动态规划是最优解法。dp[i][j]表示s1的前i个字符和s2的前j个字符能否交错组成s3的前i+j个字符。状态转移：dp[i][j]为true当且仅当(dp[i-1][j]且s1[i-1]==s3[i+j-1])或(dp[i][j-1]且s2[j-1]==s3[i+j-1])。时间复杂度O(mn)，空间复杂度O(mn)。';
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
    reverseList.choices = [
      { id: 'A', text: '使用迭代方法，维护三个指针prev、curr、next', isCorrect: true },
      { id: 'B', text: '使用递归方法，先反转子链表再处理当前节点', isCorrect: false },
      { id: 'C', text: '使用栈存储所有节点，然后重新连接', isCorrect: false },
      { id: 'D', text: '使用数组存储所有节点值，然后重新创建链表', isCorrect: false }
    ];
    reverseList.explanation = '迭代方法是最直观且高效的解法。使用三个指针：prev（前一个节点）、curr（当前节点）、next（下一个节点）。遍历链表，将当前节点的next指向prev，然后移动三个指针。时间复杂度O(n)，空间复杂度O(1)。递归方法虽然代码简洁，但空间复杂度为O(n)。';
    reverseList.hint = '使用三个指针来改变链表的指向关系';
    problems.push(reverseList);
    
    // 环形链表
    const hasCycle = new ProblemModel();
    hasCycle.id = 7;
    hasCycle.title = '环形链表';
    hasCycle.description = '给你一个链表的头节点 head ，判断链表中是否有环。\n\n如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。';
    hasCycle.difficulty = ProblemDifficulty.EASY;
    hasCycle.category = ProblemCategory.LINKED_LIST;
    hasCycle.choices = [
      { id: 'A', text: '使用哈希表存储访问过的节点', isCorrect: false },
      { id: 'B', text: '使用快慢指针（Floyd判圈算法）', isCorrect: true },
      { id: 'C', text: '遍历链表并设置访问标记', isCorrect: false },
      { id: 'D', text: '限制遍历次数，超过阈值则认为有环', isCorrect: false }
    ];
    hasCycle.explanation = '快慢指针（Floyd判圈算法）是最优解法。使用两个指针，快指针每次移动两步，慢指针每次移动一步。如果链表有环，快指针最终会追上慢指针；如果没有环，快指针会先到达链表末尾。时间复杂度O(n)，空间复杂度O(1)。';
    hasCycle.hint = '考虑使用快慢指针，如果有环，快指针会追上慢指针';
    problems.push(hasCycle);

    // 合并两个有序链表
    const mergeTwoLists = new ProblemModel();
    mergeTwoLists.id = 81;
    mergeTwoLists.title = '合并两个有序链表';
    mergeTwoLists.description = '将两个升序链表合并为一个新的升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。';
    mergeTwoLists.difficulty = ProblemDifficulty.EASY;
    mergeTwoLists.category = ProblemCategory.LINKED_LIST;
    mergeTwoLists.choices = [
      { id: 'A', text: '使用递归方法比较节点值', isCorrect: true },
      { id: 'B', text: '使用迭代方法和虚拟头节点', isCorrect: false },
      { id: 'C', text: '先将所有节点存入数组排序', isCorrect: false },
      { id: 'D', text: '使用栈来处理节点顺序', isCorrect: false }
    ];
    mergeTwoLists.explanation = '可以使用递归或迭代方法。递归方法：比较两个链表头节点，选择较小的作为结果，递归处理剩余部分。迭代方法：使用虚拟头节点，依次比较并连接较小的节点。时间复杂度O(m+n)，空间复杂度递归O(m+n)，迭代O(1)。';
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
    removeNthFromEnd.explanation = '使用双指针技巧。让快指针先走n步，然后快慢指针同时移动，当快指针到达末尾时，慢指针指向要删除节点的前一个节点。使用虚拟头节点可以简化边界情况处理。时间复杂度O(n)，空间复杂度O(1)。';
    removeNthFromEnd.hint = '使用双指针，让快指针先走n步';
    problems.push(removeNthFromEnd);

    // 链表的中间节点
    const middleNode = new ProblemModel();
    middleNode.id = 83;
    middleNode.title = '链表的中间节点';
    middleNode.description = '给定一个头结点为 head 的非空单链表，返回链表的中间结点。如果有两个中间结点，则返回第二个中间结点。';
    middleNode.difficulty = ProblemDifficulty.EASY;
    middleNode.category = ProblemCategory.LINKED_LIST;
    middleNode.choices = [
      { id: 'A', text: '先遍历计算长度，再找到中间位置', isCorrect: false },
      { id: 'B', text: '使用快慢指针，快指针走两步慢指针走一步', isCorrect: true },
      { id: 'C', text: '使用数组存储所有节点', isCorrect: false },
      { id: 'D', text: '使用递归计算中间位置', isCorrect: false }
    ];
    middleNode.explanation = '使用快慢指针技巧。快指针每次移动两步，慢指针每次移动一步。当快指针到达链表末尾时，慢指针正好在中间位置。这种方法只需要一次遍历，时间复杂度O(n)，空间复杂度O(1)。';
    middleNode.hint = '使用快慢指针，当快指针到达末尾时慢指针在中间';
    problems.push(middleNode);

    // 回文链表
    const isPalindromeList = new ProblemModel();
    isPalindromeList.id = 84;
    isPalindromeList.title = '回文链表';
    isPalindromeList.description = '给你一个单链表的头节点 head ，请你判断该链表是否为回文链表。如果是，返回 true ；否则，返回 false 。';
    isPalindromeList.difficulty = ProblemDifficulty.EASY;
    isPalindromeList.category = ProblemCategory.LINKED_LIST;
    isPalindromeList.choices = [
      { id: 'A', text: '将链表值复制到数组中，然后检查数组是否回文', isCorrect: false },
      { id: 'B', text: '找到中点，反转后半部分，然后比较', isCorrect: true },
      { id: 'C', text: '使用递归比较首尾节点', isCorrect: false },
      { id: 'D', text: '使用栈存储前半部分节点', isCorrect: false }
    ];
    isPalindromeList.explanation = '最优解法：1.使用快慢指针找到链表中点；2.反转后半部分链表；3.比较前半部分和反转后的后半部分；4.恢复链表结构。时间复杂度O(n)，空间复杂度O(1)。数组方法简单但空间复杂度O(n)。';
    isPalindromeList.hint = '找到中点后反转后半部分链表进行比较';
    problems.push(isPalindromeList);

    // 相交链表
    const getIntersectionNode = new ProblemModel();
    getIntersectionNode.id = 85;
    getIntersectionNode.title = '相交链表';
    getIntersectionNode.description = '给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。';
    getIntersectionNode.difficulty = ProblemDifficulty.EASY;
    getIntersectionNode.category = ProblemCategory.LINKED_LIST;
    getIntersectionNode.choices = [
      { id: 'A', text: '使用哈希表存储一个链表的所有节点', isCorrect: false },
      { id: 'B', text: '双指针法，两个指针分别遍历两个链表', isCorrect: true },
      { id: 'C', text: '先计算两个链表的长度差', isCorrect: false },
      { id: 'D', text: '使用栈同时存储两个链表', isCorrect: false }
    ];
    getIntersectionNode.explanation = '双指针法：两个指针分别从两个链表头开始遍历，当到达末尾时跳转到另一个链表头继续遍历。如果有相交点，两个指针会在相交点相遇；如果没有相交点，两个指针会同时到达null。时间复杂度O(m+n)，空间复杂度O(1)。';
    getIntersectionNode.hint = '两个指针分别遍历两个链表，到达末尾时跳转到另一个链表';
    problems.push(getIntersectionNode);

    // 删除排序链表中的重复元素
    const deleteDuplicates = new ProblemModel();
    deleteDuplicates.id = 86;
    deleteDuplicates.title = '删除排序链表中的重复元素';
    deleteDuplicates.description = '给定一个已排序的链表的头 head ， 删除所有重复的元素，使每个元素只出现一次 。返回已排序的链表 。';
    deleteDuplicates.difficulty = ProblemDifficulty.EASY;
    deleteDuplicates.category = ProblemCategory.LINKED_LIST;
    deleteDuplicates.choices = [
      { id: 'A', text: '使用哈希表记录出现过的值', isCorrect: false },
      { id: 'B', text: '一次遍历，比较相邻节点值', isCorrect: true },
      { id: 'C', text: '使用递归删除重复节点', isCorrect: false },
      { id: 'D', text: '先转换为数组去重再重建链表', isCorrect: false }
    ];
    deleteDuplicates.explanation = '由于链表已排序，重复元素必定相邻。一次遍历链表，比较当前节点和下一个节点的值，如果相同则删除下一个节点，否则移动到下一个节点。时间复杂度O(n)，空间复杂度O(1)。';
    deleteDuplicates.hint = '利用链表已排序的特性，比较相邻节点';
    problems.push(deleteDuplicates);

    // 两数相加
    const addTwoNumbers = new ProblemModel();
    addTwoNumbers.id = 87;
    addTwoNumbers.title = '两数相加';
    addTwoNumbers.description = '给你两个非空的链表，表示两个非负的整数。它们每位数字都是按照逆序的方式存储的，并且每个节点只能存储一位数字。请你将两个数相加，并以相同形式返回一个表示和的链表。';
    addTwoNumbers.difficulty = ProblemDifficulty.MEDIUM;
    addTwoNumbers.category = ProblemCategory.LINKED_LIST;
    addTwoNumbers.choices = [
      { id: 'A', text: '同时遍历两个链表，处理进位', isCorrect: true },
      { id: 'B', text: '先转换为整数相加再转回链表', isCorrect: false },
      { id: 'C', text: '使用栈处理进位问题', isCorrect: false },
      { id: 'D', text: '递归处理每一位的相加', isCorrect: false }
    ];
    addTwoNumbers.explanation = '模拟加法运算。同时遍历两个链表，将对应位置的数字相加，注意处理进位。使用虚拟头节点简化代码。需要考虑链表长度不同和最后的进位情况。时间复杂度O(max(m,n))，空间复杂度O(max(m,n))。';
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
    rotateRight.explanation = '1.计算链表长度并形成环；2.计算实际旋转步数k%length；3.找到新的尾节点（第length-k个节点）；4.断开环形成新链表。时间复杂度O(n)，空间复杂度O(1)。';
    rotateRight.hint = '先形成环，然后在合适的位置断开';
    problems.push(rotateRight);

    // 分隔链表
    const partition = new ProblemModel();
    partition.id = 89;
    partition.title = '分隔链表';
    partition.description = '给你一个链表的头节点 head 和一个特定值 x ，请你对链表进行分隔，使得所有小于 x 的节点都出现在大于或等于 x 的节点之前。';
    partition.difficulty = ProblemDifficulty.MEDIUM;
    partition.category = ProblemCategory.LINKED_LIST;
    partition.choices = [
      { id: 'A', text: '使用两个虚拟头节点分别存储小于和大于等于x的节点', isCorrect: true },
      { id: 'B', text: '在原链表上直接移动节点', isCorrect: false },
      { id: 'C', text: '使用数组存储节点再重新排列', isCorrect: false },
      { id: 'D', text: '使用递归分别处理两部分', isCorrect: false }
    ];
    partition.explanation = '使用两个虚拟头节点分别构建两个链表：一个存储小于x的节点，另一个存储大于等于x的节点。遍历原链表，根据节点值将节点添加到对应链表。最后将两个链表连接。时间复杂度O(n)，空间复杂度O(1)。';
    partition.hint = '使用两个链表分别存储小于和大于等于x的节点';
    problems.push(partition);

    // 复制带随机指针的链表
    const copyRandomList = new ProblemModel();
    copyRandomList.id = 90;
    copyRandomList.title = '复制带随机指针的链表';
    copyRandomList.description = '给你一个长度为 n 的链表，每个节点包含一个额外增加的随机指针 random ，该指针可以指向链表中的任何节点或空节点。';
    copyRandomList.difficulty = ProblemDifficulty.MEDIUM;
    copyRandomList.category = ProblemCategory.LINKED_LIST;
    copyRandomList.choices = [
      { id: 'A', text: '使用哈希表建立原节点和新节点的映射关系', isCorrect: true },
      { id: 'B', text: '在原链表中插入新节点再分离', isCorrect: false },
      { id: 'C', text: '先复制next指针再处理random指针', isCorrect: false },
      { id: 'D', text: '使用递归复制每个节点', isCorrect: false }
    ];
    copyRandomList.explanation = '方法1：使用哈希表。第一次遍历创建所有新节点并建立映射，第二次遍历设置next和random指针。方法2：在原链表中插入新节点，设置random指针后再分离。时间复杂度O(n)，空间复杂度哈希表O(n)，插入法O(1)。';
    copyRandomList.hint = '使用哈希表建立原节点和新节点的映射关系';
    problems.push(copyRandomList);

    // 重排链表
    const reorderList = new ProblemModel();
    reorderList.id = 91;
    reorderList.title = '重排链表';
    reorderList.description = '给定一个单链表 L 的头节点 head ，单链表 L 表示为：L0 → L1 → … → Ln - 1 → Ln。请将其重新排列后变为：L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …';
    reorderList.difficulty = ProblemDifficulty.MEDIUM;
    reorderList.category = ProblemCategory.LINKED_LIST;
    reorderList.choices = [
      { id: 'A', text: '找到中点，反转后半部分，然后交替合并', isCorrect: true },
      { id: 'B', text: '使用数组存储所有节点再重新连接', isCorrect: false },
      { id: 'C', text: '使用栈存储后半部分节点', isCorrect: false },
      { id: 'D', text: '使用递归处理重排逻辑', isCorrect: false }
    ];
    reorderList.explanation = '1.使用快慢指针找到链表中点；2.反转后半部分链表；3.交替合并前半部分和反转后的后半部分。这种方法时间复杂度O(n)，空间复杂度O(1)，是最优解法。';
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
    sortList.explanation = '使用归并排序。1.使用快慢指针找到中点分割链表；2.递归排序左右两部分；3.合并两个有序链表。时间复杂度O(nlogn)，空间复杂度O(logn)（递归栈）。这是链表排序的最优解法。';
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
    detectCycle.explanation = 'Floyd算法：1.快慢指针找到相遇点；2.一个指针从头开始，一个从相遇点开始，每次都走一步；3.两指针相遇的地方就是入环点。数学原理：设头到入环点距离a，入环点到相遇点距离b，相遇点到入环点距离c，则a=c。';
    detectCycle.hint = '先用快慢指针找相遇点，再用数学关系找入环点';
    problems.push(detectCycle);

    // 合并K个升序链表
    const mergeKLists = new ProblemModel();
    mergeKLists.id = 94;
    mergeKLists.title = '合并K个升序链表';
    mergeKLists.description = '给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。';
    mergeKLists.difficulty = ProblemDifficulty.HARD;
    mergeKLists.category = ProblemCategory.LINKED_LIST;
    mergeKLists.choices = [
      { id: 'A', text: '逐一合并链表', isCorrect: false },
      { id: 'B', text: '使用分治法两两合并', isCorrect: true },
      { id: 'C', text: '使用优先队列（最小堆）', isCorrect: false },
      { id: 'D', text: '将所有节点放入数组排序后重建', isCorrect: false }
    ];
    mergeKLists.explanation = '分治法是最优解：1.将k个链表两两配对合并；2.重复此过程直到只剩一个链表。时间复杂度O(Nlogk)，N是所有节点总数。优先队列法也可行但常数较大。逐一合并时间复杂度O(Nk)较差。';
    mergeKLists.hint = '使用分治法，将k个链表两两合并';
    problems.push(mergeKLists);

    // 反转链表II
    const reverseBetween = new ProblemModel();
    reverseBetween.id = 95;
    reverseBetween.title = '反转链表II';
    reverseBetween.description = '给你单链表的头指针 head 和两个整数 left 和 right ，其中 left <= right 。请你反转从位置 left 到位置 right 的链表节点，返回反转后的链表 。';
    reverseBetween.difficulty = ProblemDifficulty.MEDIUM;
    reverseBetween.category = ProblemCategory.LINKED_LIST;
    reverseBetween.choices = [
      { id: 'A', text: '找到反转区间，使用迭代法反转', isCorrect: true },
      { id: 'B', text: '使用递归反转指定区间', isCorrect: false },
      { id: 'C', text: '使用栈存储区间内的节点', isCorrect: false },
      { id: 'D', text: '转换为数组处理后重建链表', isCorrect: false }
    ];
    reverseBetween.explanation = '1.使用虚拟头节点简化边界处理；2.找到反转区间的前一个节点；3.在区间内使用迭代法反转链表；4.连接反转后的部分。关键是正确处理指针的连接关系。时间复杂度O(n)，空间复杂度O(1)。';
    reverseBetween.hint = '找到反转区间，使用迭代法局部反转';
    problems.push(reverseBetween);

    // 删除排序链表中的重复元素II
    const deleteDuplicatesII = new ProblemModel();
    deleteDuplicatesII.id = 96;
    deleteDuplicatesII.title = '删除排序链表中的重复元素II';
    deleteDuplicatesII.description = '给定一个已排序的链表的头 head ， 删除原始链表中所有重复数字的节点，只留下不同数字的节点 。返回已排序的链表 。';
    deleteDuplicatesII.difficulty = ProblemDifficulty.MEDIUM;
    deleteDuplicatesII.category = ProblemCategory.LINKED_LIST;
    deleteDuplicatesII.choices = [
      { id: 'A', text: '使用虚拟头节点，跳过所有重复的节点', isCorrect: true },
      { id: 'B', text: '使用哈希表记录节点出现次数', isCorrect: false },
      { id: 'C', text: '使用递归删除重复节点', isCorrect: false },
      { id: 'D', text: '先标记重复节点再删除', isCorrect: false }
    ];
    deleteDuplicatesII.explanation = '使用虚拟头节点和双指针。prev指向当前确定保留的最后一个节点，curr用于探测重复。当发现重复时，跳过所有相同值的节点。关键是正确判断重复区间的开始和结束。时间复杂度O(n)，空间复杂度O(1)。';
    deleteDuplicatesII.hint = '使用虚拟头节点，跳过所有重复值的节点';
    problems.push(deleteDuplicatesII);

    // 奇偶链表
    const oddEvenList = new ProblemModel();
    oddEvenList.id = 97;
    oddEvenList.title = '奇偶链表';
    oddEvenList.description = '给定单链表的头节点 head ，将所有索引为奇数的节点和索引为偶数的节点分别组合在一起，然后返回重新排序的列表。';
    oddEvenList.difficulty = ProblemDifficulty.MEDIUM;
    oddEvenList.category = ProblemCategory.LINKED_LIST;
    oddEvenList.choices = [
      { id: 'A', text: '使用两个指针分别处理奇偶位置的节点', isCorrect: true },
      { id: 'B', text: '使用数组存储奇偶位置的节点', isCorrect: false },
      { id: 'C', text: '使用递归分别处理奇偶节点', isCorrect: false },
      { id: 'D', text: '创建两个新链表分别存储奇偶节点', isCorrect: false }
    ];
    oddEvenList.explanation = '使用两个指针odd和even分别指向奇偶位置的节点，同时移动这两个指针，将奇数位置的节点连在一起，偶数位置的节点连在一起，最后将奇数链表的尾部连接到偶数链表的头部。时间复杂度O(n)，空间复杂度O(1)。';
    oddEvenList.hint = '使用两个指针分别连接奇偶位置的节点';
    problems.push(oddEvenList);

    // 两两交换链表中的节点
    const swapPairs = new ProblemModel();
    swapPairs.id = 98;
    swapPairs.title = '两两交换链表中的节点';
    swapPairs.description = '给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改链表节点值的情况下完成本题（即，只能进行节点交换）。';
    swapPairs.difficulty = ProblemDifficulty.MEDIUM;
    swapPairs.category = ProblemCategory.LINKED_LIST;
    swapPairs.choices = [
      { id: 'A', text: '使用递归交换每一对节点', isCorrect: false },
      { id: 'B', text: '使用迭代法和虚拟头节点', isCorrect: true },
      { id: 'C', text: '使用栈存储节点对', isCorrect: false },
      { id: 'D', text: '直接交换节点的值', isCorrect: false }
    ];
    swapPairs.explanation = '使用迭代法：1.创建虚拟头节点；2.使用prev指针指向每对节点的前一个节点；3.交换当前对节点的指针关系；4.更新prev指针到下一对。需要仔细处理指针的连接顺序。时间复杂度O(n)，空间复杂度O(1)。';
    swapPairs.hint = '使用虚拟头节点，迭代交换每一对相邻节点';
    problems.push(swapPairs);

    // K个一组翻转链表
    const reverseKGroup = new ProblemModel();
    reverseKGroup.id = 99;
    reverseKGroup.title = 'K个一组翻转链表';
    reverseKGroup.description = '给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。';
    reverseKGroup.difficulty = ProblemDifficulty.HARD;
    reverseKGroup.category = ProblemCategory.LINKED_LIST;
    reverseKGroup.choices = [
      { id: 'A', text: '先检查是否有k个节点，然后反转这k个节点', isCorrect: true },
      { id: 'B', text: '使用递归处理每k个节点', isCorrect: false },
      { id: 'C', text: '使用栈存储k个节点再重新连接', isCorrect: false },
      { id: 'D', text: '转换为数组处理后重建链表', isCorrect: false }
    ];
    reverseKGroup.explanation = '1.先遍历检查是否有k个节点；2.如果有，反转这k个节点；3.递归处理剩余部分；4.连接反转后的部分和剩余部分。关键是正确处理反转后的连接关系和边界情况。时间复杂度O(n)，空间复杂度O(1)。';
    reverseKGroup.hint = '先检查节点数量，然后分组反转并正确连接';
    problems.push(reverseKGroup);

    // 扁平化多级双向链表
    const flatten = new ProblemModel();
    flatten.id = 100;
    flatten.title = '扁平化多级双向链表';
    flatten.description = '你会得到一个双向链表，除了下一个和前一个指针之外，它还有一个子指针，可能指向单独的双向链表。这些子列表也可能会有一个或多个自己的子项，依此类推，生成多级数据结构。给你位于列表第一级的头节点，请扁平化列表，使所有结点出现在单级双链表中。';
    flatten.difficulty = ProblemDifficulty.MEDIUM;
    flatten.category = ProblemCategory.LINKED_LIST;
    flatten.choices = [
      { id: 'A', text: '使用深度优先搜索遍历所有节点', isCorrect: true },
      { id: 'B', text: '使用栈存储分支节点', isCorrect: false },
      { id: 'C', text: '使用队列进行广度优先搜索', isCorrect: false },
      { id: 'D', text: '使用递归处理每个子链表', isCorrect: false }
    ];
    flatten.explanation = '使用DFS：遍历链表，当遇到有子节点的节点时，将当前节点的next保存，然后将子链表插入到当前位置，继续遍历子链表，处理完子链表后再处理之前保存的next部分。需要正确维护双向指针关系。';
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
    maxDepth.choices = [
      { id: 'A', text: '使用递归：深度 = 1 + max(左子树深度, 右子树深度)', isCorrect: true },
      { id: 'B', text: '使用层序遍历（BFS），统计层数', isCorrect: false },
      { id: 'C', text: '使用前序遍历，维护当前深度的最大值', isCorrect: false },
      { id: 'D', text: '使用后序遍历，自底向上计算深度', isCorrect: false }
    ];
    maxDepth.explanation = '递归是最直观的解法。二叉树的最大深度等于左右子树最大深度的较大值加1。递归终止条件是节点为空时返回0。时间复杂度O(n)，空间复杂度O(h)，其中h是树的高度。层序遍历也可以解决，但代码相对复杂。';
    maxDepth.hint = '考虑递归：当前树的深度 = 1 + 左右子树深度的最大值';
    problems.push(maxDepth);
    
    // 对称二叉树
    const isSymmetric = new ProblemModel();
    isSymmetric.id = 9;
    isSymmetric.title = '对称二叉树';
    isSymmetric.description = '给你一个二叉树的根节点 root ， 检查它是否轴对称。';
    isSymmetric.difficulty = ProblemDifficulty.EASY;
    isSymmetric.category = ProblemCategory.BINARY_TREE;
    isSymmetric.choices = [
      { id: 'A', text: '使用递归比较左右子树是否镜像对称', isCorrect: true },
      { id: 'B', text: '使用层序遍历，检查每层是否回文', isCorrect: false },
      { id: 'C', text: '使用中序遍历，检查结果是否回文', isCorrect: false },
      { id: 'D', text: '使用前序遍历和后序遍历比较', isCorrect: false }
    ];
    isSymmetric.explanation = '递归比较是最优解法。定义一个辅助函数比较两个子树是否镜像：左子树的左节点与右子树的右节点相等，左子树的右节点与右子树的左节点相等。时间复杂度O(n)，空间复杂度O(h)。';
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
    inorderTraversal.explanation = '中序遍历顺序：左子树 -> 根节点 -> 右子树。递归实现最简单，迭代实现使用栈，Morris遍历可以实现O(1)空间复杂度。对于二叉搜索树，中序遍历结果是有序的。';
    inorderTraversal.hint = '递归遍历：先左子树，再根节点，最后右子树';
    problems.push(inorderTraversal);

    // 相同的树
    const isSameTree = new ProblemModel();
    isSameTree.id = 102;
    isSameTree.title = '相同的树';
    isSameTree.description = '给你两棵二叉树的根节点 p 和 q ，编写一个函数来检验这两棵树是否相同。如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。';
    isSameTree.difficulty = ProblemDifficulty.EASY;
    isSameTree.category = ProblemCategory.BINARY_TREE;
    isSameTree.choices = [
      { id: 'A', text: '递归比较两个树的每个节点', isCorrect: true },
      { id: 'B', text: '分别遍历两个树，比较遍历结果', isCorrect: false },
      { id: 'C', text: '使用层序遍历同时比较', isCorrect: false },
      { id: 'D', text: '比较树的高度和节点数', isCorrect: false }
    ];
    isSameTree.explanation = '递归比较：如果两个节点都为空则相同；如果一个为空另一个不为空则不同；如果值不同则不同；否则递归比较左右子树。时间复杂度O(min(m,n))，空间复杂度O(min(m,n))。';
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
    levelOrder.explanation = '使用队列实现BFS。初始时将根节点入队，然后循环：记录当前层节点数，依次出队并将子节点入队。每层的节点值组成一个数组。时间复杂度O(n)，空间复杂度O(n)。';
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
    minDepth.explanation = '递归解法需要注意：如果一个节点只有一个子树，最小深度不是1+0=1，而是1+另一个子树的最小深度。只有当节点是叶子节点时，深度才是1。层序遍历也可以，遇到第一个叶子节点就返回。';
    minDepth.hint = '注意只有一个子树的节点，最小深度不是1';
    problems.push(minDepth);

    // 路径总和
    const hasPathSum = new ProblemModel();
    hasPathSum.id = 105;
    hasPathSum.title = '路径总和';
    hasPathSum.description = '给你二叉树的根节点 root 和一个表示目标和的整数 targetSum 。判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和 targetSum 。';
    hasPathSum.difficulty = ProblemDifficulty.EASY;
    hasPathSum.category = ProblemCategory.BINARY_TREE;
    hasPathSum.choices = [
      { id: 'A', text: '递归遍历，每次减去当前节点值', isCorrect: true },
      { id: 'B', text: '使用深度优先搜索，维护路径和', isCorrect: false },
      { id: 'C', text: '使用广度优先搜索，同时记录路径和', isCorrect: false },
      { id: 'D', text: '先遍历所有路径，再检查和', isCorrect: false }
    ];
    hasPathSum.explanation = '递归解法：每次递归时将目标和减去当前节点值，当到达叶子节点时检查剩余目标和是否为0。时间复杂度O(n)，空间复杂度O(h)。注意叶子节点的定义：左右子树都为空。';
    hasPathSum.hint = '递归时减去当前节点值，叶子节点时检查是否为0';
    problems.push(hasPathSum);

    // 从前序与中序遍历序列构造二叉树
    const buildTree = new ProblemModel();
    buildTree.id = 106;
    buildTree.title = '从前序与中序遍历序列构造二叉树';
    buildTree.description = '给定两个整数数组 preorder 和 inorder ，其中 preorder 是二叉树的前序遍历， inorder 是同一棵树的中序遍历，请构造二叉树并返回其根节点。';
    buildTree.difficulty = ProblemDifficulty.MEDIUM;
    buildTree.category = ProblemCategory.BINARY_TREE;
    buildTree.choices = [
      { id: 'A', text: '前序确定根节点，中序确定左右子树范围', isCorrect: true },
      { id: 'B', text: '同时遍历两个数组构建树', isCorrect: false },
      { id: 'C', text: '使用栈模拟构建过程', isCorrect: false },
      { id: 'D', text: '先构建所有节点再连接', isCorrect: false }
    ];
    buildTree.explanation = '递归构建：前序遍历的第一个元素是根节点，在中序遍历中找到根节点位置，左边是左子树，右边是右子树。递归构建左右子树。使用哈希表优化中序遍历中根节点的查找。时间复杂度O(n)，空间复杂度O(n)。';
    buildTree.hint = '前序确定根，中序确定左右子树边界';
    problems.push(buildTree);

    // 二叉树的锯齿形层序遍历
    const zigzagLevelOrder = new ProblemModel();
    zigzagLevelOrder.id = 107;
    zigzagLevelOrder.title = '二叉树的锯齿形层序遍历';
    zigzagLevelOrder.description = '给你二叉树的根节点 root ，返回其节点值的锯齿形层序遍历。（即先从左往右，再从右往左进行下一层遍历，以此类推，层与层之间交替进行）。';
    zigzagLevelOrder.difficulty = ProblemDifficulty.MEDIUM;
    zigzagLevelOrder.category = ProblemCategory.BINARY_TREE;
    zigzagLevelOrder.choices = [
      { id: 'A', text: '层序遍历，奇数层反转结果', isCorrect: true },
      { id: 'B', text: '使用两个栈交替存储', isCorrect: false },
      { id: 'C', text: '使用双端队列', isCorrect: false },
      { id: 'D', text: '递归遍历，根据层数决定顺序', isCorrect: false }
    ];
    zigzagLevelOrder.explanation = '在普通层序遍历基础上，根据层数奇偶性决定是否反转当前层结果。也可以使用双端队列或两个栈实现。时间复杂度O(n)，空间复杂度O(n)。';
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
    isValidBST.explanation = '递归验证时需要传递上下界。对于每个节点，其值必须在(min, max)范围内，左子树的上界是当前节点值，右子树的下界是当前节点值。中序遍历也可以，但需要注意相等值的处理。';
    isValidBST.hint = '递归时传递上下界限制，不只是比较父子节点';
    problems.push(isValidBST);

    // 二叉树的右视图
    const rightSideView = new ProblemModel();
    rightSideView.id = 109;
    rightSideView.title = '二叉树的右视图';
    rightSideView.description = '给定一个二叉树的根节点 root，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。';
    rightSideView.difficulty = ProblemDifficulty.MEDIUM;
    rightSideView.category = ProblemCategory.BINARY_TREE;
    rightSideView.choices = [
      { id: 'A', text: '层序遍历，取每层最后一个节点', isCorrect: true },
      { id: 'B', text: '深度优先搜索，优先遍历右子树', isCorrect: false },
      { id: 'C', text: '前序遍历，记录每层第一次访问的节点', isCorrect: false },
      { id: 'D', text: '中序遍历，找到最右边的节点', isCorrect: false }
    ];
    rightSideView.explanation = '层序遍历每层最后一个节点就是右视图。也可以用DFS，优先遍历右子树，每层第一次访问的节点就是右视图节点。时间复杂度O(n)，空间复杂度O(n)。';
    rightSideView.hint = '层序遍历，每层的最后一个节点就是右视图';
    problems.push(rightSideView);

    // 二叉树展开为链表
    const flatten = new ProblemModel();
    flatten.id = 110;
    flatten.title = '二叉树展开为链表';
    flatten.description = '给你二叉树的根结点 root ，请你将它展开为一个单链表：展开后的单链表应该同样使用 TreeNode ，其中 right 子指针指向链表中下一个结点，而左子指针始终为 null 。';
    flatten.difficulty = ProblemDifficulty.MEDIUM;
    flatten.category = ProblemCategory.BINARY_TREE;
    flatten.choices = [
      { id: 'A', text: '前序遍历，重新连接节点', isCorrect: false },
      { id: 'B', text: '后序遍历，自底向上处理', isCorrect: true },
      { id: 'C', text: '使用栈存储节点', isCorrect: false },
      { id: 'D', text: 'Morris遍历算法', isCorrect: false }
    ];
    flatten.explanation = '后序遍历是最优解法：先处理右子树和左子树，然后将左子树插入到根节点和右子树之间。具体：将左子树的最右节点连接到右子树，然后将左子树移到右边，左指针置空。';
    flatten.hint = '后序遍历，将左子树插入到根节点和右子树之间';
    problems.push(flatten);

    // 路径总和II
    const pathSum = new ProblemModel();
    pathSum.id = 111;
    pathSum.title = '路径总和II';
    pathSum.description = '给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有从根节点到叶子节点路径总和等于给定目标和的路径。';
    pathSum.difficulty = ProblemDifficulty.MEDIUM;
    pathSum.category = ProblemCategory.BINARY_TREE;
    pathSum.choices = [
      { id: 'A', text: '深度优先搜索，回溯记录路径', isCorrect: true },
      { id: 'B', text: '广度优先搜索，记录路径和节点', isCorrect: false },
      { id: 'C', text: '先找到所有路径，再筛选符合条件的', isCorrect: false },
      { id: 'D', text: '使用动态规划记录路径', isCorrect: false }
    ];
    pathSum.explanation = 'DFS+回溯：遍历过程中维护当前路径和剩余目标和，到达叶子节点时检查目标和是否为0。回溯时需要移除当前节点。时间复杂度O(n²)，空间复杂度O(n)。';
    pathSum.hint = '深度优先搜索配合回溯，维护当前路径';
    problems.push(pathSum);

    // 二叉搜索树中第K小的元素
    const kthSmallest = new ProblemModel();
    kthSmallest.id = 112;
    kthSmallest.title = '二叉搜索树中第K小的元素';
    kthSmallest.description = '给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小的元素（从 1 开始计数）。';
    kthSmallest.difficulty = ProblemDifficulty.MEDIUM;
    kthSmallest.category = ProblemCategory.BINARY_TREE;
    kthSmallest.choices = [
      { id: 'A', text: '中序遍历，计数到第k个元素', isCorrect: true },
      { id: 'B', text: '层序遍历，使用优先队列', isCorrect: false },
      { id: 'C', text: '前序遍历，排序后取第k个', isCorrect: false },
      { id: 'D', text: '后序遍历，从小到大计数', isCorrect: false }
    ];
    kthSmallest.explanation = '利用BST的性质：中序遍历结果是有序的。进行中序遍历，计数到第k个元素时返回。可以用递归或迭代实现，迭代版本可以提前终止。时间复杂度O(H+k)，空间复杂度O(H)。';
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
    lowestCommonAncestor.explanation = '递归解法：如果当前节点是目标节点之一，返回当前节点；否则递归查找左右子树。如果左右子树都返回非空，说明两个目标节点分别在左右子树，当前节点是LCA；如果只有一边返回非空，返回非空的那一边。';
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
    lowestCommonAncestorBST.explanation = '利用BST性质：如果两个节点值都小于当前节点，LCA在左子树；如果都大于当前节点，LCA在右子树；否则当前节点就是LCA。可以用递归或迭代实现。时间复杂度O(h)，空间复杂度O(1)。';
    lowestCommonAncestorBST.hint = '利用BST性质，比较节点值确定搜索方向';
    problems.push(lowestCommonAncestorBST);

    // 二叉树的序列化与反序列化
    const serialize = new ProblemModel();
    serialize.id = 115;
    serialize.title = '二叉树的序列化与反序列化';
    serialize.description = '序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。';
    serialize.difficulty = ProblemDifficulty.HARD;
    serialize.category = ProblemCategory.BINARY_TREE;
    serialize.choices = [
      { id: 'A', text: '使用前序遍历，空节点用特殊符号表示', isCorrect: true },
      { id: 'B', text: '使用层序遍历，记录每层的节点', isCorrect: false },
      { id: 'C', text: '使用中序和前序遍历结合', isCorrect: false },
      { id: 'D', text: '使用后序遍历，自底向上构建', isCorrect: false }
    ];
    serialize.explanation = '前序遍历序列化：遍历时将节点值和空节点（用null表示）都记录下来。反序列化时按前序顺序重建树。也可以用层序遍历，但需要处理更多细节。关键是选择合适的遍历方式和空节点表示。';
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
    countNodes.explanation = '利用完全二叉树性质：比较左右子树高度，如果相等则左子树是满二叉树，节点数=2^h-1+1+右子树节点数；如果不等则右子树是满二叉树。时间复杂度O(log²n)，优于直接遍历的O(n)。';
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
    invertTree.explanation = '递归解法最简洁：交换当前节点的左右子树，然后递归翻转左右子树。也可以用迭代方法，使用栈或队列存储待处理的节点。时间复杂度O(n)，空间复杂度O(h)。';
    invertTree.hint = '递归交换每个节点的左右子树';
    problems.push(invertTree);

    // 二叉搜索树中的插入操作
    const insertIntoBST = new ProblemModel();
    insertIntoBST.id = 118;
    insertIntoBST.title = '二叉搜索树中的插入操作';
    insertIntoBST.description = '给定二叉搜索树（BST）的根节点 root 和要插入树中的值 value ，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。';
    insertIntoBST.difficulty = ProblemDifficulty.MEDIUM;
    insertIntoBST.category = ProblemCategory.BINARY_TREE;
    insertIntoBST.choices = [
      { id: 'A', text: '递归查找插入位置，在叶子节点插入', isCorrect: true },
      { id: 'B', text: '先找到插入位置，再调整树结构', isCorrect: false },
      { id: 'C', text: '插入后进行平衡调整', isCorrect: false },
      { id: 'D', text: '转换为数组插入后重建树', isCorrect: false }
    ];
    insertIntoBST.explanation = '利用BST性质递归查找：如果值小于当前节点值，插入左子树；如果大于，插入右子树；如果当前节点为空，创建新节点。插入操作不会破坏BST性质，且总是在叶子位置插入。时间复杂度O(h)。';
    insertIntoBST.hint = '利用BST性质递归查找插入位置';
    problems.push(insertIntoBST);

    // 删除二叉搜索树中的节点
    const deleteNode = new ProblemModel();
    deleteNode.id = 119;
    deleteNode.title = '删除二叉搜索树中的节点';
    deleteNode.description = '给定一个二叉搜索树的根节点 root 和一个值 key，删除二叉搜索树中的 key 对应的节点，并保证二叉搜索树的性质不变。返回二叉搜索树（有可能被更新）的根节点的引用。';
    deleteNode.difficulty = ProblemDifficulty.MEDIUM;
    deleteNode.category = ProblemCategory.BINARY_TREE;
    deleteNode.choices = [
      { id: 'A', text: '分情况处理：叶子节点、只有一个子树、有两个子树', isCorrect: true },
      { id: 'B', text: '先找到节点，再用中序遍历重建树', isCorrect: false },
      { id: 'C', text: '转换为数组删除后重建树', isCorrect: false },
      { id: 'D', text: '标记删除，不实际移除节点', isCorrect: false }
    ];
    deleteNode.explanation = '分三种情况：1.叶子节点直接删除；2.只有一个子树，用子树替换；3.有两个子树，用中序后继（右子树最小值）或中序前驱（左子树最大值）替换，然后递归删除后继/前驱节点。';
    deleteNode.hint = '分情况处理，有两个子树时用中序后继替换';
    problems.push(deleteNode);

    // 把二叉搜索树转换为累加树
    const convertBST = new ProblemModel();
    convertBST.id = 120;
    convertBST.title = '把二叉搜索树转换为累加树';
    convertBST.description = '给出二叉搜索树的根节点，该树的节点值各不相同，请你将其转换为累加树（Greater Sum Tree），使每个节点 node 的新值等于原树中大于或等于 node.val 的值之和。';
    convertBST.difficulty = ProblemDifficulty.MEDIUM;
    convertBST.category = ProblemCategory.BINARY_TREE;
    convertBST.choices = [
      { id: 'A', text: '反向中序遍历（右-根-左），累加节点值', isCorrect: true },
      { id: 'B', text: '先中序遍历得到有序数组，再计算累加和', isCorrect: false },
      { id: 'C', text: '层序遍历，计算每个节点的累加值', isCorrect: false },
      { id: 'D', text: '前序遍历，递归计算累加和', isCorrect: false }
    ];
    convertBST.explanation = '反向中序遍历（右-根-左）可以按从大到小的顺序访问节点。维护一个累加和变量，每访问一个节点就将其值加到累加和中，然后用累加和更新节点值。时间复杂度O(n)，空间复杂度O(h)。';
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
    climbStairs.description = '假设你正在爬楼梯。需要 n 阶你才能到达楼顶。\n\n每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？';
    climbStairs.difficulty = ProblemDifficulty.EASY;
    climbStairs.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    climbStairs.choices = [
      { id: 'A', text: '使用递归：f(n) = f(n-1) + f(n-2)', isCorrect: false },
      { id: 'B', text: '使用动态规划：dp[i] = dp[i-1] + dp[i-2]', isCorrect: true },
      { id: 'C', text: '使用数学公式直接计算', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有可能', isCorrect: false }
    ];
    climbStairs.explanation = '这是经典的斐波那契数列问题。到达第n阶的方法数等于到达第n-1阶和第n-2阶的方法数之和。使用动态规划避免重复计算，时间复杂度O(n)，空间复杂度可以优化到O(1)。直接递归会导致大量重复计算，时间复杂度为O(2^n)。';
    climbStairs.hint = '这是斐波那契数列问题，考虑动态规划避免重复计算';
    problems.push(climbStairs);

    // 最大子数组和
    const maxSubArray = new ProblemModel();
    maxSubArray.id = 141;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description = '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。';
    maxSubArray.difficulty = ProblemDifficulty.EASY;
    maxSubArray.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxSubArray.choices = [
      { id: 'A', text: '使用Kadane算法，动态规划', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '分治算法', isCorrect: false },
      { id: 'D', text: '前缀和优化', isCorrect: false }
    ];
    maxSubArray.explanation = 'Kadane算法：dp[i]表示以第i个元素结尾的最大子数组和。状态转移：dp[i] = max(nums[i], dp[i-1] + nums[i])。可以优化空间复杂度到O(1)。时间复杂度O(n)，是最优解法。';
    maxSubArray.hint = '使用Kadane算法，考虑当前元素是重新开始还是继续累加';
    problems.push(maxSubArray);

    // 打家劫舍
    const rob = new ProblemModel();
    rob.id = 142;
    rob.title = '打家劫舍';
    rob.description = '你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。';
    rob.difficulty = ProblemDifficulty.MEDIUM;
    rob.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    rob.choices = [
      { id: 'A', text: '动态规划：dp[i] = max(dp[i-1], dp[i-2] + nums[i])', isCorrect: true },
      { id: 'B', text: '贪心算法：总是选择最大值', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有可能', isCorrect: false },
      { id: 'D', text: '分治算法：分别考虑偷和不偷', isCorrect: false }
    ];
    rob.explanation = '经典动态规划问题。dp[i]表示前i间房屋能偷到的最大金额。对于第i间房屋，可以选择偷（dp[i-2] + nums[i]）或不偷（dp[i-1]），取最大值。时间复杂度O(n)，空间复杂度可优化到O(1)。';
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
    lengthOfLIS.explanation = 'DP解法：dp[i]表示以nums[i]结尾的最长递增子序列长度。对于每个i，遍历前面所有j，如果nums[j] < nums[i]，则dp[i] = max(dp[i], dp[j] + 1)。时间复杂度O(n²)。贪心+二分可优化到O(nlogn)。';
    lengthOfLIS.hint = '考虑以每个元素结尾的最长递增子序列';
    problems.push(lengthOfLIS);

    // 零钱兑换
    const coinChange = new ProblemModel();
    coinChange.id = 144;
    coinChange.title = '零钱兑换';
    coinChange.description = '给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。计算并返回可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1 。';
    coinChange.difficulty = ProblemDifficulty.MEDIUM;
    coinChange.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    coinChange.choices = [
      { id: 'A', text: '动态规划：dp[i]表示凑成金额i所需的最少硬币数', isCorrect: true },
      { id: 'B', text: '贪心算法：优先使用大面额硬币', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有组合', isCorrect: false },
      { id: 'D', text: 'BFS：层序遍历所有可能', isCorrect: false }
    ];
    coinChange.explanation = '完全背包问题变种。dp[i]表示凑成金额i的最少硬币数。状态转移：dp[i] = min(dp[i], dp[i-coin] + 1)，遍历所有硬币面额。初始化dp[0] = 0，其他为无穷大。时间复杂度O(amount * coins.length)。';
    coinChange.hint = '完全背包问题，考虑每种硬币可以使用多次';
    problems.push(coinChange);

    // 最长公共子序列
    const longestCommonSubsequence = new ProblemModel();
    longestCommonSubsequence.id = 145;
    longestCommonSubsequence.title = '最长公共子序列';
    longestCommonSubsequence.description = '给定两个字符串 text1 和 text2，返回这两个字符串的最长公共子序列的长度。如果不存在公共子序列，返回 0 。';
    longestCommonSubsequence.difficulty = ProblemDifficulty.MEDIUM;
    longestCommonSubsequence.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    longestCommonSubsequence.choices = [
      { id: 'A', text: '二维DP：dp[i][j]表示text1前i个字符和text2前j个字符的LCS长度', isCorrect: true },
      { id: 'B', text: '递归+记忆化搜索', isCorrect: false },
      { id: 'C', text: '贪心算法：逐个匹配字符', isCorrect: false },
      { id: 'D', text: '双指针：同时遍历两个字符串', isCorrect: false }
    ];
    longestCommonSubsequence.explanation = '经典二维DP问题。如果text1[i-1] == text2[j-1]，则dp[i][j] = dp[i-1][j-1] + 1；否则dp[i][j] = max(dp[i-1][j], dp[i][j-1])。时间复杂度O(m*n)，空间复杂度可优化到O(min(m,n))。';
    longestCommonSubsequence.hint = '二维DP，考虑字符相等和不等两种情况';
    problems.push(longestCommonSubsequence);

    // 编辑距离
    const minDistance = new ProblemModel();
    minDistance.id = 146;
    minDistance.title = '编辑距离';
    minDistance.description = '给你两个单词 word1 和 word2， 请返回将 word1 转换成 word2 所使用的最少操作数。你可以对一个单词进行如下三种操作：插入一个字符、删除一个字符、替换一个字符。';
    minDistance.difficulty = ProblemDifficulty.HARD;
    minDistance.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    minDistance.choices = [
      { id: 'A', text: '二维DP：考虑插入、删除、替换三种操作', isCorrect: true },
      { id: 'B', text: '贪心算法：优先进行代价最小的操作', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有操作序列', isCorrect: false },
      { id: 'D', text: 'BFS：层序遍历所有可能的状态', isCorrect: false }
    ];
    minDistance.explanation = 'Levenshtein距离问题。dp[i][j]表示word1前i个字符转换为word2前j个字符的最少操作数。如果字符相等，dp[i][j] = dp[i-1][j-1]；否则考虑三种操作的最小值加1。时间复杂度O(m*n)。';
    minDistance.hint = '考虑插入、删除、替换三种操作，取最小值';
    problems.push(minDistance);

    // 不同路径
    const uniquePaths = new ProblemModel();
    uniquePaths.id = 147;
    uniquePaths.title = '不同路径';
    uniquePaths.description = '一个机器人位于一个 m x n 网格的左上角。机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角。问总共有多少条不同的路径？';
    uniquePaths.difficulty = ProblemDifficulty.MEDIUM;
    uniquePaths.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    uniquePaths.choices = [
      { id: 'A', text: '动态规划：dp[i][j] = dp[i-1][j] + dp[i][j-1]', isCorrect: true },
      { id: 'B', text: '数学公式：组合数C(m+n-2, m-1)', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有路径', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索', isCorrect: false }
    ];
    uniquePaths.explanation = '经典路径计数问题。到达位置(i,j)的路径数等于到达(i-1,j)和(i,j-1)的路径数之和。边界条件：第一行和第一列都是1。时间复杂度O(m*n)，空间复杂度可优化到O(min(m,n))。也可用组合数学公式直接计算。';
    uniquePaths.hint = '到达某点的路径数等于其上方和左方路径数之和';
    problems.push(uniquePaths);

    // 最小路径和
    const minPathSum = new ProblemModel();
    minPathSum.id = 148;
    minPathSum.title = '最小路径和';
    minPathSum.description = '给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。说明：每次只能向下或者向右移动一步。';
    minPathSum.difficulty = ProblemDifficulty.MEDIUM;
    minPathSum.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    minPathSum.choices = [
      { id: 'A', text: '动态规划：dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]', isCorrect: true },
      { id: 'B', text: '贪心算法：每次选择较小的相邻值', isCorrect: false },
      { id: 'C', text: 'Dijkstra算法：最短路径算法', isCorrect: false },
      { id: 'D', text: 'A*算法：启发式搜索', isCorrect: false }
    ];
    minPathSum.explanation = '路径优化问题。dp[i][j]表示到达位置(i,j)的最小路径和。状态转移：从上方或左方选择较小值加上当前格子值。边界条件需要特殊处理。时间复杂度O(m*n)，可以原地修改节省空间。';
    minPathSum.hint = '选择上方和左方路径和的较小值，加上当前位置的值';
    problems.push(minPathSum);

    // 买卖股票的最佳时机
    const maxProfit = new ProblemModel();
    maxProfit.id = 149;
    maxProfit.title = '买卖股票的最佳时机';
    maxProfit.description = '给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。你只能选择某一天买入这只股票，并选择在未来的某一天卖出该股票。设计一个算法来计算你所能获取的最大利润。';
    maxProfit.difficulty = ProblemDifficulty.EASY;
    maxProfit.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProfit.choices = [
      { id: 'A', text: '一次遍历：记录最低价格，计算最大利润', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示第i天的最大利润', isCorrect: false },
      { id: 'C', text: '暴力枚举：所有买卖组合', isCorrect: false },
      { id: 'D', text: '分治算法：分别处理左右两部分', isCorrect: false }
    ];
    maxProfit.explanation = '贪心思想：维护到目前为止的最低价格，计算当前价格卖出的利润。一次遍历即可解决，时间复杂度O(n)，空间复杂度O(1)。也可以用DP思想：维护持有和不持有股票的最大利润。';
    maxProfit.hint = '记录历史最低价格，计算当前卖出的最大利润';
    problems.push(maxProfit);

    // 买卖股票的最佳时机II
    const maxProfitII = new ProblemModel();
    maxProfitII.id = 150;
    maxProfitII.title = '买卖股票的最佳时机II';
    maxProfitII.description = '给你一个整数数组 prices ，其中 prices[i] 表示某支股票第 i 天的价格。在每一天，你可以决定是否购买和/或出售股票。你在任何时候最多只能持有一股股票。你也可以先购买，然后在同一天出售。';
    maxProfitII.difficulty = ProblemDifficulty.MEDIUM;
    maxProfitII.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProfitII.choices = [
      { id: 'A', text: '贪心算法：累加所有正收益', isCorrect: true },
      { id: 'B', text: '动态规划：维护持有和不持有股票的状态', isCorrect: false },
      { id: 'C', text: '回溯算法：枚举所有买卖策略', isCorrect: false },
      { id: 'D', text: '分治算法：分别处理不同时间段', isCorrect: false }
    ];
    maxProfitII.explanation = '贪心策略：只要第二天价格比今天高就买入并在第二天卖出，累加所有正收益。等价于累加所有相邻上升的差值。时间复杂度O(n)，空间复杂度O(1)。DP解法也可以，但贪心更简洁。';
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
      { id: 'A', text: '区间DP：dp[i][j]表示s[i..j]的最长回文子序列长度', isCorrect: true },
      { id: 'B', text: '中心扩展：以每个字符为中心扩展', isCorrect: false },
      { id: 'C', text: '递归+记忆化：从两端向中间递归', isCorrect: false },
      { id: 'D', text: '转换为LCS：s与reverse(s)的最长公共子序列', isCorrect: false }
    ];
    longestPalindromeSubseq.explanation = '区间DP问题。如果s[i] == s[j]，则dp[i][j] = dp[i+1][j-1] + 2；否则dp[i][j] = max(dp[i+1][j], dp[i][j-1])。注意遍历顺序：按区间长度从小到大。时间复杂度O(n²)，空间复杂度O(n²)。';
    longestPalindromeSubseq.hint = '区间DP，考虑两端字符相等和不等的情况';
    problems.push(longestPalindromeSubseq);

    // 分割等和子集
    const canPartition = new ProblemModel();
    canPartition.id = 152;
    canPartition.title = '分割等和子集';
    canPartition.description = '给你一个只包含正整数的非空数组 nums 。请你判断是否可以将这个数组分割成两个子集，使得两个子集的元素和相等。';
    canPartition.difficulty = ProblemDifficulty.MEDIUM;
    canPartition.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    canPartition.choices = [
      { id: 'A', text: '0-1背包问题：目标是数组和的一半', isCorrect: true },
      { id: 'B', text: '回溯算法：枚举所有子集', isCorrect: false },
      { id: 'C', text: '贪心算法：优先选择大的数字', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索所有可能', isCorrect: false }
    ];
    canPartition.explanation = '转换为0-1背包问题：能否用数组中的数字凑成总和的一半。dp[i]表示是否能凑成和为i。状态转移：dp[i] = dp[i] || dp[i-num]。优化：从后往前遍历避免重复使用。时间复杂度O(n*sum)。';
    canPartition.hint = '转换为背包问题，目标是凑成总和的一半';
    problems.push(canPartition);

    // 目标和
    const findTargetSumWays = new ProblemModel();
    findTargetSumWays.id = 153;
    findTargetSumWays.title = '目标和';
    findTargetSumWays.description = '给你一个整数数组 nums 和一个整数 target 。向数组中的每个整数前添加 + 或 - ，然后串联起所有整数，可以构造一个表达式。返回可以通过上述方法构造的、运算结果等于 target 的不同表达式的数目。';
    findTargetSumWays.difficulty = ProblemDifficulty.MEDIUM;
    findTargetSumWays.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    findTargetSumWays.choices = [
      { id: 'A', text: '转换为0-1背包：找到和为(sum+target)/2的子集个数', isCorrect: true },
      { id: 'B', text: '回溯算法：枚举每个数字的正负号', isCorrect: false },
      { id: 'C', text: 'DFS+记忆化：递归搜索所有可能', isCorrect: false },
      { id: 'D', text: '动态规划：dp[i][j]表示前i个数字和为j的方案数', isCorrect: false }
    ];
    findTargetSumWays.explanation = '数学转换：设正数和为P，负数和为N，则P-N=target，P+N=sum，解得P=(sum+target)/2。问题转换为：有多少种方法选择数字使和为P。这是经典的0-1背包计数问题。';
    findTargetSumWays.hint = '转换为背包计数问题，目标是(sum+target)/2';
    problems.push(findTargetSumWays);

    // 完全平方数
    const numSquares = new ProblemModel();
    numSquares.id = 154;
    numSquares.title = '完全平方数';
    numSquares.description = '给你一个整数 n ，返回和为 n 的完全平方数的最少数量。完全平方数是一个整数，其值等于另一个整数的平方；换句话说，其值等于一个整数自乘的积。';
    numSquares.difficulty = ProblemDifficulty.MEDIUM;
    numSquares.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    numSquares.choices = [
      { id: 'A', text: '动态规划：dp[i] = min(dp[i], dp[i-j*j] + 1)', isCorrect: true },
      { id: 'B', text: 'BFS：层序遍历找到最短路径', isCorrect: false },
      { id: 'C', text: '数学定理：四平方和定理', isCorrect: false },
      { id: 'D', text: '贪心算法：优先使用大的完全平方数', isCorrect: false }
    ];
    numSquares.explanation = '完全背包问题变种。dp[i]表示和为i的完全平方数的最少数量。对于每个i，尝试所有可能的完全平方数j²，状态转移：dp[i] = min(dp[i], dp[i-j²] + 1)。时间复杂度O(n*√n)。';
    numSquares.hint = '完全背包问题，每个完全平方数可以使用多次';
    problems.push(numSquares);

    // 单词拆分
    const wordBreak = new ProblemModel();
    wordBreak.id = 155;
    wordBreak.title = '单词拆分';
    wordBreak.description = '给你一个字符串 s 和一个字符串列表 wordDict 作为字典。请你判断是否可以利用字典中出现的单词拼接出 s 。注意：不要求字典中出现的单词全部都使用，并且字典中的单词可以重复使用。';
    wordBreak.difficulty = ProblemDifficulty.MEDIUM;
    wordBreak.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    wordBreak.choices = [
      { id: 'A', text: '动态规划：dp[i]表示前i个字符是否可以拆分', isCorrect: true },
      { id: 'B', text: '回溯算法：尝试所有可能的拆分', isCorrect: false },
      { id: 'C', text: 'DFS+记忆化：递归搜索', isCorrect: false },
      { id: 'D', text: '贪心算法：优先匹配长单词', isCorrect: false }
    ];
    wordBreak.explanation = 'DP问题。dp[i]表示字符串前i个字符是否可以被拆分。状态转移：对于每个位置i，检查所有可能的单词结尾位置j，如果dp[j]为true且s[j:i]在字典中，则dp[i] = true。时间复杂度O(n²)。';
    wordBreak.hint = '检查每个位置是否可以作为某个字典单词的结尾';
    problems.push(wordBreak);

    // 乘积最大子数组
    const maxProduct = new ProblemModel();
    maxProduct.id = 156;
    maxProduct.title = '乘积最大子数组';
    maxProduct.description = '给你一个整数数组 nums ，请你找出数组中乘积最大的非空连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。';
    maxProduct.difficulty = ProblemDifficulty.MEDIUM;
    maxProduct.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    maxProduct.choices = [
      { id: 'A', text: '同时维护最大值和最小值：负数可能变成最大值', isCorrect: true },
      { id: 'B', text: '只维护最大值，类似最大子数组和', isCorrect: false },
      { id: 'C', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'D', text: '分治算法：处理正负数分布', isCorrect: false }
    ];
    maxProduct.explanation = '需要同时维护最大值和最小值，因为负数乘以最小值可能得到最大值。maxDP[i] = max(nums[i], maxDP[i-1]*nums[i], minDP[i-1]*nums[i])，minDP类似。时间复杂度O(n)，空间复杂度O(1)。';
    maxProduct.hint = '同时维护最大值和最小值，负数会改变大小关系';
    problems.push(maxProduct);

    // 解码方法
    const numDecodings = new ProblemModel();
    numDecodings.id = 157;
    numDecodings.title = '解码方法';
    numDecodings.description = '一条包含字母 A-Z 的消息通过以下映射进行了编码：A->1, B->2, ..., Z->26。要解码已编码的消息，所有数字必须基于上述映射的方法，反向映射回字母（可能有多种方法）。给你一个只含数字的非空字符串 s ，请计算并返回解码方法的总数。';
    numDecodings.difficulty = ProblemDifficulty.MEDIUM;
    numDecodings.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    numDecodings.choices = [
      { id: 'A', text: '动态规划：dp[i] = dp[i-1] + dp[i-2]（满足条件时）', isCorrect: true },
      { id: 'B', text: '回溯算法：枚举所有可能的解码方式', isCorrect: false },
      { id: 'C', text: '贪心算法：优先选择较大的数字', isCorrect: false },
      { id: 'D', text: 'DFS：深度优先搜索所有路径', isCorrect: false }
    ];
    numDecodings.explanation = '类似爬楼梯问题。dp[i]表示前i个字符的解码方法数。如果当前字符不为0，dp[i] += dp[i-1]；如果前两个字符组成的数字在10-26之间，dp[i] += dp[i-2]。需要特别处理0的情况。';
    numDecodings.hint = '类似斐波那契，考虑单个字符和两个字符的解码';
    problems.push(numDecodings);

    // 跳跃游戏
    const canJump = new ProblemModel();
    canJump.id = 158;
    canJump.title = '跳跃游戏';
    canJump.description = '给定一个非负整数数组 nums ，你最初位于数组的第一个下标。数组中的每个元素代表你在该位置可以跳跃的最大长度。判断你是否能够到达最后一个下标。';
    canJump.difficulty = ProblemDifficulty.MEDIUM;
    canJump.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    canJump.choices = [
      { id: 'A', text: '贪心算法：维护能到达的最远位置', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示是否能到达位置i', isCorrect: false },
      { id: 'C', text: '回溯算法：尝试所有可能的跳跃', isCorrect: false },
      { id: 'D', text: 'BFS：层序遍历所有可达位置', isCorrect: false }
    ];
    canJump.explanation = '贪心策略：维护当前能到达的最远位置。遍历数组，如果当前位置在可达范围内，更新最远位置为max(最远位置, i + nums[i])。如果最远位置≥数组长度-1，返回true。时间复杂度O(n)。';
    canJump.hint = '贪心维护能到达的最远位置';
    problems.push(canJump);

    // 跳跃游戏II
    const jump = new ProblemModel();
    jump.id = 159;
    jump.title = '跳跃游戏II';
    jump.description = '给定一个长度为 n 的 0 索引整数数组 nums。初始位置为 nums[0]。每个元素 nums[i] 表示从索引 i 向前跳转的最大长度。换句话说，如果你在 nums[i] 处，你可以跳转到任意 nums[i + j] 处。返回到达 nums[n - 1] 的最小跳跃次数。';
    jump.difficulty = ProblemDifficulty.MEDIUM;
    jump.category = ProblemCategory.DYNAMIC_PROGRAMMING;
    jump.choices = [
      { id: 'A', text: '贪心算法：在当前跳跃范围内选择能跳得最远的位置', isCorrect: true },
      { id: 'B', text: '动态规划：dp[i]表示到达位置i的最少跳跃次数', isCorrect: false },
      { id: 'C', text: 'BFS：层序遍历，每层表示跳跃次数', isCorrect: false },
      { id: 'D', text: '回溯算法：尝试所有可能的跳跃路径', isCorrect: false }
    ];
    jump.explanation = '贪心策略：在当前跳跃能到达的范围内，选择下一跳能到达最远位置的点。维护当前跳跃的边界，当到达边界时跳跃次数+1，更新新的边界。时间复杂度O(n)，空间复杂度O(1)。';
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
    twoSumII.description = '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。';
    twoSumII.difficulty = ProblemDifficulty.MEDIUM;
    twoSumII.category = ProblemCategory.TWO_POINTERS;
    twoSumII.choices = [
      { id: 'A', text: '使用双指针，左右两端向中间移动', isCorrect: true },
      { id: 'B', text: '使用哈希表存储数值和索引', isCorrect: false },
      { id: 'C', text: '使用二分查找', isCorrect: false },
      { id: 'D', text: '暴力枚举所有组合', isCorrect: false }
    ];
    twoSumII.explanation = '由于数组已排序，使用双指针是最优解法。左指针指向数组开头，右指针指向数组末尾。如果两数之和等于目标值，返回结果；如果小于目标值，左指针右移；如果大于目标值，右指针左移。时间复杂度O(n)，空间复杂度O(1)。';
    twoSumII.hint = '利用数组已排序的特性，使用双指针从两端向中间移动';
    problems.push(twoSumII);

    // 三数之和
    const threeSum = new ProblemModel();
    threeSum.id = 162;
    threeSum.title = '三数之和';
    threeSum.description = '给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。';
    threeSum.difficulty = ProblemDifficulty.MEDIUM;
    threeSum.category = ProblemCategory.TWO_POINTERS;
    threeSum.choices = [
      { id: 'A', text: '排序后固定一个数，对剩余数组使用双指针', isCorrect: true },
      { id: 'B', text: '使用三重循环暴力枚举', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有可能的组合', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有三元组', isCorrect: false }
    ];
    threeSum.explanation = '先排序数组，然后固定第一个数，对剩余数组使用双指针寻找两数之和等于目标值的组合。需要注意去重：跳过重复的第一个数，以及双指针移动时跳过重复值。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSum.hint = '排序后固定一个数，剩余问题转化为两数之和';
    problems.push(threeSum);

    // 盛最多水的容器
    const maxArea = new ProblemModel();
    maxArea.id = 163;
    maxArea.title = '盛最多水的容器';
    maxArea.description = '给定一个长度为 n 的整数数组 height 。有 n 条垂线，第 i 条线的两个端点是 (i, 0) 和 (i, height[i]) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。';
    maxArea.difficulty = ProblemDifficulty.MEDIUM;
    maxArea.category = ProblemCategory.TWO_POINTERS;
    maxArea.choices = [
      { id: 'A', text: '双指针从两端开始，每次移动较短的那一端', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的两条线组合', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最大面积', isCorrect: false },
      { id: 'D', text: '使用单调栈维护递增序列', isCorrect: false }
    ];
    maxArea.explanation = '双指针策略：从数组两端开始，计算当前面积，然后移动较短的那一端。因为移动较长的一端不可能得到更大的面积（宽度减小，高度受限于较短的一端）。时间复杂度O(n)，空间复杂度O(1)。';
    maxArea.hint = '双指针从两端开始，总是移动较短的那一端';
    problems.push(maxArea);

    // 移除元素
    const removeElement = new ProblemModel();
    removeElement.id = 164;
    removeElement.title = '移除元素';
    removeElement.description = '给你一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，并返回移除后数组的新长度。不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并原地修改输入数组。';
    removeElement.difficulty = ProblemDifficulty.EASY;
    removeElement.category = ProblemCategory.TWO_POINTERS;
    removeElement.choices = [
      { id: 'A', text: '使用快慢双指针，快指针遍历，慢指针记录有效位置', isCorrect: true },
      { id: 'B', text: '从后往前遍历，遇到目标值就删除', isCorrect: false },
      { id: 'C', text: '使用额外数组存储非目标值元素', isCorrect: false },
      { id: 'D', text: '使用哈希表记录要删除的位置', isCorrect: false }
    ];
    removeElement.explanation = '快慢双指针：快指针遍历数组，慢指针指向下一个有效位置。当快指针指向的元素不等于val时，将其复制到慢指针位置，然后慢指针前进。最终慢指针的值就是新数组的长度。时间复杂度O(n)，空间复杂度O(1)。';
    removeElement.hint = '使用快慢双指针，保留不等于目标值的元素';
    problems.push(removeElement);

    // 删除有序数组中的重复项
    const removeDuplicates = new ProblemModel();
    removeDuplicates.id = 165;
    removeDuplicates.title = '删除有序数组中的重复项';
    removeDuplicates.description = '给你一个升序排列的数组 nums ，请你原地删除重复出现的元素，使每个元素只出现一次，返回删除后数组的新长度。元素的相对顺序应该保持一致。';
    removeDuplicates.difficulty = ProblemDifficulty.EASY;
    removeDuplicates.category = ProblemCategory.TWO_POINTERS;
    removeDuplicates.choices = [
      { id: 'A', text: '使用快慢双指针，快指针寻找不重复元素', isCorrect: true },
      { id: 'B', text: '使用哈希表记录已出现的元素', isCorrect: false },
      { id: 'C', text: '从后往前遍历删除重复元素', isCorrect: false },
      { id: 'D', text: '使用额外数组存储唯一元素', isCorrect: false }
    ];
    removeDuplicates.explanation = '由于数组已排序，重复元素必定相邻。使用快慢双指针：慢指针指向当前唯一元素的末尾，快指针寻找下一个不同的元素。当找到时，将其复制到慢指针的下一位置。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicates.hint = '利用数组有序的特性，重复元素必定相邻';
    problems.push(removeDuplicates);

    // 反转字符串
    const reverseString = new ProblemModel();
    reverseString.id = 166;
    reverseString.title = '反转字符串';
    reverseString.description = '编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。';
    reverseString.difficulty = ProblemDifficulty.EASY;
    reverseString.category = ProblemCategory.TWO_POINTERS;
    reverseString.choices = [
      { id: 'A', text: '使用双指针从两端向中间交换字符', isCorrect: true },
      { id: 'B', text: '使用递归反转字符串', isCorrect: false },
      { id: 'C', text: '使用栈存储字符然后弹出', isCorrect: false },
      { id: 'D', text: '使用额外数组存储反转结果', isCorrect: false }
    ];
    reverseString.explanation = '经典双指针应用：左指针指向字符串开头，右指针指向字符串末尾，交换两个位置的字符，然后向中间移动，直到两指针相遇。时间复杂度O(n)，空间复杂度O(1)。';
    reverseString.hint = '双指针从两端向中间移动，交换对应位置的字符';
    problems.push(reverseString);

    // 验证回文串
    const isPalindrome = new ProblemModel();
    isPalindrome.id = 167;
    isPalindrome.title = '验证回文串';
    isPalindrome.description = '如果在将所有大写字符转换为小写字符、并移除所有非字母数字字符之后，短语正着读和反着读都一样。则可以认为该短语是一个回文串。给你一个字符串 s，如果它是回文串，返回 true ；否则，返回 false 。';
    isPalindrome.difficulty = ProblemDifficulty.EASY;
    isPalindrome.category = ProblemCategory.TWO_POINTERS;
    isPalindrome.choices = [
      { id: 'A', text: '双指针从两端向中间移动，跳过非字母数字字符', isCorrect: true },
      { id: 'B', text: '先预处理字符串，然后反转比较', isCorrect: false },
      { id: 'C', text: '使用栈存储前半部分字符', isCorrect: false },
      { id: 'D', text: '使用递归检查回文性质', isCorrect: false }
    ];
    isPalindrome.explanation = '双指针策略：左右指针分别从字符串两端开始，跳过非字母数字字符，比较对应位置的字符（转换为小写）。如果不相等则不是回文串，如果指针相遇则是回文串。时间复杂度O(n)，空间复杂度O(1)。';
    isPalindrome.hint = '双指针跳过非字母数字字符，比较对应位置的字符';
    problems.push(isPalindrome);

    // 长度最小的子数组
    const minSubArrayLen = new ProblemModel();
    minSubArrayLen.id = 168;
    minSubArrayLen.title = '长度最小的子数组';
    minSubArrayLen.description = '给定一个含有 n 个正整数的数组和一个正整数 target 。找出该数组中满足其和 ≥ target 的长度最小的连续子数组，并返回其长度。如果不存在符合条件的子数组，返回 0 。';
    minSubArrayLen.difficulty = ProblemDifficulty.MEDIUM;
    minSubArrayLen.category = ProblemCategory.TWO_POINTERS;
    minSubArrayLen.choices = [
      { id: 'A', text: '使用滑动窗口（双指针），动态调整窗口大小', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的子数组', isCorrect: false },
      { id: 'C', text: '使用前缀和加二分查找', isCorrect: false },
      { id: 'D', text: '使用动态规划记录最小长度', isCorrect: false }
    ];
    minSubArrayLen.explanation = '滑动窗口技巧：使用左右双指针维护一个窗口。右指针不断扩展窗口直到和≥target，然后尝试收缩左指针以找到最小长度。重复这个过程直到右指针到达数组末尾。时间复杂度O(n)，空间复杂度O(1)。';
    minSubArrayLen.hint = '使用滑动窗口，右指针扩展，左指针收缩';
    problems.push(minSubArrayLen);

    // 四数之和
    const fourSum = new ProblemModel();
    fourSum.id = 169;
    fourSum.title = '四数之和';
    fourSum.description = '给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件的、不重复的四元组。';
    fourSum.difficulty = ProblemDifficulty.MEDIUM;
    fourSum.category = ProblemCategory.TWO_POINTERS;
    fourSum.choices = [
      { id: 'A', text: '排序后固定两个数，对剩余数组使用双指针', isCorrect: true },
      { id: 'B', text: '使用四重循环暴力枚举', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有可能的组合', isCorrect: false },
      { id: 'D', text: '使用回溯算法枚举所有四元组', isCorrect: false }
    ];
    fourSum.explanation = '在三数之和的基础上再固定一个数。排序后使用两层循环固定前两个数，然后对剩余数组使用双指针寻找两数之和等于目标值的组合。同样需要注意去重。时间复杂度O(n³)，空间复杂度O(1)。';
    fourSum.hint = '在三数之和基础上再固定一个数，使用双指针处理剩余两个数';
    problems.push(fourSum);

    // 最接近的三数之和
    const threeSumClosest = new ProblemModel();
    threeSumClosest.id = 170;
    threeSumClosest.title = '最接近的三数之和';
    threeSumClosest.description = '给你一个长度为 n 的整数数组 nums 和 一个目标值 target。请你从 nums 中选出三个整数，使它们的和与 target 最接近。返回这三个数的和。';
    threeSumClosest.difficulty = ProblemDifficulty.MEDIUM;
    threeSumClosest.category = ProblemCategory.TWO_POINTERS;
    threeSumClosest.choices = [
      { id: 'A', text: '排序后固定一个数，双指针寻找最接近的组合', isCorrect: true },
      { id: 'B', text: '暴力枚举所有三元组', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最接近的和', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有可能的和', isCorrect: false }
    ];
    threeSumClosest.explanation = '类似三数之和，但目标是找到最接近target的和。排序后固定第一个数，使用双指针在剩余数组中寻找。每次计算当前三数之和与target的差值，更新最接近的结果。时间复杂度O(n²)，空间复杂度O(1)。';
    threeSumClosest.hint = '在三数之和基础上，维护与目标值最接近的和';
    problems.push(threeSumClosest);

    // 颜色分类
    const sortColors = new ProblemModel();
    sortColors.id = 171;
    sortColors.title = '颜色分类';
    sortColors.description = '给定一个包含红色、白色和蓝色、共 n 个元素的数组 nums ，原地对它们进行排序，使得相同颜色的元素相邻，并按照红色、白色、蓝色顺序排列。我们使用整数 0、1 和 2 分别表示红色、白色和蓝色。';
    sortColors.difficulty = ProblemDifficulty.MEDIUM;
    sortColors.category = ProblemCategory.TWO_POINTERS;
    sortColors.choices = [
      { id: 'A', text: '使用三指针：左指针处理0，右指针处理2，中间指针遍历', isCorrect: true },
      { id: 'B', text: '先统计各颜色数量，再重新填充数组', isCorrect: false },
      { id: 'C', text: '使用快速排序算法', isCorrect: false },
      { id: 'D', text: '使用归并排序算法', isCorrect: false }
    ];
    sortColors.explanation = '荷兰国旗问题：使用三指针。left指向0的边界，right指向2的边界，current遍历数组。遇到0与left交换并移动left和current，遇到2与right交换并移动right（current不动，因为交换来的元素未处理），遇到1只移动current。';
    sortColors.hint = '三指针分别处理0、1、2三种颜色的边界';
    problems.push(sortColors);

    // 合并两个有序数组
    const merge = new ProblemModel();
    merge.id = 172;
    merge.title = '合并两个有序数组';
    merge.description = '给你两个按非递减顺序排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中元素的数量。请你合并 nums2 到 nums1 中，使合并后的数组同样按非递减顺序排列。';
    merge.difficulty = ProblemDifficulty.EASY;
    merge.category = ProblemCategory.TWO_POINTERS;
    merge.choices = [
      { id: 'A', text: '从后往前合并，使用三个指针', isCorrect: true },
      { id: 'B', text: '先合并再排序', isCorrect: false },
      { id: 'C', text: '使用额外空间存储合并结果', isCorrect: false },
      { id: 'D', text: '从前往后合并，需要移动元素', isCorrect: false }
    ];
    merge.explanation = '从后往前合并避免覆盖未处理的元素。使用三个指针：p1指向nums1的有效元素末尾，p2指向nums2末尾，p指向nums1的实际末尾。比较nums1[p1]和nums2[p2]，将较大者放到nums1[p]位置。时间复杂度O(m+n)，空间复杂度O(1)。';
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
    detectCycle.explanation = 'Floyd判圈算法：快慢指针相遇后，将一个指针重置到头节点，两指针以相同速度移动，再次相遇的点就是环的入口。数学原理：设环外长度为a，环内长度为b，相遇点距入口为c，则有2(a+c) = a+b+c，解得a = b-c。';
    detectCycle.hint = '快慢指针相遇后，重置一个指针到头节点，同速移动找入口';
    problems.push(detectCycle);

    // 删除有序数组中的重复项II
    const removeDuplicatesII = new ProblemModel();
    removeDuplicatesII.id = 174;
    removeDuplicatesII.title = '删除有序数组中的重复项II';
    removeDuplicatesII.description = '给你一个有序数组 nums ，请你原地删除重复出现的元素，使得出现次数超过两次的元素只出现两次，返回删除后数组的新长度。';
    removeDuplicatesII.difficulty = ProblemDifficulty.MEDIUM;
    removeDuplicatesII.category = ProblemCategory.TWO_POINTERS;
    removeDuplicatesII.choices = [
      { id: 'A', text: '使用快慢双指针，慢指针维护结果数组', isCorrect: true },
      { id: 'B', text: '使用哈希表统计元素出现次数', isCorrect: false },
      { id: 'C', text: '从后往前遍历删除多余元素', isCorrect: false },
      { id: 'D', text: '使用额外数组存储结果', isCorrect: false }
    ];
    removeDuplicatesII.explanation = '快慢双指针：慢指针维护结果数组，快指针遍历原数组。关键观察：如果当前元素与慢指针前两个位置的元素相同，说明已经有两个相同元素了，跳过当前元素。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicatesII.hint = '比较当前元素与结果数组中前两个位置的元素';
    problems.push(removeDuplicatesII);

    // 字符串的排列
    const checkInclusion = new ProblemModel();
    checkInclusion.id = 175;
    checkInclusion.title = '字符串的排列';
    checkInclusion.description = '给你两个字符串 s1 和 s2 ，写一个函数来判断 s2 是否包含 s1 的排列。如果是，返回 true ；否则，返回 false 。';
    checkInclusion.difficulty = ProblemDifficulty.MEDIUM;
    checkInclusion.category = ProblemCategory.TWO_POINTERS;
    checkInclusion.choices = [
      { id: 'A', text: '使用滑动窗口，维护固定长度的窗口', isCorrect: true },
      { id: 'B', text: '生成s1的所有排列，逐一检查', isCorrect: false },
      { id: 'C', text: '使用动态规划记录匹配状态', isCorrect: false },
      { id: 'D', text: '使用KMP算法进行字符串匹配', isCorrect: false }
    ];
    checkInclusion.explanation = '滑动窗口：维护一个长度为s1.length的窗口在s2上滑动。使用字符频次数组比较窗口内字符分布是否与s1相同。每次移动窗口时，移除左边字符，添加右边字符，更新频次。时间复杂度O(n)，空间复杂度O(1)。';
    checkInclusion.hint = '固定长度的滑动窗口，比较字符频次分布';
    problems.push(checkInclusion);

    // 找到字符串中所有字母异位词
    const findAnagrams = new ProblemModel();
    findAnagrams.id = 176;
    findAnagrams.title = '找到字符串中所有字母异位词';
    findAnagrams.description = '给定两个字符串 s 和 p，找到 s 中所有 p 的异位词的子串，返回这些子串的起始索引。不考虑答案输出的顺序。';
    findAnagrams.difficulty = ProblemDifficulty.MEDIUM;
    findAnagrams.category = ProblemCategory.TWO_POINTERS;
    findAnagrams.choices = [
      { id: 'A', text: '使用滑动窗口，比较字符频次', isCorrect: true },
      { id: 'B', text: '对每个子串排序后与p比较', isCorrect: false },
      { id: 'C', text: '使用哈希表存储p的所有排列', isCorrect: false },
      { id: 'D', text: '使用动态规划记录匹配状态', isCorrect: false }
    ];
    findAnagrams.explanation = '滑动窗口变种：维护长度为p.length的窗口，使用字符频次数组。当窗口内字符频次与p相同时，记录起始位置。优化：使用一个变量记录匹配的字符种类数，避免每次都比较整个频次数组。时间复杂度O(n)。';
    findAnagrams.hint = '滑动窗口比较字符频次，记录匹配的起始位置';
    problems.push(findAnagrams);

    // 最小覆盖子串
    const minWindow = new ProblemModel();
    minWindow.id = 177;
    minWindow.title = '最小覆盖子串';
    minWindow.description = '给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。';
    minWindow.difficulty = ProblemDifficulty.HARD;
    minWindow.category = ProblemCategory.TWO_POINTERS;
    minWindow.choices = [
      { id: 'A', text: '使用滑动窗口，右指针扩展，左指针收缩', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的子串', isCorrect: false },
      { id: 'C', text: '使用动态规划记录最小长度', isCorrect: false },
      { id: 'D', text: '使用回溯算法寻找最小子串', isCorrect: false }
    ];
    minWindow.explanation = '滑动窗口：右指针扩展窗口直到包含t的所有字符，然后左指针收缩窗口寻找最小长度。使用哈希表记录t中字符的需求量和窗口中的字符数量。维护一个变量记录已满足的字符种类数。时间复杂度O(|s|+|t|)。';
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
    lengthOfLongestSubstring.explanation = '滑动窗口：使用左右指针维护一个无重复字符的窗口。右指针不断扩展，当遇到重复字符时，左指针移动到重复字符的下一位置。使用哈希表记录字符的最新位置。时间复杂度O(n)，空间复杂度O(min(m,n))。';
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
    trap.explanation = '双指针优化：从两端开始，维护leftMax和rightMax。如果left对应的高度小于right，说明左边的积水量由leftMax决定，计算积水并移动left指针；反之移动right指针。关键洞察：较小一侧的积水量只由该侧的最大值决定。时间复杂度O(n)，空间复杂度O(1)。';
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
    countSubstrings.explanation = '中心扩展法：对于每个可能的回文中心（字符或字符间隙），向两边扩展直到不再是回文。需要考虑奇数长度（以字符为中心）和偶数长度（以字符间隙为中心）两种情况。时间复杂度O(n²)，空间复杂度O(1)。';
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
    binarySearch.description = '给定一个n个元素有序的（升序）整型数组nums和一个目标值target，写一个函数搜索nums中的target，如果目标值存在返回下标，否则返回-1。';
    binarySearch.difficulty = ProblemDifficulty.EASY;
    binarySearch.category = ProblemCategory.BINARY_SEARCH;
    binarySearch.choices = [
      { id: 'A', text: '使用二分查找，每次排除一半元素', isCorrect: true },
      { id: 'B', text: '从头到尾线性搜索', isCorrect: false },
      { id: 'C', text: '使用哈希表存储所有元素', isCorrect: false },
      { id: 'D', text: '使用递归分治', isCorrect: false }
    ];
    binarySearch.explanation = '二分查找是在有序数组中查找元素的经典算法。每次比较中间元素与目标值，如果相等则返回索引；如果目标值较小，在左半部分继续查找；如果目标值较大，在右半部分继续查找。时间复杂度O(log n)，空间复杂度O(1)。';
    binarySearch.hint = '利用数组有序的特性，每次排除一半的搜索空间';
    problems.push(binarySearch);

    // 搜索插入位置
    const searchInsert = new ProblemModel();
    searchInsert.id = 181;
    searchInsert.title = '搜索插入位置';
    searchInsert.description = '给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。';
    searchInsert.difficulty = ProblemDifficulty.EASY;
    searchInsert.category = ProblemCategory.BINARY_SEARCH;
    searchInsert.choices = [
      { id: 'A', text: '使用二分查找，找到第一个大于等于目标值的位置', isCorrect: true },
      { id: 'B', text: '线性搜索找到插入位置', isCorrect: false },
      { id: 'C', text: '先查找目标值，不存在时再找插入位置', isCorrect: false },
      { id: 'D', text: '使用哈希表记录所有位置', isCorrect: false }
    ];
    searchInsert.explanation = '这是二分查找的变形。当目标值存在时返回其位置；当不存在时，二分查找结束时left指针指向的就是插入位置。关键是理解二分查找的边界条件。时间复杂度O(log n)，空间复杂度O(1)。';
    searchInsert.hint = '二分查找结束时，left指针指向插入位置';
    problems.push(searchInsert);

    // 在排序数组中查找元素的第一个和最后一个位置
    const searchRange = new ProblemModel();
    searchRange.id = 182;
    searchRange.title = '在排序数组中查找元素的第一个和最后一个位置';
    searchRange.description = '给定一个按照升序排列的整数数组nums，和一个目标值target。找出给定目标值在数组中的开始位置和结束位置。如果数组中不存在目标值target，返回[-1, -1]。';
    searchRange.difficulty = ProblemDifficulty.MEDIUM;
    searchRange.category = ProblemCategory.BINARY_SEARCH;
    searchRange.choices = [
      { id: 'A', text: '使用两次二分查找，分别找左边界和右边界', isCorrect: true },
      { id: 'B', text: '先用二分查找找到任意位置，再向两边扩展', isCorrect: false },
      { id: 'C', text: '线性搜索找到所有匹配位置', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有位置', isCorrect: false }
    ];
    searchRange.explanation = '需要进行两次二分查找：第一次找左边界（第一个等于target的位置），第二次找右边界（最后一个等于target的位置）。关键是正确处理边界条件，确保找到的是真正的边界。时间复杂度O(log n)，空间复杂度O(1)。';
    searchRange.hint = '分别用二分查找找左边界和右边界';
    problems.push(searchRange);

    // 搜索旋转排序数组
    const searchRotated = new ProblemModel();
    searchRotated.id = 183;
    searchRotated.title = '搜索旋转排序数组';
    searchRotated.description = '整数数组nums按升序排列，数组中的值互不相同。在传递给函数之前，nums在预先未知的某个下标k上进行了旋转。给你旋转后的数组nums和一个整数target，如果nums中存在这个目标值target，则返回它的下标，否则返回-1。';
    searchRotated.difficulty = ProblemDifficulty.MEDIUM;
    searchRotated.category = ProblemCategory.BINARY_SEARCH;
    searchRotated.choices = [
      { id: 'A', text: '判断哪一半是有序的，然后决定在哪一半搜索', isCorrect: true },
      { id: 'B', text: '先找到旋转点，再在对应部分二分查找', isCorrect: false },
      { id: 'C', text: '线性搜索整个数组', isCorrect: false },
      { id: 'D', text: '恢复数组的原始顺序再二分查找', isCorrect: false }
    ];
    searchRotated.explanation = '旋转数组的特点是至少有一半是有序的。通过比较中间元素与边界元素，可以判断哪一半是有序的。然后判断目标值是否在有序的那一半中，决定搜索方向。时间复杂度O(log n)，空间复杂度O(1)。';
    searchRotated.hint = '旋转数组至少有一半是有序的';
    problems.push(searchRotated);

    // 寻找旋转排序数组中的最小值
    const findMin = new ProblemModel();
    findMin.id = 184;
    findMin.title = '寻找旋转排序数组中的最小值';
    findMin.description = '已知一个长度为n的数组，预先按照升序排列，经由1到n次旋转后，得到输入数组。给你一个元素值互不相同的数组nums，它原来是一个升序排列的数组，并按上述情形进行了多次旋转。请你找出并返回数组中的最小元素。';
    findMin.difficulty = ProblemDifficulty.MEDIUM;
    findMin.category = ProblemCategory.BINARY_SEARCH;
    findMin.choices = [
      { id: 'A', text: '比较中间元素与右边界，决定搜索方向', isCorrect: true },
      { id: 'B', text: '比较中间元素与左边界，决定搜索方向', isCorrect: false },
      { id: 'C', text: '线性搜索找到最小值', isCorrect: false },
      { id: 'D', text: '找到旋转点就是最小值位置', isCorrect: false }
    ];
    findMin.explanation = '最小值一定在旋转点。通过比较中间元素与右边界元素：如果mid > right，说明最小值在右半部分；如果mid < right，说明最小值在左半部分（包括mid）。时间复杂度O(log n)，空间复杂度O(1)。';
    findMin.hint = '最小值在旋转点，比较中间元素与右边界';
    problems.push(findMin);

    // 寻找峰值
    const findPeakElement = new ProblemModel();
    findPeakElement.id = 185;
    findPeakElement.title = '寻找峰值';
    findPeakElement.description = '峰值元素是指其值严格大于左右相邻值的元素。给你一个整数数组nums，找到峰值元素并返回其索引。数组可能包含多个峰值，在这种情况下，返回任何一个峰值所在位置即可。';
    findPeakElement.difficulty = ProblemDifficulty.MEDIUM;
    findPeakElement.category = ProblemCategory.BINARY_SEARCH;
    findPeakElement.choices = [
      { id: 'A', text: '比较中间元素与相邻元素，向上坡方向搜索', isCorrect: true },
      { id: 'B', text: '线性搜索找到所有峰值', isCorrect: false },
      { id: 'C', text: '从两端向中间搜索', isCorrect: false },
      { id: 'D', text: '找到最大值就是峰值', isCorrect: false }
    ];
    findPeakElement.explanation = '关键观察：如果nums[mid] < nums[mid+1]，说明右侧存在峰值；如果nums[mid] > nums[mid+1]，说明左侧存在峰值（包括mid）。因为数组边界被视为负无穷，所以一定存在峰值。时间复杂度O(log n)，空间复杂度O(1)。';
    findPeakElement.hint = '向上坡方向搜索，一定能找到峰值';
    problems.push(findPeakElement);

    // 搜索二维矩阵
    const searchMatrix = new ProblemModel();
    searchMatrix.id = 186;
    searchMatrix.title = '搜索二维矩阵';
    searchMatrix.description = '编写一个高效的算法来判断m x n矩阵中，是否存在一个目标值。该矩阵具有如下特性：每行中的整数从左到右按升序排列。每行的第一个整数大于前一行的最后一个整数。';
    searchMatrix.difficulty = ProblemDifficulty.MEDIUM;
    searchMatrix.category = ProblemCategory.BINARY_SEARCH;
    searchMatrix.choices = [
      { id: 'A', text: '将二维矩阵看作一维有序数组进行二分查找', isCorrect: true },
      { id: 'B', text: '先二分查找行，再二分查找列', isCorrect: false },
      { id: 'C', text: '从右上角开始搜索', isCorrect: false },
      { id: 'D', text: '逐行线性搜索', isCorrect: false }
    ];
    searchMatrix.explanation = '由于矩阵的特殊性质，可以将其看作一个有序的一维数组。通过坐标转换：对于位置i，对应的矩阵坐标是(i/n, i%n)。然后进行标准的二分查找。时间复杂度O(log(m*n))，空间复杂度O(1)。';
    searchMatrix.hint = '将二维矩阵映射为一维有序数组';
    problems.push(searchMatrix);

    // 搜索二维矩阵II
    const searchMatrixII = new ProblemModel();
    searchMatrixII.id = 187;
    searchMatrixII.title = '搜索二维矩阵II';
    searchMatrixII.description = '编写一个高效的算法来搜索m x n矩阵matrix中的一个目标值target。该矩阵具有以下特性：每行的元素从左到右升序排列。每列的元素从上到下升序排列。';
    searchMatrixII.difficulty = ProblemDifficulty.MEDIUM;
    searchMatrixII.category = ProblemCategory.BINARY_SEARCH;
    searchMatrixII.choices = [
      { id: 'A', text: '从右上角或左下角开始搜索', isCorrect: true },
      { id: 'B', text: '对每一行进行二分查找', isCorrect: false },
      { id: 'C', text: '对每一列进行二分查找', isCorrect: false },
      { id: 'D', text: '从中心开始向四周扩散搜索', isCorrect: false }
    ];
    searchMatrixII.explanation = '从右上角开始：如果当前值大于目标值，向左移动；如果小于目标值，向下移动；如果相等，找到目标。这样每次都能排除一行或一列。时间复杂度O(m+n)，空间复杂度O(1)。';
    searchMatrixII.hint = '从右上角开始，每次排除一行或一列';
    problems.push(searchMatrixII);

    // 寻找两个正序数组的中位数
    const findMedian = new ProblemModel();
    findMedian.id = 188;
    findMedian.title = '寻找两个正序数组的中位数';
    findMedian.description = '给定两个大小分别为m和n的正序（从小到大）数组nums1和nums2。请你找出并返回这两个正序数组的中位数。算法的时间复杂度应该为O(log (m+n))。';
    findMedian.difficulty = ProblemDifficulty.HARD;
    findMedian.category = ProblemCategory.BINARY_SEARCH;
    findMedian.choices = [
      { id: 'A', text: '在较短数组上二分查找，找到正确的分割点', isCorrect: true },
      { id: 'B', text: '合并两个数组再找中位数', isCorrect: false },
      { id: 'C', text: '使用双指针找到中位数位置', isCorrect: false },
      { id: 'D', text: '分别在两个数组上二分查找', isCorrect: false }
    ];
    findMedian.explanation = '关键是找到一个分割点，使得左半部分的最大值小于等于右半部分的最小值，且两部分长度相等（或相差1）。在较短数组上进行二分查找，确定分割位置，然后计算另一个数组的分割位置。时间复杂度O(log(min(m,n)))，空间复杂度O(1)。';
    findMedian.hint = '在较短数组上二分查找分割点';
    problems.push(findMedian);

    // 第一个错误的版本
    const firstBadVersion = new ProblemModel();
    firstBadVersion.id = 189;
    firstBadVersion.title = '第一个错误的版本';
    firstBadVersion.description = '你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错误的。假设你有n个版本[1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。';
    firstBadVersion.difficulty = ProblemDifficulty.EASY;
    firstBadVersion.category = ProblemCategory.BINARY_SEARCH;
    firstBadVersion.choices = [
      { id: 'A', text: '使用二分查找，找到第一个错误版本', isCorrect: true },
      { id: 'B', text: '从第一个版本开始线性搜索', isCorrect: false },
      { id: 'C', text: '从最后一个版本开始向前搜索', isCorrect: false },
      { id: 'D', text: '随机选择版本进行检测', isCorrect: false }
    ];
    firstBadVersion.explanation = '这是寻找左边界的二分查找问题。如果当前版本是错误的，说明第一个错误版本在左半部分（包括当前版本）；如果当前版本是正确的，说明第一个错误版本在右半部分。时间复杂度O(log n)，空间复杂度O(1)。';
    firstBadVersion.hint = '寻找第一个错误版本，使用左边界二分查找';
    problems.push(firstBadVersion);

    // 猜数字大小
    const guessNumber = new ProblemModel();
    guessNumber.id = 190;
    guessNumber.title = '猜数字大小';
    guessNumber.description = '猜数字游戏的规则如下：每轮游戏，我都会从1到n随机选择一个数字。请你猜选出的数字。如果你猜错了，我会告诉你，你猜测的数字比我选出的数字是大了还是小了。你可以通过调用一个预先定义好的接口int guess(int num)来获取猜测结果。';
    guessNumber.difficulty = ProblemDifficulty.EASY;
    guessNumber.category = ProblemCategory.BINARY_SEARCH;
    guessNumber.choices = [
      { id: 'A', text: '使用二分查找，根据guess函数的返回值调整搜索范围', isCorrect: true },
      { id: 'B', text: '从1开始线性搜索', isCorrect: false },
      { id: 'C', text: '随机猜测数字', isCorrect: false },
      { id: 'D', text: '使用三分查找', isCorrect: false }
    ];
    guessNumber.explanation = '标准的二分查找应用。根据guess函数的返回值：-1表示猜大了，1表示猜小了，0表示猜对了。相应地调整搜索范围。时间复杂度O(log n)，空间复杂度O(1)。';
    guessNumber.hint = '根据guess函数返回值调整二分查找范围';
    problems.push(guessNumber);

    // 完全平方数
    const isPerfectSquare = new ProblemModel();
    isPerfectSquare.id = 191;
    isPerfectSquare.title = '有效的完全平方数';
    isPerfectSquare.description = '给定一个正整数num，编写一个函数，如果num是一个完全平方数，则返回true，否则返回false。进阶：不要使用任何内置的库函数，如sqrt。';
    isPerfectSquare.difficulty = ProblemDifficulty.EASY;
    isPerfectSquare.category = ProblemCategory.BINARY_SEARCH;
    isPerfectSquare.choices = [
      { id: 'A', text: '使用二分查找找到平方根', isCorrect: true },
      { id: 'B', text: '使用牛顿迭代法', isCorrect: false },
      { id: 'C', text: '逐个尝试所有可能的平方根', isCorrect: false },
      { id: 'D', text: '使用数学公式判断', isCorrect: false }
    ];
    isPerfectSquare.explanation = '在1到num之间二分查找，找到一个数x使得x*x = num。注意处理整数溢出问题，可以通过x <= num/x来避免。时间复杂度O(log n)，空间复杂度O(1)。';
    isPerfectSquare.hint = '二分查找平方根，注意避免整数溢出';
    problems.push(isPerfectSquare);

    // 两数之和II - 输入有序数组
    const twoSumSorted = new ProblemModel();
    twoSumSorted.id = 192;
    twoSumSorted.title = '两数之和II - 输入有序数组';
    twoSumSorted.description = '给你一个下标从1开始的整数数组numbers，该数组已按非递减顺序排列，请你从数组中找出满足相加之和等于目标数target的两个数。如果设这两个数分别是numbers[index1]和numbers[index2]，则1 <= index1 < index2 <= numbers.length。';
    twoSumSorted.difficulty = ProblemDifficulty.MEDIUM;
    twoSumSorted.category = ProblemCategory.BINARY_SEARCH;
    twoSumSorted.choices = [
      { id: 'A', text: '使用双指针从两端向中间搜索', isCorrect: true },
      { id: 'B', text: '对每个元素二分查找其补数', isCorrect: false },
      { id: 'C', text: '使用哈希表存储已遍历的元素', isCorrect: false },
      { id: 'D', text: '暴力搜索所有可能的组合', isCorrect: false }
    ];
    twoSumSorted.explanation = '利用数组有序的特性，使用双指针：如果两数之和大于目标值，右指针左移；如果小于目标值，左指针右移；如果等于目标值，找到答案。时间复杂度O(n)，空间复杂度O(1)。';
    twoSumSorted.hint = '利用有序特性，使用双指针技巧';
    problems.push(twoSumSorted);

    // 寻找比目标字母大的最小字母
    const nextGreatestLetter = new ProblemModel();
    nextGreatestLetter.id = 193;
    nextGreatestLetter.title = '寻找比目标字母大的最小字母';
    nextGreatestLetter.description = '给你一个排序后的字符列表letters，列表中只包含小写英文字母。另给出一个目标字母target，请你寻找在这一有序列表里比目标字母大的最小字母。在比较时，字母是依照ASCII码顺序比较的。比如，目标字母target = "z"时，应该返回"a"。';
    nextGreatestLetter.difficulty = ProblemDifficulty.EASY;
    nextGreatestLetter.category = ProblemCategory.BINARY_SEARCH;
    nextGreatestLetter.choices = [
      { id: 'A', text: '使用二分查找找到第一个大于目标的字母', isCorrect: true },
      { id: 'B', text: '线性搜索找到第一个大于目标的字母', isCorrect: false },
      { id: 'C', text: '从后往前搜索', isCorrect: false },
      { id: 'D', text: '使用哈希表存储所有字母', isCorrect: false }
    ];
    nextGreatestLetter.explanation = '这是寻找右边界的二分查找变形。需要找到第一个大于target的字母。如果所有字母都不大于target，则返回第一个字母（循环特性）。时间复杂度O(log n)，空间复杂度O(1)。';
    nextGreatestLetter.hint = '寻找第一个大于目标的字母，注意循环特性';
    problems.push(nextGreatestLetter);

    // 山脉数组的峰顶索引
    const peakIndexInMountainArray = new ProblemModel();
    peakIndexInMountainArray.id = 194;
    peakIndexInMountainArray.title = '山脉数组的峰顶索引';
    peakIndexInMountainArray.description = '符合下列属性的数组arr称为山脉数组：arr.length >= 3，存在i（0 < i < arr.length - 1）使得：arr[0] < arr[1] < ... arr[i-1] < arr[i]，arr[i] > arr[i+1] > ... > arr[arr.length - 1]。给你由整数组成的山脉数组arr，返回任何满足arr[0] < arr[1] < ... arr[i-1] < arr[i] > arr[i+1] > ... > arr[arr.length - 1]的下标i。';
    peakIndexInMountainArray.difficulty = ProblemDifficulty.EASY;
    peakIndexInMountainArray.category = ProblemCategory.BINARY_SEARCH;
    peakIndexInMountainArray.choices = [
      { id: 'A', text: '使用二分查找，比较中间元素与相邻元素', isCorrect: true },
      { id: 'B', text: '线性搜索找到峰顶', isCorrect: false },
      { id: 'C', text: '从两端向中间搜索', isCorrect: false },
      { id: 'D', text: '找到最大值的位置', isCorrect: false }
    ];
    peakIndexInMountainArray.explanation = '山脉数组保证存在唯一峰顶。使用二分查找：如果arr[mid] < arr[mid+1]，说明峰顶在右半部分；如果arr[mid] > arr[mid+1]，说明峰顶在左半部分（包括mid）。时间复杂度O(log n)，空间复杂度O(1)。';
    peakIndexInMountainArray.hint = '山脉数组有唯一峰顶，向上坡方向搜索';
    problems.push(peakIndexInMountainArray);

    // 分割数组的最大值
    const splitArray = new ProblemModel();
    splitArray.id = 195;
    splitArray.title = '分割数组的最大值';
    splitArray.description = '给定一个非负整数数组nums和一个整数m，你需要将这个数组分成m个非空的连续子数组。设计一个算法使得这m个子数组各自和的最大值最小。';
    splitArray.difficulty = ProblemDifficulty.HARD;
    splitArray.category = ProblemCategory.BINARY_SEARCH;
    splitArray.choices = [
      { id: 'A', text: '二分查找答案，检查是否能在m个子数组内完成分割', isCorrect: true },
      { id: 'B', text: '使用动态规划计算最优分割', isCorrect: false },
      { id: 'C', text: '贪心算法分割数组', isCorrect: false },
      { id: 'D', text: '暴力尝试所有可能的分割方案', isCorrect: false }
    ];
    splitArray.explanation = '这是"二分查找答案"的经典应用。答案的范围是[max(nums), sum(nums)]。对于每个可能的答案，检查是否能在m个子数组内完成分割。使用贪心策略：尽可能让每个子数组的和接近但不超过当前答案。时间复杂度O(n*log(sum))，空间复杂度O(1)。';
    splitArray.hint = '二分查找答案，贪心检查分割可行性';
    problems.push(splitArray);

    // 在D天内送达包裹的能力
    const shipWithinDays = new ProblemModel();
    shipWithinDays.id = 196;
    shipWithinDays.title = '在D天内送达包裹的能力';
    shipWithinDays.description = '传送带上的包裹必须在D天内从一个港口运送到另一个港口。传送带上的第i个包裹的重量为weights[i]。每一天，我们都会按给出重量的顺序往传送带上装载包裹。我们装载的重量不会超过船的最大运载能力。返回能在D天内将传送带上的所有包裹送达的船的最低运载能力。';
    shipWithinDays.difficulty = ProblemDifficulty.MEDIUM;
    shipWithinDays.category = ProblemCategory.BINARY_SEARCH;
    shipWithinDays.choices = [
      { id: 'A', text: '二分查找船的运载能力，检查是否能在D天内完成', isCorrect: true },
      { id: 'B', text: '贪心算法计算最小运载能力', isCorrect: false },
      { id: 'C', text: '动态规划计算最优方案', isCorrect: false },
      { id: 'D', text: '平均分配包裹重量', isCorrect: false }
    ];
    shipWithinDays.explanation = '又一个"二分查找答案"问题。运载能力的范围是[max(weights), sum(weights)]。对于每个可能的运载能力，模拟装载过程，检查是否能在D天内完成。时间复杂度O(n*log(sum))，空间复杂度O(1)。';
    shipWithinDays.hint = '二分查找运载能力，模拟装载过程';
    problems.push(shipWithinDays);

    // 爱吃香蕉的珂珂
    const minEatingSpeed = new ProblemModel();
    minEatingSpeed.id = 197;
    minEatingSpeed.title = '爱吃香蕉的珂珂';
    minEatingSpeed.description = '珂珂喜欢吃香蕉。这里有N堆香蕉，第i堆中有piles[i]根香蕉。警卫已经离开了，将在H小时后回来。珂珂可以决定她吃香蕉的速度K（单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉K根。如果这堆香蕉少于K根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。返回她可以在H小时内吃掉所有香蕉的最小速度K。';
    minEatingSpeed.difficulty = ProblemDifficulty.MEDIUM;
    minEatingSpeed.category = ProblemCategory.BINARY_SEARCH;
    minEatingSpeed.choices = [
      { id: 'A', text: '二分查找吃香蕉的速度，检查是否能在H小时内吃完', isCorrect: true },
      { id: 'B', text: '计算平均速度作为答案', isCorrect: false },
      { id: 'C', text: '贪心选择最优速度', isCorrect: false },
      { id: 'D', text: '线性搜索所有可能的速度', isCorrect: false }
    ];
    minEatingSpeed.explanation = '经典的"二分查找答案"问题。速度的范围是[1, max(piles)]。对于每个可能的速度K，计算吃完所有香蕉需要的时间：对于每堆香蕉piles[i]，需要ceil(piles[i]/K)小时。时间复杂度O(n*log(max))，空间复杂度O(1)。';
    minEatingSpeed.hint = '二分查找吃香蕉的速度，计算所需时间';
    problems.push(minEatingSpeed);

    // 制作m束花所需的最少天数
    const minDaysBloom = new ProblemModel();
    minDaysBloom.id = 198;
    minDaysBloom.title = '制作m束花所需的最少天数';
    minDaysBloom.description = '给你一个整数数组bloomDay，以及两个整数m和k。现需要制作m束花。制作花束时，需要使用花园中相邻的k朵花。花园中有n朵花，第i朵花会在bloomDay[i]时盛开，当花盛开后，就可以用于制作花束。请你返回从花园中摘k朵相邻的花来制作m束花所需要的最少天数。如果不能制作出m束花则返回-1。';
    minDaysBloom.difficulty = ProblemDifficulty.MEDIUM;
    minDaysBloom.category = ProblemCategory.BINARY_SEARCH;
    minDaysBloom.choices = [
      { id: 'A', text: '二分查找天数，检查是否能制作出m束花', isCorrect: true },
      { id: 'B', text: '贪心选择最早盛开的花', isCorrect: false },
      { id: 'C', text: '动态规划计算最优方案', isCorrect: false },
      { id: 'D', text: '排序后选择合适的时间段', isCorrect: false }
    ];
    minDaysBloom.explanation = '"二分查找答案"问题。天数范围是[min(bloomDay), max(bloomDay)]。对于每个可能的天数，检查有多少朵花已经盛开，然后统计能制作多少束花（需要k朵相邻的花）。时间复杂度O(n*log(max))，空间复杂度O(1)。';
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
    validParentheses.description = '给定一个只包括"("，")"，"{"，"}"，"["，"]"的字符串s，判断字符串是否有效。有效字符串需满足：左括号必须用相同类型的右括号闭合，左括号必须以正确的顺序闭合。';
    validParentheses.difficulty = ProblemDifficulty.EASY;
    validParentheses.category = ProblemCategory.STACK;
    validParentheses.choices = [
      { id: 'A', text: '使用栈存储左括号，遇到右括号时检查匹配', isCorrect: true },
      { id: 'B', text: '使用计数器分别统计各种括号的数量', isCorrect: false },
      { id: 'C', text: '使用递归检查括号匹配', isCorrect: false },
      { id: 'D', text: '从左到右扫描，直接匹配相邻的括号对', isCorrect: false }
    ];
    validParentheses.explanation = '栈是解决括号匹配问题的经典数据结构。遍历字符串，遇到左括号时入栈，遇到右括号时检查栈顶是否为对应的左括号。如果匹配则出栈继续，不匹配则返回false。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validParentheses.hint = '使用栈来匹配括号，左括号入栈，右括号时检查匹配';
    problems.push(validParentheses);

    // 最小栈
    const minStack = new ProblemModel();
    minStack.id = 199;
    minStack.title = '最小栈';
    minStack.description = '设计一个支持push，pop，top操作，并能在常数时间内检索到最小元素的栈。实现MinStack类：MinStack()初始化堆栈对象。void push(int val)将元素val推入堆栈。void pop()删除堆栈顶部的元素。int top()获取堆栈顶部的元素。int getMin()获取堆栈中的最小元素。';
    minStack.difficulty = ProblemDifficulty.EASY;
    minStack.category = ProblemCategory.STACK;
    minStack.choices = [
      { id: 'A', text: '使用辅助栈存储每个位置的最小值', isCorrect: true },
      { id: 'B', text: '每次getMin时遍历整个栈', isCorrect: false },
      { id: 'C', text: '使用变量记录当前最小值', isCorrect: false },
      { id: 'D', text: '对栈进行排序维护最小值', isCorrect: false }
    ];
    minStack.explanation = '使用两个栈：主栈存储所有元素，辅助栈存储每个位置对应的最小值。push时，辅助栈压入当前最小值；pop时，两个栈同时弹出。这样getMin操作的时间复杂度为O(1)。空间复杂度O(n)。';
    minStack.hint = '使用辅助栈记录每个位置的最小值';
    problems.push(minStack);

    // 逆波兰表达式求值
    const evalRPN = new ProblemModel();
    evalRPN.id = 200;
    evalRPN.title = '逆波兰表达式求值';
    evalRPN.description = '根据逆波兰表示法，求表达式的值。有效的算符包括+、-、*、/。每个运算对象可以是整数，也可以是另一个逆波兰表达式。注意两个整数之间的除法只保留整数部分。可以保证给定的逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为0的情况。';
    evalRPN.difficulty = ProblemDifficulty.MEDIUM;
    evalRPN.category = ProblemCategory.STACK;
    evalRPN.choices = [
      { id: 'A', text: '使用栈存储操作数，遇到运算符时弹出两个数计算', isCorrect: true },
      { id: 'B', text: '递归解析表达式', isCorrect: false },
      { id: 'C', text: '转换为中缀表达式再计算', isCorrect: false },
      { id: 'D', text: '使用双指针从两端解析', isCorrect: false }
    ];
    evalRPN.explanation = '逆波兰表达式（后缀表达式）的特点是运算符在操作数之后。使用栈：遇到数字时入栈，遇到运算符时弹出两个数进行计算，将结果入栈。最终栈中只剩一个数，即为结果。时间复杂度O(n)，空间复杂度O(n)。';
    evalRPN.hint = '栈存储操作数，遇到运算符就计算';
    problems.push(evalRPN);

    // 每日温度
    const dailyTemperatures = new ProblemModel();
    dailyTemperatures.id = 201;
    dailyTemperatures.title = '每日温度';
    dailyTemperatures.description = '给定一个整数数组temperatures，表示每天的温度，返回一个数组answer，其中answer[i]是指在第i天之后，才会有更高的温度。如果气温在这之后都不会升高，请在该位置用0来代替。';
    dailyTemperatures.difficulty = ProblemDifficulty.MEDIUM;
    dailyTemperatures.category = ProblemCategory.STACK;
    dailyTemperatures.choices = [
      { id: 'A', text: '使用单调递减栈存储温度的索引', isCorrect: true },
      { id: 'B', text: '对每个位置向后遍历找到更高温度', isCorrect: false },
      { id: 'C', text: '使用双指针技巧', isCorrect: false },
      { id: 'D', text: '排序后处理', isCorrect: false }
    ];
    dailyTemperatures.explanation = '这是单调栈的经典应用。维护一个单调递减的栈（存储索引），当遇到更高温度时，栈中所有小于当前温度的元素都找到了答案。栈中存储的是还没找到更高温度的日期索引。时间复杂度O(n)，空间复杂度O(n)。';
    dailyTemperatures.hint = '单调递减栈，存储还未找到更高温度的日期索引';
    problems.push(dailyTemperatures);

    // 下一个更大元素I
    const nextGreaterElement = new ProblemModel();
    nextGreaterElement.id = 202;
    nextGreaterElement.title = '下一个更大元素I';
    nextGreaterElement.description = 'nums1中数字x的下一个更大元素是指x在nums2中对应位置右边的第一个比x大的元素。给你两个没有重复元素的数组nums1和nums2，下标从0开始计数，其中nums1是nums2的子集。对于每个0 <= i < nums1.length，找出满足nums1[i] == nums2[j]的下标j，并且确定nums2[j]的下一个更大元素。如果不存在下一个更大元素，那么本次查询的答案是-1。';
    nextGreaterElement.difficulty = ProblemDifficulty.EASY;
    nextGreaterElement.category = ProblemCategory.STACK;
    nextGreaterElement.choices = [
      { id: 'A', text: '使用单调栈预处理nums2，再查询nums1', isCorrect: true },
      { id: 'B', text: '对nums1中每个元素在nums2中暴力搜索', isCorrect: false },
      { id: 'C', text: '排序后使用二分查找', isCorrect: false },
      { id: 'D', text: '使用双指针技巧', isCorrect: false }
    ];
    nextGreaterElement.explanation = '先用单调栈处理nums2，找出每个元素的下一个更大元素，存储在哈希表中。然后遍历nums1，在哈希表中查询结果。单调栈维护递减序列，当遇到更大元素时，栈中元素都找到了答案。时间复杂度O(m+n)，空间复杂度O(n)。';
    nextGreaterElement.hint = '先用单调栈处理nums2，再查询nums1';
    problems.push(nextGreaterElement);

    // 下一个更大元素II
    const nextGreaterElementII = new ProblemModel();
    nextGreaterElementII.id = 203;
    nextGreaterElementII.title = '下一个更大元素II';
    nextGreaterElementII.description = '给定一个循环数组nums（nums[nums.length - 1]的下一个元素是nums[0]），返回nums中每个元素的下一个更大元素。数字x的下一个更大元素是按数组遍历顺序，这个数字之后的第一个比它更大的数，这意味着你应该循环地搜索它的下一个更大的数。如果不存在，则输出-1。';
    nextGreaterElementII.difficulty = ProblemDifficulty.MEDIUM;
    nextGreaterElementII.category = ProblemCategory.STACK;
    nextGreaterElementII.choices = [
      { id: 'A', text: '使用单调栈，将数组扩展为两倍长度处理', isCorrect: true },
      { id: 'B', text: '对每个元素循环遍历数组', isCorrect: false },
      { id: 'C', text: '使用递归处理循环', isCorrect: false },
      { id: 'D', text: '复制数组拼接后处理', isCorrect: false }
    ];
    nextGreaterElementII.explanation = '由于是循环数组，可以将数组看作长度为2n的数组（通过取模实现）。使用单调栈，遍历两遍数组。第一遍处理正常情况，第二遍处理循环情况。栈中存储索引，当遇到更大元素时更新结果。时间复杂度O(n)，空间复杂度O(n)。';
    nextGreaterElementII.hint = '将循环数组扩展为两倍长度，使用单调栈';
    problems.push(nextGreaterElementII);

    // 柱状图中最大的矩形
    const largestRectangle = new ProblemModel();
    largestRectangle.id = 204;
    largestRectangle.title = '柱状图中最大的矩形';
    largestRectangle.description = '给定n个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为1。求在该柱状图中，能够勾勒出来的矩形的最大面积。';
    largestRectangle.difficulty = ProblemDifficulty.HARD;
    largestRectangle.category = ProblemCategory.STACK;
    largestRectangle.choices = [
      { id: 'A', text: '使用单调递增栈，计算每个柱子能扩展的最大矩形', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的矩形', isCorrect: false },
      { id: 'C', text: '分治算法递归处理', isCorrect: false },
      { id: 'D', text: '动态规划计算最大面积', isCorrect: false }
    ];
    largestRectangle.explanation = '使用单调递增栈存储柱子索引。当遇到较矮的柱子时，栈中较高的柱子都可以计算面积了。对于栈顶柱子，其高度确定，宽度是当前位置与栈中下一个元素之间的距离。在数组末尾添加0确保所有柱子都被处理。时间复杂度O(n)，空间复杂度O(n)。';
    largestRectangle.hint = '单调递增栈，遇到较矮柱子时计算面积';
    problems.push(largestRectangle);

    // 最大矩形
    const maximalRectangle = new ProblemModel();
    maximalRectangle.id = 205;
    maximalRectangle.title = '最大矩形';
    maximalRectangle.description = '给定一个仅包含0和1、大小为rows x cols的二维二进制矩阵，找出只包含1的最大矩形，并返回其面积。';
    maximalRectangle.difficulty = ProblemDifficulty.HARD;
    maximalRectangle.category = ProblemCategory.STACK;
    maximalRectangle.choices = [
      { id: 'A', text: '将问题转化为多个柱状图中最大矩形问题', isCorrect: true },
      { id: 'B', text: '使用动态规划直接计算', isCorrect: false },
      { id: 'C', text: '暴力枚举所有可能的矩形', isCorrect: false },
      { id: 'D', text: '使用并查集处理连通区域', isCorrect: false }
    ];
    maximalRectangle.explanation = '将二维问题转化为一维问题。对于每一行，计算以该行为底的柱状图的高度数组，然后使用"柱状图中最大矩形"的算法。每一行都可以看作一个柱状图问题。时间复杂度O(rows*cols)，空间复杂度O(cols)。';
    maximalRectangle.hint = '转化为柱状图最大矩形问题，逐行处理';
    problems.push(maximalRectangle);

    // 去除重复字母
    const removeDuplicateLetters = new ProblemModel();
    removeDuplicateLetters.id = 206;
    removeDuplicateLetters.title = '去除重复字母';
    removeDuplicateLetters.description = '给你一个字符串s，请你去除字符串中重复的字母，使得每个字母只出现一次。需保证返回结果的字典序最小（要求不能打乱其他字符的相对位置）。';
    removeDuplicateLetters.difficulty = ProblemDifficulty.MEDIUM;
    removeDuplicateLetters.category = ProblemCategory.STACK;
    removeDuplicateLetters.choices = [
      { id: 'A', text: '使用单调栈维护字典序，配合字符计数和访问标记', isCorrect: true },
      { id: 'B', text: '先统计字符频次，再贪心选择', isCorrect: false },
      { id: 'C', text: '使用哈希表去重后排序', isCorrect: false },
      { id: 'D', text: '递归处理每个字符', isCorrect: false }
    ];
    removeDuplicateLetters.explanation = '使用单调栈维护结果的字典序。需要三个辅助结构：计数数组记录每个字符剩余次数，访问数组记录字符是否已在结果中，栈维护当前结果。当遇到字符时，如果已在栈中则跳过；否则，如果栈顶字符大于当前字符且后面还会出现，则弹出栈顶。时间复杂度O(n)，空间复杂度O(1)。';
    removeDuplicateLetters.hint = '单调栈+计数+访问标记，维护字典序最小';
    problems.push(removeDuplicateLetters);

    // 单调递增的数字
    const monotoneIncreasingDigits = new ProblemModel();
    monotoneIncreasingDigits.id = 207;
    monotoneIncreasingDigits.title = '单调递增的数字';
    monotoneIncreasingDigits.description = '当且仅当每个相邻位数上的数字x和y满足x <= y时，我们称这个整数是单调递增的。给定一个整数n，返回小于或等于n的最大数字，且数字呈单调递增。';
    monotoneIncreasingDigits.difficulty = ProblemDifficulty.MEDIUM;
    monotoneIncreasingDigits.category = ProblemCategory.STACK;
    monotoneIncreasingDigits.choices = [
      { id: 'A', text: '从右到左遍历，遇到递减位置就调整', isCorrect: true },
      { id: 'B', text: '使用栈维护单调性', isCorrect: false },
      { id: 'C', text: '贪心从左到右构造', isCorrect: false },
      { id: 'D', text: '动态规划计算最优解', isCorrect: false }
    ];
    monotoneIncreasingDigits.explanation = '从右到左遍历数字的各位。当发现nums[i] > nums[i+1]时，将nums[i]减1，并将i+1位及其后面的所有位都设为9。这样可以保证结果最大且单调递增。需要记录最早需要设为9的位置。时间复杂度O(log n)，空间复杂度O(log n)。';
    monotoneIncreasingDigits.hint = '从右到左调整，遇到递减就减1并后面置9';
    problems.push(monotoneIncreasingDigits);

    // 验证栈序列
    const validateStackSequences = new ProblemModel();
    validateStackSequences.id = 208;
    validateStackSequences.title = '验证栈序列';
    validateStackSequences.description = '给定pushed和popped两个序列，每个序列中的值都不重复，只有当它们可能是在最初空的栈上进行的推入push和弹出pop操作序列的结果时，才返回true；否则，返回false。';
    validateStackSequences.difficulty = ProblemDifficulty.MEDIUM;
    validateStackSequences.category = ProblemCategory.STACK;
    validateStackSequences.choices = [
      { id: 'A', text: '模拟栈操作过程，检查是否能产生目标序列', isCorrect: true },
      { id: 'B', text: '检查两个序列的元素是否相同', isCorrect: false },
      { id: 'C', text: '使用数学公式验证', isCorrect: false },
      { id: 'D', text: '递归验证每个子序列', isCorrect: false }
    ];
    validateStackSequences.explanation = '使用栈模拟整个过程。遍历pushed数组，将元素入栈。每次入栈后，检查栈顶是否等于popped数组当前要弹出的元素，如果是则弹出并移动popped指针。最后检查栈是否为空。时间复杂度O(n)，空间复杂度O(n)。';
    validateStackSequences.hint = '模拟栈操作，入栈后检查是否需要弹出';
    problems.push(validateStackSequences);

    // 基本计算器
    const basicCalculator = new ProblemModel();
    basicCalculator.id = 209;
    basicCalculator.title = '基本计算器';
    basicCalculator.description = '给你一个字符串表达式s，请你实现一个基本计算器来计算并返回它的值。注意:不允许使用任何将字符串作为数学表达式计算的内置函数，比如eval()。';
    basicCalculator.difficulty = ProblemDifficulty.HARD;
    basicCalculator.category = ProblemCategory.STACK;
    basicCalculator.choices = [
      { id: 'A', text: '使用栈处理括号和运算符优先级', isCorrect: true },
      { id: 'B', text: '递归解析表达式', isCorrect: false },
      { id: 'C', text: '转换为后缀表达式再计算', isCorrect: false },
      { id: 'D', text: '使用状态机解析', isCorrect: false }
    ];
    basicCalculator.explanation = '使用栈处理括号。遇到数字时累加，遇到运算符时根据前一个运算符处理当前数字，遇到左括号时将当前结果和运算符入栈，遇到右括号时弹出栈顶进行计算。关键是正确处理运算符的优先级和括号的嵌套。时间复杂度O(n)，空间复杂度O(n)。';
    basicCalculator.hint = '栈处理括号，记录当前数字和运算符';
    problems.push(basicCalculator);

    // 基本计算器II
    const basicCalculatorII = new ProblemModel();
    basicCalculatorII.id = 210;
    basicCalculatorII.title = '基本计算器II';
    basicCalculatorII.description = '给你一个字符串表达式s，请你实现一个基本计算器来计算并返回它的值。整数除法仅保留整数部分。你可以假设给定的表达式总是有效的。所有中间结果将在[-2^31, 2^31 - 1]的范围内。';
    basicCalculatorII.difficulty = ProblemDifficulty.MEDIUM;
    basicCalculatorII.category = ProblemCategory.STACK;
    basicCalculatorII.choices = [
      { id: 'A', text: '使用栈处理乘除法的优先级', isCorrect: true },
      { id: 'B', text: '从左到右直接计算', isCorrect: false },
      { id: 'C', text: '先处理所有乘除，再处理加减', isCorrect: false },
      { id: 'D', text: '使用递归处理优先级', isCorrect: false }
    ];
    basicCalculatorII.explanation = '使用栈处理运算符优先级。遇到数字时，根据前一个运算符决定操作：+号将数字入栈，-号将负数入栈，*和/号与栈顶元素计算后入栈。最后将栈中所有数字相加。这样确保乘除法优先于加减法执行。时间复杂度O(n)，空间复杂度O(n)。';
    basicCalculatorII.hint = '栈处理优先级，乘除立即计算，加减延后';
    problems.push(basicCalculatorII);

    // 字符串解码
    const decodeString = new ProblemModel();
    decodeString.id = 211;
    decodeString.title = '字符串解码';
    decodeString.description = '给定一个经过编码的字符串，返回它解码后的字符串。编码规则为: k[encoded_string]，表示其中方括号内部的encoded_string正好重复k次。注意k保证为正整数。';
    decodeString.difficulty = ProblemDifficulty.MEDIUM;
    decodeString.category = ProblemCategory.STACK;
    decodeString.choices = [
      { id: 'A', text: '使用栈处理嵌套的括号结构', isCorrect: true },
      { id: 'B', text: '递归解析每个括号', isCorrect: false },
      { id: 'C', text: '正则表达式匹配替换', isCorrect: false },
      { id: 'D', text: '从内到外逐层解码', isCorrect: false }
    ];
    decodeString.explanation = '使用两个栈：数字栈存储重复次数，字符串栈存储当前构建的字符串。遇到数字时累加，遇到[时将当前数字和字符串入栈并重置，遇到字母时添加到当前字符串，遇到]时弹出栈顶进行重复操作。时间复杂度O(n)，空间复杂度O(n)。';
    decodeString.hint = '两个栈分别存储数字和字符串，处理嵌套结构';
    problems.push(decodeString);

    // 移掉K位数字
    const removeKdigits = new ProblemModel();
    removeKdigits.id = 212;
    removeKdigits.title = '移掉K位数字';
    removeKdigits.description = '给你一个以字符串表示的非负整数num和一个整数k，移除这个数中的k位数字，使得剩下的数字最小。请你返回这个最小的数字。';
    removeKdigits.difficulty = ProblemDifficulty.MEDIUM;
    removeKdigits.category = ProblemCategory.STACK;
    removeKdigits.choices = [
      { id: 'A', text: '使用单调递增栈，贪心移除较大的数字', isCorrect: true },
      { id: 'B', text: '暴力尝试所有可能的移除方案', isCorrect: false },
      { id: 'C', text: '从高位开始移除最大的数字', isCorrect: false },
      { id: 'D', text: '使用动态规划找最优解', isCorrect: false }
    ];
    removeKdigits.explanation = '使用单调递增栈贪心策略。遍历数字，如果当前数字小于栈顶且还需要移除数字，则弹出栈顶。这样可以保证移除的都是相对较大的数字。最后如果还需要移除，从末尾移除。注意处理前导零和空结果的情况。时间复杂度O(n)，空间复杂度O(n)。';
    removeKdigits.hint = '单调递增栈贪心移除，保留较小数字';
    problems.push(removeKdigits);

    // 接雨水
    const trapRainWater = new ProblemModel();
    trapRainWater.id = 213;
    trapRainWater.title = '接雨水';
    trapRainWater.description = '给定n个非负整数表示每个宽度为1的柱子的高度图，计算按此排列的柱子，下雨之后能够接多少雨水。';
    trapRainWater.difficulty = ProblemDifficulty.HARD;
    trapRainWater.category = ProblemCategory.STACK;
    trapRainWater.choices = [
      { id: 'A', text: '使用单调递减栈计算每个凹槽的积水', isCorrect: true },
      { id: 'B', text: '双指针从两端向中间计算', isCorrect: false },
      { id: 'C', text: '动态规划预处理左右最大值', isCorrect: false },
      { id: 'D', text: '暴力计算每个位置的积水高度', isCorrect: false }
    ];
    trapRainWater.explanation = '使用单调递减栈存储柱子索引。当遇到较高柱子时，可以形成凹槽接水。弹出栈顶作为底部，计算由当前柱子和新栈顶围成的矩形积水量。宽度是两个柱子之间的距离，高度是较矮柱子减去底部高度。时间复杂度O(n)，空间复杂度O(n)。';
    trapRainWater.hint = '单调递减栈，遇到高柱子时计算凹槽积水';
    problems.push(trapRainWater);

    // 滑动窗口最大值
    const maxSlidingWindow = new ProblemModel();
    maxSlidingWindow.id = 214;
    maxSlidingWindow.title = '滑动窗口最大值';
    maxSlidingWindow.description = '给你一个整数数组nums，有一个大小为k的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的k个数字。滑动窗口每次只向右移动一位。返回滑动窗口中的最大值。';
    maxSlidingWindow.difficulty = ProblemDifficulty.HARD;
    maxSlidingWindow.category = ProblemCategory.STACK;
    maxSlidingWindow.choices = [
      { id: 'A', text: '使用双端队列维护单调递减序列', isCorrect: true },
      { id: 'B', text: '使用堆维护窗口最大值', isCorrect: false },
      { id: 'C', text: '暴力计算每个窗口的最大值', isCorrect: false },
      { id: 'D', text: '使用线段树查询区间最大值', isCorrect: false }
    ];
    maxSlidingWindow.explanation = '使用双端队列（deque）维护一个单调递减的序列，存储数组索引。队列头部始终是当前窗口的最大值索引。添加新元素时，从队列尾部移除所有小于当前元素的索引；移动窗口时，检查队列头部是否超出窗口范围。时间复杂度O(n)，空间复杂度O(k)。';
    maxSlidingWindow.hint = '双端队列维护单调递减，队头是窗口最大值';
    problems.push(maxSlidingWindow);

    // 最短无序连续子数组
    const findUnsortedSubarray = new ProblemModel();
    findUnsortedSubarray.id = 215;
    findUnsortedSubarray.title = '最短无序连续子数组';
    findUnsortedSubarray.description = '给你一个整数数组nums，你需要找出一个连续子数组，如果对这个子数组进行升序排序，那么整个数组都会变为升序排序。请你找出符合题意的最短子数组，并输出它的长度。';
    findUnsortedSubarray.difficulty = ProblemDifficulty.MEDIUM;
    findUnsortedSubarray.category = ProblemCategory.STACK;
    findUnsortedSubarray.choices = [
      { id: 'A', text: '使用单调栈找到需要排序的边界', isCorrect: true },
      { id: 'B', text: '排序后比较找出不同的区间', isCorrect: false },
      { id: 'C', text: '双指针从两端找到无序边界', isCorrect: false },
      { id: 'D', text: '遍历找到最大最小值的位置', isCorrect: false }
    ];
    findUnsortedSubarray.explanation = '使用两个单调栈：递增栈从左到右找到需要排序的左边界，递减栈从右到左找到需要排序的右边界。当栈不为空且当前元素破坏单调性时，更新边界。这样可以准确找到最短的需要排序的子数组。时间复杂度O(n)，空间复杂度O(n)。';
    findUnsortedSubarray.hint = '两个单调栈分别找左右边界';
    problems.push(findUnsortedSubarray);

    // 132模式
    const find132pattern = new ProblemModel();
    find132pattern.id = 216;
    find132pattern.title = '132模式';
    find132pattern.description = '给你一个整数数组nums，数组中共有n个整数。132模式的子序列由三个整数nums[i]、nums[j]和nums[k]组成，并同时满足：i < j < k和nums[i] < nums[k] < nums[j]。如果nums中存在132模式的子序列，返回true；否则，返回false。';
    find132pattern.difficulty = ProblemDifficulty.MEDIUM;
    find132pattern.category = ProblemCategory.STACK;
    find132pattern.choices = [
      { id: 'A', text: '使用单调栈维护可能的第二大值', isCorrect: true },
      { id: 'B', text: '暴力枚举所有三元组', isCorrect: false },
      { id: 'C', text: '动态规划记录状态', isCorrect: false },
      { id: 'D', text: '排序后使用双指针', isCorrect: false }
    ];
    find132pattern.explanation = '从右到左遍历，使用单调递减栈维护可能作为"3"的候选值，用变量记录当前的"2"（第二大值）。当遇到比"2"小的数时，就找到了132模式。栈中维护的是比当前"2"大的数，当遇到更大的数时，更新"2"的值。时间复杂度O(n)，空间复杂度O(n)。';
    find132pattern.hint = '从右到左，栈维护候选"3"，变量记录"2"';
    problems.push(find132pattern);

    // 子数组的最小值之和
    const sumSubarrayMins = new ProblemModel();
    sumSubarrayMins.id = 217;
    sumSubarrayMins.title = '子数组的最小值之和';
    sumSubarrayMins.description = '给定一个整数数组arr，找到min(b)的总和，其中b的范围为arr的每个（连续）子数组。由于答案可能很大，因此返回答案模10^9 + 7。';
    sumSubarrayMins.difficulty = ProblemDifficulty.MEDIUM;
    sumSubarrayMins.category = ProblemCategory.STACK;
    sumSubarrayMins.choices = [
      { id: 'A', text: '使用单调栈计算每个元素作为最小值的贡献', isCorrect: true },
      { id: 'B', text: '暴力枚举所有子数组', isCorrect: false },
      { id: 'C', text: '动态规划计算最小值', isCorrect: false },
      { id: 'D', text: '分治算法递归处理', isCorrect: false }
    ];
    sumSubarrayMins.explanation = '对每个元素，计算它作为最小值的子数组数量。使用单调递增栈找到每个元素左边和右边第一个更小的元素，确定该元素作为最小值的范围。左边界到该元素的距离乘以该元素到右边界的距离，就是包含该元素且以它为最小值的子数组数量。时间复杂度O(n)，空间复杂度O(n)。';
    sumSubarrayMins.hint = '单调栈找边界，计算每个元素的贡献';
    problems.push(sumSubarrayMins);

    // 最大宽度坡
    const maxWidthRamp = new ProblemModel();
    maxWidthRamp.id = 218;
    maxWidthRamp.title = '最大宽度坡';
    maxWidthRamp.description = '给定一个整数数组A，坡是元组(i, j)，其中i < j且A[i] <= A[j]。这样的坡的宽度为j - i。找出A中的坡的最大宽度，如果不存在，返回0。';
    maxWidthRamp.difficulty = ProblemDifficulty.MEDIUM;
    maxWidthRamp.category = ProblemCategory.STACK;
    maxWidthRamp.choices = [
      { id: 'A', text: '使用单调递减栈存储可能的左端点', isCorrect: true },
      { id: 'B', text: '暴力枚举所有可能的坡', isCorrect: false },
      { id: 'C', text: '排序后使用双指针', isCorrect: false },
      { id: 'D', text: '动态规划计算最大宽度', isCorrect: false }
    ];
    maxWidthRamp.explanation = '首先用单调递减栈存储所有可能作为坡左端点的索引。然后从右到左遍历数组，对于每个位置，在栈中找到最左边满足条件的位置。由于栈是单调递减的，可以贪心地弹出栈顶元素来找到最优解。时间复杂度O(n)，空间复杂度O(n)。';
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
    palindromeNumber.description = '给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。';
    palindromeNumber.difficulty = ProblemDifficulty.EASY;
    palindromeNumber.category = ProblemCategory.MATH;
    palindromeNumber.choices = [
      { id: 'A', text: '将数字转换为字符串，然后比较字符串与其反转', isCorrect: false },
      { id: 'B', text: '反转整个数字，然后比较原数字与反转后的数字', isCorrect: false },
      { id: 'C', text: '只反转数字的后半部分，然后比较前半部分与反转后的后半部分', isCorrect: true },
      { id: 'D', text: '使用递归逐位比较', isCorrect: false }
    ];
    palindromeNumber.explanation = '最优解法是只反转数字的后半部分。通过不断取余和除法操作，将数字的后半部分反转，当原数字小于等于反转数字时停止。对于奇数位数字，需要将反转数字除以10去掉中间位。时间复杂度O(log n)，空间复杂度O(1)。';
    palindromeNumber.hint = '考虑只反转数字的一半，避免整数溢出';
    problems.push(palindromeNumber);

    // 整数反转
    const reverseInteger = new ProblemModel();
    reverseInteger.id = 302;
    reverseInteger.title = '整数反转';
    reverseInteger.description = '给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。如果反转后整数超过 32 位的有符号整数的范围 [−2³¹,  2³¹ − 1] ，就返回 0。';
    reverseInteger.difficulty = ProblemDifficulty.EASY;
    reverseInteger.category = ProblemCategory.MATH;
    reverseInteger.choices = [
      { id: 'A', text: '使用字符串反转，然后转换回整数', isCorrect: false },
      { id: 'B', text: '使用数学方法：不断取余和除法，同时检查溢出', isCorrect: true },
      { id: 'C', text: '使用栈存储各位数字，然后弹出重组', isCorrect: false },
      { id: 'D', text: '使用递归逐位处理', isCorrect: false }
    ];
    reverseInteger.explanation = '使用数学方法逐位反转。通过 result = result * 10 + x % 10 来构建反转数字，同时需要在每次操作前检查是否会导致32位整数溢出。可以通过比较 result 与 (2³¹-1)/10 来提前判断溢出。时间复杂度O(log n)，空间复杂度O(1)。';
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
    romanToInt.explanation = '从左到右遍历罗马数字字符串。使用哈希表存储每个字符对应的数值。如果当前字符的值小于下一个字符的值，说明这是一个减法情况（如IV=4），则减去当前值；否则加上当前值。时间复杂度O(n)，空间复杂度O(1)。';
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
    intToRoman.explanation = '使用贪心算法。预先定义所有可能的罗马数字组合（包括减法情况如CM=900, CD=400等），按从大到小排序。然后从最大的开始，尽可能多地使用当前组合，直到数字变为0。时间复杂度O(1)，空间复杂度O(1)。';
    intToRoman.hint = '预定义所有罗马数字组合，贪心地从大到小匹配';
    problems.push(intToRoman);

    // 字符串相乘
    const multiplyStrings = new ProblemModel();
    multiplyStrings.id = 305;
    multiplyStrings.title = '字符串相乘';
    multiplyStrings.description = '给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。';
    multiplyStrings.difficulty = ProblemDifficulty.MEDIUM;
    multiplyStrings.category = ProblemCategory.MATH;
    multiplyStrings.choices = [
      { id: 'A', text: '模拟手工乘法过程，使用数组存储每一位的结果', isCorrect: true },
      { id: 'B', text: '将字符串转换为整数后直接相乘', isCorrect: false },
      { id: 'C', text: '使用递归分治算法', isCorrect: false },
      { id: 'D', text: '使用快速傅里叶变换', isCorrect: false }
    ];
    multiplyStrings.explanation = '模拟手工乘法。创建长度为 m+n 的数组存储结果，其中 m 和 n 分别是两个数字的长度。对于位置 i 和 j 的数字相乘，结果应该放在位置 i+j 和 i+j+1。最后处理进位并转换为字符串。时间复杂度O(m*n)，空间复杂度O(m+n)。';
    multiplyStrings.hint = '模拟手工乘法，注意处理进位和前导零';
    problems.push(multiplyStrings);

    // 快乐数
    const happyNumber = new ProblemModel();
    happyNumber.id = 306;
    happyNumber.title = '快乐数';
    happyNumber.description = '编写一个算法来判断一个数 n 是不是快乐数。快乐数定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1（此时我们称这个数为快乐数），或是无限循环但始终变不到 1。如果可以变为 1，那么这个数就是快乐数。';
    happyNumber.difficulty = ProblemDifficulty.EASY;
    happyNumber.category = ProblemCategory.MATH;
    happyNumber.choices = [
      { id: 'A', text: '使用哈希集合检测循环', isCorrect: true },
      { id: 'B', text: '使用快慢指针检测循环', isCorrect: true },
      { id: 'C', text: '设置最大迭代次数限制', isCorrect: false },
      { id: 'D', text: '使用递归直到找到结果', isCorrect: false }
    ];
    happyNumber.explanation = '有两种主要方法：1) 使用哈希集合存储已经出现过的数字，如果再次出现说明进入循环；2) 使用快慢指针，类似检测链表环的方法。两种方法都能有效检测循环。时间复杂度O(log n)，空间复杂度O(log n)或O(1)。';
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
    trailingZeroes.explanation = '尾随零由因子10产生，而10=2×5。在阶乘中，因子2的个数总是比因子5多，所以只需要计算因子5的个数。计算方法：n/5 + n/25 + n/125 + ...，即计算能被5、25、125等整除的数的个数。时间复杂度O(log n)，空间复杂度O(1)。';
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
    rightShift.explanation = '使用位运算模拟加法。异或运算(^)可以计算无进位的和，与运算(&)可以计算进位。重复这个过程直到没有进位为止。具体步骤：1) sum = a ^ b（无进位和）2) carry = (a & b) << 1（进位）3) 重复直到carry为0。时间复杂度O(1)，空间复杂度O(1)。';
    rightShift.hint = '使用异或计算无进位和，使用与运算计算进位';
    problems.push(rightShift);

    // 丑数
    const uglyNumber = new ProblemModel();
    uglyNumber.id = 309;
    uglyNumber.title = '丑数';
    uglyNumber.description = '丑数 就是只包含质因数 2、3 和 5 的正整数。给你一个整数 n ，请你判断 n 是否为 丑数 。如果是，返回 true ；否则，返回 false 。';
    uglyNumber.difficulty = ProblemDifficulty.EASY;
    uglyNumber.category = ProblemCategory.MATH;
    uglyNumber.choices = [
      { id: 'A', text: '不断除以2、3、5，最后判断结果是否为1', isCorrect: true },
      { id: 'B', text: '使用质因数分解算法', isCorrect: false },
      { id: 'C', text: '使用动态规划判断', isCorrect: false },
      { id: 'D', text: '使用递归检查每个因子', isCorrect: false }
    ];
    uglyNumber.explanation = '简单的数学方法。如果n是丑数，那么它只包含因子2、3、5。不断用n除以2、3、5（只要能整除），最后如果结果是1，说明n是丑数；否则不是。需要特别处理n<=0的情况。时间复杂度O(log n)，空间复杂度O(1)。';
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
    uglyNumberII.explanation = '使用动态规划和三指针。维护三个指针p2、p3、p5，分别表示下一个要乘以2、3、5的丑数的位置。每次选择 min(ugly[p2]*2, ugly[p3]*3, ugly[p5]*5) 作为下一个丑数，然后移动对应的指针。时间复杂度O(n)，空间复杂度O(n)。';
    uglyNumberII.hint = '使用三指针动态规划，每次选择最小的候选丑数';
    problems.push(uglyNumberII);

    // 超级丑数
    const superUglyNumber = new ProblemModel();
    superUglyNumber.id = 311;
    superUglyNumber.title = '超级丑数';
    superUglyNumber.description = '超级丑数 是一个正整数，并满足其所有质因数都出现在质数数组 primes 中。给你一个整数 n 和一个整数数组 primes ，返回第 n 个 超级丑数 。';
    superUglyNumber.difficulty = ProblemDifficulty.MEDIUM;
    superUglyNumber.category = ProblemCategory.MATH;
    superUglyNumber.choices = [
      { id: 'A', text: '扩展丑数II的方法，为每个质因数维护一个指针', isCorrect: true },
      { id: 'B', text: '使用最小堆维护候选数', isCorrect: false },
      { id: 'C', text: '暴力检查每个数的质因数', isCorrect: false },
      { id: 'D', text: '使用递归生成序列', isCorrect: false }
    ];
    superUglyNumber.explanation = '扩展丑数II的思路。为每个质因数维护一个指针，每次从所有候选数中选择最小的作为下一个超级丑数。需要注意去重，当多个质因数产生相同的候选数时，要同时移动对应的指针。时间复杂度O(n*k)，空间复杂度O(n+k)，其中k是质因数个数。';
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
    addDigits.explanation = '这是一个数学问题，结果实际上是数字根(Digital Root)。对于正整数，数字根的公式是：(num - 1) % 9 + 1。特殊情况：当num为0时，结果为0。这个公式基于9的倍数的性质。时间复杂度O(1)，空间复杂度O(1)。';
    addDigits.hint = '这是数字根问题，可以用数学公式直接计算';
    problems.push(addDigits);

    // 完全平方数
    const perfectSquares = new ProblemModel();
    perfectSquares.id = 313;
    perfectSquares.title = '完全平方数';
    perfectSquares.description = '给你一个整数 n ，返回 和为 n 的完全平方数的最少数量 。完全平方数 是一个整数，其值等于另一个整数的平方；换句话说，其值等于一个整数自乘的积。例如，1、4、9 和 16 都是完全平方数，而 3 和 11 不是。';
    perfectSquares.difficulty = ProblemDifficulty.MEDIUM;
    perfectSquares.category = ProblemCategory.MATH;
    perfectSquares.choices = [
      { id: 'A', text: '使用动态规划：dp[i] = min(dp[i-j*j] + 1)', isCorrect: true },
      { id: 'B', text: '使用BFS搜索最短路径', isCorrect: false },
      { id: 'C', text: '使用贪心算法选择最大的完全平方数', isCorrect: false },
      { id: 'D', text: '使用数学定理直接计算', isCorrect: false }
    ];
    perfectSquares.explanation = '使用动态规划。dp[i]表示和为i的完全平方数的最少数量。状态转移方程：dp[i] = min(dp[i-j*j] + 1)，其中j*j <= i。初始化dp[0] = 0。也可以使用BFS，将问题看作图的最短路径问题。时间复杂度O(n*√n)，空间复杂度O(n)。';
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
    countPrimes.explanation = '使用埃拉托斯特尼筛法。创建布尔数组标记每个数是否为质数，初始都为true。从2开始，将每个质数的倍数标记为false。最后统计仍为true的数的个数。优化：只需检查到√n，且可以从i²开始标记。时间复杂度O(n log log n)，空间复杂度O(n)。';
    countPrimes.hint = '使用埃拉托斯特尼筛法，标记质数的倍数';
    problems.push(countPrimes);

    // 同构字符串
    const isomorphicStrings = new ProblemModel();
    isomorphicStrings.id = 315;
    isomorphicStrings.title = '同构字符串';
    isomorphicStrings.description = '给定两个字符串 s 和 t ，判断它们是否是同构的。如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。';
    isomorphicStrings.difficulty = ProblemDifficulty.EASY;
    isomorphicStrings.category = ProblemCategory.MATH;
    isomorphicStrings.choices = [
      { id: 'A', text: '使用两个哈希表分别记录s到t和t到s的映射', isCorrect: true },
      { id: 'B', text: '只使用一个哈希表记录映射关系', isCorrect: false },
      { id: 'C', text: '使用数组记录字符出现位置', isCorrect: false },
      { id: 'D', text: '直接比较字符串模式', isCorrect: false }
    ];
    isomorphicStrings.explanation = '需要建立双向映射关系。使用两个哈希表，一个记录s到t的映射，另一个记录t到s的映射。遍历字符串时，检查当前字符的映射是否与已建立的映射一致。如果不一致或者映射冲突，返回false。时间复杂度O(n)，空间复杂度O(1)。';
    isomorphicStrings.hint = '需要建立双向映射，确保一对一的对应关系';
    problems.push(isomorphicStrings);

    // 存在重复元素
    const containsDuplicate = new ProblemModel();
    containsDuplicate.id = 316;
    containsDuplicate.title = '存在重复元素';
    containsDuplicate.description = '给你一个整数数组 nums 。如果任一值在数组中出现 至少两次 ，返回 true ；如果数组中每个元素互不相同，返回 false 。';
    containsDuplicate.difficulty = ProblemDifficulty.EASY;
    containsDuplicate.category = ProblemCategory.MATH;
    containsDuplicate.choices = [
      { id: 'A', text: '使用哈希集合检查重复元素', isCorrect: true },
      { id: 'B', text: '先排序再检查相邻元素', isCorrect: false },
      { id: 'C', text: '使用两层循环暴力检查', isCorrect: false },
      { id: 'D', text: '使用位运算标记出现的数字', isCorrect: false }
    ];
    containsDuplicate.explanation = '最简单的方法是使用哈希集合。遍历数组，对于每个元素，检查是否已在集合中。如果在，返回true；如果不在，加入集合。遍历完成后返回false。时间复杂度O(n)，空间复杂度O(n)。也可以先排序再检查相邻元素，时间复杂度O(n log n)，空间复杂度O(1)。';
    containsDuplicate.hint = '使用哈希集合是最直接的方法';
    problems.push(containsDuplicate);

    // 存在重复元素II
    const containsDuplicateII = new ProblemModel();
    containsDuplicateII.id = 317;
    containsDuplicateII.title = '存在重复元素 II';
    containsDuplicateII.description = '给你一个整数数组 nums 和一个整数 k ，判断数组中是否存在两个 不同的索引 i 和 j ，满足 nums[i] == nums[j] 且 abs(i - j) <= k 。如果存在，返回 true ；否则，返回 false 。';
    containsDuplicateII.difficulty = ProblemDifficulty.EASY;
    containsDuplicateII.category = ProblemCategory.MATH;
    containsDuplicateII.choices = [
      { id: 'A', text: '使用哈希表记录每个元素最近出现的索引', isCorrect: true },
      { id: 'B', text: '使用滑动窗口维护大小为k的窗口', isCorrect: false },
      { id: 'C', text: '对每个元素检查前k个位置', isCorrect: false },
      { id: 'D', text: '使用两层循环暴力检查', isCorrect: false }
    ];
    containsDuplicateII.explanation = '使用哈希表记录每个元素最近出现的索引。遍历数组时，对于每个元素，检查它是否在哈希表中且索引差值不超过k。如果满足条件返回true，否则更新该元素在哈希表中的索引。时间复杂度O(n)，空间复杂度O(min(n,k))。';
    containsDuplicateII.hint = '记录每个元素最近出现的索引，检查索引差值';
    problems.push(containsDuplicateII);

    // 存在重复元素III
    const containsDuplicateIII = new ProblemModel();
    containsDuplicateIII.id = 318;
    containsDuplicateIII.title = '存在重复元素 III';
    containsDuplicateIII.description = '给你一个整数数组 nums 和两个整数 k 和 t 。判断数组中是否存在 两个不同的索引 i 和 j，使得 abs(nums[i] - nums[j]) <= t ，同时 abs(i - j) <= k 。如果存在则返回 true，不存在返回 false。';
    containsDuplicateIII.difficulty = ProblemDifficulty.MEDIUM;
    containsDuplicateIII.category = ProblemCategory.MATH;
    containsDuplicateIII.choices = [
      { id: 'A', text: '使用桶排序思想，将数字分到不同桶中', isCorrect: true },
      { id: 'B', text: '使用平衡二叉搜索树维护滑动窗口', isCorrect: false },
      { id: 'C', text: '对每个元素检查前k个元素', isCorrect: false },
      { id: 'D', text: '使用哈希表记录所有元素', isCorrect: false }
    ];
    containsDuplicateIII.explanation = '使用桶排序思想。将数字按照大小分到不同的桶中，桶的大小为t+1。如果两个数在同一个桶中，它们的差值一定不超过t。还需要检查相邻桶中的数字。维护一个大小为k的滑动窗口。时间复杂度O(n)，空间复杂度O(min(n,k))。';
    containsDuplicateIII.hint = '使用桶排序思想，桶大小为t+1，检查同桶和相邻桶';
    problems.push(containsDuplicateIII);

    // 缺失数字
    const missingNumber = new ProblemModel();
    missingNumber.id = 319;
    missingNumber.title = '缺失数字';
    missingNumber.description = '给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。';
    missingNumber.difficulty = ProblemDifficulty.EASY;
    missingNumber.category = ProblemCategory.MATH;
    missingNumber.choices = [
      { id: 'A', text: '使用数学公式：期望和减去实际和', isCorrect: true },
      { id: 'B', text: '使用异或运算的性质', isCorrect: true },
      { id: 'C', text: '使用哈希集合记录出现的数字', isCorrect: false },
      { id: 'D', text: '先排序再查找缺失位置', isCorrect: false }
    ];
    missingNumber.explanation = '有多种解法：1) 数学方法：计算0到n的期望和n*(n+1)/2，减去数组实际和；2) 异或方法：利用a^a=0的性质，将0到n的所有数与数组中所有数异或。两种方法时间复杂度都是O(n)，空间复杂度O(1)。';
    missingNumber.hint = '可以用数学公式或异或运算的性质';
    problems.push(missingNumber);

    return problems;
  }
}