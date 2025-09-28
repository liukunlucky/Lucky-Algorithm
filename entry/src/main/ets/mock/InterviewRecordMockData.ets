import { InterviewRecordModel, InterviewStatus, InterviewRound, InterviewResult, OfferStatus } from '../model/InterviewRecordModel';
import { InterviewStats } from '../dao/InterviewRecordDao';

/**
 * 获取模拟面试记录数据
 */
export function getInterviewRecordMockData(): InterviewRecordModel[] {
  const records: InterviewRecordModel[] = [];

  // 阿里巴巴 - 已完成面试，收到offer
  const record1 = new InterviewRecordModel();
  record1.id = 1;
  record1.company = '阿里巴巴';
  record1.position = '高级前端开发工程师';
  record1.interviewDate = '2024-01-15';
  record1.interviewTime = '14:00';
  record1.round = InterviewRound.TECHNICAL;
  record1.status = InterviewStatus.COMPLETED;
  record1.result = InterviewResult.PASS;
  record1.offerStatus = OfferStatus.RECEIVED;
  record1.interviewType = '线上面试';
  record1.interviewer = '张技术总监';
  record1.duration = 90;
  record1.questions = '1. 介绍一下React的生命周期\n2. 如何优化前端性能\n3. 手写防抖函数\n4. 项目中遇到的技术难点';
  record1.answers = '详细回答了React生命周期，从性能优化角度分析了代码分割、懒加载等方案，手写了防抖函数并解释原理';
  record1.techStack = 'React, TypeScript, Node.js, 微前端';
  record1.difficulty = 4;
  record1.experience = '面试官很专业，问题有深度，整体体验不错';
  record1.notes = '技术栈匹配度高，团队氛围好，薪资待遇优秀';
  records.push(record1);

  // 字节跳动 - 进行中
  const record2 = new InterviewRecordModel();
  record2.id = 2;
  record2.company = '字节跳动';
  record2.position = 'Android开发工程师';
  record2.interviewDate = '2024-01-20';
  record2.interviewTime = '10:30';
  record2.round = InterviewRound.TECHNICAL;
  record2.status = InterviewStatus.SCHEDULED;
  record2.result = InterviewResult.PENDING;
  record2.offerStatus = OfferStatus.NO_OFFER;
  record2.interviewType = '现场面试';
  record2.interviewer = '李高级工程师';
  record2.duration = 60;
  record2.questions = '';
  record2.answers = '';
  record2.techStack = 'Android, Kotlin, MVVM, 组件化';
  record2.difficulty = 0;
  record2.experience = '';
  record2.notes = '一面技术面试，主要考察Android基础和项目经验';
  records.push(record2);

  // 腾讯 - 已完成，未通过
  const record3 = new InterviewRecordModel();
  record3.id = 3;
  record3.company = '腾讯';
  record3.position = '后端开发工程师';
  record3.interviewDate = '2024-01-10';
  record3.interviewTime = '15:30';
  record3.round = InterviewRound.TECHNICAL;
  record3.status = InterviewStatus.COMPLETED;
  record3.result = InterviewResult.FAIL;
  record3.offerStatus = OfferStatus.NO_OFFER;
  record3.interviewType = '线上面试';
  record3.interviewer = '王架构师';
  record3.duration = 75;
  record3.questions = '1. 分布式系统设计\n2. 数据库优化\n3. 缓存策略\n4. 微服务架构';
  record3.answers = '回答了基本概念，但在分布式一致性和高并发处理方面回答不够深入';
  record3.techStack = 'Java, Spring Boot, Redis, MySQL, 微服务';
  record3.difficulty = 5;
  record3.experience = '问题很有挑战性，暴露了一些知识盲区';
  record3.notes = '需要加强分布式系统和高并发相关知识';
  records.push(record3);

  // 美团 - HR面试通过
  const record4 = new InterviewRecordModel();
  record4.id = 4;
  record4.company = '美团';
  record4.position = '产品经理';
  record4.interviewDate = '2024-01-12';
  record4.interviewTime = '11:00';
  record4.round = InterviewRound.HR;
  record4.status = InterviewStatus.COMPLETED;
  record4.result = InterviewResult.PASS;
  record4.offerStatus = OfferStatus.NO_OFFER;
  record4.interviewType = '线上面试';
  record4.interviewer = '陈HR';
  record4.duration = 45;
  record4.questions = '1. 自我介绍\n2. 为什么选择美团\n3. 职业规划\n4. 期望薪资';
  record4.answers = '详细介绍了产品经验，表达了对美团业务的理解和兴趣';
  record4.techStack = '产品设计, 数据分析, 用户研究';
  record4.difficulty = 2;
  record4.experience = 'HR很友善，沟通顺畅';
  record4.notes = '等待技术面试通知';
  records.push(record4);

  // 百度 - 终面
  const record5 = new InterviewRecordModel();
  record5.id = 5;
  record5.company = '百度';
  record5.position = '算法工程师';
  record5.interviewDate = '2024-01-18';
  record5.interviewTime = '16:00';
  record5.round = InterviewRound.FINAL;
  record5.status = InterviewStatus.COMPLETED;
  record5.result = InterviewResult.PASS;
  record5.offerStatus = OfferStatus.PENDING;
  record5.interviewType = '现场面试';
  record5.interviewer = '刘总监';
  record5.duration = 120;
  record5.questions = '1. 机器学习算法原理\n2. 深度学习项目经验\n3. 算法优化思路\n4. 团队管理经验';
  record5.answers = '详细讲解了推荐算法项目，分享了模型优化经验';
  record5.techStack = 'Python, TensorFlow, 推荐算法, 深度学习';
  record5.difficulty = 4;
  record5.experience = '终面主要考察综合能力和团队协作';
  record5.notes = '面试官对项目经验很感兴趣，等待offer结果';
  records.push(record5);

  // 小米 - 已取消
  const record6 = new InterviewRecordModel();
  record6.id = 6;
  record6.company = '小米';
  record6.position = 'UI设计师';
  record6.interviewDate = '2024-01-25';
  record6.interviewTime = '14:30';
  record6.round = InterviewRound.TECHNICAL;
  record6.status = InterviewStatus.CANCELLED;
  record6.result = InterviewResult.UNKNOWN;
  record6.offerStatus = OfferStatus.NO_OFFER;
  record6.interviewType = '现场面试';
  record6.interviewer = '';
  record6.duration = 0;
  record6.questions = '';
  record6.answers = '';
  record6.techStack = 'UI设计, 交互设计, Figma, Sketch';
  record6.difficulty = 0;
  record6.experience = '';
  record6.notes = '因个人原因取消面试';
  records.push(record6);

  // 京东 - 即将面试
  const record7 = new InterviewRecordModel();
  record7.id = 7;
  record7.company = '京东';
  record7.position = '数据分析师';
  record7.interviewDate = '2024-01-22';
  record7.interviewTime = '09:30';
  record7.round = InterviewRound.TECHNICAL;
  record7.status = InterviewStatus.SCHEDULED;
  record7.result = InterviewResult.PENDING;
  record7.offerStatus = OfferStatus.NO_OFFER;
  record7.interviewType = '线上面试';
  record7.interviewer = '赵数据总监';
  record7.duration = 0;
  record7.questions = '';
  record7.answers = '';
  record7.techStack = 'SQL, Python, 数据可视化, 机器学习';
  record7.difficulty = 0;
  record7.experience = '';
  record7.notes = '准备SQL和Python相关题目';
  records.push(record7);

  // 滴滴 - 已接受offer
  const record8 = new InterviewRecordModel();
  record8.id = 8;
  record8.company = '滴滴';
  record8.position = '全栈开发工程师';
  record8.interviewDate = '2024-01-08';
  record8.interviewTime = '13:00';
  record8.round = InterviewRound.FINAL;
  record8.status = InterviewStatus.COMPLETED;
  record8.result = InterviewResult.PASS;
  record8.offerStatus = OfferStatus.ACCEPTED;
  record8.interviewType = '现场面试';
  record8.interviewer = '孙技术总监';
  record8.duration = 100;
  record8.questions = '1. 全栈项目架构设计\n2. 前后端技术选型\n3. 性能优化方案\n4. 团队协作经验';
  record8.answers = '展示了完整的全栈项目，详细说明了技术选型理由';
  record8.techStack = 'Vue.js, Node.js, MongoDB, Docker';
  record8.difficulty = 3;
  record8.experience = '面试官很认可项目经验，团队氛围很好';
  record8.notes = '已接受offer，准备入职';
  records.push(record8);

  return records;
}

/**
 * 获取统计数据
 */
export function getInterviewStatistics(): InterviewStats {
  const records = getInterviewRecordMockData();
  
  const stats: InterviewStats = {
    total: records.length,
    pending: 0,
    completed: 0,
    passed: 0,
    failed: 0,
    offers: 0
  };

  records.forEach(record => {
    // 统计面试状态
    switch (record.status) {
      case InterviewStatus.SCHEDULED:
        stats.pending++;
        break;
      case InterviewStatus.COMPLETED:
        stats.completed++;
        break;
    }

    // 统计面试结果
    switch (record.result) {
      case InterviewResult.PASS:
        stats.passed++;
        break;
      case InterviewResult.FAIL:
        stats.failed++;
        break;
    }

    // 统计offer情况
    if (record.offerStatus === OfferStatus.RECEIVED || 
        record.offerStatus === OfferStatus.ACCEPTED || 
        record.offerStatus === OfferStatus.REJECTED) {
      stats.offers++;
    }
  });

  return stats;
}