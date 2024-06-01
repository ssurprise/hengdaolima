import { RefreshViewObj } from '../utils/RefreshLoad'


@Component
export struct PullDownRefreshView {
  @ObjectLink stateDetail: RefreshViewObj;

  build() {
    Row() {
      Image(this.stateDetail.imageSrc)
        .width(18)
        .height(18)

      Text(this.stateDetail.textValue)
        .margin({ left: 7, bottom: 1 })
        .fontSize(17)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(70)
    .justifyContent(FlexAlign.Center)
  }
}