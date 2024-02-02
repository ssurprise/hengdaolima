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
          .height(20)
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
      .backgroundColor("#55bdbdbd")

      this.renderPreferencePath()
      this.renderTips()
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

  @Builder renderPreferencePath() {
    Text(`首选项存储路径：${getContext(this).preferencesDir}`)
      .fontSize(12)
      .margin({ top: 50, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
      .fontColor('#212121')
  }

  @Builder renderTips() {
    Text('首选项约束限制：')
      .fontSize(14)
      .margin({ top: 50, left: 10, right: 10 })
      .fontStyle(FontStyle.Normal)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
    Text('1. Key键为string类型，要求非空且长度不超过80个字节。')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
    Text('2. 如果Value值为string类型，可以为空，不为空时长度不超过8192个字节')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
    Text('3. 内存会随着存储数据量的增大而增大，所以存储的数据量应该是轻量级的，建议存储的数据不超过一万条，否则会在内存方面产生较大的开销。')
      .fontSize(12)
      .margin({ top: 5, left: 10, right: 10 })
      .fontStyle(FontStyle.Italic)
  }
}