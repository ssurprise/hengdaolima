import { TitleComp } from '../view/TitleComp'
import BrowserHistoryViewMode from '../viewmodel/BrowserHistoryViewMode'
import { BrowserHistoryItem } from '../model/BrowserHistoryItem';


@Entry
@Component
struct RdbPage {
  @State message: string = 'Hello World'
  @State historyArray: Array<BrowserHistoryItem> = null

  build() {
    Column() {
      TitleComp({ titleName: '浏览历史' })
      List({ space: 10 }) {
        ForEach(this.historyArray, (item: BrowserHistoryItem, index: number) => {
          ListItem() {
            this.renderItemView(item, index)
          }
          .margin({ left: 15, right: 15 })

        }, (item: BrowserHistoryItem, index: number) => item.name + index)
      }
      .width('100%')
      .height('70%')
      .backgroundColor($r('app.color.login_page_background'))
    }
    .width('100%')
  }

  aboutToAppear() {
    BrowserHistoryViewMode.queryHistory(getContext(this), (data, errCode, errMsg) => {
      if (data != null) {
        this.historyArray = data.convertToArray()
      }
    })
  }

  @Builder renderItemView(item: BrowserHistoryItem, index: number) {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Center
    }) {
      Column() {
        Text(`${item.name}`)
          .fontColor('#ffffff')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Text(`${item.pagePath}`)
          .fontColor('#ffffff')
          .fontSize(10)
          .fontWeight(FontWeight.Regular)
          .margin({ top: 5 })
      }
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text(`打开次数：${item.count}`)
          .fontColor('#55212121')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding({ left: 12, top: 10, right: 12, bottom: 10 })
    .borderRadius(10)
    .backgroundColor(0xff4081)
    .borderStyle(BorderStyle.Solid)
  }
}