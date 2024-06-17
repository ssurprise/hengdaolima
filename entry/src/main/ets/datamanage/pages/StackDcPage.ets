import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import Stack from '@ohos.util.Stack';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/26 14:01
 * @Description： 线性容器Stack
 */
@Entry
@Component
struct StackDcPage {
  mutableStack: Stack<number> = new Stack()
  @State result: string = ""
  private sampleTxt: string = ""
  private autoValue: number = 99

  build() {
    Column() {
      TitleComp({ titleName: 'Stack' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.util.Stack 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({
          tipArray: [
            'Stack 基于数组的数据结构实现，特点是先进后出，只能在一端进行数据的插入和删除。',
            'Stack 和 Queue 相比，Queue基于循环队列实现，只能在一端删除，另一端插入，而Stack都在一端操作。',
            '推荐使用场景： 一般符合先进后出的场景可以使用Stack。',
            'Stack 可以通过forEach方法，或者通过 Symbol.iterator 获取迭代器来进行循环遍历',
            'Stack 没有 clone 方法'
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
    this.mutableStack.push(1)
    this.mutableStack.push(2)
    this.mutableStack.push(3)
    this.mutableStack.push(4)
    this.mutableStack.push(5)
    this.sampleTxt = this.getStackStr()
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
      Button('栈顶插入元素')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableStack.push(++this.autoValue);
            this.result = `添加成功，添加的值为：${value} \n${this.getStackStr()}`
          } catch (err) {
            this.result = `添加失败， err=${err}`
          }
        })
      Button('删除栈顶元素')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableStack.pop();
            this.result = `删除成功，删除的值为：${value} \n${this.getStackStr()}`
          } catch (err) {
            this.result = `删除成功， err=${err}`
          }
        })
      Button('获取栈顶元素')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          try {
            let value = this.mutableStack.peek();
            this.result = `获取成功，栈顶的值为：${value} \n${this.getStackStr()}`

          } catch (err) {
            this.result = `获取成功，err=${err}`
          }
        })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  private getStackStr(): string {
    let showTxt = '{'
    for (let item of this.mutableStack) {
      showTxt += `${item}，`
    }
    if (showTxt.endsWith('，')) {
      showTxt = showTxt.substring(0, showTxt.length - 1)
    }
    showTxt += '}'
    return showTxt
  }
}