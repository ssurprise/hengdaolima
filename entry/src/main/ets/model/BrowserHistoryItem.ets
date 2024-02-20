/**
 * 浏览历史
 */
export class BrowserHistoryItem {
  name: string;
  /**
   * page 路径
   */
  pagePath: string;
  /**
   * 最近打开时间
   */
  lastTime: number;
  /**
   * 打开次数
   */
  count: number;
}