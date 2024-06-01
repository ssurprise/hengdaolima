import router from '@ohos.router';
import systemDateTime from '@ohos.systemDateTime';
import { CatalogItemInfo } from '../model/CatalogItemInfo';
import { CommonConstants } from '../../common/constants/CommonConstants';
import BrowserHistoryViewMode from '../../datamanage/viewmodel/BrowserHistoryViewMode';


@Component
export struct DashboardComp {
  @Prop mType: string
  @State mDashboardArray: Array<CatalogItemInfo> = []
  private readonly mCatalogArray = new Map([
    ['component', [
      new CatalogItemInfo('文本', 'uicomp/page/TextPage'),
      new CatalogItemInfo('输入框', 'uicomp/page/TextInputPage'),
      new CatalogItemInfo('按钮-Button', 'uicomp/page/ButtonPage'),
      new CatalogItemInfo('图像-Image', 'uicomp/page/ImagePage'),
      new CatalogItemInfo('单选-Radio', 'uicomp/page/RadioPage'),
      new CatalogItemInfo('跑马灯-Marquee', 'uicomp/page/MarqueePage'),
      new CatalogItemInfo('进度条-Progress', 'uicomp/page/ProgressPage'),
      new CatalogItemInfo('线性-Row', 'uicomp/page/RowPage'),
      new CatalogItemInfo('层叠-Stack', 'uicomp/page/StackPage'),
      new CatalogItemInfo('轮播-Swiper', 'uicomp/page/SwiperPage'),
      new CatalogItemInfo('列表-List-间距', 'uicomp/page/ListPage'),
      new CatalogItemInfo('列表-List-分组', 'uicomp/page/ListPage2'),
      new CatalogItemInfo('网格-Grid', 'uicomp/page/GridPage'),
      new CatalogItemInfo('弹性-Flex', 'uicomp/page/FlexPage'),
      new CatalogItemInfo('刷新-Refresh', 'uicomp/page/RefreshPage'),
      new CatalogItemInfo('选择器-Picker', 'uicomp/page/PickerPage'),
      new CatalogItemInfo('搜索框-Search', 'uicomp/page/SearchPage'),
      new CatalogItemInfo('瀑布流-WaterFlow', 'uicomp/page/WaterFlowPage')]
    ],
    ['image_animation', [
      new CatalogItemInfo('图形', 'imagebu/page/ShapePage'),
      new CatalogItemInfo('图片处理', 'imagebu/page/PixelMapPage'),
      new CatalogItemInfo('图像效果', 'imagebu/page/EffectKitPage'),
      new CatalogItemInfo('图形变换', 'imagebu/page/TransformPage'),
      new CatalogItemInfo('Canvas绘图', 'imagebu/page/CanvasPage'),
      new CatalogItemInfo('显示动画', 'imagebu/page/AnimToPage'),
      new CatalogItemInfo('属性动画', 'imagebu/page/AnimationPage'),
      new CatalogItemInfo('json动画', 'imagebu/page/LottiePage')]
    ],
    ['arkts_base', [
      new CatalogItemInfo('ArrayList', 'datamanage/page/ArrayListPage'),
      new CatalogItemInfo('LinkedList', 'datamanage/page/LinkedListPage'),
      new CatalogItemInfo('栈-Stack', 'datamanage/page/StackDcPage'),
      new CatalogItemInfo('队列-Queue', 'datamanage/page/QueuePage'),
      new CatalogItemInfo('双端队列-Deque', 'datamanage/page/DequePage'),
      new CatalogItemInfo('DataUriUtils', 'datamanage/page/DataUriUtilsPage'),
      new CatalogItemInfo('异步并发', 'datamanage/page/PromisePage')]
    ],
    ['data_manager', [
      new CatalogItemInfo('首选项', 'datamanage/page/PreferencePage'),
      new CatalogItemInfo('关系型数据库', 'datamanage/page/RdbPage'),
      new CatalogItemInfo('应用文件路径', 'filemanage/page/FileDirPage'),
      new CatalogItemInfo('文件访问', 'filemanage/page/FileFsPage'),
      new CatalogItemInfo('创建文本文件', 'filemanage/page/FileTextCreatePage'),
      new CatalogItemInfo('文件选择器', 'filemanage/page/FilePickerPage')]
    ],
    ['practice', [
      new CatalogItemInfo('网络请求', 'practice/page/HttpRequestPage'),
      new CatalogItemInfo('权限', 'practice/page/PermissionPage'),
      new CatalogItemInfo('Web页', 'practice/page/WebPage'),
      new CatalogItemInfo('通知-基础类型', 'practice/page/NotificationPage'),
      new CatalogItemInfo('警告弹窗', 'practice/page/AlertDialogPage'),
      new CatalogItemInfo('Toast', 'practice/page/ToastPage'),
      new CatalogItemInfo('倒计时/定时器', 'practice/page/TimeIntervalPage'),
      new CatalogItemInfo('拨打电话', 'practice/page/CallPage'),
      new CatalogItemInfo('设备信息', 'practice/page/DeviceInfoPage'),
      new CatalogItemInfo('App管理能力', 'practice/page/AppManagerPage'),
      new CatalogItemInfo('Px<=>Vp', 'practice/page/PxAndVpPage')]
    ]
  ])

  build() {
    if (this.mDashboardArray.length > 0) {
      Grid() {
        ForEach(this.mDashboardArray, (item: CatalogItemInfo, index: Number) => {
          GridItem() {
            Text(item.name)
              .width('100%')
              .height('100%')
              .padding({ left: 5, right: 5 })
              .fontSize(12)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(0x007DFF)
              .borderRadius(8)
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
      .columnsTemplate('1fr 1fr 1fr 1fr') //仅设置columnsTemplate时，Grid主轴为垂直方向，交叉轴为水平方向。
      .columnsGap(8)
      .rowsGap(8)
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