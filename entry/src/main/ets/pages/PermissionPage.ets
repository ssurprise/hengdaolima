import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/3/8 11:02
 * @Description： 权限访问
 */
@Entry
@Component
struct PermissionPage {
  @State result: string = ''

  build() {
    Column() {
      TitleComp({ titleName: '权限管理' })

      Column() {
        Text('注：该页面主要介绍的是 @ohos.abilityAccessCtrl 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        Text(this.result)
          .width('100%')
          .height(60)
          .padding(10)
          .fontSize(14)
          .backgroundColor('#bdbdbd')
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
      .margin({ top: 15 })
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }
}