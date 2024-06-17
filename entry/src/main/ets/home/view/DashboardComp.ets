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
      new CatalogItemInfo('文本', 'uicomp/pages/TextPage'),
      new CatalogItemInfo('输入框', 'uicomp/pages/TextInputPage'),
      new CatalogItemInfo('按钮-Button', 'uicomp/pages/ButtonPage'),
      new CatalogItemInfo('图像-Image', 'uicomp/pages/ImagePage'),
      new CatalogItemInfo('单选-Radio', 'uicomp/pages/RadioPage'),
      new CatalogItemInfo('跑马灯-Marquee', 'uicomp/pages/MarqueePage'),
      new CatalogItemInfo('进度条-Progress', 'uicomp/pages/ProgressPage'),
      new CatalogItemInfo('线性-Row', 'uicomp/pages/RowPage'),
      new CatalogItemInfo('层叠-Stack', 'uicomp/pages/StackPage'),
      new CatalogItemInfo('轮播-Swiper', 'uicomp/pages/SwiperPage'),
      new CatalogItemInfo('列表-List-间距', 'uicomp/pages/ListPage'),
      new CatalogItemInfo('列表-List-分组', 'uicomp/pages/ListPage2'),
      new CatalogItemInfo('网格-Grid', 'uicomp/pages/GridPage'),
      new CatalogItemInfo('弹性-Flex', 'uicomp/pages/FlexPage'),
      new CatalogItemInfo('刷新-Refresh', 'uicomp/pages/RefreshPage'),
      new CatalogItemInfo('选择器-Picker', 'uicomp/pages/PickerPage'),
      new CatalogItemInfo('搜索框-Search', 'uicomp/pages/SearchPage'),
      new CatalogItemInfo('瀑布流-WaterFlow', 'uicomp/pages/WaterFlowPage')]
    ],
    ['image_animation', [
      new CatalogItemInfo('图形', 'imagebu/pages/ShapePage'),
      new CatalogItemInfo('图片处理', 'imagebu/pages/PixelMapPage'),
      new CatalogItemInfo('图像效果', 'imagebu/pages/EffectKitPage'),
      new CatalogItemInfo('图形变换', 'imagebu/pages/TransformPage'),
      new CatalogItemInfo('Canvas绘图', 'imagebu/pages/CanvasPage'),
      new CatalogItemInfo('显示动画', 'imagebu/pages/AnimToPage'),
      new CatalogItemInfo('属性动画', 'imagebu/pages/AnimationPage'),
      new CatalogItemInfo('json动画', 'imagebu/pages/LottiePage')]
    ],
    ['arkts_base', [
      new CatalogItemInfo('ArrayList', 'datamanage/pages/ArrayListPage'),
      new CatalogItemInfo('LinkedList', 'datamanage/pages/LinkedListPage'),
      new CatalogItemInfo('栈-Stack', 'datamanage/pages/StackDcPage'),
      new CatalogItemInfo('队列-Queue', 'datamanage/pages/QueuePage'),
      new CatalogItemInfo('双端队列-Deque', 'datamanage/pages/DequePage'),
      new CatalogItemInfo('排序', 'datamanage/pages/SortPage'),
      new CatalogItemInfo('DataUriUtils', 'datamanage/pages/DataUriUtilsPage'),
      new CatalogItemInfo('异步并发', 'datamanage/pages/PromisePage')]
    ],
    ['data_manager', [
      new CatalogItemInfo('首选项', 'datamanage/pages/PreferencePage'),
      new CatalogItemInfo('关系型数据库', 'datamanage/pages/RdbPage'),
      new CatalogItemInfo('应用文件路径', 'filemanage/pages/FileDirPage'),
      new CatalogItemInfo('文件访问', 'filemanage/pages/FileFsPage'),
      new CatalogItemInfo('创建文本文件', 'filemanage/pages/FileTextCreatePage'),
      new CatalogItemInfo('文件选择器', 'filemanage/pages/FilePickerPage')]
    ],
    ['practice', [
      new CatalogItemInfo('网络请求', 'practice/pages/HttpRequestPage'),
      new CatalogItemInfo('权限', 'practice/pages/PermissionPage'),
      new CatalogItemInfo('Web页', 'practice/pages/WebPage'),
      new CatalogItemInfo('通知-基础类型', 'practice/pages/NotificationPage'),
      new CatalogItemInfo('警告弹窗', 'practice/pages/AlertDialogPage'),
      new CatalogItemInfo('Toast', 'practice/pages/ToastPage'),
      new CatalogItemInfo('倒计时/定时器', 'practice/pages/TimeIntervalPage'),
      new CatalogItemInfo('拨打电话', 'practice/pages/CallPage'),
      new CatalogItemInfo('设备信息', 'practice/pages/DeviceInfoPage'),
      new CatalogItemInfo('App管理能力', 'practice/pages/AppManagerPage'),
      new CatalogItemInfo('Px<=>Vp', 'practice/pages/PxAndVpPage')]
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