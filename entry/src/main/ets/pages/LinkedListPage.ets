import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'
import LinkedList from '@ohos.util.LinkedList';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 14:01
 * @Description： LinkedList
 */
@Entry
@Component
struct LinkedListPage {
  private mutableList: LinkedList<number> = new LinkedList()
  @State result: string = ""
  private sampleTxt: string = ""
  private autoValue: number = 99

  build() {
    Column() {
      TitleComp({ titleName: 'LinkedList' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.util.LinkedList 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({
          tipArray: [
            'LinkedList 底层通过双向链表实现，双向链表的每个节点都包含对前一个元素和后一个元素的引用。当需要查询元素时，可以从头遍历，也可以从尾部遍历，插入、删除效率高，查询效率低。LinkedList允许元素为null。',
            'LinkedList 和 List 相比，LinkedList是双向链表，可以快速地在头尾进行增删，而List是单向链表，无法双向操作。',
            'LinkedList 和 ArrayList 相比，插入数据效率LinkedList优于ArrayList，而查询效率ArrayList优于LinkedList。',
            '推荐使用场景： 当需要频繁的插入删除时，推荐使用LinkedList高效操作。',
            'LinkedList 可以通过forEach方法，或者通过 Symbol.iterator 获取迭代器来进行循环遍历；可以通过调用convertToArray()方法把当前LinkedList实例转换成数组',
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
    this.mutableList.add(1)
    this.mutableList.add(2)
    this.mutableList.add(3)
    this.mutableList.add(4)
    this.mutableList.add(5)
    this.sampleTxt = this.getLinkedListStr()
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
      Button('头部添加')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            this.mutableList.addFirst(++this.autoValue);
            this.result = `添加成功，添加的值为：${this.autoValue} \n${this.getLinkedListStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('尾部添加')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let r = this.mutableList.add(++this.autoValue);
            if (r) {
              this.result = `添加成功，添加的值为：${this.autoValue} \n${this.getLinkedListStr()}`
            } else {
              this.result = `添加失败`
            }
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('指定位置插入')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            this.mutableList.insert(2, ++this.autoValue);
            this.result = `插入成功，插入的位置为：2，值为：${this.autoValue} \n${this.getLinkedListStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)

    Row() {
      Button('删除第一个')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableList.removeFirst();
            this.result = `删除成功，删除的值为：${value} \n${this.getLinkedListStr()}`
          } catch (err) {
            this.result = `删除失败， err=${err}`
          }
        })
      Button('删除最后一个')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableList.removeLast();
            this.result = `删除成功，删除的值为：${value} \n${this.getLinkedListStr()}`
          } catch (err) {
            this.result = `删除失败， err=${err}`
          }
        })
      Button('删除指定位置')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableList.removeByIndex(2);
            this.result = `删除成功，删除的位置为：2，值为：${value} \n${this.getLinkedListStr()}`
          } catch (err) {
            this.result = `删除失败， err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  private getLinkedListStr(): string {
    // ps: 这里可以直接使用 ，我之所以自己写，纯是为了可以调间距，好看。
    let showTxt = '{ '

    this.mutableList.forEach((value, index) => {
      showTxt += `${value}，`
    })
    if (showTxt.endsWith('，')) {
      showTxt = showTxt.substring(0, showTxt.length - 1)
    }
    showTxt += ' }'
    return showTxt
  }
}