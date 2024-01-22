import { TitleComp } from '../view/TitleComp';
import promptAction from '@ohos.promptAction';


@Entry
@Component
struct RadioPage {
  build() {
    Column() {
      TitleComp('单选框-Radio')
      Row() {
        Column() {
          Radio({ value: 'Radio1', group: 'radioGroup' })
            .borderWidth("1vp")
            .borderStyle(BorderStyle.Dashed)
            .borderColor("#212121")
            .checked(false)
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                // 切换为响铃模式
                promptAction.showToast({ message: 'Ringing mode.' })
              }
            })
          Text('Ringing')
        }

        Column() {
          Radio({ value: 'Radio2', group: 'radioGroup' })
            .borderWidth("1vp")
            .borderStyle(BorderStyle.Dashed)
            .borderColor("#212121")
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                // 切换为振动模式
                promptAction.showToast({ message: 'Vibration mode.' })
              }
            })
          Text('Vibration')
        }

        Column() {
          Radio({ value: 'Radio3', group: 'radioGroup' })
            .borderWidth("1vp")
            .borderStyle(BorderStyle.Dashed)
            .borderColor("#212121")
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                // 切换为静音模式
                promptAction.showToast({ message: 'Silent mode.' })
              }
            })
          Text('Silent')
        }
      }
      .width('100%')
      .margin({ top: 50 })
      .justifyContent(FlexAlign.SpaceAround)

      Text('注意：')
        .fontSize(14)
        .margin({ top: 50, left: 10, right: 10 })
        .fontStyle(FontStyle.Normal)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)
      Text('1. Radio 仅支持选中和未选中两种样式，不支持自定义颜色和形状')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
      Text('2. Radio 没有固定的父控件，允许在不同的父组件中进行关联，只要关联的group是同一个即可。如上图，三个Radio 分属三个不同的Row布局，但是group 配置的是同一个。')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
      Text('3. Radio 是不带文本提示的，Radio控件中的value 并不是文本的显示内容，上面的文本是我自己添加的Text控件。Radio的实际大小即为虚线边框所表示的范围')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}