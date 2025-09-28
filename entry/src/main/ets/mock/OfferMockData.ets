import { OfferModel, OfferStatus, JobType, WorkMode } from '../model/OfferModel';
import { OfferStatistics, GroupedOffers } from '../dao/OfferDao';

/**
 * Offer Mock数据
 */
export function getOfferMockData(): OfferModel[] {
  const offers: OfferModel[] = [];

  // 阿里巴巴 - 已收到offer
  const offer1 = new OfferModel();
  offer1.id = 1;
  offer1.company = '阿里巴巴';
  offer1.position = '高级前端开发工程师';
  offer1.department = '淘宝技术部';
  offer1.location = '杭州';
  offer1.baseSalary = 35000;
  offer1.annualSalary = 420000;
  offer1.bonus = 80000;
  offer1.stockOptions = '价值约20万的股票期权';
  offer1.benefits = '五险一金、补充医疗保险、年度体检、健身房、免费三餐、班车接送';
  offer1.workingHours = '9:30-18:30，弹性工作制';
  offer1.vacationDays = 15;
  offer1.jobType = JobType.FULL_TIME;
  offer1.workMode = WorkMode.HYBRID;
  offer1.status = OfferStatus.RECEIVED;
  offer1.offerDate = '2024-01-16';
  offer1.expiryDate = '2024-01-30';
  offer1.startDate = '2024-03-01';
  offer1.hrContact = '13800138001';
  offer1.hrName = '张小美';
  offer1.notes = '技术栈匹配度高，团队氛围好，发展前景不错';
  offer1.pros = '大厂背景、技术氛围好、薪资待遇优秀、股票期权有潜力';
  offer1.cons = '工作压力较大、加班较多、竞争激烈';
  offer1.satisfactionScore = 4;
  offers.push(offer1);

  // 字节跳动 - 已接受
  const offer2 = new OfferModel();
  offer2.id = 2;
  offer2.company = '字节跳动';
  offer2.position = 'Android开发工程师';
  offer2.department = '抖音技术团队';
  offer2.location = '北京';
  offer2.baseSalary = 32000;
  offer2.annualSalary = 384000;
  offer2.bonus = 100000;
  offer2.stockOptions = '价值约30万的期权';
  offer2.benefits = '五险一金、补充医疗、年度体检、健身房、免费三餐、住房补贴';
  offer2.workingHours = '10:00-19:00，弹性工作制';
  offer2.vacationDays = 12;
  offer2.jobType = JobType.FULL_TIME;
  offer2.workMode = WorkMode.ONSITE;
  offer2.status = OfferStatus.ACCEPTED;
  offer2.offerDate = '2024-01-10';
  offer2.expiryDate = '2024-01-24';
  offer2.startDate = '2024-02-26';
  offer2.responseDate = '2024-01-12';
  offer2.hrContact = '13900139002';
  offer2.hrName = '李小花';
  offer2.notes = '已接受，准备入职';
  offer2.pros = '技术前沿、成长空间大、薪资有竞争力、团队年轻有活力';
  offer2.cons = '工作节奏快、压力大、需要经常加班';
  offer2.satisfactionScore = 5;
  offers.push(offer2);

  // 腾讯 - 已拒绝
  const offer3 = new OfferModel();
  offer3.id = 3;
  offer3.company = '腾讯';
  offer3.position = '后端开发工程师';
  offer3.department = '微信事业群';
  offer3.location = '深圳';
  offer3.baseSalary = 28000;
  offer3.annualSalary = 336000;
  offer3.bonus = 60000;
  offer3.stockOptions = '价值约15万的股票';
  offer3.benefits = '五险一金、补充医疗、年度体检、健身房、免费午餐';
  offer3.workingHours = '9:30-18:30';
  offer3.vacationDays = 10;
  offer3.jobType = JobType.FULL_TIME;
  offer3.workMode = WorkMode.ONSITE;
  offer3.status = OfferStatus.REJECTED;
  offer3.offerDate = '2024-01-08';
  offer3.expiryDate = '2024-01-22';
  offer3.responseDate = '2024-01-15';
  offer3.hrContact = '13700137003';
  offer3.hrName = '王小丽';
  offer3.notes = '薪资相对较低，已拒绝';
  offer3.pros = '大厂背景、稳定性好、福利完善';
  offer3.cons = '薪资偏低、晋升较慢、创新空间有限';
  offer3.satisfactionScore = 3;
  offers.push(offer3);

  // 美团 - 待定
  const offer4 = new OfferModel();
  offer4.id = 4;
  offer4.company = '美团';
  offer4.position = '产品经理';
  offer4.department = '到店事业部';
  offer4.location = '北京';
  offer4.baseSalary = 30000;
  offer4.annualSalary = 360000;
  offer4.bonus = 70000;
  offer4.stockOptions = '价值约18万的期权';
  offer4.benefits = '五险一金、补充医疗、年度体检、健身房、免费三餐';
  offer4.workingHours = '9:30-18:30';
  offer4.vacationDays = 12;
  offer4.jobType = JobType.FULL_TIME;
  offer4.workMode = WorkMode.HYBRID;
  offer4.status = OfferStatus.PENDING;
  offer4.offerDate = '';
  offer4.expiryDate = '';
  offer4.startDate = '';
  offer4.hrContact = '13600136004';
  offer4.hrName = '陈小雅';
  offer4.notes = '还在等待最终offer确认';
  offer4.pros = '业务发展好、产品影响力大、团队专业';
  offer4.cons = '竞争激烈、工作压力大';
  offer4.satisfactionScore = 0;
  offers.push(offer4);

  // 百度 - 已收到，即将过期
  const offer5 = new OfferModel();
  offer5.id = 5;
  offer5.company = '百度';
  offer5.position = '算法工程师';
  offer5.department = '智能云事业群';
  offer5.location = '北京';
  offer5.baseSalary = 33000;
  offer5.annualSalary = 396000;
  offer5.bonus = 90000;
  offer5.stockOptions = '价值约25万的股票';
  offer5.benefits = '五险一金、补充医疗、年度体检、健身房、免费午餐、班车';
  offer5.workingHours = '9:00-18:00';
  offer5.vacationDays = 15;
  offer5.jobType = JobType.FULL_TIME;
  offer5.workMode = WorkMode.ONSITE;
  offer5.status = OfferStatus.RECEIVED;
  offer5.offerDate = '2024-01-18';
  offer5.expiryDate = '2024-01-25';  // 即将过期
  offer5.startDate = '2024-03-15';
  offer5.hrContact = '13500135005';
  offer5.hrName = '刘小敏';
  offer5.notes = '算法岗位，技术挑战性强，需要尽快决定';
  offer5.pros = '技术实力强、AI领域领先、发展前景好';
  offer5.cons = '转型期不确定性、部分业务竞争激烈';
  offer5.satisfactionScore = 4;
  offers.push(offer5);

  // 小米 - 已过期
  const offer6 = new OfferModel();
  offer6.id = 6;
  offer6.company = '小米';
  offer6.position = 'UI设计师';
  offer6.department = '设计中心';
  offer6.location = '北京';
  offer6.baseSalary = 25000;
  offer6.annualSalary = 300000;
  offer6.bonus = 50000;
  offer6.stockOptions = '价值约10万的期权';
  offer6.benefits = '五险一金、补充医疗、年度体检、免费午餐';
  offer6.workingHours = '9:30-18:30';
  offer6.vacationDays = 10;
  offer6.jobType = JobType.FULL_TIME;
  offer6.workMode = WorkMode.ONSITE;
  offer6.status = OfferStatus.EXPIRED;
  offer6.offerDate = '2024-01-05';
  offer6.expiryDate = '2024-01-19';  // 已过期
  offer6.hrContact = '13400134006';
  offer6.hrName = '赵小静';
  offer6.notes = '因个人原因未及时回复，offer已过期';
  offer6.pros = '设计氛围好、产品影响力大、团队年轻';
  offer6.cons = '薪资相对较低、设计话语权有限';
  offer6.satisfactionScore = 3;
  offers.push(offer6);

  // 京东 - 实习offer
  const offer7 = new OfferModel();
  offer7.id = 7;
  offer7.company = '京东';
  offer7.position = '数据分析实习生';
  offer7.department = '数据智能部';
  offer7.location = '北京';
  offer7.baseSalary = 8000;
  offer7.annualSalary = 0;
  offer7.bonus = 0;
  offer7.stockOptions = '';
  offer7.benefits = '实习补贴、免费午餐、学习机会';
  offer7.workingHours = '9:30-17:30';
  offer7.vacationDays = 0;
  offer7.jobType = JobType.INTERN;
  offer7.workMode = WorkMode.ONSITE;
  offer7.status = OfferStatus.RECEIVED;
  offer7.offerDate = '2024-01-20';
  offer7.expiryDate = '2024-02-05';
  offer7.startDate = '2024-02-20';
  offer7.hrContact = '13300133007';
  offer7.hrName = '孙小慧';
  offer7.notes = '实习机会，可以积累经验';
  offer7.pros = '学习机会多、导师指导、转正机会';
  offer7.cons = '薪资较低、工作内容相对简单';
  offer7.satisfactionScore = 3;
  offers.push(offer7);

  // 滴滴 - 远程工作
  const offer8 = new OfferModel();
  offer8.id = 8;
  offer8.company = '滴滴';
  offer8.position = '全栈开发工程师';
  offer8.department = '技术中台';
  offer8.location = '远程';
  offer8.baseSalary = 29000;
  offer8.annualSalary = 348000;
  offer8.bonus = 65000;
  offer8.stockOptions = '价值约12万的期权';
  offer8.benefits = '五险一金、远程办公补贴、设备补贴';
  offer8.workingHours = '弹性工作制';
  offer8.vacationDays = 15;
  offer8.jobType = JobType.FULL_TIME;
  offer8.workMode = WorkMode.REMOTE;
  offer8.status = OfferStatus.RECEIVED;
  offer8.offerDate = '2024-01-14';
  offer8.expiryDate = '2024-01-28';
  offer8.startDate = '2024-03-01';
  offer8.hrContact = '13200132008';
  offer8.hrName = '周小婷';
  offer8.notes = '远程工作机会，工作灵活度高';
  offer8.pros = '远程工作、时间灵活、技术栈全面';
  offer8.cons = '沟通成本高、团队协作挑战';
  offer8.satisfactionScore = 4;
  offers.push(offer8);

  return offers;
}

