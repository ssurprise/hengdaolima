import { TitleComp } from '../view/TitleComp';


@Entry
@Component
struct WaterFlowPage {
  @State message: string = 'Hello World'

  build() {
    Column() {

      TitleComp({ titleName: 'WaterFlow' })

      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}