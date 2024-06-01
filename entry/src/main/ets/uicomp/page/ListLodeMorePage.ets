import { TipsComp } from '../../common/view/TipsComp'
import { TitleComp } from '../../common/view/TitleComp'
import { PullDownRefreshView } from '../../common/view/PullDownRefreshView'
import { LoadState, RefreshViewObj } from '../../common/utils/RefreshLoad'

@Entry
@Component
struct ListLodeMorePage {
  private readonly TAG: string = 'pullDownRefresh'
  private arr: string[] = new Array(20).fill('').map((_, index) => `item ${index}`)
  @State mLoadState: LoadState = LoadState.NONE
  @State isLoadingVisible: boolean = false
  @State isPullRefreshOperation: boolean = false;
  @State isVisiblePullDown: boolean = false;
  @State mStartIndex: number = 0
  @State mEndIndex: number = 0
  @State isRefreshing: boolean = false
  @State isCanRefresh: boolean = false
  @State offsetY: number = 0
  @State downY: number = 0
  @State lastMoveY: number = 0

  build() {
    Column() {
      TitleComp({ titleName: 'List-加载' })

      Column() {
        this.listLayout()
      }
      .width('100%')
      .onTouch((event: TouchEvent | undefined) => {
        if (event) {
          this.handlerTouchEvent(event);
        }
      })

      this.renderTips()
    }
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }

  @Builder listLayout() {
    List({ space: 10 }) {

      ListItem() {
        if (this.isVisiblePullDown) {
          PullDownRefreshView({ stateDetail: new RefreshViewObj(this.mLoadState) })
        }
      }

      ForEach(this.arr, (item: string) => {
        ListItem() {
          Text(item)
            .width('100%')
            .height('100%')
            .fontSize(20)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .backgroundColor(0x007DFF)
        }
        .width('90%')
        .height(48)
      }, item => item)
    }
    .width('100%')
    .height('70%')
    .alignListItem(ListItemAlign.Center)
    .edgeEffect(EdgeEffect.None)
    .offset({ x: 0, y: `${this.offsetY}px` })
    .onScrollIndex((start: number, end: number) => {
      this.mStartIndex = start;
      this.mEndIndex = end;
    })
    // .onTouch((event: TouchEvent) => {
    //   this.handlerTouchEvent(event)
    // })
  }

  handlerTouchEvent(event: TouchEvent) {
    switch (event.type) {
      case TouchType.Down:
        // 记录按下的点
        this.downY = event.touches[0].y
        this.lastMoveY = event.touches[0].y
        break
      case TouchType.Move:
        console.log(this.TAG, `handlerTouchEvent-Move,lastMoveY=${this.lastMoveY} cur=${event.touches[0].y}`)
        if (this.isRefreshing) {
          return
        }
        let isDownPull = (event.touches[0].y - this.lastMoveY) > 0;// 手纸向下滑动，当前比上一次的位置要大。
        console.log(this.TAG, `handlerTouchEvent-isDownPull=${isDownPull}， isVisiblePullDown=${this.isVisiblePullDown}`)
        if ((isDownPull === true) || (this.isPullRefreshOperation === true)) {
          this.touchMovePullRefresh(event);
        } else {

        }
        this.lastMoveY = event.touches[0].y;
        break
      case TouchType.Up:
        if (this.isRefreshing === true) {
          return;
        }
        if ((this.isVisiblePullDown === true)) {
          // Lift your finger and pull down to refresh.
          this.touchUpPullRefresh();
        }
        break
      case TouchType.Cancel:
        break
      default:
        break;
    }
  }

  private touchMovePullRefresh(event: TouchEvent) {
    if (this.mStartIndex === 0) {
      this.isPullRefreshOperation = true;
      this.offsetY = event.touches[0].y - this.downY;
      let height = vp2px(70);
      if (this.offsetY >= height) {
        this.pullRefreshState(LoadState.READY);
        this.offsetY = height + this.offsetY * 0.1;
      } else {
        this.pullRefreshState(LoadState.NONE);
      }
      if (this.offsetY < 0) {
        this.offsetY = 0;
        this.isVisiblePullDown = false;
      }
    }
  }

  private touchUpPullRefresh() {
  if (this.isCanRefresh === true) {
    this.offsetY = vp2px(70);
    this.pullRefreshState(LoadState.LOADING);
    setTimeout(() => {
      this.pullRefreshState(LoadState.SUCCESS);

      animateTo({
        duration: 50,
        delay: 50,
        onFinish: () => {
          this.pullRefreshState(LoadState.NONE);
          // this.isVisiblePullDown = false;
          this.isPullRefreshOperation = false;
        }
      }, () => {
        this.offsetY = 0;
      })

    }, 3000);
  } else {
    // closeRefresh(newsModel, false);
  }
}

  private pullRefreshState(state: number) {
    switch (state) {
      case LoadState.NONE:
        this.isCanRefresh = false;
        this.isRefreshing = false;
      this.isPullRefreshOperation = true;
        break;
      case LoadState.READY:
        this.isCanRefresh = true;
        this.isRefreshing = false;
        break;
      case LoadState.LOADING:
        this.offsetY = vp2px(70);
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      case LoadState.SUCCESS:
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      case LoadState.FAILED:
        this.isCanRefresh = true;
        this.isRefreshing = true;
        break;
      default:
        break;
    }
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      'divider 可以和 space 同时设置。当divider的`strokeWidth`小于space时，会现在space的中间位置显示。如果 divider 的`strokeWidth`大于space的宽度，则会使用`strokeWidth`的宽度。'
    ] })
  }
}