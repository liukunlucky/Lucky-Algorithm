/**
 * 时间工具类
 * 解决时区问题，确保保存和显示的都是本地时间
 */
export class TimeUtils {
  
  /**
   * 获取本地时间的ISO字符串
   * 解决toISOString()返回UTC时间的问题
   */
  static getLocalISOString(date?: Date): string {
    const now = date || new Date();
    const offset = now.getTimezoneOffset() * 60000; // 获取时区偏移量（毫秒）
    const localTime = new Date(now.getTime() - offset);
    return localTime.toISOString();
  }

  /**
   * 获取本地日期字符串 (YYYY-MM-DD格式)
   */
  static getLocalDateString(date?: Date): string {
    return TimeUtils.getLocalISOString(date).split('T')[0];
  }

  /**
   * 获取本地时间字符串 (HH:MM:SS格式)
   */
  static getLocalTimeString(date?: Date): string {
    return TimeUtils.getLocalISOString(date).split('T')[1].split('.')[0];
  }

  /**
   * 格式化显示时间
   * @param dateString ISO时间字符串
   * @returns 格式化后的时间字符串
   */
  static formatDisplayTime(dateString: string): string {
    if (!dateString || dateString.trim() === '') {
      return '未知时间';
    }
    
    const date = new Date(dateString);
    if (isNaN(date.getTime())) {
      return '未知时间';
    }
    
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    
    if (diffDays === 0) {
      // 今天
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `今天 ${hours}:${minutes}`;
    } else if (diffDays === 1) {
      // 昨天
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `昨天 ${hours}:${minutes}`;
    } else if (diffDays < 7) {
      // 一周内
      return `${diffDays}天前`;
    } else {
      // 超过一周
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const day = date.getDate().toString().padStart(2, '0');
      const hours = date.getHours().toString().padStart(2, '0');
      const minutes = date.getMinutes().toString().padStart(2, '0');
      return `${month}-${day} ${hours}:${minutes}`;
    }
  }
}