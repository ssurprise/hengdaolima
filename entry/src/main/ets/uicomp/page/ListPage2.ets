import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'

@Entry
@Component
struct ListPage2 {
  @State onScrollIndexStart: number = 0;
  @State onScrollIndexEnd: number = 0;
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
        this.onScrollIndexStart = start
        this.onScrollIndexEnd = end
      })
      .margin({ top: 20 })
      .sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
      .alignListItem(ListItemAlign.Center)
      .divider({ strokeWidth: 1, color: Color.Green, startMargin: 10, endMargin: 10 })
      .borderStyle(BorderStyle.Dashed)
      .borderWidth(1)
      .borderColor("#212121")
      .width('90%')
      .height(360)

      Text(`onScrollIndex 事件监听：start=${this.onScrollIndexStart}, end=${this.onScrollIndexEnd}`)
        .width('100%')
        .alignSelf(ItemAlign.Start)
        .margin({ left: $r('app.float.page_space_left'), top: 10, right: $r('app.float.page_space_right') })
        .fontSize(12)

      this.renderTips()
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

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '分割线和space间距是针对 ListItemGroup 而不是 ListItem',
      'ListItemGroup作为一个整体计算一个索引,不计算ListItemGroup内部ListItem的索引值。',
      'onScrollIndex 方法回调中返回的 start和end 也是针对 ListItemGroup的，也可以印证上面的问题'
    ] })
  }
}