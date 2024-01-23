import { TitleComp } from '../view/TitleComp'

@Entry
@Component
struct ListsPage {
  private arr: string[] = new Array(20).fill('').map((_, index) => `item ${index}`)

  build() {
    Column() {
      TitleComp({ titleName: 'List-间距/分割线' })
      List({ space: 10 }) {
        ForEach(this.arr, (item: string) => {
          ListItem() {
            Text(item)
              .width('80%')
              .height('80%')
              .fontSize(20)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0x007DFF)
          }
          .width('90%')
          .height(48)
          .borderStyle(BorderStyle.Dashed)
          .borderWidth(1)
          .borderColor(Color.Red)
        }, item => item)
      }
      .lanes(2)
      .alignListItem(ListItemAlign.Center)
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        console.log('ListsPage', 'first=' + firstIndex)
        console.log('ListsPage', 'last=' + lastIndex)
      })
      // .onScroll((scrollOffset: number, scrollState: ScrollState) => {
      //   console.log('ListsPage', 'scrollOffset' + scrollOffset)
      //   console.log('ListsPage', 'scrollState' + scrollState)
      // })
      .onReachStart(() => {
        console.log('ListsPage', 'onReachStart')
      })
      .onReachEnd(() => {
        console.log('ListsPage', 'onReachEnd')
      })
      .onScrollStop(() => {
        console.log('ListsPage', 'onScrollStop')
      })
      .divider({ strokeWidth: 1, color: Color.Green, startMargin: 10, endMargin: 10 })
      .borderStyle(BorderStyle.Dashed)
      .borderWidth(1)
      .borderColor("#212121")
      .width('90%')
      .height(360)

      Column() {
        Text('说明：')
          .fontSize(14)
          .fontStyle(FontStyle.Normal)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Red)
        Text('1. divider 可以和 space 同时设置。当divider的`strokeWidth`小于space时，会现在space的中间位置显示。如果 divider 的`strokeWidth`大于space的宽度，则会使用`strokeWidth`的宽度。')
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
      }
      .width('100%')
      .margin({ top: 30 })
      .padding({ left: 9, right: 9 })
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }
}