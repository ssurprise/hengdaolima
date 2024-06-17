import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import image from '@ohos.multimedia.image';
import effectKit from '@ohos.effectKit';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 19:44
 * @Description： 图像效果
 */
@Entry
@Component
struct EffectKitPage {
  readonly TAG: string = "EffectKitPage"
  @State widthValue: number = 0
  @State heightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0
  @State mainColorTxt: string = ''
  @State mainColor: string = '#00ffffff'
  @State imagePixelMap: image.PixelMap = null
  @State effectPixelMap: image.PixelMap = null
  private sampleRes: Resource = $r("app.media.image_01")

  build() {
    Column() {
      TitleComp({ titleName: '图像效果' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.effectKit 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 10 })

        Image(this.sampleRes)
          .width(180)
          .height(150)
          .margin({ top: "20vp" })
          .alignSelf(ItemAlign.Center)
          .objectFit(ImageFit.Contain)
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
        this.renderMainColor()
        this.renderEffect()
        this.renderTips()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 15, right: 15 })
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  onPageShow() {
    getContext(this).resourceManager.getMediaContent(this.sampleRes)
      .then((array) => {
        let options = {
          alphaType: 0, // 透明度
          editable: false, // 是否可编辑
          pixelFormat: 3, // 像素格式
        }
        image.createImageSource(array.buffer)
          .createPixelMap(options)
          .then((pixelMap) => {
            this.imagePixelMap = pixelMap
            effectKit.createColorPicker(pixelMap)
              .then((colorPicker) => {
                colorPicker.getMainColor()
                  .then((color) => {
                    this.mainColor = `#${color.alpha.toString(16)}${color.red.toString(16)}${color.green.toString(16)}${color.blue.toString(16)}`
                    this.mainColorTxt = this.mainColor
                  }).catch((err) => {
                  console.error(this.TAG, `获取主色失败. err=${err}`);
                })
              })
              .catch((err) => {
                console.error(this.TAG, `创建ColorPicker失败. err==${err}`);
              })
          })
          .catch((error) => {
            console.error(this.TAG, `创建PixelMap失败, =${error}`)
          })
      })
      .catch((error) => {
        console.error(this.TAG, "获取图片资源失败, err=" + error)
      })
  }

  @Builder renderImageSize() {
    Text(`图片宽高：${this.widthValue} * ${this.heightValue}   组件宽高：${this.componentWidth} * ${this.componentHeight}`)
      .margin({ top: 5 })
      .alignSelf(ItemAlign.Center)
      .fontSize(10)
      .fontColor("#212121")
      .fontStyle(FontStyle.Italic)
  }

  @Builder renderMainColor() {
    Row() {
      Text('图片主色：')
        .fontColor('#212121')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
      Text(this.mainColorTxt)
        .height(22)
        .margin({ left: 5 })
        .padding({ left: 5, right: 5 })
        .textAlign(TextAlign.Center)
        .fontSize(10)
        .fontColor('#212121')
        .backgroundColor(this.mainColor)
    }
    .alignItems(VerticalAlign.Center)
    .margin({ top: 20 })
  }

  @Builder renderEffect() {
    Row() {
      Button('模糊效果')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          if (this.imagePixelMap != null) {
            let headFilter = effectKit.createEffect(this.imagePixelMap);
            if (headFilter != null) {
              this.effectPixelMap = headFilter.blur(5).getPixelMap()
            }
          }
        })
      Button('高亮效果')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          if (this.imagePixelMap != null) {
            let headFilter = effectKit.createEffect(this.imagePixelMap);
            if (headFilter != null) {
              this.effectPixelMap = headFilter.brightness(0.5).getPixelMap()
            }
          }
        })
      Button('灰度效果')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          if (this.imagePixelMap != null) {
            let headFilter = effectKit.createEffect(this.imagePixelMap);
            if (headFilter != null) {
              this.effectPixelMap = headFilter.grayscale().getPixelMap()
            }
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)

    if (this.effectPixelMap != null) {
      Image(this.effectPixelMap)
        .width(180)
        .height(150)
        .margin({ top: 10 })
        .alignSelf(ItemAlign.Center)
        .objectFit(ImageFit.Contain)
        .borderWidth("1vp")
        .borderStyle(BorderStyle.Dashed)
        .borderColor("#212121")
    }
  }

  @Builder renderTips() {
    TipsComp({ marginSpace: 0,
      tipArray: [
        '关于获取主色，感觉有点迷。例如，一张图片蓝色挺多的，但是返回的主色确实其他颜色。',
        '模糊效果：radius-模糊半径，单位是像素。模糊效果与所设置的值成正比，值越大效果越明显。',
        '高亮效果：bright-高亮程度，取值范围在0-1之间，取值为0时图像保持不变。']
    })
  }
}