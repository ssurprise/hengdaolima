import { TitleComp } from '../view/TitleComp';
import dataPreferences from '@ohos.data.preferences';



@Entry
@Component
struct PreferencePage {
  @State message: string = 'Hello World'

  build() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
  }

  onPageShow(){

  }
}