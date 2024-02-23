import { DashboardComp } from '../view/DashboardComp';


@Component
export struct CatalogComponent {
  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        /*
        TabContent组件不支持设置通用宽度属性，其宽度默认撑满Tabs父组件。
        TabContent组件不支持设置通用高度属性，其高度由Tabs父组件高度与TabBar组件高度决定。
        TabContent组件不支持内容过长时页面的滑动，如需页面滑动，可嵌套List使用。
         */
        TabContent() {
          DashboardComp({ mType: 'component' })
        }
        .padding({ left: 5, right: 5 })
        .tabBar("组件")

        TabContent() {
          DashboardComp({ mType: 'image_animation' })
        }
        .padding({ left: 5, right: 5 })
        .tabBar("图像/动画")

        TabContent() {
          DashboardComp({ mType: 'arkts_base' })
        }
        .padding({ left: 5, right: 5 })
        .tabBar("ArkTs基础")

        TabContent() {
          DashboardComp({ mType: 'data_manager' })
        }
        .padding({ left: 5, right: 5 })
        .tabBar("数据管理")

        TabContent() {
          DashboardComp({ mType: 'practice' })
        }
        .padding({ left: 5, right: 5 })
        .tabBar("实践")
      }
      .barMode(BarMode.Scrollable)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.login_page_background'))
  }
}