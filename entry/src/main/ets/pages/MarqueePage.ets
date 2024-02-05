import { TitleComp } from '../view/TitleComp';

@Entry
@Component
struct MarqueePage {
  private src: string = "相见时难别亦难，东风无力百花残。春蚕到死丝方尽，蜡炬成灰泪始干。晓镜但愁云鬓改，夜吟应觉月光寒。蓬山此去无多路，青鸟殷勤为探看。"
  readonly START_DEFAULT_VAL = true
  readonly FROM_START_DEFAULT_VAL = true
  readonly FomStart_DEFAULT_VAL = true
  @State mStart: boolean = this.START_DEFAULT_VAL
  @State mFomStart: boolean = this.FROM_START_DEFAULT_VAL
  @State mStep: number = 6
  @State mLoop: number = -1

  build() {
    Column() {

      TitleComp({ titleName: "跑马灯-Marquee" })

      Marquee({
        start: this.mStart,
        step: this.mStep,
        loop: this.mLoop,
        fromStart: this.mFomStart,
        src: this.src
      })
        .borderStyle(BorderStyle.Dashed)
        .borderWidth(1)
        .borderColor("#212121")
        .width('60%')
        .fontSize(16)
        .fontColor("#212121")
        .alignSelf(ItemAlign.Center)
        .margin({ top: 30 })

      this.renderController()
      this.renderTips()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }

  @Builder renderController() {
    Text('属性设置：')
      .fontSize(14)
      .margin({ top: 30, left: 10, right: 10 })
      .fontStyle(FontStyle.Normal)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)

    // 设置播放状态
    Row() {
      Text("是否进入播放状态")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
      Toggle({ type: ToggleType.Switch, isOn: this.START_DEFAULT_VAL })
        .onChange((isOn) => {
          this.mStart = isOn
        })
    }
    .width('90%')
    .height(40)
    .margin({ top: 8, left: 15, right: 15 })
    .padding({ left: 10, right: 10 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#f5f5f5")
    .borderRadius(12)

    //设置文本从头开始滚动或反向滚动。
    Row() {
      Text("从头开始滚动")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
      Toggle({ type: ToggleType.Switch, isOn: this.FROM_START_DEFAULT_VAL })
        .onChange((isOn) => {
          this.mFomStart = isOn
        })
    }
    .width('90%')
    .height(40)
    .margin({ top: 8, left: 15, right: 15 })
    .padding({ left: 10, right: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(0)
    .backgroundColor("#f5f5f5")

    //设置滚动步长
    Row() {
      Text("滚动动画文本滚动步长")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)

      TextInput({ text: '6' })
        .type(InputType.Number)
        .style(TextInputStyle.Default)
        .width('15%')
        .height(35)
        .backgroundColor(Color.Transparent)
        .borderColor('#212121')
        .borderRadius(0)
        .borderWidth({ bottom: 1 })
        .textAlign(TextAlign.Center)
        .onChange((value) => {
          this.mStep = Number.parseInt(value)
        })
    }
    .width('90%')
    .height(40)
    .margin({ top: 8, left: 15, right: 15 })
    .padding({ left: 10, right: 10 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#f5f5f5")
    .borderRadius(12)

    //设置重复滚动的次数
    Row() {
      Text("设置重复滚动的次数")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)

      TextInput({ text: '-1' })
        .type(InputType.PhoneNumber)
        .style(TextInputStyle.Default)
        .width('15%')
        .height(35)
        .backgroundColor(Color.Transparent)
        .borderColor('#212121')
        .borderRadius(0)
        .borderWidth({ bottom: 1 })
        .textAlign(TextAlign.Center)
        .onChange((value) => {
          this.mLoop = Number.parseInt(value)
        })
    }
    .width('90%')
    .height(40)
    .margin({ top: 8, left: 15, right: 15 })
    .padding({ left: 10, right: 10 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#f5f5f5")
    .borderRadius(12)

    Text('小于等于零时无限循环')
      .fontColor("#757575")
      .fontSize(10)
      .fontStyle(FontStyle.Italic)
      .margin({ left: 20 })
  }

  @Builder renderTips() {
    Text('说明：')
      .fontSize(14)
      .margin({ top: 50, left: 12, right: 10 })
      .fontStyle(FontStyle.Normal)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
    Text('1. start属性提示：有限的滚动次数播放完毕后，不可以通过改变start重置滚动次数重新开始播放。')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
    Text('2. lop属性提示：ArkTS卡片上该参数设置任意值都仅在可见时滚动一次')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
  }
}