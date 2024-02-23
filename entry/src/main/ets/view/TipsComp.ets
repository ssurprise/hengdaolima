/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/21 11:03
 * @Description： 提示说明自定义组件
 */
@Component
export struct TipsComp {
  private label: string = '说明：'
  private marginSpace: Length = $r('app.float.tip_comp_margin_left')
  private tipArray: Array<String>

  build() {
    Column() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)

      ForEach(this.tipArray, (item: String, index: number) => {
        Text(`${index + 1}. ${item}`)
          .margin({ top: 2 })
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
      }, (item: String, index: number) => index + "")
    }
    .alignItems(HorizontalAlign.Start)
    .alignSelf(ItemAlign.Start)
    .margin({ left: this.marginSpace, top: 20, right: this.marginSpace })
  }
}