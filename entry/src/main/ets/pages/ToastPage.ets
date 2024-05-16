import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ToastPage {
  private duration: number = 2000
  private content: string = ''

  build() {
    Column() {
      TitleComp({ titleName: 'Toast' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.promptAction 模块提供的显示Toast的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderToastConfig()

        TipsComp({ marginSpace: 0,
          tipArray: [
            '样式无法修改，像字体、字号之类的同样无法修改，但是可以通过bottom属性来调整距离屏幕底部的距离。',
            'duration属性：默认值1500ms，取值区间：1500ms-10000ms。若小于1500ms则取默认值，若大于10000ms则取上限值10000ms。非必需',
            'bottom属性：设置弹窗边框距离屏幕底部的位置。非必需'
          ]
        })
          .margin({ top: 30 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({ top: 15, left: 15, right: 15 })
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .width('100%')
  }

  @Builder renderToastConfig() {
    Text('文本信息')
      .margin({ top: 20 })
      .fontSize(12)
      .fontColor('#212121')
      .fontWeight(FontWeight.Medium)

    TextInput({ placeholder: '请输入' })
      .width('100%')
      .fontSize(14)
      .placeholderFont({ size: 14 })
      .type(InputType.Normal)
      .margin({ top: 2 })
      .borderRadius(8)
      .onChange((value) => {
        this.content = value
      })

    Text('显示时长')
      .margin({ top: 20 })
      .fontSize(12)
      .fontColor('#212121')
      .fontWeight(FontWeight.Medium)

    Row() {
      TextInput({ placeholder: '请输入' })
        .width('50%')
        .fontSize(14)
        .placeholderFont({ size: 14 })
        .type(InputType.Number)
        .borderRadius(8)
        .onChange((value) => {
          try {
            this.duration = Number.parseInt(value)
          } catch (e) {
          }
        })
      Text('ms')
        .fontSize(16)
        .fontColor('#ff4081')
        .margin({ left: 3 })

      Blank()

      Button("Show")
        .height(30)
        .padding({ left: 20, top: 1, right: 20, bottom: 1 })
        .type(ButtonType.Normal)
        .borderRadius(8)
        .fontSize(14)
        .onClick(() => {
          promptAction.showToast({ message: this.content, duration: this.duration, bottom: 100 })
        })
    }
    .width('100%')
    .margin({ top: 2 })
    .alignItems(VerticalAlign.Center)
  }
}