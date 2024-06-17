import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'
import promptAction from '@ohos.promptAction';


@Entry
@Component
struct AlertDialogPage {

  build() {
    Column() {
      TitleComp({ titleName: '警告弹窗' })

      Column() {
        Text('调用的是 AlertDialog.show 方法，可配置标题、内容、对其方式、偏移量、点击遮障层的时候是否关闭弹窗、回调函数...下面做个简单演示')
          .fontColor('#ff4081')
          .fontSize(12)
          .padding(10)
          .backgroundColor('#f5f5f5')
          .margin({ top: 10 })

        this.showAlertDialog()
      }
      .width('100%')
      .padding({ left: 15, top: 20, right: 15 })
      .alignItems(HorizontalAlign.Start)

      TipsComp({
        tipArray:[
          'gridCounts：弹窗容器宽度所占用栅格数。该属性一定要设置合理值，如果设置为0，则不会显示',
          '通过侧滑或者其他返回方式可以取消警告弹窗，即使 autoCancel 配置为true， 另外不会触发cancel（）回调'
        ]
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder showAlertDialog() {
    Row() {
      Button('1个按钮')
        .backgroundColor(0x317aff)
        .onClick(() => {
          AlertDialog.show(
            {
              title: '一个按钮',
              message: '点击空白可取消，屏幕位置：居中，x轴偏移30vp',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              offset: { dx: 30, dy: 0 },
              gridCount: 5,
              confirm: {
                value: '知道了',
                action: () => {
                  promptAction.showToast({ message: '收到点击按钮回调' })
                }
              },
              cancel: () => {
                promptAction.showToast({ message: '收到cancel 回调' })
              }
            }
          )
        })

      Button('2个按钮')
        .backgroundColor(0x317aff)
        .onClick(() => {
          AlertDialog.show(
            {
              title: '2个按钮',
              message: '点击空白不可取消，屏幕位置：下，Y轴偏移 -50vp',
              autoCancel: false,
              alignment: DialogAlignment.Bottom,
              gridCount: 5, // 弹窗容器宽度所占用栅格数
              offset: { dx: 0, dy: -50 },
              primaryButton: {
                value: '取消',
                action: () => {
                  promptAction.showToast({ message: '点击取消按钮' })
                }
              },
              secondaryButton: {
                value: '确认',
                action: () => {
                  promptAction.showToast({ message: '点击确定按钮' })
                }
              },
              cancel:()=>{
                promptAction.showToast({ message: '收到cancel 回调' })
              }
            }
          )
        })
    }
    .width('100%')
    .margin({ top: 20 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}