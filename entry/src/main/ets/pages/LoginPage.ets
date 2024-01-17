import router from '@ohos.router';
import MediaQueryModel from '../model/MediaQueryModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { LoginComponent } from '../view/LoginComponent';

/**
 * This template implements the Login function.
 * First register personal details. Log in after entering the username and password.
 * Click the button at the bottom to ask for help and check the privacy statement.
 * Developers can save username and password by Preference or Relational Database.
 */
@Entry
@Component
struct LoginPage {
  aboutToAppear() {
    MediaQueryModel.register();
  }

  aboutToDisappear() {
    MediaQueryModel.unRegister();
  }

  build() {
    Column() {
      this.Title()
      this.catalog()

      Scroll() {
        Column() {
          LoginComponent()

          Blank()

          PrivacyStatementComponent()
        }
        .height(CommonConstants.SCROLL_HEIGHT_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
        .alignItems(HorizontalAlign.Start)
        .padding($r('app.float.login_operation_area_padding'))
      }
      .layoutWeight(CommonConstants.LOGIN_SCROLL_LAYOUT_WEIGHT)
    }
    .width(CommonConstants.LOGIN_PAGE_WIDTH_PERCENT)
    .backgroundColor($r('app.color.login_page_background'))
  }

  @Builder Title() {
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

      Text($r('app.string.title'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }

  @Builder catalog() {
    Row() {
      Text($r('app.string.catalog_text'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(FontWeight.Regular)
        .height("24vp")
        .width("30%")
        .textAlign(TextAlign.Center)
        .onClick(() => {
          router.pushUrl({ url: CommonConstants.ROUTER_CATALOG_PAGE_URL, params: { index: "login" } })
        })
      Text("文本")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(FontWeight.Regular)
        .height("24vp")
        .width("30%")
        .textAlign(TextAlign.Center)
        .onClick(() => {
          router.pushUrl({ url: CommonConstants.ROUTER_Text_PAGE_URL, params: { index: "login" } })
        })
    }.width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}