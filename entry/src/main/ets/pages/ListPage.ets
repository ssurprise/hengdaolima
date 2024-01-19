import { TitleComp } from '../view/TitleComp'

@Entry
@Component
struct ListsPage {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Column() {
      TitleComp('List')
      List({ space: 10 }) {
        ForEach(this.arr, (item: number) => {
          ListItem() {
            Text(`${item}`)
              .width('100%')
              .height(100)
              .fontSize(20)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0x007DFF)
          }
        }, item => item)
      }
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
      .padding('12vp')
    }
    .height('100%')
    .width('100%')
  }
}