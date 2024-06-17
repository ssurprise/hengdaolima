import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';


@Entry
@Component
export struct StackPage {
  @State mAlignContent: Alignment = Alignment.Center

  build() {
    Column() {
      TitleComp({ titleName: '层叠布局-Stack' })

      Stack({}) {
        Column()
          .width('90%')
          .height('80%')
          .backgroundColor('#ff58b87c')

        Text('text')
          .width('60%')
          .height('60%')
          .backgroundColor('#ffc3f6aa')

        Button('button')
          .width('30%')
          .height('25%')
          .backgroundColor('#ff8ff3eb')
          .fontColor('#000')
      }
      .width('92%')
      .height(180)
      .margin({ left: 9, top: 30, right: 9 })
      .borderWidth("1vp")
      .borderStyle(BorderStyle.Dashed)
      .borderColor("#212121")
      .alignContent(this.mAlignContent)

      this.renderController()
      this.renderTips()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder renderController() {
    Text('alignContent：')
      .margin({ top: "15vp" })
      .textAlign(TextAlign.Start)
      .fontSize("14fp")
      .fontWeight(FontWeight.Medium)
      .margin({ left: "20vp", top: "16vp" })
      .fontColor("#212121")

    Row() {
      Row() {
        Radio({ value: "TopStart", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.TopStart
            }
          })
        Text('TopStart')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "Top", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.Top
            }
          })
        Text('Top')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "TopEnd", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.TopEnd
            }
          })
        Text('TopEnd')
          .fontSize('14fp')
          .margin({ left: 3 })
      }
    }.margin({ top: "8vp" })
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)

    Row() {
      Row() {
        Radio({ value: "Start", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.Start
            }
          })
        Text('Start')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "Center", group: 'alignContent' })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.Center
            }
          })
        Text('Center')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "End", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.End
            }
          })
        Text('End')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

    }.margin({ top: "8vp" })
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)

    Row() {
      Row() {
        Radio({ value: "BottomStart", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.BottomStart
            }
          })
        Text('BottomStart')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "Bottom", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.Bottom
            }
          })
        Text('Bottom')
          .fontSize('14fp')
          .margin({ left: 3 })
      }

      Row() {
        Radio({ value: "BottomEnd", group: 'alignContent' })
          .checked(false)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mAlignContent = Alignment.BottomEnd
            }
          })
        Text('BottomEnd')
          .fontSize('14fp')
          .margin({ left: 3 })
      }
    }.margin({ top: "8vp" })
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '虚线框表示的是Stack组件的实际大小，深绿色的是一个Column容器组件，浅绿色的是一个Text组件，浅蓝色是一个Button组件',
      '对标Android中的FrameLayout'
    ] })
  }
}