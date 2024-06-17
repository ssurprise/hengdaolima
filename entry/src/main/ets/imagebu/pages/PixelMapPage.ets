import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import image from '@ohos.multimedia.image';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 19:44
 * @Description： 图像处理：裁减、缩放、翻转、旋转、偏移等操作
 */
@Entry
@Component
struct PixelMapPage {
  readonly TAG: string = "PixelMapPage"
  @State samplePicSize: string = ' '
  @State actionTip: string = ''
  @State testPicSize: string = ' '
  @State testPixelMap: image.PixelMap = null
  private sampleRes: Resource = $r("app.media.image_01")

  async getPixelMap(): Promise<image.PixelMap> {
    let mediaCount = await getContext(this).resourceManager.getMediaContent(this.sampleRes)
    let options = {
      alphaType: 0, // 透明度
      editable: true, // 是否可编辑
      pixelFormat: 3, // 像素格式
    }
    return image.createImageSource(mediaCount.buffer).createPixelMap(options)
  }

  build() {
    Column() {
      TitleComp({ titleName: '图片处理' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.multimedia.image 模块提供的功能，包括通过属性创建PixelMap、读取图像像素数据、读取区域内的图片数据等。' +
        '图片处理指对PixelMap进行相关的操作，如获取图片信息、裁剪、缩放、偏移、旋转、翻转、设置透明度、读写像素数据等。')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 10 })

        this.renderRoom()
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

  @Builder renderRoom() {
    Row() {
      Column() {
        Text('对照组')
          .margin({ top: 2 })
          .fontSize(14)
          .fontColor('#212121')
        Image(this.sampleRes)
          .width('100%')
          .height(150)
          .objectFit(ImageFit.Contain)
          .borderWidth(1)
          .borderStyle(BorderStyle.Solid)
          .borderColor("#212121")
          .onComplete(msg => {
            // 通过在Image组件上绑定onComplete事件，图片加载成功后可以获取图片的必要信息。如果图片加载失败，也可以通过绑定onError回调来获得结果。
            if (msg) {
              this.samplePicSize = `图片宽高：${msg.width} * ${msg.height}`
            }
          })
        Text(this.samplePicSize)
          .margin({ top: 1 })
          .fontSize(12)
          .fontColor('#212121')
      }
      .width('45%')
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text('实验组')
          .margin({ top: 2 })
          .fontSize(14)
          .fontColor('#212121')
        Image(this.testPixelMap)
          .width('100%')
          .height(150)
          .objectFit(ImageFit.Contain)
          .borderWidth(1)
          .borderStyle(BorderStyle.Solid)
          .borderColor("#212121")
          .onComplete(msg => {
            // 通过在Image组件上绑定onComplete事件，图片加载成功后可以获取图片的必要信息。如果图片加载失败，也可以通过绑定onError回调来获得结果。
            if (msg) {
              this.testPicSize = `图片宽高：${msg.width} * ${msg.height}`
            }
          })
        Text(this.testPicSize)
          .margin({ top: 1 })
          .fontSize(12)
          .fontColor('#212121')
      }
      .width('45%')
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .margin({ top: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder renderEffect() {
    Row() {
      Button('裁减')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            // x: 裁剪起始点横坐标
            // y: 裁剪起始点纵坐标
            // width: 裁剪宽度，方向为从左到右，即，裁剪后的图片宽度
            // height: 裁剪高度，方向为从上往下，即，裁剪后的图片高度
            pixelMap.crop({ x: 100, y: 50, size: { height: 100, width: 300 } })
              .then(() => {
                this.testPixelMap = pixelMap
                this.actionTip = '裁剪起始点横坐标：100，纵坐标：50。裁减高度：100，宽度：300'
              })
          }).catch(() => {
          })
        })
      Button('缩放')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.scale(0.5, 2).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = '横坐标缩放比例：0.5，纵坐标缩放比例：2'
            })
          }).catch(() => {
          })
        })
      Button('偏移')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.translate(200, -100).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = '横坐标移动距离：200，纵坐标移动距离：-100。 注意观察实验组图片的宽高变化哦~'
            });
          }).catch(() => {
          })
        })
      Button('旋转')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.rotate(90).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = '顺时针旋转90°'
            });
          }).catch(() => {
          })
        })
    }
    .width('100%')
    .margin({ top: 15 })
    .justifyContent(FlexAlign.SpaceBetween)

    Row() {
      Button('垂直翻转')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.flip(false, true).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = ''
            });
          }).catch(() => {
          })
        })
      Button('水平翻转')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.flip(true, false).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = ''
            });
          }).catch(() => {
          })
        })
      Button('透明度')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.getPixelMap().then((pixelMap) => {
            pixelMap.opacity(0.2).then(() => {
              this.testPixelMap = pixelMap
              this.actionTip = '透明度：0.2'
            });
          }).catch(() => {
          })
        })
    }
    .width('100%')
    .margin({ top: 5 })
    .justifyContent(FlexAlign.SpaceBetween)

    if (this.actionTip != null && this.actionTip.length > 0) {
      Text(this.actionTip)
        .width('100%')
        .fontSize(10)
        .fontColor('#212121')
        .padding({ left: 10, top: 5, right: 10, bottom: 5 })
        .margin({ top: 8 })
        .borderRadius(5)
        .backgroundColor('#22ff4081')
    }
  }

  @Builder renderTips() {
    TipsComp({ marginSpace: 0,
      tipArray: [
        'demo中所有的变换操作都是重新从原图获取新的PixelMap进行操作的，不是对变换后的数据进行变换。',
        '注意观察变换操作后图片大小的变化！！！',
        'PixelMap 的一系列操作都是异步的',
        '开发步骤：①.通过context 获取到 resourceManager 对象，然后再获取本地media下的图片资源；②.使用ArrayBuffer创建ImageSource实例；③.设置解码参数DecodingOptions，解码获取PixelMap图片对象.'
      ]
    })
  }
}