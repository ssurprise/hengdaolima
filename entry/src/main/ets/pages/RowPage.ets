import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'

@Entry
@Component
struct RowPage {
  @State mFlexAlign: FlexAlign = FlexAlign.Start
  @State mVerticalAlign: VerticalAlign = VerticalAlign.Top

  build() {
    Column() {
      TitleComp({ titleName: '线性布局-Row' })

      Row() {
        Text("aaaa")
          .width('20%')
          .height(30)
          .textAlign(TextAlign.Center)
          .backgroundColor(0xF5DEB3)
        Text("bbb")
          .width('20%')
          .height(30)
          .textAlign(TextAlign.Center)
          .backgroundColor(0xD2B48C)
        Text("ccc")
          .width('20%')
          .height(30)
          .textAlign(TextAlign.Center)
          .backgroundColor(0xF5D131)
      }
      .width('90%')
      .height(60)
      .margin({ top: 20 })
      .alignSelf(ItemAlign.Center)
      .backgroundColor(0xAFEEEE)
      .alignItems(this.mVerticalAlign)
      .justifyContent(this.mFlexAlign)

      this.renderJustContent()
      this.renderVerticalAlign()
      this.renderAutoAdapt()
      this.renderTips()
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * 渲染主轴对其方式属性（justifyContent）控制
   */
  @Builder renderJustContent() {
    Text('主轴对齐方式(justifyContent):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 30, left: 16 })
    Row() {
      Row() {
        Radio({ value: "Start", group: "FlexAlign" })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.Start
            }
          })
        Text('Start').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "Center", group: "FlexAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.Center
            }
          })
        Text('Center').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "End", group: "FlexAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.End
            }
          })
        Text('End').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 14 })

    Row() {
      Row() {
        Radio({ value: "SpaceBetween", group: "FlexAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceBetween
            }
          })
        Text('SpaceBetween').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "SpaceAround", group: "FlexAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceAround
            }
          })
        Text('SpaceAround').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "SpaceEvenly", group: "FlexAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceEvenly
            }
          })
        Text('SpaceEvenly').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 14 })
  }

  /**
   * 渲染交叉轴对其方式属性控制
   */
  @Builder renderVerticalAlign() {
    Text('交叉轴对齐方式(alignItems):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 5, left: 16 })
    Row() {
      Row() {
        Radio({ value: "Top", group: "ItemAlign" })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mVerticalAlign = VerticalAlign.Top
            }
          })
        Text('Top').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "Center", group: "ItemAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mVerticalAlign = VerticalAlign.Center
            }
          })
        Text('Center').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)

      Row() {
        Radio({ value: "Bottom", group: "ItemAlign" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mVerticalAlign = VerticalAlign.Bottom
            }
          })
        Text('Bottom').fontSize(12).fontStyle(FontStyle.Italic)
      }.layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 14 })
  }

  @Builder renderAutoAdapt() {
    Text("blank组件实现自适应拉伸").fontSize("12vp").margin({ top: '15vp' })
    Row() {
      Text("aaaa")
        .height("100%")
        .borderWidth("1vp")
        .borderStyle(BorderStyle.Dashed)
        .borderColor("#212121")
      Blank()
      Text("bbb")
        .height("100%")
        .borderWidth("1vp")
        .borderStyle(BorderStyle.Dashed)
        .borderColor("#212121")
      Text("ccc")
        .height("100%")
        .borderWidth("1vp")
        .borderStyle(BorderStyle.Dashed)
        .borderColor("#212121")
    }
    .width('100%')
    .height("40vp")
    .backgroundColor("#f5f5f5")

  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      'FlexAlign.SpaceAround：水平方向方向均匀分配元素，相邻元素之间距离相同。第一个元素到行首的距离和最后一个元素到行尾的距离是相邻元素之间距离的一半。',
      'FlexAlign.SpaceEvenly：水平方向方向均匀分配元素，相邻元素之间的距离、第一个元素与行首的间距、最后一个元素到行尾的间距都完全一样。',
      '使用Blank组件也可以实现SpaceBetween的效果'
    ] })
  }
}