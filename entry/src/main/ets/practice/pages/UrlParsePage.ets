import Url from '@ohos.url'
import promptAction from '@ohos.promptAction'
import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'


@Entry
@Component
struct UrlParsePage {
  private mUrl: string = 'https://jingxi:123456@host:8080/directory/file?query=pppppp&where=bj#qwer=da'
  @State mResult: string[] = null

  build() {
    Column() {
      TitleComp({ titleName: 'Url解析' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.url 模块提供的url解析的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        TextArea({ text: this.mUrl, placeholder: '请输入目标url' })
          .width('100%')
          .height(90)
          .margin({ top: 10 })
          .fontSize(12)
          .fontColor('#212121')
          .placeholderFont({ size: 12, weight: FontWeight.Normal })
          .placeholderColor('#757575')
          .onChange((value: string) => {
            this.mUrl = value
          })
        Button('开始解析')
          .type(ButtonType.Capsule)
          .width(100)
          .height(38)
          .margin({ top: 10 })
          .fontSize(14)
          .fontColor('#ffffff')
          .backgroundColor('#ff4081')
          .onClick(() => {
            this.toParseUrl()
          })

        Column({ space: 5 }) {
          ForEach(this.mResult, (item, index) => {
            Column() {
              Text(item)
                .fontColor('#212121')
                .fontSize(12)
            }

          }, item => item)
        }
        .width('100%')
        .padding({ left: 10, top: 5, right: 10, bottom: 5 })
        .margin({ top: 20 })
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('#bdbdbd')
        .borderRadius(8)

        this.renderTips()
      }
      .width('100%')
      .padding({ top: 15, left: 15, right: 15 })
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .width('100%')

  }

  toParseUrl() {
    if (null == this.mUrl || this.mUrl == '' || this.mUrl == undefined) {
      promptAction.showToast({ message: 'url 无效，无法进行解析！' })
      return
    }
    let url = Url.URL.parseURL(this.mUrl);
    this.mResult = []
    this.mResult.push(`protocol：${url.protocol}`)
    this.mResult.push(`username：${url.username}`)
    this.mResult.push(`password：${url.password}`)
    this.mResult.push(`hostname：${url.hostname}`)
    this.mResult.push(`port：${url.port}`)
    this.mResult.push(`pathname：${url.pathname}`)
    this.mResult.push(`search：${url.search}`)
    this.mResult.push(`params：${url.params}`)
    this.mResult.push(`hash：${url.hash}`)
  }

  // protocol :// hostname[:port] / path / [:parameters][?query]#fragment

  @Builder renderTips() {
    TipsComp({
      marginSpace: 0,
      tipArray: [
        'URL的一般语法格式为 protocol :// hostname[:port] / path / [:parameters][?query]#fragment',
        'URL的 host 属性和 hostname 属性略有不同，两者都是获取和设置URL的主机部分，但是 hostname 不带主机端口。',
        'URL的 hash 属性：获取和设置URL的片段部分。在其他语言中会用 fragment 或者 ref 来表示。个人感觉在鸿蒙里用hash 来表示片段不太妥~'
      ]
    })
  }
}