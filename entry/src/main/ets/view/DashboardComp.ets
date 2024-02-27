import router from '@ohos.router';
import systemDateTime from '@ohos.systemDateTime';
import { CatalogItemInfo } from '../common/bean/CatalogItemInfo';
import { CommonConstants } from '../common/constants/CommonConstants';
import BrowserHistoryViewMode from '../viewmodel/BrowserHistoryViewMode';


@Component
export struct DashboardComp {
  @Prop mType: string
  @State mDashboardArray: Array<CatalogItemInfo> = []
  private readonly mCatalogArray = new Map([
    ['component', [
      new CatalogItemInfo('文本', CommonConstants.ROUTER_TEXT_PAGE_URL),
      new CatalogItemInfo('输入框', 'pages/TextInputPage'),
      new CatalogItemInfo('图像', CommonConstants.ROUTER_IMAGE_PAGE_URL),
      new CatalogItemInfo('单选-Radio', 'pages/RadioPage'),
      new CatalogItemInfo('跑马灯-Marquee', 'pages/MarqueePage'),
      new CatalogItemInfo('进度条-Progress', 'pages/ProgressPage'),
      new CatalogItemInfo('线性-Row', CommonConstants.ROUTER_ROW_PAGE_URL),
      new CatalogItemInfo('层叠-Stack', 'pages/StackPage'),
      new CatalogItemInfo('轮播-Swiper', 'pages/SwiperPage'),
      new CatalogItemInfo('列表-List-间距', 'pages/ListPage'),
      new CatalogItemInfo('列表-List-分组', 'pages/ListPage2'),
      new CatalogItemInfo('网格-Grid', 'pages/GridPage'),
      new CatalogItemInfo('弹性-Flex', 'pages/FlexPage'),
      new CatalogItemInfo('刷新-Refresh', 'pages/RefreshPage'),
      new CatalogItemInfo('选择器-Picker', 'pages/PickerPage')]
    ],
    ['image_animation', [
      new CatalogItemInfo('图形', 'pages/ShapePage'),
      new CatalogItemInfo('图像变换', 'pages/PixelMapPage'),
      new CatalogItemInfo('图像效果', 'pages/EffectKitPage'),
      new CatalogItemInfo('Canvas绘图', 'pages/CanvasPage'),
      new CatalogItemInfo('显示动画', 'pages/AnimToPage'),
      new CatalogItemInfo('属性动画', 'pages/AnimationPage'),
      new CatalogItemInfo('json动画', 'pages/LottiePage')]
    ],
    ['arkts_base', [
      new CatalogItemInfo('ArrayList', 'pages/ArrayListPage'),
      new CatalogItemInfo('LinkedList', 'pages/LinkedListPage'),
      new CatalogItemInfo('栈-Stack', 'pages/StackDcPage'),
      new CatalogItemInfo('队列-Queue', 'pages/QueuePage'),
      new CatalogItemInfo('双端队列-Deque', 'pages/DequePage'),
      new CatalogItemInfo('DataUriUtils', 'pages/DataUriUtilsPage'),
      new CatalogItemInfo('App管理能力', 'pages/AppManagerPage'),
      new CatalogItemInfo('异步并发', 'pages/PromisePage')]
    ],
    ['data_manager', [
      new CatalogItemInfo('首选项', 'pages/PreferencePage'),
      new CatalogItemInfo('关系型数据库', 'pages/RdbPage')]
    ],
    ['practice', [
      new CatalogItemInfo('网络请求', 'pages/HttpRequestPage'),
      new CatalogItemInfo('Web页', 'pages/WebPage'),
      new CatalogItemInfo('通知-基础类型', 'pages/NotificationPage'),
      new CatalogItemInfo('弹窗', 'pages/AlertDialogPage'),
      new CatalogItemInfo('拨打电话', 'pages/CallPage'),
      new CatalogItemInfo('设备信息', 'pages/DeviceInfoPage')]
    ]
  ])

  build() {
    if (this.mDashboardArray.length > 0) {
      Grid() {
        ForEach(this.mDashboardArray, (item: CatalogItemInfo, index: Number) => {
          GridItem() {
            Text(item.name)
              .fontSize(14)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .fontStyle(FontStyle.Normal)
              .backgroundColor(0x007DFF)
              .borderRadius(10)
              .width('100%')
              .height('100%')
              .textAlign(TextAlign.Center)
          }
          .height('50vp')
          .onClick(() => {
            router.pushUrl({ url: item.path });
            BrowserHistoryViewMode.addHistoryItem(getContext(), {
              name: item.name,
              pagePath: item.path,
              lastTime: 1
            })
          })
          // @ts-ignore
        }, (item: CatalogItemInfo) => item.name)
      }
      .columnsTemplate('1fr 1fr 1fr  1fr') //仅设置columnsTemplate时，Grid主轴为垂直方向，交叉轴为水平方向。
      .columnsGap(10)
      .rowsGap(10)
      .padding(10)
    } else {
      Text('暂无数据')
        .width('100%')
        .height('100%')
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)
        .fontSize(32)
        .textAlign(TextAlign.Center)
    }
  }

  aboutToAppear() {
    this.mDashboardArray = this.mCatalogArray.get(this.mType)
  }
}