import { InterviewStatus, InterviewRound, InterviewResult, OfferStatus as InterviewOfferStatus } from '../model/InterviewRecordModel';
import { OfferStatus, JobType, WorkMode } from '../model/OfferModel';

/**
 * 枚举映射工具类
 * 用于在数据库Long值和枚举之间进行转换
 */
export class EnumMapper {
  
  // InterviewStatus 映射
  private static readonly INTERVIEW_STATUS_TO_LONG: Map<InterviewStatus, number> = new Map([
    [InterviewStatus.SCHEDULED, 0],
    [InterviewStatus.COMPLETED, 1],
    [InterviewStatus.CANCELLED, 2],
    [InterviewStatus.PENDING, 3]
  ]);

  private static readonly LONG_TO_INTERVIEW_STATUS: Map<number, InterviewStatus> = new Map([
    [0, InterviewStatus.SCHEDULED],
    [1, InterviewStatus.COMPLETED],
    [2, InterviewStatus.CANCELLED],
    [3, InterviewStatus.PENDING]
  ]);

  // InterviewRound 映射
  private static readonly INTERVIEW_ROUND_TO_LONG: Map<InterviewRound, number> = new Map([
    [InterviewRound.HR, 0],
    [InterviewRound.TECHNICAL, 1],
    [InterviewRound.MANAGER, 2],
    [InterviewRound.FINAL, 3],
    [InterviewRound.ONSITE, 4]
  ]);

  private static readonly LONG_TO_INTERVIEW_ROUND: Map<number, InterviewRound> = new Map([
    [0, InterviewRound.HR],
    [1, InterviewRound.TECHNICAL],
    [2, InterviewRound.MANAGER],
    [3, InterviewRound.FINAL],
    [4, InterviewRound.ONSITE]
  ]);

  // InterviewResult 映射
  private static readonly INTERVIEW_RESULT_TO_LONG: Map<InterviewResult, number> = new Map([
    [InterviewResult.PASS, 0],
    [InterviewResult.FAIL, 1],
    [InterviewResult.PENDING, 2],
    [InterviewResult.UNKNOWN, 3]
  ]);

  private static readonly LONG_TO_INTERVIEW_RESULT: Map<number, InterviewResult> = new Map([
    [0, InterviewResult.PASS],
    [1, InterviewResult.FAIL],
    [2, InterviewResult.PENDING],
    [3, InterviewResult.UNKNOWN]
  ]);

  // InterviewOfferStatus 映射 (来自InterviewRecordModel)
  private static readonly INTERVIEW_OFFER_STATUS_TO_LONG: Map<InterviewOfferStatus, number> = new Map([
    [InterviewOfferStatus.NO_OFFER, 0],
    [InterviewOfferStatus.PENDING, 1],
    [InterviewOfferStatus.RECEIVED, 2],
    [InterviewOfferStatus.ACCEPTED, 3],
    [InterviewOfferStatus.REJECTED, 4]
  ]);

  private static readonly LONG_TO_INTERVIEW_OFFER_STATUS: Map<number, InterviewOfferStatus> = new Map([
    [0, InterviewOfferStatus.NO_OFFER],
    [1, InterviewOfferStatus.PENDING],
    [2, InterviewOfferStatus.RECEIVED],
    [3, InterviewOfferStatus.ACCEPTED],
    [4, InterviewOfferStatus.REJECTED]
  ]);

  // OfferStatus 映射 (来自OfferModel)
  private static readonly OFFER_STATUS_TO_LONG: Map<OfferStatus, number> = new Map([
    [OfferStatus.PENDING, 0],
    [OfferStatus.RECEIVED, 1],
    [OfferStatus.ACCEPTED, 2],
    [OfferStatus.REJECTED, 3],
    [OfferStatus.EXPIRED, 4]
  ]);

  private static readonly LONG_TO_OFFER_STATUS: Map<number, OfferStatus> = new Map([
    [0, OfferStatus.PENDING],
    [1, OfferStatus.RECEIVED],
    [2, OfferStatus.ACCEPTED],
    [3, OfferStatus.REJECTED],
    [4, OfferStatus.EXPIRED]
  ]);

