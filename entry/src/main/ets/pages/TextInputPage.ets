import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';


@Entry
@Component
struct TextInputPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: 'TextInput' })

      this.renderTextInput()
      this.renderTextArea()
      this.renderTips()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder renderTextInput() {
    Text('单行输入框')
      .margin({ top: 15, left: 15 })

    TextInput({ placeholder: '单行输入框', text: '123456', })
      .width('80%')
      .margin({ left: 15, top: 3 })
      .onChange((value: string) => {
        console.log('TextInputPage', 'TextInput-value:' + value);
      })
      .onFocus(() => {
        console.log('TextInputPage', 'TextInput-获取焦点');
      })
  }

  @Builder renderTextArea() {
    Text('多行输入框')
      .margin({ left: 15, top: 20 })

    TextArea({ placeholder: '多行输入框', text: '123456789', })
      .width('80%')
      .margin({ left: 15, top: 3 })
      .onChange((value: string) => {
        console.log('TextInputPage', 'TextArea-value:' + value);
      })
      .onFocus(() => {
        console.log('TextInputPage', 'TextArea-获取焦点');
      })
  }

  @Builder renderTips() {
    TipsComp({
      tipArray: [
        '样式无法修改。想把输入框样式换乘下划线样式，但是发现即使背景换了，输入区和组件的底边还是有间距，如果高度调的小，那么输入区就被裁减了！有点拉跨'
      ]
    })
  }
}