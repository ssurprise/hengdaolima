import { TitleComp } from '../view/TitleComp'

@Entry
@Component
struct GridPage {
  private arr: Array<String> = new Array<String>(16).fill("").map((_, index) => `item ${index}`)

  build() {
    Column() {
      TitleComp()

      Text("标准的3x3").fontSize("12vp").margin({ top: '15vp' })
      Grid() {
        ForEach(this.arr, (item: string) => {
          GridItem() {
            Text(item)
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor(0x007DFF)
              .width('100%')
              .height('100%')
              .textAlign(TextAlign.Center)
          }
        }, item => item)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr ')
      .columnsGap(10)
      .rowsGap(10)
      .padding(10)
      .height(200)

      Text("跨网格").fontSize("12vp").margin({ top: '15vp' })
      Grid() {
        GridItem() {
          Text(this.arr[0] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }.columnStart(1).columnEnd(2)

        GridItem() {
          Text(this.arr[1] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }.rowStart(1).rowEnd(2)

        GridItem() {
          Text(this.arr[2] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }.rowStart(2).rowEnd(3)

        GridItem() {
          Text(this.arr[3] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }

        GridItem() {
          Text(this.arr[4] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }.columnStart(2).columnEnd(3)

        GridItem() {
          Text(this.arr[5] + "")
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(0x007DFF)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
        }.columnStart(2).columnEnd(3)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr ')
      .columnsGap(10)
      .rowsGap(10)
      .padding(10)
      .height(200)

    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}