import router from '@ohos.router';

@Component
export struct TitleComp {
  titleName: string

  /**
   * In low-code mode, do not add anything to the build function, as it will be
   * overwritten by the content generated by the .visual file in the build phase.
   */
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({
            left: $r('app.float.image_margin_left'),
            right: $r('app.float.image_margin_right')
          })
          .onClick(() => {
            router.back();
          })
        Text(this.titleName)
          .fontSize($r("app.float.title_text_size"))
          .fontColor($r("app.color.title"))
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(VerticalAlign.Center)
      .width("100%")
      .height($r("app.float.title_height"))

      Divider()
        .width("100%")
        .height("1px")
        .color("#bdbdbd")
    }
  }
}