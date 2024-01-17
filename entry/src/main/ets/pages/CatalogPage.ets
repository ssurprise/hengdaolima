import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Component
@Entry
export struct CatalogPage {
  build() {
    Column() {
      this.title()

    }
  }

  @Builder title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left')
        })
        .onClick(() => {
          router.back();
        })
      Text($r("app.string.title"))
        .fontSize($r("app.float.title_text_size"))
        .fontColor($r("app.color.title"))
        .fontStyle(FontStyle.Normal)
    }.width(CommonConstants.FULL_WIDTH_PERCENT)
    .height("24vp")
  }

  onPageShow() {
    let n: Number = router.getParams()["index"]
    console.info("hengdaolima", "CatalogPage-onPageShow, n=" + n)
  }

  onPageHide() {
    console.info("hengdaolima", "CatalogPage-onPageHide")
  }

  onBackPress(){
    console.info("hengdaolima", "CatalogPage-onBackPress")
  }
}