import router from '@ohos.router';
import { CatalogItemInfo } from '../common/bean/CatalogItemInfo';
import { CommonConstants } from '../common/constants/CommonConstants';

@Component
export struct CatalogComponent {
  private mCatalogArray: Array<CatalogItemInfo> = [
    new CatalogItemInfo('文本', CommonConstants.ROUTER_TEXT_PAGE_URL),
    new CatalogItemInfo('图像', CommonConstants.ROUTER_IMAGE_PAGE_URL),
    new CatalogItemInfo('线性-Row', CommonConstants.ROUTER_ROW_PAGE_URL),
    new CatalogItemInfo('列表-List', 'pages/ListPage'),
    new CatalogItemInfo('网格-Grid', 'pages/GridPage'),
    new CatalogItemInfo('层叠-Stack', 'pages/StackPage'),
    new CatalogItemInfo('单选-Radio', 'pages/RadioPage'),
    new CatalogItemInfo('轮播-Swiper', 'pages/SwiperPage')
  ]

  build() {
    Column() {
      Grid() {
        ForEach(this.mCatalogArray, (item: CatalogItemInfo, index: Number) => {
          GridItem() {
            // @ts-ignore
            Text(item.name)
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor(0x007DFF)
              .width('100%')
              .height('100%')
              .textAlign(TextAlign.Center)
          }
          .height('50vp')
          .onClick(() => {
            router.pushUrl({ url: item.path });
          })
          // @ts-ignore
        }, (item: CatalogItemInfo) => item.name)
      }
      .margin({ top: '20vp' })
      .columnsTemplate('1fr 1fr 1fr  1fr') //仅设置columnsTemplate时，Grid主轴为垂直方向，交叉轴为水平方向。
      .columnsGap(10)
      .rowsGap(10)
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}