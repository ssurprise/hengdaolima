import { TitleComp } from '../view/TitleComp';


@Entry
@Component
struct RefreshPage {
  // https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-container-refresh-0000001478181429-V3

  @State isRefreshing: boolean = false
  @State mState: string = '-1'
  readonly text = '先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。然侍卫之臣不懈于内，忠志之士忘身于外者，盖追先帝之殊遇，欲报之于陛下也。诚宜开张圣听，以光先帝遗德，恢弘志士之气，不宜妄自菲薄，引喻失义，以塞忠谏之路也。\n宫中府中，俱为一体，陟罚臧否，不宜异同。若有作奸犯科及为忠善者，宜付有司论其刑赏，以昭陛下平明之理，不宜偏私，使内外异法也。\n侍中、侍郎郭攸之、费祎、董允等，此皆良实，志虑忠纯，是以先帝简拔以遗陛下。愚以为宫中之事，事无大小，悉以咨之，然后施行，必能裨补阙漏，有所广益。\n将军向宠，性行淑均，晓畅军事，试用于昔日，先帝称之曰能，是以众议举宠为督。愚以为营中之事，悉以咨之，必能使行阵和睦，优劣得所。\n亲贤臣，远小人，此先汉所以兴隆也；亲小人，远贤臣，此后汉所以倾颓也。先帝在时，每与臣论此事，未尝不叹息痛恨于桓、灵也。侍中、尚书、长史、参军，此悉贞良死节之臣，愿陛下亲之信之，则汉室之隆，可计日而待也。\n臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。\n先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明，故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。\n愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏，臣不胜受恩感激。\n今当远离，临表涕零，不知所言。'

  build() {
    Column() {
      TitleComp({ titleName: '刷新-Refresh' })

      Refresh({ refreshing: $$this.isRefreshing, offset: 20, friction: 62 }) {
        Scroll() {
          Text(this.text)
            .fontSize(14)
            .margin(10)
        }
        .width("100%")
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('90%')
      .height(400)
      .backgroundColor("#22ff4081")
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false
        }, 1000)
      })
      .onStateChange((state: RefreshStatus) => {
        this.mState = state + ""
      })

      Text(`state: ${this.mState}`)
      this.renderTips()
    }
    .width('100%')
  }

  @Builder renderTips() {
    Text('说明：')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 50, left: 12, right: 10 })
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.Red)
    Text('1. offset属性：下拉起点距离组件顶部的距离。默认值：16单位：vp. 取值范围：[0vp,64vp]，大于64vp按照64vp处理。')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 10, right: 10 })
      .fontSize(12)
      .fontStyle(FontStyle.Italic)
    Text('2. friction属性：下拉摩擦系数，取值范围为0到100。默认值：62。0表示下拉刷新容器不跟随手势下拉而下拉。数值越大，下拉刷新容器跟随手势下拉的反应越灵敏。')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 10, right: 10 })
      .fontSize(12)
      .fontStyle(FontStyle.Italic)
    Text('3. 样式暂不支持自定义！')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 10, right: 10 })
      .fontSize(12)
      .fontColor("#ff4081")
      .fontStyle(FontStyle.Italic)
    Text('4. 如果内有子组件Scroll，那么会和Scroll的回弹效果有冲突。')
      .alignSelf(ItemAlign.Start)
      .margin({ top: 5, left: 10, right: 10 })
      .fontSize(12)
      .fontColor("#ff4081")
      .fontStyle(FontStyle.Italic)
  }

  pageTransition(){

  }
}