import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'

@Entry
@Component
struct SearchPage {
  @State changeValue: string = ''
  @State submitValue: string = ''
  private controller: SearchController = new SearchController()

  build() {
    Column() {
      TitleComp({ titleName: 'Search组件' })

      Column() {

        Search({ value: this.changeValue, placeholder: '搜索内容', controller: this.controller })
          .searchButton('搜索')
          .width('100%')
          .height(40)
          .backgroundColor('#ffffff')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
            // 点击搜索图标、搜索按钮或者按下软键盘搜索按钮时触发该回调。
            this.submitValue = value
          })
          .onChange((value: string) => {
            // 输入内容发生变化时，触发该回调。
            this.changeValue = value
          })

        Text(`onChange事件的入参：${this.changeValue}`)
          .fontSize(14)
          .fontColor('#212121')
          .margin({ top: 20 })

        Text(`onSubmit事件的入参：${this.submitValue}`)
          .fontSize(14)
          .fontColor('#212121')
          .margin({ top: 10 })

        TipsComp({
          marginSpace: 0,
          tipArray: [
            'onSubmit(callback: (value: string) => void)：点击搜索图标、搜索按钮或者按下软键盘搜索按钮时触发该回调。',
            'onChange(callback: (value: string) => void)：输入内容发生变化时，触发该回调。',
            '上面整个白色区域都是Search组件的区域，样式修改的地方不多，比如搜索icon、删除icon 都是不可以修改的。'
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
}