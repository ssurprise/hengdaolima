import { TitleComp } from '../view/TitleComp'

@Entry
@Component
struct ListPage2 {
  private numArr: object[] = [
    {
      title: '个位数',
      numbersArray: [1, 2, 3, 4, 5, 6, 7, 8, 9]
    },
    {
      title: '十位数',
      numbersArray: [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
    },
    {
      title: '百位数',
      numbersArray: [100, 101, 102, 103, 104, 105, 106, 107, 108, 109]
    }
  ]

  build() {
    Column() {
      TitleComp({ titleName: 'List-分组' })
      List({ space: 10 }) {
        ForEach(this.numArr, item => {
          ListItemGroup({ header: this.itemHead(item.title) }) {
            ForEach(item.numbersArray, (numItem: number) => {
              ListItem() {
                Text(numItem + "")
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
            }, numItem => numItem + "")
          }
        })
      }
      .onScrollIndex((start: number, end: number) => {
        console.log("ListPage2", "onScrollIndex, start=" + start + " end=" + end)
      })
      .sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
      .alignListItem(ListItemAlign.Center)
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
        Text('1. 分割线和space间距是针对 ListItemGroup 而不是 ListItem')
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
        Text('2. onScrollIndex 方法回调中返回的 start和end 也是针对 ListItemGroup的')
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

  @Builder itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text)
      .fontSize(20)
      .backgroundColor('#f5f5f5')
      .width('100%')
      .padding(5)
  }
}