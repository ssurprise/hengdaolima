import { TitleComp } from '../view/TitleComp'

@Entry
@Component
struct RowPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp().height("56vp").backgroundColor(0xffffff)

      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .backgroundColor("#f5f5f5")
      .margin({ top: '15vp' })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .margin({ top: '15vp' })
      .backgroundColor("#f5f5f5")
      .justifyContent(FlexAlign.Center)

      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .margin({ top: '15vp' })
      .backgroundColor("#f5f5f5")
      .justifyContent(FlexAlign.End)

      Text("justifyContent:SpaceBetween").fontSize("12vp").margin({ top: '15vp' })
      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .backgroundColor("#f5f5f5")
      .justifyContent(FlexAlign.SpaceBetween)

      Text("justifyContent:SpaceAround").fontSize("12vp").margin({ top: '15vp' })
      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .backgroundColor("#f5f5f5")
      .justifyContent(FlexAlign.SpaceAround)

      Text("justifyContent:SpaceEvenly").fontSize("12vp").margin({ top: '15vp' })
      Row() {
        Text("aaaa")
          .height("100%")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
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
      .height("50vp")
      .backgroundColor("#f5f5f5")
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }
}