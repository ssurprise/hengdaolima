import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';


@Entry
@Component
struct TextInputPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: 'TextInput' })

      this.renderTextInput()
      this.renderTextArea()
      this.renderCustomStyle()
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

  @Builder renderCustomStyle() {
    Text('自定义样式')
      .margin({ left: 15, top: 20 })

    TextInput({ placeholder: '自定义样式', text: '123456', })
      .width('80%')
      .margin({ left: 15, top: 3 })
      .padding(5)
      .caretColor(Color.Blue)
      .borderRadius(0)
      .backgroundColor(Color.Yellow)
      .borderWidth({ left: 1, top: 0, right: 1, bottom: 5 })
      .borderColor({ left: '#ff4081', top: '#007DFF', right: '#ff4081', bottom: Color.Green })
  }

  @Builder renderTips() {
    TipsComp({
      tipArray: [
        '通用属性padding的默认值为：{top: 8 vp, right: 16 vp, bottom: 8 vp, left: 16 vp }',
        '自定义样式按需修改 padding、borderRadius、backgroundColor属性，默认的样式中配置了这几个属性。',
        '光标宽1.5vp，光标高度与文本选中底板高度和字体大小相关。 目前暂未找到可以自定义光标样式的api！'
      ]
    })
  }
}