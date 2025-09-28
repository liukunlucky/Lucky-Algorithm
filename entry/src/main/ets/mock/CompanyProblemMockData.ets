import { CompanyProblemModel, Company, CompanyProblemDifficulty, ProgrammingLanguage, CodeSolution } from '../model/CompanyProblemModel';

export class CompanyProblemMockData {
  static getProblems(): CompanyProblemModel[] {
    const problems: CompanyProblemModel[] = [];

    // 阿里巴巴真题1：两数之和
    const twoSum = new CompanyProblemModel();
    twoSum.id = 1;
    twoSum.title = '两数之和';
    twoSum.description = '给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出和为目标值 target 的那两个整数，并返回它们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。\n\n你可以按任意顺序返回答案。\n\n示例 1：\n输入：nums = [2,7,11,15], target = 9\n输出：[0,1]\n解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。';
    twoSum.company = Company.ALIBABA;
    twoSum.difficulty = CompanyProblemDifficulty.EASY;
    twoSum.tags = ['数组', '哈希表'];
    twoSum.year = 2024;
    twoSum.position = 'Java开发工程师';
    twoSum.frequency = 5;
    
    // Java解答
    const javaSolution: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            map.put(nums[i], i);
        }
        throw new IllegalArgumentException("No two sum solution");
    }
}`,
      explanation: '使用哈希表存储数组值和索引的映射关系，遍历数组时查找target-nums[i]是否存在于哈希表中。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(n)'
    };
    
    // Python解答
    const pythonSolution: CodeSolution = {
      language: ProgrammingLanguage.PYTHON,
      code: `class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        hashmap = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in hashmap:
                return [hashmap[complement], i]
            hashmap[num] = i
        return []`,
      explanation: '使用字典存储数组值和索引的映射关系，遍历数组时查找target-num是否存在于字典中。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(n)'
    };
    
    // C++解答
    const cppSolution: CodeSolution = {
      language: ProgrammingLanguage.CPP,
      code: `class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> map;
        for (int i = 0; i < nums.size(); i++) {
            int complement = target - nums[i];
            if (map.find(complement) != map.end()) {
                return {map[complement], i};
            }
            map[nums[i]] = i;
        }
        return {};
    }
};`,
      explanation: '使用unordered_map存储数组值和索引的映射关系，遍历数组时查找target-nums[i]是否存在。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(n)'
    };
    
    twoSum.solutions = [javaSolution, pythonSolution, cppSolution];
    twoSum.hints = ['考虑使用哈希表来存储已遍历的元素', '对于每个元素，查找target减去当前元素的值是否存在'];
    problems.push(twoSum);

    // 字节跳动真题：反转链表
    const reverseList = new CompanyProblemModel();
    reverseList.id = 2;
    reverseList.title = '反转链表';
    reverseList.description = '给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。\n\n示例 1：\n输入：head = [1,2,3,4,5]\n输出：[5,4,3,2,1]\n\n示例 2：\n输入：head = [1,2]\n输出：[2,1]';
    reverseList.company = Company.BYTEDANCE;
    reverseList.difficulty = CompanyProblemDifficulty.EASY;
    reverseList.tags = ['链表', '递归'];
    reverseList.year = 2024;
    reverseList.position = '后端开发工程师';
    reverseList.frequency = 4;
    
    // Java解答
    const reverseJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public ListNode reverseList(ListNode head) {
        ListNode prev = null;
        ListNode curr = head;
        while (curr != null) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
}`,
      explanation: '使用迭代方法，维护三个指针：prev、curr、next，逐个反转节点的指向。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    // Python解答
    const reversePython: CodeSolution = {
      language: ProgrammingLanguage.PYTHON,
      code: `class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        prev = None
        curr = head
        while curr:
            next_temp = curr.next
            curr.next = prev
            prev = curr
            curr = next_temp
        return prev`,
      explanation: '使用迭代方法，维护三个指针：prev、curr、next_temp，逐个反转节点的指向。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    // C++解答
    const reverseCpp: CodeSolution = {
      language: ProgrammingLanguage.CPP,
      code: `class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* prev = nullptr;
        ListNode* curr = head;
        while (curr != nullptr) {
            ListNode* next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
};`,
      explanation: '使用迭代方法，维护三个指针：prev、curr、next，逐个反转节点的指向。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    reverseList.solutions = [reverseJava, reversePython, reverseCpp];
    reverseList.hints = ['考虑使用三个指针来追踪前一个、当前和下一个节点', '也可以考虑递归解法'];
    problems.push(reverseList);

    // 美团真题：合并两个有序链表
    const mergeTwoLists = new CompanyProblemModel();
    mergeTwoLists.id = 4;
    mergeTwoLists.title = '合并两个有序链表';
    mergeTwoLists.description = '将两个升序链表合并为一个新的升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。\n\n示例 1：\n输入：l1 = [1,2,4], l2 = [1,3,4]\n输出：[1,1,2,3,4,4]';
    mergeTwoLists.company = Company.MEITUAN;
    mergeTwoLists.difficulty = CompanyProblemDifficulty.EASY;
    mergeTwoLists.tags = ['链表', '递归'];
    mergeTwoLists.year = 2024;
    mergeTwoLists.position = '后端开发';
    mergeTwoLists.frequency = 4;
    
    // Java解答
    const mergeJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (list1 != null && list2 != null) {
            if (list1.val <= list2.val) {
                current.next = list1;
                list1 = list1.next;
            } else {
                current.next = list2;
                list2 = list2.next;
            }
            current = current.next;
        }
        
        current.next = list1 != null ? list1 : list2;
        return dummy.next;
    }
}`,
      explanation: '使用虚拟头节点简化操作，比较两个链表的当前节点值，选择较小的节点连接到结果链表。',
      timeComplexity: 'O(m + n)',
      spaceComplexity: 'O(1)'
    };
    
    mergeTwoLists.solutions = [mergeJava];
    mergeTwoLists.hints = ['使用虚拟头节点简化边界处理', '比较两个链表的当前节点，选择较小的'];
    problems.push(mergeTwoLists);

    // 百度真题：三数之和
    const threeSum = new CompanyProblemModel();
    threeSum.id = 5;
    threeSum.title = '三数之和';
    threeSum.description = '给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有和为 0 且不重复的三元组。\n\n注意：答案中不可以包含重复的三元组。';
    threeSum.company = Company.BAIDU;
    threeSum.difficulty = CompanyProblemDifficulty.MEDIUM;
    threeSum.tags = ['数组', '双指针', '排序'];
    threeSum.year = 2024;
    threeSum.position = '算法工程师';
    threeSum.frequency = 3;
    
    // Java解答
    const threeSumJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 2; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) continue;
            
            int left = i + 1, right = nums.length - 1;
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                if (sum == 0) {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    while (left < right && nums[left] == nums[left + 1]) left++;
                    while (left < right && nums[right] == nums[right - 1]) right--;
                    left++;
                    right--;
                } else if (sum < 0) {
                    left++;
                } else {
                    right--;
                }
            }
        }
        return result;
    }
}`,
      explanation: '先排序，然后固定第一个数，用双指针寻找另外两个数。注意去重处理。',
      timeComplexity: 'O(n²)',
      spaceComplexity: 'O(1)'
    };
    
    threeSum.solutions = [threeSumJava];
    threeSum.hints = ['先对数组排序', '固定一个数，用双指针寻找另外两个数', '注意去重处理'];
    problems.push(threeSum);

    // 腾讯真题：最长回文子串
    const longestPalindrome = new CompanyProblemModel();
    longestPalindrome.id = 6;
    longestPalindrome.title = '最长回文子串';
    longestPalindrome.description = '给你一个字符串 s，找到 s 中最长的回文子串。\n\n示例 1：\n输入：s = "babad"\n输出："bab"\n解释："aba" 同样是符合题意的答案。';
    longestPalindrome.company = Company.TENCENT;
    longestPalindrome.difficulty = CompanyProblemDifficulty.MEDIUM;
    longestPalindrome.tags = ['字符串', '动态规划', '中心扩展'];
    longestPalindrome.year = 2024;
    longestPalindrome.position = '后端开发工程师';
    longestPalindrome.frequency = 4;
    
    const palindromeJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public String longestPalindrome(String s) {
        if (s == null || s.length() < 1) return "";
        int start = 0, end = 0;
        for (int i = 0; i < s.length(); i++) {
            int len1 = expandAroundCenter(s, i, i);
            int len2 = expandAroundCenter(s, i, i + 1);
            int len = Math.max(len1, len2);
            if (len > end - start) {
                start = i - (len - 1) / 2;
                end = i + len / 2;
            }
        }
        return s.substring(start, end + 1);
    }
    
    private int expandAroundCenter(String s, int left, int right) {
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        return right - left - 1;
    }
}`,
      explanation: '中心扩展算法，对每个可能的中心点进行扩展，找到最长的回文子串。',
      timeComplexity: 'O(n²)',
      spaceComplexity: 'O(1)'
    };
    
    longestPalindrome.solutions = [palindromeJava];
    longestPalindrome.hints = ['考虑中心扩展算法', '注意奇数长度和偶数长度的回文串'];
    problems.push(longestPalindrome);

    // 美团真题：买卖股票的最佳时机
    const maxProfit = new CompanyProblemModel();
    maxProfit.id = 7;
    maxProfit.title = '买卖股票的最佳时机';
    maxProfit.description = '给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。\n\n你只能选择某一天买入这只股票，并选择在未来的某一天卖出该股票。设计一个算法来计算你所能获取的最大利润。\n\n返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。';
    maxProfit.company = Company.MEITUAN;
    maxProfit.difficulty = CompanyProblemDifficulty.EASY;
    maxProfit.tags = ['数组', '动态规划'];
    maxProfit.year = 2024;
    maxProfit.position = '算法工程师';
    maxProfit.frequency = 5;
    
    const profitJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int maxProfit(int[] prices) {
        int minPrice = Integer.MAX_VALUE;
        int maxProfit = 0;
        for (int i = 0; i < prices.length; i++) {
            if (prices[i] < minPrice) {
                minPrice = prices[i];
            } else if (prices[i] - minPrice > maxProfit) {
                maxProfit = prices[i] - minPrice;
            }
        }
        return maxProfit;
    }
}`,
      explanation: '一次遍历，记录最低价格，计算当前价格与最低价格的差值作为利润。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    maxProfit.solutions = [profitJava];
    maxProfit.hints = ['记录历史最低价格', '计算当前价格与历史最低价格的差值'];
    problems.push(maxProfit);

    // 京东真题：有效的括号
    const validParentheses = new CompanyProblemModel();
    validParentheses.id = 8;
    validParentheses.title = '有效的括号';
    validParentheses.description = '给定一个只包括 \'(\'，\')\'，\'[\'，\']\'，\'{\'，\'}\' 的字符串 s ，判断字符串是否有效。\n\n有效字符串需满足：\n1. 左括号必须用相同类型的右括号闭合。\n2. 左括号必须以正确的顺序闭合。';
    validParentheses.company = Company.JD;
    validParentheses.difficulty = CompanyProblemDifficulty.EASY;
    validParentheses.tags = ['栈', '字符串'];
    validParentheses.year = 2024;
    validParentheses.position = 'Java开发工程师';
    validParentheses.frequency = 4;
    
    const parenthesesJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (c == '(' || c == '[' || c == '{') {
                stack.push(c);
            } else {
                if (stack.isEmpty()) return false;
                char top = stack.pop();
                if ((c == ')' && top != '(') ||
                    (c == ']' && top != '[') ||
                    (c == '}' && top != '{')) {
                    return false;
                }
            }
        }
        return stack.isEmpty();
    }
}`,
      explanation: '使用栈来匹配括号，遇到左括号入栈，遇到右括号出栈并检查是否匹配。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(n)'
    };
    
    validParentheses.solutions = [parenthesesJava];
    validParentheses.hints = ['使用栈数据结构', '左括号入栈，右括号出栈匹配'];
    problems.push(validParentheses);

    // 小米真题：爬楼梯
    const climbStairs = new CompanyProblemModel();
    climbStairs.id = 9;
    climbStairs.title = '爬楼梯';
    climbStairs.description = '假设你正在爬楼梯。需要 n 阶你才能到达楼顶。\n\n每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？';
    climbStairs.company = Company.XIAOMI;
    climbStairs.difficulty = CompanyProblemDifficulty.EASY;
    climbStairs.tags = ['动态规划', '数学'];
    climbStairs.year = 2024;
    climbStairs.position = '软件开发工程师';
    climbStairs.frequency = 3;
    
    const climbJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int climbStairs(int n) {
        if (n <= 2) return n;
        int first = 1, second = 2;
        for (int i = 3; i <= n; i++) {
            int third = first + second;
            first = second;
            second = third;
        }
        return second;
    }
}`,
      explanation: '动态规划思想，f(n) = f(n-1) + f(n-2)，类似斐波那契数列。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    climbStairs.solutions = [climbJava];
    climbStairs.hints = ['动态规划', '斐波那契数列'];
    problems.push(climbStairs);

    // 滴滴真题：最大子数组和
    const maxSubArray = new CompanyProblemModel();
    maxSubArray.id = 10;
    maxSubArray.title = '最大子数组和';
    maxSubArray.description = '给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。\n\n子数组是数组中的一个连续部分。';
    maxSubArray.company = Company.DIDI;
    maxSubArray.difficulty = CompanyProblemDifficulty.EASY;
    maxSubArray.tags = ['数组', '动态规划', '分治'];
    maxSubArray.year = 2024;
    maxSubArray.position = '算法工程师';
    maxSubArray.frequency = 4;
    
    const maxSubJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int maxSubArray(int[] nums) {
        int maxSum = nums[0];
        int currentSum = nums[0];
        for (int i = 1; i < nums.length; i++) {
            currentSum = Math.max(nums[i], currentSum + nums[i]);
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}`,
      explanation: 'Kadane算法，动态规划思想，当前最大和要么是当前元素，要么是之前的和加上当前元素。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    maxSubArray.solutions = [maxSubJava];
    maxSubArray.hints = ['Kadane算法', '动态规划'];
    problems.push(maxSubArray);

    // 华为真题：最长公共前缀
    const longestCommonPrefix = new CompanyProblemModel();
    longestCommonPrefix.id = 11;
    longestCommonPrefix.title = '最长公共前缀';
    longestCommonPrefix.description = '编写一个函数来查找字符串数组中的最长公共前缀。\n\n如果不存在公共前缀，返回空字符串 ""。';
    longestCommonPrefix.company = Company.HUAWEI;
    longestCommonPrefix.difficulty = CompanyProblemDifficulty.EASY;
    longestCommonPrefix.tags = ['字符串'];
    longestCommonPrefix.year = 2024;
    longestCommonPrefix.position = '软件开发工程师';
    longestCommonPrefix.frequency = 3;
    
    const prefixJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public String longestCommonPrefix(String[] strs) {
        if (strs == null || strs.length == 0) return "";
        String prefix = strs[0];
        for (int i = 1; i < strs.length; i++) {
            while (strs[i].indexOf(prefix) != 0) {
                prefix = prefix.substring(0, prefix.length() - 1);
                if (prefix.isEmpty()) return "";
            }
        }
        return prefix;
    }
}`,
      explanation: '以第一个字符串为基准，逐个与其他字符串比较，不断缩短前缀直到找到公共前缀。',
      timeComplexity: 'O(S)',
      spaceComplexity: 'O(1)'
    };
    
    longestCommonPrefix.solutions = [prefixJava];
    longestCommonPrefix.hints = ['以第一个字符串为基准', '逐个比较缩短前缀'];
    problems.push(longestCommonPrefix);

    // 网易真题：删除链表的倒数第N个结点
    const removeNthFromEnd = new CompanyProblemModel();
    removeNthFromEnd.id = 12;
    removeNthFromEnd.title = '删除链表的倒数第N个结点';
    removeNthFromEnd.description = '给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。';
    removeNthFromEnd.company = Company.NETEASE;
    removeNthFromEnd.difficulty = CompanyProblemDifficulty.MEDIUM;
    removeNthFromEnd.tags = ['链表', '双指针'];
    removeNthFromEnd.year = 2024;
    removeNthFromEnd.position = '后端开发工程师';
    removeNthFromEnd.frequency = 3;
    
    const removeJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode first = dummy;
        ListNode second = dummy;
        
        for (int i = 1; i <= n + 1; i++) {
            first = first.next;
        }
        
        while (first != null) {
            first = first.next;
            second = second.next;
        }
        
        second.next = second.next.next;
        return dummy.next;
    }
}`,
      explanation: '双指针技巧，让第一个指针先走n+1步，然后两个指针同时移动，当第一个指针到达末尾时，第二个指针正好在要删除节点的前一个位置。',
      timeComplexity: 'O(L)',
      spaceComplexity: 'O(1)'
    };
    
    removeNthFromEnd.solutions = [removeJava];
    removeNthFromEnd.hints = ['使用双指针', '让快指针先走n+1步'];
    problems.push(removeNthFromEnd);

    // 阿里巴巴困难题：正则表达式匹配
    const regexMatch = new CompanyProblemModel();
    regexMatch.id = 13;
    regexMatch.title = '正则表达式匹配';
    regexMatch.description = '给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 \'.\' 和 \'*\' 的正则表达式匹配。\n\n\'.\' 匹配任意单个字符\n\'*\' 匹配零个或多个前面的那一个元素';
    regexMatch.company = Company.ALIBABA;
    regexMatch.difficulty = CompanyProblemDifficulty.HARD;
    regexMatch.tags = ['字符串', '动态规划', '递归'];
    regexMatch.year = 2024;
    regexMatch.position = '高级Java工程师';
    regexMatch.frequency = 2;
    
    const regexJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public boolean isMatch(String s, String p) {
        int m = s.length(), n = p.length();
        boolean[][] dp = new boolean[m + 1][n + 1];
        dp[0][0] = true;
        
        for (int i = 0; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (p.charAt(j - 1) == '*') {
                    dp[i][j] = dp[i][j - 2];
                    if (matches(s, p, i, j - 1)) {
                        dp[i][j] = dp[i][j] || dp[i - 1][j];
                    }
                } else {
                    if (matches(s, p, i, j)) {
                        dp[i][j] = dp[i - 1][j - 1];
                    }
                }
            }
        }
        return dp[m][n];
    }
    
    private boolean matches(String s, String p, int i, int j) {
        if (i == 0) return false;
        if (p.charAt(j - 1) == '.') return true;
        return s.charAt(i - 1) == p.charAt(j - 1);
    }
}`,
      explanation: '动态规划解法，dp[i][j]表示s的前i个字符与p的前j个字符是否匹配。',
      timeComplexity: 'O(mn)',
      spaceComplexity: 'O(mn)'
    };
    
    regexMatch.solutions = [regexJava];
    regexMatch.hints = ['动态规划', '分情况讨论*的匹配'];
    problems.push(regexMatch);

    // 字节跳动困难题：接雨水
    const trapRainWater = new CompanyProblemModel();
    trapRainWater.id = 14;
    trapRainWater.title = '接雨水';
    trapRainWater.description = '给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能够接多少雨水。';
    trapRainWater.company = Company.BYTEDANCE;
    trapRainWater.difficulty = CompanyProblemDifficulty.HARD;
    trapRainWater.tags = ['数组', '双指针', '动态规划', '单调栈'];
    trapRainWater.year = 2024;
    trapRainWater.position = '高级算法工程师';
    trapRainWater.frequency = 3;
    
    const trapJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int trap(int[] height) {
        int left = 0, right = height.length - 1;
        int leftMax = 0, rightMax = 0;
        int result = 0;
        
        while (left < right) {
            if (height[left] < height[right]) {
                if (height[left] >= leftMax) {
                    leftMax = height[left];
                } else {
                    result += leftMax - height[left];
                }
                left++;
            } else {
                if (height[right] >= rightMax) {
                    rightMax = height[right];
                } else {
                    result += rightMax - height[right];
                }
                right--;
            }
        }
        return result;
    }
}`,
      explanation: '双指针解法，从两端向中间移动，维护左右两边的最大高度，计算能接的雨水量。',
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(1)'
    };
    
    trapRainWater.solutions = [trapJava];
    trapRainWater.hints = ['双指针从两端向中间', '维护左右最大高度'];
    problems.push(trapRainWater);

    // 腾讯困难题：最小覆盖子串
    const minWindow = new CompanyProblemModel();
    minWindow.id = 15;
    minWindow.title = '最小覆盖子串';
    minWindow.description = '给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。';
    minWindow.company = Company.TENCENT;
    minWindow.difficulty = CompanyProblemDifficulty.HARD;
    minWindow.tags = ['哈希表', '字符串', '滑动窗口'];
    minWindow.year = 2024;
    minWindow.position = '高级后端工程师';
    minWindow.frequency = 2;
    
    const windowJava: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public String minWindow(String s, String t) {
        Map<Character, Integer> need = new HashMap<>();
        Map<Character, Integer> window = new HashMap<>();
        
        for (char c : t.toCharArray()) {
            need.put(c, need.getOrDefault(c, 0) + 1);
        }
        
        int left = 0, right = 0;
        int valid = 0;
        int start = 0, len = Integer.MAX_VALUE;
        
        while (right < s.length()) {
            char c = s.charAt(right);
            right++;
            
            if (need.containsKey(c)) {
                window.put(c, window.getOrDefault(c, 0) + 1);
                if (window.get(c).equals(need.get(c))) {
                    valid++;
                }
            }
            
            while (valid == need.size()) {
                if (right - left < len) {
                    start = left;
                    len = right - left;
                }
                
                char d = s.charAt(left);
                left++;
                
                if (need.containsKey(d)) {
                    if (window.get(d).equals(need.get(d))) {
                        valid--;
                    }
                    window.put(d, window.get(d) - 1);
                }
            }
        }
        
        return len == Integer.MAX_VALUE ? "" : s.substring(start, start + len);
    }
}`,
      explanation: '滑动窗口算法，右指针扩大窗口直到包含所有字符，然后左指针收缩窗口寻找最小覆盖。',
      timeComplexity: 'O(|s| + |t|)',
      spaceComplexity: 'O(|s| + |t|)'
    };
    
    minWindow.solutions = [windowJava];
    minWindow.hints = ['滑动窗口', '哈希表记录字符频次'];
    problems.push(minWindow);

    // 11. 岛屿数量 - 美团
    const numIslands = new CompanyProblemModel();
    numIslands.id = 11;
    numIslands.title = '岛屿数量';
    numIslands.description = '给你一个由 \'1\'（陆地）和 \'0\'（水）组成的的二维网格，请你计算网格中岛屿的数量。岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。此外，你可以假设该网格的四条边均被水包围。';
    numIslands.company = Company.MEITUAN;
    numIslands.difficulty = CompanyProblemDifficulty.MEDIUM;
    numIslands.tags = ['深度优先搜索', '广度优先搜索', '并查集'];
    numIslands.year = 2024;
    numIslands.position = '后端开发';
    numIslands.frequency = 5;

    const islandsDFS: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int numIslands(char[][] grid) {
        if (grid == null || grid.length == 0) {
            return 0;
        }
        
        int nr = grid.length;
        int nc = grid[0].length;
        int num_islands = 0;
        
        for (int r = 0; r < nr; ++r) {
            for (int c = 0; c < nc; ++c) {
                if (grid[r][c] == '1') {
                    ++num_islands;
                    dfs(grid, r, c);
                }
            }
        }
        
        return num_islands;
    }
    
    void dfs(char[][] grid, int r, int c) {
        int nr = grid.length;
        int nc = grid[0].length;
        
        if (r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == '0') {
            return;
        }
        
        grid[r][c] = '0';
        dfs(grid, r - 1, c);
        dfs(grid, r + 1, c);
        dfs(grid, r, c - 1);
        dfs(grid, r, c + 1);
    }
}`,
      explanation: '使用深度优先搜索，遍历网格，遇到陆地就进行DFS将整个岛屿标记为已访问。',
      timeComplexity: 'O(M×N)',
      spaceComplexity: 'O(M×N)'
    };

    numIslands.solutions = [islandsDFS];
    numIslands.hints = ['DFS遍历', '将访问过的陆地标记为水'];
    problems.push(numIslands);

    // 12. 二叉树的层序遍历 - 京东
    const levelOrder = new CompanyProblemModel();
    levelOrder.id = 12;
    levelOrder.title = '二叉树的层序遍历';
    levelOrder.description = '给你二叉树的根节点 root ，返回其节点值的层序遍历。（即逐层地，从左到右访问所有节点）。';
    levelOrder.company = Company.JD;
    levelOrder.difficulty = CompanyProblemDifficulty.MEDIUM;
    levelOrder.tags = ['树', '广度优先搜索'];
    levelOrder.year = 2024;
    levelOrder.position = '算法工程师';
    levelOrder.frequency = 5;

    const levelOrderBFS: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) {
            return result;
        }
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> currentLevel = new ArrayList<>();
            
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                currentLevel.add(node.val);
                
                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }
            
            result.add(currentLevel);
        }
        
        return result;
    }
}`,
      explanation: '使用队列进行广度优先搜索，每次处理一层的所有节点。',
      timeComplexity: 'O(N)',
      spaceComplexity: 'O(N)'
    };

    levelOrder.solutions = [levelOrderBFS];
    levelOrder.hints = ['BFS', '队列', '记录每层节点数'];
    problems.push(levelOrder);

    // 13. 最长递增子序列 - 百度
    const lengthOfLIS = new CompanyProblemModel();
    lengthOfLIS.id = 13;
    lengthOfLIS.title = '最长递增子序列';
    lengthOfLIS.description = '给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。子序列是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。';
    lengthOfLIS.company = Company.BAIDU;
    lengthOfLIS.difficulty = CompanyProblemDifficulty.MEDIUM;
    lengthOfLIS.tags = ['动态规划', '二分查找'];
    lengthOfLIS.year = 2024;
    lengthOfLIS.position = '算法工程师';
    lengthOfLIS.frequency = 4;

    const lisDP: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int lengthOfLIS(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }
        
        int[] dp = new int[nums.length];
        dp[0] = 1;
        int maxans = 1;
        
        for (int i = 1; i < nums.length; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
            maxans = Math.max(maxans, dp[i]);
        }
        
        return maxans;
    }
}`,
      explanation: 'dp[i]表示以nums[i]结尾的最长递增子序列长度，状态转移方程为dp[i] = max(dp[j] + 1)，其中j < i且nums[j] < nums[i]。',
      timeComplexity: 'O(N²)',
      spaceComplexity: 'O(N)'
    };

    const lisBinary: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int lengthOfLIS(int[] nums) {
        int[] tails = new int[nums.length];
        int res = 0;
        
        for (int num : nums) {
            int i = 0, j = res;
            while (i < j) {
                int m = (i + j) / 2;
                if (tails[m] < num) i = m + 1;
                else j = m;
            }
            tails[i] = num;
            if (res == j) res++;
        }
        
        return res;
    }
}`,
      explanation: '维护一个tails数组，tails[i]表示长度为i+1的递增子序列的最小尾部元素，使用二分查找优化。',
      timeComplexity: 'O(N log N)',
      spaceComplexity: 'O(N)'
    };

    lengthOfLIS.solutions = [lisDP, lisBinary];
    lengthOfLIS.hints = ['动态规划', '二分查找优化', 'tails数组'];
    problems.push(lengthOfLIS);

    // 14. 旋转数组 - 滴滴
    const rotate = new CompanyProblemModel();
    rotate.id = 14;
    rotate.title = '旋转数组';
    rotate.description = '给定一个数组，将数组中的元素向右移动 k 个位置，其中 k 是非负数。';
    rotate.company = Company.DIDI;
    rotate.difficulty = CompanyProblemDifficulty.MEDIUM;
    rotate.tags = ['数组', '数学', '双指针'];
    rotate.year = 2024;
    rotate.position = '后端开发';
    rotate.frequency = 4;

    const rotateReverse: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public void rotate(int[] nums, int k) {
        k %= nums.length;
        reverse(nums, 0, nums.length - 1);
        reverse(nums, 0, k - 1);
        reverse(nums, k, nums.length - 1);
    }
    
    public void reverse(int[] nums, int start, int end) {
        while (start < end) {
            int temp = nums[start];
            nums[start] = nums[end];
            nums[end] = temp;
            start++;
            end--;
        }
    }
}`,
      explanation: '三次反转：先反转整个数组，再反转前k个元素，最后反转后n-k个元素。',
      timeComplexity: 'O(N)',
      spaceComplexity: 'O(1)'
    };

    rotate.solutions = [rotateReverse];
    rotate.hints = ['三次反转', '原地操作'];
    problems.push(rotate);

    // 15. 合并区间 - 快手
    const merge = new CompanyProblemModel();
    merge.id = 15;
    merge.title = '合并区间';
    merge.description = '以数组 intervals 表示若干个区间的集合，其中单个区间为 intervals[i] = [starti, endi] 。请你合并所有重叠的区间，并返回一个不重叠的区间数组，该数组需恰好覆盖输入中的所有区间。';
    merge.company = Company.KUAISHOU;
    merge.difficulty = CompanyProblemDifficulty.MEDIUM;
    merge.tags = ['数组', '排序'];
    merge.year = 2024;
    merge.position = '算法工程师';
    merge.frequency = 5;

    const mergeIntervals: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int[][] merge(int[][] intervals) {
        if (intervals.length <= 1) {
            return intervals;
        }
        
        // 按起始位置排序
        Arrays.sort(intervals, (i1, i2) -> Integer.compare(i1[0], i2[0]));
        
        List<int[]> result = new ArrayList<>();
        int[] newInterval = intervals[0];
        result.add(newInterval);
        
        for (int[] interval : intervals) {
            if (interval[0] <= newInterval[1]) {
                // 重叠，合并区间
                newInterval[1] = Math.max(newInterval[1], interval[1]);
            } else {
                // 不重叠，添加新区间
                newInterval = interval;
                result.add(newInterval);
            }
        }
        
        return result.toArray(new int[result.size()][]);
    }
}`,
      explanation: '先按起始位置排序，然后遍历区间，如果当前区间与前一个区间重叠则合并，否则添加新区间。',
      timeComplexity: 'O(N log N)',
      spaceComplexity: 'O(log N)'
    };

    merge.solutions = [mergeIntervals];
    merge.hints = ['排序', '贪心算法'];
    problems.push(merge);

    // 16. 单词搜索 - 拼多多
    const exist = new CompanyProblemModel();
    exist.id = 16;
    exist.title = '单词搜索';
    exist.description = '给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中"相邻"单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。';
    exist.company = Company.PINDUODUO;
    exist.difficulty = CompanyProblemDifficulty.MEDIUM;
    exist.tags = ['数组', '回溯'];
    exist.year = 2024;
    exist.position = '后端开发';
    exist.frequency = 4;

    const existBacktrack: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public boolean exist(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;
        
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (dfs(board, word, i, j, 0)) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    private boolean dfs(char[][] board, String word, int i, int j, int k) {
        if (k == word.length()) {
            return true;
        }
        
        if (i < 0 || i >= board.length || j < 0 || j >= board[0].length || 
            board[i][j] != word.charAt(k)) {
            return false;
        }
        
        char temp = board[i][j];
        board[i][j] = '/'; // 标记为已访问
        
        boolean res = dfs(board, word, i + 1, j, k + 1) ||
                     dfs(board, word, i - 1, j, k + 1) ||
                     dfs(board, word, i, j + 1, k + 1) ||
                     dfs(board, word, i, j - 1, k + 1);
        
        board[i][j] = temp; // 回溯
        return res;
    }
}`,
      explanation: '使用回溯算法，从每个位置开始尝试匹配单词，使用临时标记避免重复访问。',
      timeComplexity: 'O(M×N×4^L)',
      spaceComplexity: 'O(L)'
    };

    exist.solutions = [existBacktrack];
    exist.hints = ['回溯算法', 'DFS', '临时标记'];
    problems.push(exist);

    // 17. 最大正方形 - 美团
    const maximalSquare = new CompanyProblemModel();
    maximalSquare.id = 17;
    maximalSquare.title = '最大正方形';
    maximalSquare.description = '在一个由 \'0\' 和 \'1\' 组成的二维矩阵内，找到只包含 \'1\' 的最大正方形，并返回其面积。';
    maximalSquare.company = Company.MEITUAN;
    maximalSquare.difficulty = CompanyProblemDifficulty.MEDIUM;
    maximalSquare.tags = ['动态规划', '数组'];
    maximalSquare.year = 2024;
    maximalSquare.position = '算法工程师';
    maximalSquare.frequency = 3;

    const maxSquareDP: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int maximalSquare(char[][] matrix) {
        int rows = matrix.length, cols = rows > 0 ? matrix[0].length : 0;
        int[][] dp = new int[rows + 1][cols + 1];
        int maxsqlen = 0;
        
        for (int i = 1; i <= rows; i++) {
            for (int j = 1; j <= cols; j++) {
                if (matrix[i-1][j-1] == '1'){
                    dp[i][j] = Math.min(Math.min(dp[i][j-1], dp[i-1][j]), dp[i-1][j-1]) + 1;
                    maxsqlen = Math.max(maxsqlen, dp[i][j]);
                }
            }
        }
        
        return maxsqlen * maxsqlen;
    }
}`,
      explanation: 'dp[i][j]表示以(i,j)为右下角的最大正方形边长，状态转移方程为dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1。',
      timeComplexity: 'O(M×N)',
      spaceComplexity: 'O(M×N)'
    };

    maximalSquare.solutions = [maxSquareDP];
    maximalSquare.hints = ['动态规划', '正方形性质'];
    problems.push(maximalSquare);

    // 18. 课程表 - 字节跳动
    const canFinish = new CompanyProblemModel();
    canFinish.id = 18;
    canFinish.title = '课程表';
    canFinish.description = '你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1 。在选修某些课程之前需要一些先修课程。 先修课程按数组 prerequisites 给出，其中 prerequisites[i] = [ai, bi] ，表示如果要学习课程 ai 则 必须 先学习课程 bi 。例如，先修课程对 [0, 1] 表示：想要学习课程 0 ，你需要先完成课程 1 。请你判断是否可能完成所有课程的学习？';
    canFinish.company = Company.BYTEDANCE;
    canFinish.difficulty = CompanyProblemDifficulty.MEDIUM;
    canFinish.tags = ['深度优先搜索', '广度优先搜索', '图', '拓扑排序'];
    canFinish.year = 2024;
    canFinish.position = '后端开发';
    canFinish.frequency = 5;

    const canFinishDFS: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        List<List<Integer>> adjacency = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            adjacency.add(new ArrayList<>());
        }
        
        int[] flags = new int[numCourses];
        for (int[] cp : prerequisites) {
            adjacency.get(cp[1]).add(cp[0]);
        }
        
        for (int i = 0; i < numCourses; i++) {
            if (!dfs(adjacency, flags, i)) return false;
        }
        
        return true;
    }
    
    private boolean dfs(List<List<Integer>> adjacency, int[] flags, int i) {
        if (flags[i] == 1) return false; // 当前节点已在路径中，存在环
        if (flags[i] == -1) return true; // 当前节点已完成访问
        
        flags[i] = 1; // 标记当前节点在路径中
        for (int j : adjacency.get(i)) {
            if (!dfs(adjacency, flags, j)) return false;
        }
        flags[i] = -1; // 标记当前节点已完成访问
        
        return true;
    }
}`,
      explanation: '构建邻接表表示有向图，使用DFS检测是否存在环。flags数组：0未访问，1正在访问，-1已完成访问。',
      timeComplexity: 'O(N + M)',
      spaceComplexity: 'O(N + M)'
    };

    canFinish.solutions = [canFinishDFS];
    canFinish.hints = ['拓扑排序', '环检测', 'DFS'];
    problems.push(canFinish);

    // 19. 搜索旋转排序数组 - 腾讯
    const search = new CompanyProblemModel();
    search.id = 19;
    search.title = '搜索旋转排序数组';
    search.description = '整数数组 nums 按升序排列，数组中的值 互不相同 。在传递给函数之前，nums 在预先未知的某个下标 k（0 <= k < nums.length）上进行了 旋转，使数组变为 [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]（下标 从 0 开始 计数）。例如， [0,1,2,4,5,6,7] 在下标 3 处经旋转后可能变为 [4,5,6,7,0,1,2] 。给你 旋转后 的数组 nums 和一个整数 target ，如果 nums 中存在这个目标值 target ，则返回它的下标，否则返回 -1 。';
    search.company = Company.TENCENT;
    search.difficulty = CompanyProblemDifficulty.MEDIUM;
    search.tags = ['数组', '二分查找'];
    search.year = 2024;
    search.position = '后端开发';
    search.frequency = 5;

    const searchRotated: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int search(int[] nums, int target) {
        int left = 0, right = nums.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) {
                return mid;
            }
            
            if (nums[left] <= nums[mid]) {
                // 左半部分有序
                if (nums[left] <= target && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            } else {
                // 右半部分有序
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        
        return -1;
    }
}`,
      explanation: '旋转数组的一半必然是有序的，先判断哪一半有序，再判断target是否在有序的一半中。',
      timeComplexity: 'O(log N)',
      spaceComplexity: 'O(1)'
    };

    search.solutions = [searchRotated];
    search.hints = ['二分查找', '判断有序区间'];
    problems.push(search);

    // 20. 乘积最大子数组 - 小米
    const maxProduct = new CompanyProblemModel();
    maxProduct.id = 20;
    maxProduct.title = '乘积最大子数组';
    maxProduct.description = '给你一个整数数组 nums ，请你找出数组中乘积最大的连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。';
    maxProduct.company = Company.XIAOMI;
    maxProduct.difficulty = CompanyProblemDifficulty.MEDIUM;
    maxProduct.tags = ['数组', '动态规划'];
    maxProduct.year = 2024;
    maxProduct.position = '算法工程师';
    maxProduct.frequency = 4;

    const maxProductDP: CodeSolution = {
      language: ProgrammingLanguage.JAVA,
      code: `class Solution {
    public int maxProduct(int[] nums) {
        int maxSoFar = nums[0];
        int minSoFar = nums[0];
        int result = maxSoFar;
        
        for (int i = 1; i < nums.length; i++) {
            int curr = nums[i];
            int tempMaxSoFar = Math.max(curr, Math.max(maxSoFar * curr, minSoFar * curr));
            minSoFar = Math.min(curr, Math.min(maxSoFar * curr, minSoFar * curr));
            
            maxSoFar = tempMaxSoFar;
            result = Math.max(maxSoFar, result);
        }
        
        return result;
    }
}`,
      explanation: '由于负数的存在，需要同时维护最大值和最小值。当前位置的最大值可能来自：当前数、前面最大值乘当前数、前面最小值乘当前数。',
      timeComplexity: 'O(N)',
      spaceComplexity: 'O(1)'
    };

    maxProduct.solutions = [maxProductDP];
    maxProduct.hints = ['动态规划', '同时维护最大最小值'];
    problems.push(maxProduct);

    return problems;
  }
}