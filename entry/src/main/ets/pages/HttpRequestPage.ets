import { TitleComp } from '../view/TitleComp';
import http from '@ohos.net.http';


@Entry
@Component
struct HttpRequestPage {
  @State mCity: string = '北京'
  @State mResult: string = ''

  build() {
    Column() {
      TitleComp({ titleName: 'HttpRequest' })

      Column() {
        Text('注：该页面主要介绍的是 @ohos.net.http 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)
          .margin({ top: 10 })

        Row() {
          Text('城市:')
            .fontColor('#212121')
            .fontSize(16)
            .fontStyle(FontStyle.Normal)
            .fontWeight(FontWeight.Medium)
          TextInput({ text: this.mCity, placeholder: '请输出要查询的城市名称' })
            .type(InputType.Normal)
            .fontSize(14)
            .width('50%')
            .margin({ left: 10 })
            .onChange((value: string) => {
              this.mCity = value
            })

          Blank()

          Button('查询')
            .type(ButtonType.Capsule)
            .width('20%')
            .height(36)
            .margin({ left: 10 })
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontStyle(FontStyle.Normal)
            .onClick(() => {
              this.onHttpRequest()
            })
        }
        .width('100%')
        .height(48)
        .margin({ top: 20 })
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text('结果:')
            .fontColor('#212121')
            .fontSize(16)
            .fontStyle(FontStyle.Normal)
            .fontWeight(FontWeight.Medium)
          Text(this.mResult)
            .fontColor('#212121')
            .fontSize(14)
            .fontStyle(FontStyle.Normal)
            .margin({ top: 3 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#f5f5f5')
      .alignItems(HorizontalAlign.Start)
    }
    .height('100%')
    .width('100%')
  }

  private onHttpRequest(): void {

    let httpRequest = http.createHttp()
    let promise = httpRequest.request(
      `http://v.juhe.cn/weather/index?format=2&key=487a0e269f87aa5c666ebf17b40e80f3&cityname=${this.mCity}`,
      { method: http.RequestMethod.GET,
        // 可选，默认为60s
        connectTimeout: 60000,
        // 可选，默认为60s
        readTimeout: 60000,
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
    promise.then((data) => {
      if (data.responseCode === http.ResponseCode.OK) {
        this.mResult = `code: ${data.responseCode}\nResult: ${data.result.toString()}`
        console.log('HttpRequestPage', 'Result:' + data.result);
        console.log('HttpRequestPage', 'code:' + data.responseCode);
      }
    }).catch((err) => {
      console.log('HttpRequestPage', 'error:' + JSON.stringify(err));
      this.mResult = JSON.stringify(err)
    });
  }
}