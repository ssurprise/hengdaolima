import { TitleComp } from '../view/TitleComp'
import BrowserHistoryViewMode from '../viewmodel/BrowserHistoryViewMode'
import { BrowserHistoryItem } from '../model/BrowserHistoryItem';


/**
 * 关系型数据库示例：浏览历史
 */
@Entry
@Component
struct RdbPage {
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
      .height('60%')
      .backgroundColor($r('app.color.login_page_background'))

      this.renderTips()
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
          .fontColor('#ffffff')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.End)
    }
    .margin({ top: this.getItemMarginTop(index) })
    .padding({ left: 12, top: 10, right: 12, bottom: 10 })
    .borderRadius(10)
    .backgroundColor(0xff4081)
    .borderStyle(BorderStyle.Solid)
  }

  @Builder renderTips() {
    Text('说明：')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 20, left: 15, right: 15 })
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
    Text('1. 数据存储使用的关系型数据库')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 15, right: 15 })
      .fontSize(12)
      .fontStyle(FontStyle.Italic)
  }

  private getItemMarginTop(index: number): number {
    if (index == 0) {
      return 10
    } else {
      return 0
    }
  }
}