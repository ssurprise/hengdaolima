import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/23 17:53
 * @Description： 选择器组件-包括日期选择器、时间选择器、文本选择器
 */
@Entry
@Component
struct PickerPage {
  @State pickerType: number = 0
  @State trackTxt: string = " "
  private city: string[] = ['北京', '上海', '广州', '深圳', '成都', '重庆', '西安', '哈尔滨', '青岛']

  build() {
    Column() {
      TitleComp({ titleName: '选择器' })
      Column() {
        this.renderController()
        this.renderPicker()

        TipsComp({ marginSpace: 0, tipArray: [
          '上面的示例中给父组件添加了背景颜色和边框，方便观察选择器的大小。可以观察到不管是 TextPicker 还是 DatePicker、TimePicker 在顶部和底部的位置是有白色的渐变蒙层的。',
          'DatePicker：日期选择器中的月份是从0开始的。显示的是1月，但是回调函数中的 value.month 却是 0',
          'api9 暂不支持样式修改！'
        ] })
      }
      .padding({ left: 15, right: 15 })
      .width('100%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }

  @Builder renderController() {
    Row() {
      Row() {
        Radio({ value: "text", group: "selector" })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.pickerType = 0
              this.trackTxt = '切换为文本选择器'
            }
          })
        Text('文本选择器').fontSize(12).fontStyle(FontStyle.Italic)
      }

      Row() {
        Radio({ value: "date", group: "selector" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.pickerType = 1
              this.trackTxt = '切换为日期选择器'
            }
          })
        Text('日期选择器').fontSize(12).fontStyle(FontStyle.Italic)
      }

      Row() {
        Radio({ value: "time", group: "selector" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.pickerType = 2
              this.trackTxt = '切换为时间选择器'
            }
          })
        Text('时间选择器').fontSize(12).fontStyle(FontStyle.Italic)
      }
    }
    .width('100%')
    .margin({ top: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder renderPicker() {
    Row() {
      if (0 == this.pickerType) {
        TextPicker({ range: this.city })
          .onChange((value: string, index: number) => {
            this.trackTxt = `选中=》${value} index：${index}`
          })
      } else if (1 == this.pickerType) {
        DatePicker({ start: new Date('2010-1-1'), end: new Date('2025-1-1') })
          .onChange((value: DatePickerResult) => {
            this.trackTxt = `选择的日期：${value.year}年 ${value.month}月 ${value.day}日`
          })
      } else if (2 == this.pickerType) {
        TimePicker()
          .useMilitaryTime(true)
          .onChange((value: TimePickerResult) => {
            this.trackTxt = `选择的时间：${value.hour}h ${value.minute}min`
          })
      }
    }
    .width('70%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ff4081')
    .borderWidth(2)
    .borderStyle(BorderStyle.Solid)
    .borderColor('#212121')
    .borderRadius(10)

    Text(this.trackTxt)
      .fontSize(12)
      .fontColor('#212121')
      .margin({ top: 10 })
  }
}