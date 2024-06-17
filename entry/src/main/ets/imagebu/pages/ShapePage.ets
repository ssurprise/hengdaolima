import { TitleComp } from '../../common/view/TitleComp'


@Entry
@Component
struct ShapePage {
  build() {
    Column() {
      TitleComp({ titleName: 'Shape图形' })

      Scroll() {
        Column() {
          this.renderCircle()
          this.renderEllipse()
          this.renderPolyline()
          this.renderRect()
        }
        .padding({ left: 15, right: 15 })
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)

    }.width('100%')
  }

  /**
   * 圆
   */
  @Builder renderCircle() {
    Text('圆：Circle组件')
      .fontSize(14)
      .margin({ top: 20 })
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .alignSelf(ItemAlign.Start)

    Row() {
      // 宽高设置不一致时以短边为直径
      Circle({ width: 40, height: 40 })
        .fill('#ff4081')

      Circle()
        .width(40)
        .height(40)
        .strokeWidth(3)
        .fill(Color.Blue)
        .stroke(Color.Red)
        .strokeDashArray([5, 2])
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)

    Text('注意：宽高设置不一致时以短边为直径')
      .fontSize(12)
      .margin({ top: 10 })
      .fontStyle(FontStyle.Italic)
      .fontColor(Color.Gray)
      .alignSelf(ItemAlign.Start)
  }

  /**
   * 椭圆
   */
  @Builder renderEllipse() {
    Text('椭圆：Ellipse组件')
      .fontSize(14)
      .margin({ top: 20 })
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .alignSelf(ItemAlign.Start)

    Row() {
      // 宽高设置不一致时以短边为直径
      Ellipse({ width: 60, height: 40 })
        .fill("#ff4081")

      Ellipse()
        .width(40)
        .height(40)
        .strokeWidth(3)
        .fill(Color.Blue)
        .stroke("#ff4081")
        .strokeDashArray([5, 2, 3, 5, 1])
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)

    Text('注意：宽高一样大小时和圆的表现形式一样')
      .fontSize(12)
      .margin({ top: 10 })
      .fontStyle(FontStyle.Italic)
      .fontColor(Color.Gray)
      .alignSelf(ItemAlign.Start)
  }

  /**
   * 折线
   */
  @Builder renderPolyline() {
    Text('折线：Polyline组件')
      .fontSize(14)
      .margin({ top: 20 })
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .alignSelf(ItemAlign.Start)

    Row() {
      // 宽高设置不一致时以短边为直径
      Polyline({ width: 100, height: 60 })
        .points([[0, 60], [25, 0], [50, 60], [75, 0], [100, 60]])
        .fillOpacity(0)
        .strokeLineJoin(LineJoinStyle.Round) // 设置折线拐角处为圆弧
        .strokeLineCap(LineCapStyle.Round) //设置折线两端为半圆
        .stroke(Color.Blue)
        .strokeWidth(3)

      Polyline({ width: 100, height: 60 })
        .fill("#ff4081")
        .points([[0, 60], [25, 0], [50, 60], [75, 0], [100, 60]])
        .stroke(Color.Blue)
        .strokeWidth(3)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)

    Text('注意：如果没有填充色，需要设置fillOpacity属性为0，否则是黑色的填充色')
      .fontSize(12)
      .margin({ top: 10 })
      .fontStyle(FontStyle.Italic)
      .fontColor(Color.Gray)
      .alignSelf(ItemAlign.Start)
  }

  /**
   * 矩形
   */
  @Builder renderRect() {
    Text('矩形：Rect组件')
      .fontSize(14)
      .margin({ top: 20 })
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .alignSelf(ItemAlign.Start)

    Row() {
      // 宽高设置不一致时以短边为直径
      Rect({ width: 60, height: 60 })
        .radius([[10, 5], [5, 10], [12, 5], [10, 8]])
        .fill('#ff4081')
        .strokeWidth(2)
        .stroke('#212121')

      Rect({ width: 80, height: 60 })
        .radius([[10, 5], [5, 10], [12, 5], [10, 8]])
        .fill('#ff4081')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)

    Text('注意：如果没有填充色，需要设置fillOpacity属性为0，否则是黑色的填充色')
      .fontSize(12)
      .margin({ top: 10 })
      .fontStyle(FontStyle.Italic)
      .fontColor(Color.Gray)
      .alignSelf(ItemAlign.Start)
  }
}