/**
 * 获取Offer统计数据
 */
export function getOfferStatistics(): OfferStatistics {
  const offers = getOfferMockData();
  
  const stats: OfferStatistics = {
    total: offers.length,
    pending: 0,
    accepted: 0,
    rejected: 0,
    expired: 0,
    avgSalary: 0,
    maxSalary: 0
  };

  let salarySum = 0;
  let salaryCount = 0;

  offers.forEach(offer => {
    // 统计状态
    switch (offer.status) {
      case OfferStatus.PENDING:
        stats.pending++;
        break;
      case OfferStatus.ACCEPTED:
        stats.accepted++;
        break;
      case OfferStatus.REJECTED:
        stats.rejected++;
        break;
      case OfferStatus.EXPIRED:
        stats.expired++;
        break;
    }

    // 统计薪资
    if (offer.annualSalary > 0) {
      const totalComp = offer.getTotalCompensation();
      salarySum += totalComp;
      salaryCount++;

      if (totalComp > stats.maxSalary) {
        stats.maxSalary = totalComp;
      }
    }
  });

  if (salaryCount > 0) {
    stats.avgSalary = Math.round(salarySum / salaryCount);
  }

  return stats;
}

/**
 * 按状态分组获取Offer
 */
export function getOffersByStatus(): GroupedOffers {
  const offers = getOfferMockData();
  const grouped: GroupedOffers = {
    urgent: [],      // 紧急处理
    received: [],    // 已收到
    pending: [],     // 待定
    accepted: [],    // 已接受
    rejected: [],    // 已拒绝
    expired: []      // 已过期
  };

  offers.forEach(offer => {
    if (offer.needsUrgentAction()) {
      grouped.urgent.push(offer);
    } else {
      switch (offer.status) {
        case OfferStatus.RECEIVED:
          grouped.received.push(offer);
          break;
        case OfferStatus.PENDING:
          grouped.pending.push(offer);
          break;
        case OfferStatus.ACCEPTED:
          grouped.accepted.push(offer);
          break;
        case OfferStatus.REJECTED:
          grouped.rejected.push(offer);
          break;
        case OfferStatus.EXPIRED:
          grouped.expired.push(offer);
          break;
      }
    }
  });

  return grouped;
}