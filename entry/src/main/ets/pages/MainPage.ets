import { MineComponent } from '../view/MineComponent'
import { CatalogComponent } from '../view/CatalogComponent'
import { HomeComponent } from '../view/HomeComponent'

@Entry
@Component
struct MainPage {
  private controller: TabsController = new TabsController()

  build() {
    Column() {
      Tabs({ controller: this.controller, barPosition: BarPosition.End }) {
        TabContent() {
          HomeComponent()
        }.tabBar("首页")

        TabContent() {
          CatalogComponent()
        }.tabBar("目录")

        TabContent() {
          MineComponent()
        }.tabBar("我的")
      }
      .width('100%') // 设置Tabs组件宽度
      .height('100%') // 设置Tabs组件高度
      .barMode(BarMode.Fixed) // barMode是控制导航栏是否可以滚动
      .scrollable(false)
      .barWidth('100%') // 设置TabBar宽度
      .barHeight(60) // 设置TabBar高度
    }
    .height('100%')
    .width('100%')
  }
}