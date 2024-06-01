import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';

@Entry
@Component
struct TextPage {
  @State example: string = '君不见，黄河之水天上来，奔流到海不复回。君不见，高堂明镜悲白发，朝如青丝暮成雪。人生得意须尽欢，莫使金樽空对月。天生我材必有用，千金散尽还复来。'
  @State mLetterSpacing: number = 0
  @State mLineHeight: number = 0

  build() {
    Column() {
      TitleComp({ titleName: 'Text' })

      Text(this.example)
        .width('70%')
        .height(180)
        .fontColor(Color.Orange)
        .fontSize(14)
        .lineHeight(this.mLineHeight)
        .letterSpacing(this.mLetterSpacing)
        .textAlign(TextAlign.Center)
        .margin({ top: 20 })
        .backgroundColor(0xF1F3F5)

      this.renderLetterSpacing()
      this.renderLineHeight()
      this.renderTextSpan()
      this.renderTips()
    }.width('100%')
  }

  @Builder renderLetterSpacing() {
    Text(`设置字间距：${this.mLetterSpacing}`)
      .margin({ left: 16, top: 16 })
      .alignSelf(ItemAlign.Start)
      .fontSize("14fp")
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
    Slider({ value: this.mLetterSpacing, min: 0, max: 20, step: 1 })
      .width('80%')
      .showTips(true)
      .onChange((value: number, mode: SliderChangeMode) => {
        this.mLetterSpacing = value
      })
  }

  @Builder renderLineHeight() {
    Text(`设置行高：${this.mLineHeight}`)
      .margin({ left: 16, top: 10 })
      .alignSelf(ItemAlign.Start)
      .fontSize("14fp")
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
    Slider({ value: this.mLineHeight, min: 0, max: 30, step: 1 })
      .width('80%')
      .showTips(true)
      .onChange((value: number, mode: SliderChangeMode) => {
        this.mLineHeight = value
      })
  }

  @Builder renderTextSpan() {
    Text(this.example) {
      Span('白日依山尽，')
        .fontSize(12)
        .fontColor(Color.Red)
        .fontStyle(FontStyle.Italic)
      Span('黄河入海流。')
        .fontSize(10)
        .fontColor(Color.Blue)
      Span('欲穷千里目，')
        .height(this.mLineHeight)
        .fontSize(20)
        .fontColor(Color.Green)
        .fontWeight(FontWeight.Bolder)
      Span('更上一层楼。')
        .fontSize(14)
        .fontColor(Color.Black)
    }
    .width('60%')
    .fontColor(Color.Orange)
    .fontSize(20)
    .textAlign(TextAlign.Start)
    .margin({ top: 15 })
    .backgroundColor(0xF1F3F5)
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '可是使用Text组件 + Span组件实现 Android 中 SpannableString 的效果',
      '可以包含Span子组件，在有Span设置的情况下，Text的初始内容无效。如： Text("蓝天"){ Span("白云") } 此时蓝天的本文内容显示不出来。',
      '行高设置值不大于0时，不限制文本行高，自适应字体大小',
      '行高属性和 Span 组件不兼容。也就是说如果Text组件中使用了子组件Span，那么行高的设置属性不会生效。'
    ] })
  }
}