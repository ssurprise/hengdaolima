import { TitleComp } from '../view/TitleComp';
import promptAction from '@ohos.promptAction';
import dataPreferences from '@ohos.data.preferences';


@Entry
@Component
struct PreferencePage {
  readonly TAG = "PreferencePage"
  readonly KEY = "home_show_history"
  @State isShowHistory: boolean = false
  private mPreferences: dataPreferences.Preferences = null

  build() {
    Column() {
      TitleComp({ titleName: '首选项' })

      Row() {
        Text("首页显示历史")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor("#212121")

        Toggle({ type: ToggleType.Switch, isOn: this.isShowHistory })
          .onChange((isOn: boolean) => {
            // 需要执行的操作
            if (isOn) {
              promptAction.showToast({ message: 'home_show_history is on.' })
            } else {
              promptAction.showToast({ message: 'home_show_history is off.' })
            }
            if (this.mPreferences != null) {
              this.mPreferences.put(this.KEY, isOn, (err) => {
                if (err) {
                  console.error(this.TAG, `Failed to put data. Code:${err.code}, message:${err.message}`);
                  return;
                }
                console.info(this.TAG, 'Succeeded in putting data.');
              })
            }
          })
      }
      .width('90%')
      .height(40)
      .padding({ left: 10, right: 10 })
      .margin({ top: 20 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignSelf(ItemAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor("#757575")
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .height('100%')
    .width('100%')
  }

  aboutToAppear() {
    dataPreferences.getPreferences(getContext(this), 'my_setting', (error, preferences) => {
      if (error) {
        console.error(this.TAG, `Failed to get preferences. Code:${error.code},message:${error.message}`);
        return;
      }
      console.info(this.TAG, 'Succeeded in getting preferences.');
      this.mPreferences = preferences
      preferences.get(this.KEY, false, (err, val) => {
        if (err) {
          console.error(this.TAG, `Failed to get value of '${this.KEY}'. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(this.TAG, `Succeeded in getting value of '${this.KEY}'. val: ${val}.`);
        this.isShowHistory = val as boolean
      })
    })
  }

  aboutToDisappear() {
    this.mPreferences.flush()
    this.mPreferences = null
  }
}