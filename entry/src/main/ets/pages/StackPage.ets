import { TitleComp } from '../view/TitleComp';


@Entry
@Component
export struct StackPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp('Stack')

      Stack({}) {
        Column() {
        }
        .width('90%')
        .height('100%')
        .backgroundColor('#ff58b87c')

        Text('text')
          .width('60%')
          .height('60%')
          .backgroundColor('#ffc3f6aa')

        Button('button')
          .width('30%')
          .height('30%')
          .backgroundColor('#ff8ff3eb')
          .fontColor('#000')
      }
      .alignContent(Alignment.Center)
      .width('100%')
      .height(150)
      .margin({ top: 50 })
    }
    .width('100%')
  }
}