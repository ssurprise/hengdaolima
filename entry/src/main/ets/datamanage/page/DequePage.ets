import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import Deque from '@ohos.util.Deque'; // 导入Deque模块


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 14:01
 * @Description： 双端队列-Deque
 */
@Entry
@Component
struct DequePage {
  mutableDeque: Deque<number> = new Deque()
  @State result: string = ""
  private sampleTxt: string = ""
  private autoValue: number = 99

  build() {
    Column() {
      TitleComp({ titleName: 'Deque' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.util.Deque 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({
          tipArray: [
            'Deque（double ended queue）根据循环队列的数据结构实现，符合先进先出以及先进后出的特点。Deque会根据实际需要动态调整容量，每次进行两倍扩容。',
            'Deque和Queue相比，Queue的特点是先进先出，只能在头部删除元素，尾部增加元素，而Deque支持两端的元素插入和移除',
            '与Vector相比，它们都支持在两端增删元素，但Deque不能进行中间插入的操作。对头部元素的插入删除效率高于Vector，而Vector访问元素的效率高于Deque。',
            '推荐使用场景： 需要频繁在集合两端进行增删元素的操作时，推荐使用Deque。',
            'Deque 可以通过forEach方法，或者通过 Symbol.iterator 获取迭代器来进行循环遍历',
            'Deque 没有 clone 方法'
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
    this.mutableDeque.insertFront(1)
    this.mutableDeque.insertFront(2)
    this.mutableDeque.insertFront(3)
    this.mutableDeque.insertFront(4)
    this.mutableDeque.insertFront(5)
    this.sampleTxt = this.getDequeStr()
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
      Button('队头添加')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            this.mutableDeque.insertFront(++this.autoValue);
            this.result = `添加成功，添加的值为：${this.autoValue} \n${this.getDequeStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('队尾添加')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            this.mutableDeque.insertEnd(++this.autoValue);
            this.result = `添加成功，添加的值为：${this.autoValue} \n${this.getDequeStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('删除队头')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let result = this.mutableDeque.popFirst();
            this.result = `删除成功，删除的值为：${result} \n${this.getDequeStr()}`

          } catch (err) {
            this.result = `删除失败，err=${err}`
          }
        })
      Button('删除队尾')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let result = this.mutableDeque.popLast();
            this.result = `删除成功，删除的值为：${result} \n${this.getDequeStr()}`
          } catch (err) {
            this.result = `删除失败，err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  private getDequeStr(): string {
    let showTxt = '{'
    for (let item of this.mutableDeque) {
      showTxt += `${item}，`
    }
    if (showTxt.endsWith('，')) {
      showTxt = showTxt.substring(0, showTxt.length - 1)
    }
    showTxt += '}'
    return showTxt
  }
}