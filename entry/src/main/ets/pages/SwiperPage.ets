import { TitleComp } from '../view/TitleComp'


@Entry
@Component
struct SwiperPage {
  @State isLoop: boolean = false
  @State autoPlay: boolean = false
  @State interval: number = 3000
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      TitleComp({ titleName: 'Swiper' })
      Swiper(this.swiperController) {
        Text("0")
          .width('60%')
          .height('180vp')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)

        Text("1")
          .width('90%')
          .height('200vp')
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .fontSize(30)

        Text("2")
          .width('70%')
          .height('150vp')
          .backgroundColor(Color.Blue)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .margin({ left: 9, top: 30, right: 9 })
      .borderWidth("1vp")
      .borderStyle(BorderStyle.Dashed)
      .borderColor("#212121")
      .loop(this.isLoop)
      .autoPlay(this.autoPlay)
      .interval(this.interval)

      Row() {
        Button("上一页").onClick(() => {
          this.swiperController.showPrevious()
        })
        Button("下一页").onClick(() => {
          this.swiperController.showNext()
        })
      }
      .width('100%')
      .margin({ top: 3 })
      .justifyContent(FlexAlign.SpaceEvenly)

      Text('设置：')
        .textAlign(TextAlign.Start)
        .fontSize("14fp")
        .fontWeight(FontWeight.Medium)
        .margin({ left: "9vp", top: "16vp" })
        .fontColor("#212121")

      Row() {
        Text('循环:').fontSize(12)
        Radio({ value: 'loop_yes', group: 'loopGroup' })
          .margin({ left: 10 })
          .checked(this.isLoop)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.isLoop = true
            }
          })
        Text('是')
          .fontSize(12)
          .margin({ left: 3 })

        Radio({ value: 'loop_no', group: 'loopGroup' })
          .margin({ left: 10 })
          .checked(!this.isLoop)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.isLoop = false
            }
          })
        Text('否')
          .fontSize(12)
          .margin({ left: 3 })
      }.margin({ left: "9vp" })

      Row() {
        Text('自动轮播:').fontSize(12)
        Radio({ value: 'autoPlay_yes', group: 'autoPlayGroup' })
          .margin({ left: 10 })
          .checked(this.autoPlay)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.autoPlay = true
            }
          })
        Text('是')
          .fontSize(12)
          .margin({ left: 3 })
        Radio({ value: 'autoPlay_no', group: 'autoPlayGroup' })
          .margin({ left: 10 })
          .checked(!this.autoPlay)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.autoPlay = false
            }
          })
        Text('否')
          .fontSize(12)
          .margin({ left: 3 })
      }
      .margin({ left: "9vp" })

      Text('说明：')
        .fontSize(14)
        .margin({ top: 50, left: 10, right: 10 })
        .fontStyle(FontStyle.Normal)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)
      Text('1. autoPlay完全生效需要loop为true，否则在滑到到最后一个时，不会再切换到第一个')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
      Text('2. 官方：如果开发者对Swiper组件设置了固定的尺寸，则在轮播显示过程中均以该尺寸生效；否则，在轮播过程中，会根据子组件的大小自动调整自身的尺寸。 ' +
      '疑问：上面的示例中Swiper并没有设置高度，但是对每个子view设置了不同高度，但是通过观察，发现Swiper的高度并没有随着子view的变化而改变自己的高度，可以通过背景颜色和边框对比。' +
      '边框是设置给Swiper的，颜色是设置给子View的。')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}