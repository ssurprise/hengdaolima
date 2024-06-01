import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import Queue from '@ohos.util.Queue';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 14:01
 * @Description： 队列-Queue
 */
@Entry
@Component
struct QueuePage {
  private mutableQueue: Queue<number> = new Queue()
  @State result: string = ""
  private sampleTxt: string = ""
  private autoValue: number = 99

  build() {
    Column() {
      TitleComp({ titleName: 'Queue' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.util.Queue 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({
          tipArray: [
            'Queue的特点是先进先出，在尾部增加元素，在头部删除元素。根据循环队列的数据结构实现。',
            'Queue和Deque相比，Queue只能在一端删除一端增加，而Deque可以两端增删。',
            '推荐使用场景： 一般符合先进先出的场景可以使用Queue。',
            'Deque 可以通过forEach方法，或者通过 Symbol.iterator 获取迭代器来进行循环遍历',
            'Queue 没有 clone 方法'
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
    this.mutableQueue.add(1)
    this.mutableQueue.add(2)
    this.mutableQueue.add(3)
    this.mutableQueue.add(4)
    this.mutableQueue.add(5)
    this.sampleTxt = this.getQueueStr()
  }

  @Builder renderSample() {
    Text('对照')
      .fontSize(14)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Text(this.sampleTxt)
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
      Button('队尾添加')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            this.mutableQueue.add(++this.autoValue);
            this.result = `添加成功，添加的值为：${this.autoValue} \n${this.getQueueStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('删除队头')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let result = this.mutableQueue.pop();
            this.result = `删除成功，删除的值为：${result} \n${this.getQueueStr()}`

          } catch (err) {
            this.result = `删除失败，err=${err}`
          }
        })
      Button('获取对头元素')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let result = this.mutableQueue.getFirst();
            this.result = `队头的值为：${result} \n${this.getQueueStr()}`
          } catch (err) {
            this.result = `获取失败，err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  private getQueueStr(): string {
    let showTxt = '{'
    for (let item of this.mutableQueue) {
      showTxt += `${item}，`
    }
    if (showTxt.endsWith('，')) {
      showTxt = showTxt.substring(0, showTxt.length - 1)
    }
    showTxt += '}'
    return showTxt
  }
}