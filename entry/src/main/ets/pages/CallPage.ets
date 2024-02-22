import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp';
import call from '@ohos.telephony.call';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/22 17:15
 * @Description： 拨打电话
 */
@Entry
@Component
struct CallPage {
  @State phoneNumber: string = ''
  @State warning: string = ''

  build() {
    Column() {
      TitleComp({ titleName: '拨打电话' })

      Column() {
        Row() {
          TextInput({ placeholder: '请输入电话号码' })
            .type(InputType.PhoneNumber)
            .width('60%')
            .maxLength(11)
            .fontColor('#212121')
            .fontSize(14)
            .alignSelf(ItemAlign.Center)
            .onChange(value => {
              this.phoneNumber = value
            })
          Blank()
          Text("拨打电话")
            .width(90)
            .height(33)
            .textAlign(TextAlign.Center)
            .borderRadius(18)
            .borderStyle(BorderStyle.Solid)
            .backgroundColor('#ff4081')
            .fontColor('#ffffff')
            .onClick(() => {
              this.call()
            })
        }
        .width('100%')
        .margin({ top: 20 })

        Text(this.warning)
          .fontColor('#ff4081')
          .fontSize(12)
          .margin({ left: 15, top: 5 })
          .fontWeight(FontWeight.Regular)
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
      .alignItems(HorizontalAlign.Start)

    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  call() {
    // 调用查询能力接口
    let isSupport = call.hasVoiceCapability();
    if (!isSupport) {
      this.warning = 'not support voice capability'
      return;
    }

    if (this.phoneNumber == null || this.phoneNumber.length <= 0) {
      this.warning = 'phone number is error'
      return
    }

    // 如果设备支持呼叫能力，则继续跳转到拨号界面，并显示拨号的号码
    call.makeCall(this.phoneNumber, (err) => {
      if (!err) {
        this.warning = "make call success."
      } else {
        this.warning = "make call fail, err is:" + JSON.stringify(err)
      }
    });

    // 订阅通话业务状态变化
    // observer.on("callStateChange", (data) => {
    //   console.log("call state change, data is:" + JSON.stringify(data));
    // });
  }
}