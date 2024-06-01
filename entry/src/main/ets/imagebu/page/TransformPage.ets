import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';

@Entry
@Component
struct TransformPage {
  @State mAngle: number = 0;
  @State mTranslateX: number = 0;
  @State mTranslateY: number = 0;
  @State mScaleX: number = 1;
  @State mScaleY: number = 1;

  build() {
    Column() {
      TitleComp({ titleName: '图形变换' })

      Column() {
        Text('注：该页面主要介绍的是对 \'组件\' 进行的旋转、平移、缩放、矩阵变换等操作。')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderExample()
        this.renderController()
        this.renderTips()
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')

    }
    .width('100%')
    .height('100%')
  }

  @Builder renderExample() {
    Row() {
      Text('我是文本')
        .fontColor('#212121')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .padding(5)
        .backgroundColor('#ff4081')

      Image($r('app.media.ic_launcher'))
        .width(50)
        .height(50)
        .overlay('我是Image', { align: Alignment.BottomStart, offset: { x: 0 } })
    }
    .overlay('我是Row', { align: Alignment.BottomStart, offset: { x: 0 } })
    .width(150)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Center)
    .backgroundColor('#ffffffff')
    .margin({ top: 40 })
    .borderRadius(8)
    .rotate({
      x: 0,
      y: 0,
      z: 1,
      centerX: '50%',
      centerY: '50%',
      angle: this.mAngle
    })
    .translate({ x: this.mTranslateX, y: this.mTranslateY })
    .scale({
      x: this.mScaleX,
      y: this.mScaleY,
      z: 1,
      centerX: '50%',
      centerY: '50%'
    })
  }

  @Builder renderController() {
    // 旋转
    Text('旋转角度')
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 40 })
    Text('注：此处案例的旋转轴为Z轴，旋转中心点为组件的中心点')
      .fontColor('#ff4081')
      .fontSize(12)

    Row() {
      Text('0')
        .width(30)
        .fontColor('#212121')
        .fontSize(12)

      Slider({
        min: 0,
        max: 359,
        step: 1,
        style: SliderStyle.InSet,
        direction: Axis.Horizontal
      })
        .height(12)
        .layoutWeight(1)
        .margin({ top: 5 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.mAngle = value
        })

      Text('360°')
        .width(30)
        .fontColor('#212121')
        .fontSize(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)

    // 平移
    Text('X轴平移')
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Row() {
      Text('-100')
        .width(30)
        .fontColor('#212121')
        .fontSize(12)

      Slider({
        min: -100,
        max: 100,
        step: 1,
        style: SliderStyle.InSet,
        direction: Axis.Horizontal
      })
        .height(12)
        .layoutWeight(1)
        .margin({ top: 5 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.mTranslateX = value
        })

      Text('100')
        .width(30)
        .textAlign(TextAlign.End)
        .fontColor('#212121')
        .fontSize(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)

    Text('Y轴平移')
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 10 })

    Row() {
      Text('-50')
        .width(30)
        .fontColor('#212121')
        .fontSize(12)

      Slider({
        min: -50,
        max: 50,
        step: 1,
        style: SliderStyle.InSet,
        direction: Axis.Horizontal
      })
        .height(12)
        .layoutWeight(1)
        .margin({ top: 5 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.mTranslateY = value
        })

      Text('50')
        .width(30)
        .textAlign(TextAlign.End)
        .fontColor('#212121')
        .fontSize(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)

    this.renderScaleController()
  }

  @Builder renderScaleController(){
    Text('Y轴平移')
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 10 })

    Row() {
      Text('-50')
        .width(30)
        .fontColor('#212121')
        .fontSize(12)

      Slider({
        min: -50,
        max: 50,
        step: 1,
        style: SliderStyle.InSet,
        direction: Axis.Horizontal
      })
        .height(12)
        .layoutWeight(1)
        .margin({ top: 5 })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.mTranslateY = value
        })

      Text('50')
        .width(30)
        .textAlign(TextAlign.End)
        .fontColor('#212121')
        .fontSize(12)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder renderTips() {
    TipsComp({
      marginSpace: 0,
      tipArray: [
        '在 rotate 属性中的，旋转轴和旋转中心点都基于坐标系设定，组件发生位移时，坐标系不会随之移动。',
        'transform：设置当前组件的变换矩阵。当前示例暂无介绍！',
      ]
    }).margin({ top: 30 })
  }
}