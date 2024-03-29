import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';

@Entry
@Component
struct AnimationPage {
  @State myWidth: number = 100;
  @State myHeight: number = 100;
  private flag: boolean = false

  build() {
    Column() {
      TitleComp({ titleName: '属性动画' })

      Row() {
        Image($r('app.media.image_05'))
          .width(this.myWidth)
          .height(this.myWidth)
            //animation只对其上面的type、width、height属性生效，时长为1000ms，曲线为Ease
          .animation({
            duration: 1000,
            tempo: 1.0,
            delay: 0,
            curve: Curve.Linear,
            playMode: PlayMode.Alternate,
            iterations: 1
          })
          .objectFit(ImageFit.Cover)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(300)

      Button('开始')
        .margin({ top: 10 })
        .onClick(() => {
          if (this.flag) {
            this.myWidth = 100
            this.myHeight = 100
          } else {
            this.myWidth = 300
            this.myHeight = 200
          }
          this.flag = !this.flag
        })

      this.renderTips()
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '想要组件随某个属性值的变化而产生动画，此属性需要加在animation属性之前。有的属性变化不希望通过animation产生属性动画，可以放在animation之后',
      '属性动画支持的属性包括width、height、backgroundColor、opacity、scale、rotate、translate等',
      '如果一个属性配置了属性动画，且在显式动画闭包中改变该属性值，属性动画优先生效，会使用属性动画的动画参数。'
    ] })
  }
}