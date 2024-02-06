import { TitleComp } from '../view/TitleComp'


@Entry
@Component
struct AlertDialogPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComp({ titleName: '弹窗' })
      Button('警告弹窗-1个按钮')
        .margin({ left: 16, right: 16, top: 20 })
        .backgroundColor(0x317aff)
        .onClick(() => {
          AlertDialog.show(
            {
              title: 'title',
              message: 'text',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              offset: { dx: 0, dy: -20 },
              gridCount: 3,
              confirm: {
                value: 'button',
                action: () => {
                  console.info('Button-clicking callback')
                }
              },
              cancel: () => {
                console.info('Closed callbacks')
              }
            }
          )
        })

      Button('警告弹窗-2个按钮')
        .margin({ left: 16, right: 16, top: 20 })
        .backgroundColor(0x317aff)
        .onClick(() => {
          AlertDialog.show(
            {
              title: 'title',
              message: 'text',
              autoCancel: true,
              alignment: DialogAlignment.Bottom,
              gridCount: 4, // 弹窗容器宽度所占用栅格数
              offset: { dx: 0, dy: -20 },
              primaryButton: {
                value: 'cancel',
                action: () => {
                  console.info('Callback when the first button is clicked')
                }
              },
              secondaryButton: {
                value: 'ok',
                action: () => {
                  console.info('Callback when the second button is clicked')
                }
              },
              cancel: () => {
                console.info('Closed callbacks')
              }
            }
          )
        })

    }.alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}