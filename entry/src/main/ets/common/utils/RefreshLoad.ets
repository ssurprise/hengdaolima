/**
 * 加载状态
 */
export const enum LoadState {
  NONE = 0,
  // 准备状态，此时可以进行刷新
  READY = 1,
  // 加载中
  LOADING = 2,
  // 成功
  SUCCESS = 3,
  // 失败
  FAILED = 4,
}


@Observed
export class RefreshViewObj {
  /**
   * 状态
   */
  state: LoadState;

  /**
   * 加载状态图
   */
  imageSrc: Resource;

  /**
   * 文本提示
   */
  textValue: Resource;

  constructor(state: LoadState) {
    this.state = state;
    switch (state) {
      case LoadState.NONE:
        this.textValue = $r('app.string.pull_down_refresh_text');
        this.imageSrc = $r('app.media.ic_pull_down_refresh');
        break;
      case LoadState.READY:
        this.textValue = $r('app.string.release_refresh_text');
        this.imageSrc = $r('app.media.ic_pull_up_refresh');
        break;
      case LoadState.LOADING:
        this.textValue = $r('app.string.refreshing_text');
        this.imageSrc = $r('app.media.ic_pull_up_load');
        break;
      case LoadState.SUCCESS:
        this.textValue = $r('app.string.refresh_success_text');
        this.imageSrc = $r('app.media.ic_refresh_succeed');
        break;
      case LoadState.FAILED:
        this.textValue = $r('app.string.refresh_fail_text');
        this.imageSrc = $r('app.media.ic_refresh_fail');
        break;
      default:
        this.textValue = $r('app.string.pull_down_refresh_text');
        this.imageSrc = $r('app.media.ic_pull_down_refresh');
        break
    }
  }
}