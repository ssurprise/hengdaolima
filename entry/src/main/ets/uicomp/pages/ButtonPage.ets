import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'

@Entry
@Component
struct ButtonPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: 'Button' })

      Column() {
        this.renderNormalType()
        this.renderCapsuleType()
        this.renderCircleType()

        Button() {
          Row() {
            Text('哎嘿？')
            Image($r('app.media.image_05'))
              .objectFit(ImageFit.Contain)
          }
        }
        .type(ButtonType.Normal)
        .width(120)
        .height(60)
        .margin({top:20})
        .borderStyle(BorderStyle.Dashed)
        .borderWidth(2)
        .borderColor('#212121')

        TipsComp({
          marginSpace: 0,
          tipArray: [
            'Button组件是可以包含单个子组件的',
            '按钮圆角通过通用属性borderRadius设置（不支持通过border接口设置圆角），且只支持设置一个相同的圆角。',
            '当按钮类型为Capsule时，borderRadius设置不生效，按钮圆角始终为宽、高中较小值的一半。',
            '当按钮类型为Circle时，borderRadius即为按钮半径，若未设置borderRadius按钮半径则为宽、高中较小值的一半。'
          ] })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 15, top: 20, right: 15 })
    }
    .height('100%')
    .height('100%')
  }

  @Builder renderNormalType() {
    Text('Normal Button')
      .fontSize(14)
      .fontColor(0x212121)

    Row() {
      Button('OK', { type: ButtonType.Normal, stateEffect: true })
        .width(90)
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .onClick(() => {
          console.log('ButtonType.Normal')
        })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row() {
          LoadingProgress().width(20).height(20).margin({ left: 12 }).color(0xFFFFFF)
          Text('loading').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 12 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(90)
      .height(40)
      .margin({ left: 30 })
      .borderRadius(8)
      .backgroundColor(0x317aff)
    }
    .width('100%')
    .margin({ top: 3 })
  }

  @Builder renderCapsuleType() {
    Text('Capsule Button').fontSize(14).fontColor(0x212121).margin({ top: 20 })

    Row() {
      Button('胶囊样式', { type: ButtonType.Capsule, stateEffect: true })
        .width(90)
        .backgroundColor(0x317aff)

      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Row() {
          LoadingProgress().width(20).height(20).margin({ left: 12 }).color(0xFFFFFF)
          Text('loading').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 12 })
        }
        .width(90)
        .height(40)
        .alignItems(VerticalAlign.Center)
      }
      .margin({ left: 30 })
      .backgroundColor(0x317aff)
    }
    .width('100%')
    .margin({ top: 3 })
  }

  @Builder renderCircleType() {
    Text('Circle button')
      .fontSize(12)
      .fontColor(0x212121)
      .margin({ top: 20 })

    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        LoadingProgress().width(20).height(20).color(0xFFFFFF)
      }.width(55).height(55).backgroundColor(0x317aff)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        LoadingProgress().width(20).height(20).color(0xFFFFFF)
      }.width(55).height(55).margin({ left: 20 }).backgroundColor(0xF55A42)
    }
    .width('100%')
    .margin({ top: 10 })
  }
}