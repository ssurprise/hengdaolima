import { MineComponent } from '../view/MineComponent'
import { CatalogComponent } from '../view/CatalogComponent'
import { HomeComponent } from '../view/HomeComponent'
import { buttonInfo, ButtonInfoModel } from '../model/MainPageData'

@Entry
@Component
struct MainPage {
  private controller: TabsController = new TabsController()
  @State currentPageIndex: number = 0;

  build() {
    Column() {
      Tabs({ controller: this.controller, barPosition: BarPosition.End, index: this.currentPageIndex }) {
        TabContent() {
          HomeComponent()
        }.tabBar(this.BottomNavigation(buttonInfo[0]))

        TabContent() {
          CatalogComponent()
        }.tabBar(this.BottomNavigation(buttonInfo[1]))

        TabContent() {
          MineComponent()
        }.tabBar(this.BottomNavigation(buttonInfo[2]))
      }
      .width('100%') // 设置Tabs组件宽度
      .height('100%') // 设置Tabs组件高度
      .barMode(BarMode.Fixed) // barMode是控制导航栏是否可以滚动，默认情况下其值为Fixed，表示为固定导航栏。
      .scrollable(false) // 控制滑动切换，默认为true，表示可以滑动。
      .barWidth('100%') // 设置TabBar宽度
      .barHeight(56) // 设置TabBar高度
      .onChange((index: number) => {
        this.currentPageIndex = index;
      })
    }
    .height('100%')
    .width('100%')
  }

  @Builder BottomNavigation(button: ButtonInfoModel) {
    Column({ space: 5 }) {
      Image(this.currentPageIndex === button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width(24)
        .height(24)
      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? '#e92f4f' : Color.Black)
        .textAlign(TextAlign.Center)
        .fontSize(10)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}