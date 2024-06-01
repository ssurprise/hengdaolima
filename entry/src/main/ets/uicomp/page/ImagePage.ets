import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'


@Entry
@Component
struct ImagePage {
  @State imageFit: ImageFit = ImageFit.Cover
  @State imageRenderMode: ImageRenderMode = ImageRenderMode.Original
  @State widthValue: number = 0
  @State heightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0

  build() {
    Row() {
      Column() {
        TitleComp({ titleName: 'Image' })

        Image($r("app.media.image_05"))
          .objectFit(this.imageFit)
          .renderMode(this.imageRenderMode)
          .margin({ top: "20vp" })
          .width("200vp")
          .height("200vp")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
          .onComplete(msg => {
            // 通过在Image组件上绑定onComplete事件，图片加载成功后可以获取图片的必要信息。如果图片加载失败，也可以通过绑定onError回调来获得结果。
            if (msg) {
              this.widthValue = msg.width
              this.heightValue = msg.height
              this.componentWidth = msg.componentWidth
              this.componentHeight = msg.componentHeight
            }
          })

        this.renderImageSize()
        this.renderImageComponentSize()
        this.renderObjectFit()
        this.renderRenderMode()
        this.renderTips()
      }
      .width('100%')
    }
  }

  @Builder renderImageSize() {
    Text(`图片宽高: ${this.widthValue} * ${this.heightValue}`)
      .margin({ left: 15, top: 10 })
      .alignSelf(ItemAlign.Start)
      .fontSize(12)
      .fontColor("#212121")
      .fontStyle(FontStyle.Italic)
  }

  @Builder renderImageComponentSize() {
    Text(`组件宽高: ${this.componentWidth} * ${this.componentHeight}`)
      .margin({ left: 15 })
      .alignSelf(ItemAlign.Start)
      .fontSize(12)
      .fontColor("#212121")
      .fontStyle(FontStyle.Italic)
  }

  /**
   * 设置缩放类型
   */
  @Builder renderObjectFit() {
    Text("缩放类型（objectFit属性）:")
      .margin({ left: 16, top: 10 })
      .alignSelf(ItemAlign.Start)
      .fontSize(14)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)

    Row() {
      Button("Contain").onClick(() => {
        this.imageFit = ImageFit.Contain
      })
      Button("Cover").onClick(() => {
        this.imageFit = ImageFit.Cover
      })
      Button("Auto").onClick(() => {
        this.imageFit = ImageFit.Auto
      })
    }.margin({ top: "8vp" })
    .width("100%")
    .height(30)
    .justifyContent(FlexAlign.SpaceEvenly)

    Row() {
      Button("Fill").onClick(() => {
        this.imageFit = ImageFit.Fill
      })
      Button("ScaleDown").onClick(() => {
        this.imageFit = ImageFit.ScaleDown
      })
      Button("None").onClick(() => {
        this.imageFit = ImageFit.None
      })
    }
    .width("100%")
    .height(30)
    .margin({ top: "8vp" })
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  /**
   * 设置渲染模式
   */
  @Builder renderRenderMode() {
    Text("渲染模式（renderMode属性）:")
      .margin({ left: 16, top: 10 })
      .alignSelf(ItemAlign.Start)
      .fontSize(14)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)

    Row() {
      Button("Original").onClick(() => {
        this.imageRenderMode = ImageRenderMode.Original
      })
      Button("Template").onClick(() => {
        this.imageRenderMode = ImageRenderMode.Template
      })
    }
    .width("100%")
    .height(30)
    .margin({ top: "8vp" })
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '没有子组件',
      'overlay属性配置的内容可显示在组件之外，不受组件的宽高影响'
    ] })
  }
}