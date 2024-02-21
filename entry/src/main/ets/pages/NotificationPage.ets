import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';
import NotificationManager from '@ohos.notificationManager';
import image from '@ohos.multimedia.image';


@Entry
@Component
struct NotificationPage {
  readonly TAG: string = 'NotificationPage'
  @State mType: NotificationManager.ContentType = NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT
  private notificationId: number = 1
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
        .margin({ top: 10, right: 30 })
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

  async sendNotification() {

    // 获取图片信息
    let pixelMap = null
    if (NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE == this.mType) {
      let resManager = getContext(this).resourceManager
      let imageArray = await resManager.getMediaContent($r('app.media.ic_launcher').id)
      let imageResource = image.createImageSource(imageArray.buffer)
      pixelMap = await imageResource.createPixelMap();
    }

    let notificationRequest =
      {
        id: this.notificationId++,
        content: {
          slotType: NotificationManager.SlotType.SERVICE_INFORMATION,
          contentType: this.mType,
          normal: {
            title: this.mTitle,
            text: this.mText,
          },
          longText: {
            title: this.mTitle,
            text: this.mText,
            longText: this.mLongText,
            expandedTitle: this.mExpandedTitle,
            briefText: "briefText?"
          },
          multiLine: {
            title: this.mTitle,
            text: this.mText,
            longTitle: this.mExpandedTitle,
            lines: this.mLines,
            briefText: "briefText?"
          },
          picture: {
            title: this.mTitle,
            text: this.mText,
            expandedTitle: this.mExpandedTitle,
            briefText: "briefText?",
            picture: pixelMap
          }
        }
      }
    NotificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.log(this.TAG, `[ANS] failed to publish, error[${err}]`);
        return;
      }
      console.error(this.TAG, `[ANS] publish success`);
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
    TipsComp({
      label: '说明：',
      tipArray: [
        '考虑到高度问题，上面的配置中省略了附加信息、概要内容的填写。通知内容为多行时，为了简单，只提供了两行配置。'
      ]
    })

    TipsComp({
      label: '注意：',
      tipArray: [
        '图片类型通知图片内容为PixelMap型对象，其大小不能超过2M，这点在API文档里并没有体现，但是在指南中有一句描述。如果超过限制大小会报错无效参数。'
      ]
    })

    TipsComp({
      label: '疑问：',
      tipArray: [
        'NotificationPictureContent 展开时的标题属性名称是expandedTitle，而NotificationMultiLineContent 展开时的标题属性名称是longTitle，同一个意思为啥用了俩不一样的名称，我是不理解。'
      ]
    })
  }
}