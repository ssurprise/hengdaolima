import { TitleComp } from '../view/TitleComp'


@Entry
@Component
struct CanvasPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private img: ImageBitmap = new ImageBitmap("../resources/base/media/image_08.jpg")
  @State imageWidthValue: number = 0
  @State imageHeightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0

  build() {
    Column() {
      TitleComp({ titleName: 'Canvas-绘图' })

      this.renderOriginImage()
      this.renderCanvas()
      this.renderTips()
    }
    .width('100%')
  }

  @Builder renderOriginImage() {
    Text('原图')
      .fontColor("#212121")
      .fontSize(12)
      .alignSelf(ItemAlign.Start)
      .margin({ left: 15, top: 12 })

    Image($r("app.media.image_08"))
      .width(200)
      .height(200)
      .borderWidth("1vp")
      .objectFit(ImageFit.Contain)
      .borderStyle(BorderStyle.Dashed)
      .borderColor("#212121")
      .onComplete(msg => {
        // 通过在Image组件上绑定onComplete事件，图片加载成功后可以获取图片的必要信息。如果图片加载失败，也可以通过绑定onError回调来获得结果。
        if (msg) {
          this.imageWidthValue = msg.width
          this.imageHeightValue = msg.height
          this.componentWidth = msg.componentWidth
          this.componentHeight = msg.componentHeight
        }
      })
    Text(`组件宽高：${this.componentWidth}*${this.componentHeight}  图片宽高：${this.imageWidthValue}*${this.imageHeightValue}`)
      .fontStyle(FontStyle.Italic)
      .fontSize(12)
      .fontColor("#757575")
  }

  @Builder renderCanvas() {
    Text('裁减')
      .fontColor("#212121")
      .fontSize(12)
      .margin({ left: 15, top: 10 })
      .alignSelf(ItemAlign.Start)

    Canvas(this.context)
      .width('200vp')
      .height(200)
      .backgroundColor('#22ff4081')
      .alignSelf(ItemAlign.Center)
      .onReady(() => {
        /*
        *在画布上绘制图像
        *@param image 绘制到画布上的图片对象。
        *@param sx 裁切源图像时距离源图像左上角的x坐标值。
        *@param sy 裁切源图像时距离源图像左上角的y坐标值。
        *@param sw 裁切源图像时需要裁切的宽度。
        *@param sh 裁切源图像时需要裁切的高度。
        *@param dx 绘制区域左上角在x轴的位置。 单位：vp
        *@param dy 绘制区域左上角在y轴的位置。 单位：vp
        *@param dw 绘制区域的宽度。当绘制区域的宽度和裁剪图像的宽度不一致时，将图像宽度拉伸或压缩为绘制区域的宽度。单位：vp
        *@param dh 绘制区域的高度。当绘制区域的高度和裁剪图像的高度不一致时，将图像高度拉伸或压缩为绘制区域的高度。单位：vp
         */
        console.debug('CanvasPage', `Canvas.onReady, height=${this.context.height} width=${this.context.width}}`)
        this.context.drawImage(this.img, 0, 0, 65, 37, 0, 0, 100, 100)
      })
  }

  @Builder renderTips() {
    Text('说明：')
      .fontSize(14)
      .margin({ top: 40, left: 9, right: 9 })
      .fontStyle(FontStyle.Normal)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
      .alignSelf(ItemAlign.Start)

    Text('1. Canvas组件初始化完成时的事件回调onReady，该事件之后Canvas组件宽高确定且可获取，可使用Canvas相关API进行绘制')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
      .alignSelf(ItemAlign.Start)
    Text('2. drawImage 方法中的参数单位都是vp，不论是宽高还是锚点的单位都是vp。即使图片源获取到的图片宽高单位为px，在 drawImage 方法中也需要切换成对应的vp。')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
      .alignSelf(ItemAlign.Start)
  }
}