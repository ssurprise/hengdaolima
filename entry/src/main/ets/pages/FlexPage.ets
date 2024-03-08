import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/1 11:15
 * @Description： Flex组件示例
 */
@Entry
@Component
struct FlexPage {
  @State mDirection: FlexDirection = FlexDirection.Row
  @State mFlexWrap: FlexWrap = FlexWrap.NoWrap
  @State mFlexAlign: FlexAlign = FlexAlign.Start
  @State mAlignItem: ItemAlign = ItemAlign.Auto

  build() {
    Column() {
      TitleComp({ titleName: "弹性布局" })

      Flex({
        direction: this.mDirection,
        wrap: this.mFlexWrap,
        justifyContent: this.mFlexAlign,
        alignItems: this.mAlignItem
      }) {
        Text('1').width('60%').height(40).backgroundColor(0xF5DEB3)
        Text('2').width('30%').height(30).backgroundColor(0xD2B48C)
        Text('3').width('40%').height(20).backgroundColor(0xF5D131)
      }
      .width('90%')
      .height(60)
      .padding(5)
      .backgroundColor(0xAFEEEE)
      .margin({ left: 16, right: 16, top: 15 })

      this.renderFlexDirection()
      this.renderFlexWrap()
      this.renderJustContent()
      this.renderItemAlign()
      this.renderTips()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }

  /**
   * 渲染布局方向属性（duration）控制
   */
  @Builder renderFlexDirection() {
    Text('布局方向(duration):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20, left: 16 })
    Row() {
      Row() {
        Radio({ value: "Row", group: "FlexDirection" })
          .width(20)
          .height(20)
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mDirection = FlexDirection.Row
            }
          })
        Text('Row').fontSize(12).fontStyle(FontStyle.Italic)
      }.width('50%')

      Row() {
        Radio({ value: "RowReverse", group: "FlexDirection" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mDirection = FlexDirection.RowReverse
            }
          })
        Text('RowReverse').fontSize(12).fontStyle(FontStyle.Italic)
      }.width('50%')
    }
    .width('100%')
    .margin({ left: 16, top: 2 })

    Row() {
      Row() {
        Radio({ value: "Column", group: "FlexDirection" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mDirection = FlexDirection.Column
            }
          })
        Text('Column').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "ColumnReverse", group: "FlexDirection" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mDirection = FlexDirection.ColumnReverse
            }
          })
        Text('ColumnReverse').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 16 })
  }

  /**
   * 渲染布局换行属性（wrap）控制
   */
  @Builder renderFlexWrap() {
    Text('布局换行(wrap):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 5, left: 16 })

    Row() {
      Row() {
        Radio({ value: "NoWrap", group: "FlexWrap" })
          .width(20)
          .height(20)
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexWrap = FlexWrap.NoWrap
            }
          })
        Text('NoWrap').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "WrapReverse", group: "FlexWrap" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexWrap = FlexWrap.WrapReverse
            }
          })
        Text('WrapReverse').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Wrap", group: "FlexWrap" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexWrap = FlexWrap.Wrap
            }
          })
        Text('Wrap').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .margin({ left: 16, top: 2, right: 15 })
    .width('100%')
  }

  /**
   * 渲染主轴对其方式属性（justifyContent）控制
   */
  @Builder renderJustContent() {
    Text('主轴对齐方式(justifyContent):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 5, left: 16 })
    Row() {
      Row() {
        Radio({ value: "Start", group: "FlexAlign" })
          .width(20)
          .height(20)
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.Start
            }
          })
        Text('Start').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Center", group: "FlexAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.Center
            }
          })
        Text('Center').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "End", group: "FlexAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.End
            }
          })
        Text('End').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 16 })

    Row() {
      Row() {
        Radio({ value: "SpaceBetween", group: "FlexAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceBetween
            }
          })
        Text('SpaceBetween').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "SpaceAround", group: "FlexAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceAround
            }
          })
        Text('SpaceAround').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "SpaceEvenly", group: "FlexAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mFlexAlign = FlexAlign.SpaceEvenly
            }
          })
        Text('SpaceEvenly').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 16 })
  }

  /**
   * 渲染交叉轴对其方式属性控制
   */
  @Builder renderItemAlign() {
    Text('交叉轴对齐方式(alignItems):')
      .fontSize(13)
      .fontColor("#212121")
      .fontWeight(FontWeight.Medium)
      .margin({ top: 5, left: 16 })
    Row() {
      Row() {
        Radio({ value: "Auto", group: "ItemAlign" })
          .width(20)
          .height(20)
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.Auto
            }
          })
        Text('Auto').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Start", group: "ItemAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.Start
            }
          })
        Text('Start').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Center", group: "ItemAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.Center
            }
          })
        Text('Center').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 16 })

    Row() {
      Row() {
        Radio({ value: "End", group: "ItemAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.End
            }
          })
        Text('End').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Baseline", group: "ItemAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.Baseline
            }
          })
        Text('Baseline').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)

      Row() {
        Radio({ value: "Stretch", group: "ItemAlign" })
          .width(20)
          .height(20)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignItem = ItemAlign.Stretch
            }
          })
        Text('Stretch').fontSize(12).fontStyle(FontStyle.Italic)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .margin({ left: 16 })
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      'Flex组件在渲染时存在二次布局过程，因此在对性能有严格要求的场景下建议使用Column、Row代替。',
      'wrap属性为 FlexWrap.NoWrap（默认值）时，表示不换行。\n   ·当 duration属性为横向时，如果子组件的宽度总和大于父元素的宽度，则子组件会被压缩宽度；\n   ·当 duration属性为纵向时，如果子组件的高度总和大于父元素的高度，则子组件会被压缩高度。',
      '容器和子元素都可以设置交叉轴对齐方式，且子元素设置的对齐方式优先级较高。\n   ·Flex组件的alignItems参数设置子组件在交叉轴的对齐方式\n   ·子组件的alignSelf属性也可以设置子组件在父容器交叉轴的对齐格式，且会覆盖Flex布局容器中alignItems配置'
    ] })
  }
}
