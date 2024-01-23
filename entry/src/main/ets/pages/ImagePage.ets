import { TitleComp } from '../view/TitleComp'


@Entry
@Component
struct ImagePage {
  @State imageFit: ImageFit = ImageFit.Cover

  build() {
    Row() {
      Column() {
        TitleComp({ titleName: 'Image' })

        Image($r("app.media.image_05"))
          .objectFit(this.imageFit)
          .margin({ top: "20vp" })
          .width("200vp")
          .height("200vp")
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")

        Text("适配类型:")
          .margin({ top: "15vp" })
          .textAlign(TextAlign.Start)
          .fontSize("14fp")
          .fontWeight(FontWeight.Medium)
          .margin({ left: "20vp", top: "16vp" })
          .width("100%")
          .fontColor("#212121")

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
        }.margin({ top: "8vp" })
        .width("100%")
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
    }
  }
}