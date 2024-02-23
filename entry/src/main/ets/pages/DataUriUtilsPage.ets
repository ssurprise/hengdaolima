import dataUriUtils from '@ohos.app.ability.dataUriUtils';

import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'


@Entry
@Component
struct DataUriUtilsPage {
  readonly SAMPLE_URI: string = "com.hengdao.lima/zhan/1528"
  private variableUri: string = this.SAMPLE_URI
  @State result: string = ""

  build() {
    Column() {
      TitleComp({ titleName: 'DataUriUtils' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.app.ability.dataUriUtils 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderSample()
        this.renderResult()
        this.renderController()

        TipsComp({ tipArray: [
          'Demo 中固定写死了追加的id为 1111， 修改的id为 6666',
          "attachId 可以无限追加，但是 updateId 只会更新最后一个",
          'api太少了，只有对id的增、删、改操作！'
        ], marginSpace: 0 })
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

  @Builder renderSample() {
    Text('对照')
      .fontSize(14)
      .fontColor($r('app.color.main_txt_color'))
      .fontWeight(FontWeight.Medium)
      .margin({ top: 20 })

    Text(this.SAMPLE_URI)
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
      .height(60)
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
      Button('查询').onClick(() => {
        try {
          let id = dataUriUtils.getId(this.variableUri);
          this.result = `get id: ${id}`
        } catch (err) {
          this.result = `获取id失败，检查uri:${err}`
        }
      })
      Button('附加').onClick(() => {
        let id = 1111;
        try {
          this.variableUri = dataUriUtils.attachId(this.variableUri, id,);
          this.result = `附加id成功: ${this.variableUri}`
        } catch (err) {
          this.result = `附加id失败，${err}`
        }
      })
      Button('更新').onClick(() => {
        try {
          let id = 6666;
          this.variableUri = dataUriUtils.updateId(this.variableUri, id);
          this.result = `更新id成功：${this.variableUri}`

        } catch (err) {
          this.result = `更新id失败，检查uri：${this.variableUri}`
        }
      })
      Button('删除').onClick(() => {
        try {
          this.variableUri = dataUriUtils.deleteId(this.variableUri);
          this.result = `删除id成功：${this.variableUri}`
        } catch (err) {
          this.result = `删除id失败，检查uri：${this.variableUri}`
        }
      })
    }
    .width('100%')
    .margin({ top: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}