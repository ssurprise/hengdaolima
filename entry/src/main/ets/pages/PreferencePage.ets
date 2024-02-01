import { TitleComp } from '../view/TitleComp';
import dataPreferences from '@ohos.data.preferences';


@Entry
@Component
struct PreferencePage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: '首选项' })

      Row() {
        Text("首页显示历史")

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 16, right: 16 })
      .height(40)
    }
    .alignItems(HorizontalAlign.Start)
    .height('100%')
    .width('100%')
  }

  onPageShow() {

  }
}