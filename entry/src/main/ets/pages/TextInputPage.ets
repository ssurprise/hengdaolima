import { TitleComp } from '../view/TitleComp';


@Entry
@Component
struct TextInputPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: 'TextInput' })

      Text('单行输入框')
        .margin({ top: 15, left: 9 })

      TextInput({ placeholder: '单行输入框', text: '123456', })
        .margin({ left: 9, top: 3 })
        .onChange((value: string) => {
          console.log('TextInputPage', 'TextInput-value:' + value);
        })
        .onFocus(() => {
          console.log('TextInputPage', 'TextInput-获取焦点');
        })

      Text('多行输入框')
        .margin({ top: 20, left: 9 })

      TextArea({ placeholder: '多行输入框', text: '123456789', })
        .margin({ left: 9, top: 3 })
        .onChange((value: string) => {
          console.log('TextInputPage', 'TextArea-value:' + value);
        })
        .onFocus(() => {
          console.log('TextInputPage', 'TextArea-获取焦点');
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}