  // JobType 映射
  private static readonly JOB_TYPE_TO_LONG: Map<JobType, number> = new Map([
    [JobType.FULL_TIME, 0],
    [JobType.PART_TIME, 1],
    [JobType.INTERN, 2],
    [JobType.CONTRACT, 3]
  ]);

  private static readonly LONG_TO_JOB_TYPE: Map<number, JobType> = new Map([
    [0, JobType.FULL_TIME],
    [1, JobType.PART_TIME],
    [2, JobType.INTERN],
    [3, JobType.CONTRACT]
  ]);

  // WorkMode 映射
  private static readonly WORK_MODE_TO_LONG: Map<WorkMode, number> = new Map([
    [WorkMode.ONSITE, 0],
    [WorkMode.REMOTE, 1],
    [WorkMode.HYBRID, 2]
  ]);

  private static readonly LONG_TO_WORK_MODE: Map<number, WorkMode> = new Map([
    [0, WorkMode.ONSITE],
    [1, WorkMode.REMOTE],
    [2, WorkMode.HYBRID]
  ]);

  // InterviewStatus 转换方法
  static interviewStatusToLong(status: InterviewStatus): number {
    return EnumMapper.INTERVIEW_STATUS_TO_LONG.get(status) ?? 3; // 默认为PENDING
  }

  static longToInterviewStatus(value: number): InterviewStatus {
    return EnumMapper.LONG_TO_INTERVIEW_STATUS.get(value) ?? InterviewStatus.PENDING;
  }

  // InterviewRound 转换方法
  static interviewRoundToLong(round: InterviewRound): number {
    return EnumMapper.INTERVIEW_ROUND_TO_LONG.get(round) ?? 0; // 默认为HR
  }

  static longToInterviewRound(value: number): InterviewRound {
    return EnumMapper.LONG_TO_INTERVIEW_ROUND.get(value) ?? InterviewRound.HR;
  }

  // InterviewResult 转换方法
  static interviewResultToLong(result: InterviewResult): number {
    return EnumMapper.INTERVIEW_RESULT_TO_LONG.get(result) ?? 3; // 默认为UNKNOWN
  }

  static longToInterviewResult(value: number): InterviewResult {
    return EnumMapper.LONG_TO_INTERVIEW_RESULT.get(value) ?? InterviewResult.UNKNOWN;
  }

  // InterviewOfferStatus 转换方法
  static interviewOfferStatusToLong(status: InterviewOfferStatus): number {
    return EnumMapper.INTERVIEW_OFFER_STATUS_TO_LONG.get(status) ?? 0; // 默认为NO_OFFER
  }

  static longToInterviewOfferStatus(value: number): InterviewOfferStatus {
    return EnumMapper.LONG_TO_INTERVIEW_OFFER_STATUS.get(value) ?? InterviewOfferStatus.NO_OFFER;
  }

  // OfferStatus 转换方法
  static offerStatusToLong(status: OfferStatus): number {
    return EnumMapper.OFFER_STATUS_TO_LONG.get(status) ?? 0; // 默认为PENDING
  }

  static longToOfferStatus(value: number): OfferStatus {
    return EnumMapper.LONG_TO_OFFER_STATUS.get(value) ?? OfferStatus.PENDING;
  }

  // JobType 转换方法
  static jobTypeToLong(jobType: JobType): number {
    return EnumMapper.JOB_TYPE_TO_LONG.get(jobType) ?? 0; // 默认为FULL_TIME
  }

  static longToJobType(value: number): JobType {
    return EnumMapper.LONG_TO_JOB_TYPE.get(value) ?? JobType.FULL_TIME;
  }

  // WorkMode 转换方法
  static workModeToLong(workMode: WorkMode): number {
    return EnumMapper.WORK_MODE_TO_LONG.get(workMode) ?? 0; // 默认为ONSITE
  }

  static longToWorkMode(value: number): WorkMode {
    return EnumMapper.LONG_TO_WORK_MODE.get(value) ?? WorkMode.ONSITE;
  }
}