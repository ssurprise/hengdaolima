import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'
import promptAction from '@ohos.promptAction'
import systemDateTime from '@ohos.systemDateTime'


@Entry
@Component
struct TimeIntervalPage {
  private intervalId: number = 0
  private intervalTime: number = 0
  private timeoutId: number = 0
  private timeoutTime: number = 0
  @State recordsArray: Array<String> = []

  build() {
    Column() {
      TitleComp({ titleName: '定时器' })

      Column() {
        Text('注：该页面主要介绍的是公共模块提供的 setTimeout、setInterval 方法。')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderTimeoutConfig()
        this.renderIntervalConfig()

        List() {
          ForEach(this.recordsArray, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(16)
                .fontSize(12)
                .fontStyle(FontStyle.Normal)
            }
            .padding({ left: 10, top: 5, right: 10 })
          }, (_item: any, index?: number) => index + "")
        }
        .width('100%')
        .height(200)
        .padding({ bottom: 5 })
        .alignSelf(ItemAlign.Center)
        .backgroundColor('#bdbdbd')
        .backgroundBlurStyle(BlurStyle.Regular)
        .margin({ top: 10 })

        TipsComp({
          marginSpace: 0,
          tipArray: [
            'setTimeout：设置一个定时器，该定时器在定时器到期后执行一个函数。该定时器在回调被执行后自动删除，或使用clearTimeout接口手动删除。',
            'setInterval：重复调用一个函数，在每次调用之间具有固定的时间延迟。删除该定时器需手动调用clearInterval接口。',
          ]
        })
      }
      .width('100%')
      .padding({ left: 15, top: 15, right: 15 })
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderTimeoutConfig() {
    Text('开启一个定时任务')
      .fontColor('#212121')
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Row() {
      TextInput({ placeholder: '请输入' })
        .width('40%')
        .fontSize(14)
        .placeholderFont({ size: 14 })
        .type(InputType.Number)
        .margin({ top: 2 })
        .borderRadius(8)
        .onChange((value) => {
          try {
            this.timeoutTime = Number.parseInt(value)
          } catch (e) {
          }
        })
      Text('ms')
        .fontSize(16)
        .fontColor('#ff4081')
        .margin({ left: 3 })

      Blank()

      Button("启动")
        .height(30)
        .padding({ left: 15, top: 1, right: 15, bottom: 1 })
        .type(ButtonType.Normal)
        .borderRadius(8)
        .fontSize(14)
        .onClick(() => {
          if (this.timeoutId == 0) {
            this.timeoutId = setTimeout(() => {
              // 到执行时间时记录
              systemDateTime.getDate().then((date) => {

                this.recordsArray.push(`定时任务=>执行，time=${date.toTimeString()}`)
                this.recordsArray.push(`定时任务结束， timeoutId=${this.timeoutId}`)
                this.timeoutId = 0

              }).catch((error) => {
                console.info(`Failed to get date. message:${error.message}, code:${error.code}`);
              })
            }, this.timeoutTime)

            // 按下开始时记录
            systemDateTime.getDate().then((date) => {
              this.recordsArray.push(`启动定时任务，timeoutId=${this.timeoutId}，time=${date.toTimeString()}`)
            }).catch((error) => {
              console.info(`Failed to get date. message:${error.message}, code:${error.code}`);
            })

          } else {
            promptAction.showToast({ message: `当前有正在运行中的定时任务，timeoutId = ${this.timeoutId}` })
          }
        })

      Button("取消")
        .height(30)
        .padding({ left: 15, top: 1, right: 15, bottom: 1 })
        .type(ButtonType.Normal)
        .borderRadius(8)
        .fontSize(14)
        .margin({ left: 15 })
        .onClick(() => {
          if (!this.cancelTimeout()) {
            promptAction.showToast({ message: `暂无正在运行中的定时任务！` })
          }
        })
    }
    .width('100%')
    .margin({ top: 2 })
  }

  @Builder renderIntervalConfig() {
    Text('开启一个周期任务')
      .fontColor('#212121')
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Row() {
      TextInput({ placeholder: '请输入' })
        .width('40%')
        .fontSize(14)
        .placeholderFont({ size: 14 })
        .type(InputType.Number)
        .margin({ top: 2 })
        .borderRadius(8)
        .onChange((value) => {
          try {
            this.intervalTime = Number.parseInt(value)
          } catch (e) {
          }
        })
      Text('ms')
        .fontSize(16)
        .fontColor('#ff4081')
        .margin({ left: 3 })

      Blank()

      Button("启动")
        .height(30)
        .padding({ left: 15, top: 1, right: 15, bottom: 1 })
        .type(ButtonType.Normal)
        .borderRadius(8)
        .fontSize(14)
        .onClick(() => {
          if (this.intervalId == 0) {
            this.intervalId = setInterval(() => {
              systemDateTime.getDate().then((date) => {
                this.recordsArray.push(`周期任务=>执行，time=${date.toTimeString()}`)
              })
            }, this.intervalTime)

            // 任务启动记录
            systemDateTime.getDate().then((date) => {
              this.recordsArray.push(`启动周期任务，id=${this.intervalId}，time=${date.toTimeString()}`)
            }).catch((error) => {
              console.info(`Failed to get date. message:${error.message}, code:${error.code}`);
            })

          } else {
            promptAction.showToast({ message: `当前有正在运行中的定时任务，intervalId = ${this.intervalId}` })
          }
        })

      Button("取消")
        .height(30)
        .padding({ left: 15, top: 1, right: 15, bottom: 1 })
        .type(ButtonType.Normal)
        .borderRadius(8)
        .fontSize(14)
        .margin({ left: 15 })
        .onClick(() => {
          if (!this.cancelInterval()) {
            promptAction.showToast({ message: `暂无正在运行中的定时任务！` })
          }
        })
    }
    .width('100%')
    .margin({ top: 2 })
  }

  aboutToDisappear() {
    this.cancelInterval()
    this.cancelTimeout()
  }

  cancelInterval(): Boolean {
    if (this.intervalId != 0) {
      clearInterval(this.intervalTime)
      this.recordsArray.push(`取消周期任务，intervalId=${this.intervalId}`)
      this.intervalId = 0
      return true
    } else {
      return false
    }
  }

  cancelTimeout(): Boolean {
    if (this.timeoutId != 0) {
      clearTimeout(this.timeoutId)
      this.recordsArray.push(`取消定时任务，timeoutId=${this.timeoutId}`)
      this.timeoutId = 0
      return true
    } else {
      return false
    }
  }
}