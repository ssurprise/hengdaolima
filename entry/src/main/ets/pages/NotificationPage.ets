import { TitleComp } from '../view/TitleComp';
import NotificationManager from '@ohos.notificationManager';


@Entry
@Component
struct NotificationPage {
  @State message: string = 'Hello World'
  @State mType: NotificationManager.ContentType = NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT
  private mTitle: string = ''
  private mText: string = ''
  private mExpandedTitle: string = ''
  private mLongText: string = ''
  private mLines = []

  build() {
    Column() {
      TitleComp({ titleName: '通知' })

      this.renderContentType()
      this.renderForm()

      Button('发送')
        .height(40)
        .width(80)
        .margin({ right: 15 })
        .alignSelf(ItemAlign.End)
        .type(ButtonType.Capsule)
        .onClick(() => {
          this.sendNotification()
        })

      this.renderTips()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  private sendNotification() {
    let notificationRequest =
      {
        id: 1,
        content: {
          slotType: NotificationManager.SlotType.SERVICE_INFORMATION,
          contentType: this.mType,
          normal: {
            title: this.mTitle,
            text: this.mText,
            longText: this.mLongText,
            expandedTitle: this.mExpandedTitle,
            longTitle: this.mExpandedTitle,
            lines: this.mLines
          }
        }
      }
    NotificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.error(`[ANS] failed to publish, error[${err}]`);
        return;
      }
      console.info(`[ANS] publish success`);
    });
  }

  @Builder renderContentType() {
    Text('通知内容类型')
      .fontColor("#212121")
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .margin({ left: 15, top: 15 })

    Row() {
      Row() {
        Radio({ value: "BASIC_TEXT", group: "NotificationType" })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mType = NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT
            }
          })
        Text('普通文本类型')
          .fontColor('#212121')
          .fontSize(12)
      }.width('50%')

      Row() {
        Radio({ value: "LONG_TEXT", group: "NotificationType" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mType = NotificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT
            }
          })
        Text('长文本类型')
          .fontColor('#212121')
          .fontSize(12)
      }.width('50%')
    }
    .height(30)
    .margin({ left: 15, top: 5, right: 15 })

    Row() {
      Row() {
        Radio({ value: "MULTILINE", group: "NotificationType" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mType = NotificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE
            }
          })
        Text('多行文本类型')
          .fontColor('#212121')
          .fontSize(12)
      }.width('50%')

      Row() {
        Radio({ value: "PICTURE", group: "NotificationType" })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.mType = NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE
            }
          })
        Text('图片类型')
          .fontColor('#212121')
          .fontSize(12)
      }.width('50')
    }
    .height(30)
    .margin({ left: 15, right: 15 })
  }

  @Builder renderForm() {
    Column() {
      Text('通知标题')
        .fontWeight(FontWeight.Medium)
        .fontColor("#212121")
        .fontSize(12)
      TextInput({ text: '我是通知标题', placeholder: '请输入标题（必填）' })
        .margin({ top: 3 })
        .fontSize(12)
        .width('90%')
        .onChange((val) => {
          this.mTitle = val
        })

      Text('通知内容')
        .fontWeight(FontWeight.Medium)
        .fontColor("#212121")
        .fontSize(12)
        .margin({ top: 5 })
      TextInput({ text: '我是通知内容', placeholder: '请输入文本内容（必填）' })
        .margin({ top: 3 })
        .fontSize(12)
        .width('90%')
        .onChange((val) => {
          this.mText = val
        })

      if (NotificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT == this.mType) {
        this.renderLongText()
      } else if (NotificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE == this.mType) {
        this.renderMutliText()
      } else if (NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE == this.mType) {
        this.renderPicture()
      } else {
      }
    }
    .width('90%')
    .margin({ top: 10 })
    .padding(10)
    .alignSelf(ItemAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(10)
    .backgroundColor("#09757575")
  }

  @Builder renderLongText() {
    // 长文本类型通知，在基础文本类型的基础上新增了长文本内容、内容概要和通知展开时的标题
    Text('通知展开时的标题')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({ text: '展示时的标题', placeholder: '请输入通知展开时的标题' })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mExpandedTitle = val
      })

    Text('通知的长文本')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({
      text: '那么长长长长长长长长长长长长长长长长长长长长长长长长的文本内容啊',
      placeholder: '请输入多行文本内容'
    })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mLongText = val
      })
  }

  @Builder renderMutliText() {
    Text('通知展开时的标题')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({ text: '展示时的标题', placeholder: '请输入通知展开时的标题' })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mExpandedTitle = val
      })

    Text('多行内容·1')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({ text: '多行内容的第一行内容是这样的哦', placeholder: '请输入多行文本内容' })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mLines[0] = val
      })

    Text('多行内容·2')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({ text: '多行内容的第二行内容是这样的哦', placeholder: '请输入多行文本内容' })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mLines[1] = val
      })
  }

  @Builder renderPicture() {
    Text('通知展开时的标题')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
    TextInput({ text: '展示时的标题', placeholder: '请输入通知展开时的标题' })
      .margin({ top: 3 })
      .fontSize(12)
      .width('90%')
      .onChange((val) => {
        this.mExpandedTitle = val
      })
    Text('关于图片，直接代码中写死了。')
      .fontWeight(FontWeight.Medium)
      .fontColor("#212121")
      .fontSize(12)
      .margin({ top: 5 })
  }

  @Builder renderTips() {
    Text('说明：')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 50, left: 12, right: 10 })
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
    Text('1. 考虑到高度问题，上面的配置中省略了附加信息、概要内容的填写。通知内容为多行时，为了简单，只提供了两行配置。')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 10, right: 10 })
      .fontSize(12)
      .fontStyle(FontStyle.Italic)
  }
}