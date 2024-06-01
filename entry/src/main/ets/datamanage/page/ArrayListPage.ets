import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import ArrayList from '@ohos.util.ArrayList';


@Entry
@Component
struct ArrayListPage {
  readonly SAMPLE_LIST: ArrayList<number> = new ArrayList()
  private mutableList: ArrayList<number> = null
  @State result: string = ""
  private autoValue: number = 99

  build() {
    Column() {
      TitleComp({ titleName: 'ArrayList' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.util.ArrayList 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({
          tipArray: [
            'ArrayList是一种线性数据结构，底层基于数组实现。ArrayList会根据实际需要动态调整容量，每次扩容增加50%。',
            'Vector和ArrayList和相似，都是基于数组实现，但Vector每次扩容增加1倍，而且从api 9 开始已经废弃了Vector，推荐使用ArrayList'
          ], marginSpace: 0 }
        )
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: $r('app.float.page_space_left'), right: $r('app.float.page_space_right') })
      .backgroundColor('#f5f5f5')

    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    this.SAMPLE_LIST.add(1)
    this.SAMPLE_LIST.add(2)
    this.SAMPLE_LIST.add(3)
    this.SAMPLE_LIST.add(4)
    this.SAMPLE_LIST.add(5)
    this.mutableList = this.SAMPLE_LIST.clone()
  }

  @Builder renderSample() {
    Text('对照')
      .fontSize(14)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Text(`[${this.SAMPLE_LIST.convertToArray()}]`)
      .width('100%')
      .height(40)
      .margin({ top: 3 })
      .padding({ left: 12, right: 12 })
      .textAlign(TextAlign.Start)
      .fontSize(12)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .borderRadius(10)
      .backgroundColor('#ffffff')
  }

  @Builder renderResult() {
    Text('结果')
      .fontSize(14)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Text(this.result)
      .width('100%')
      .height(70)
      .margin({ top: 3 })
      .padding({ left: 12, right: 12 })
      .textAlign(TextAlign.Start)
      .fontSize(12)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .borderRadius(10)
      .backgroundColor('#ffffff')
  }

  @Builder renderController() {
    Row() {
      Button('添加')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          try {
            let result = this.mutableList.add(++this.autoValue);
            if (result) {
              this.result = `添加成功: \n{${this.mutableList.convertToArray()}}`
            } else {
              this.result = `添加失败`
            }
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('插入')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          try {
            this.mutableList.insert(++this.autoValue, 1);
            this.result = `插入成功，删除的位置为：1，值为：${this.autoValue}\n{${this.mutableList.convertToArray()}}`
          } catch (err) {
            this.result = `插入失败， err=${err}`
          }
        })
      Button('删除指定位置')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          try {
            let value = this.mutableList.removeByIndex(3);
            this.result = `删除成功，删除的位置为：3，值为：${value}\n{${this.mutableList.convertToArray()}}`

          } catch (err) {
            this.result = `删除失败，err=${err}`
          }
        })
      Button('排序')
        .height(30)
        .fontSize(14)
        .onClick(() => {
          try {
            this.mutableList.sort((f: number, s: number) => {
              return s - f
            });
            this.result = `排序成功\n{${this.mutableList.convertToArray()}}`
          } catch (err) {
            this.result = `排序失败，err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}