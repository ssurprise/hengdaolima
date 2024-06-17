import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';

@Entry
@Component
struct AnimationPage {
  @State myWidth: number = 100;
  @State myHeight: number = 100;
  @State mAngle: number = 0;
  private flag: boolean = false

  build() {
    Column() {
      TitleComp({ titleName: '属性动画' })

      Row() {
        Image($r('app.media.image_05'))
          .width(this.myWidth)
          .height(this.myWidth)
          .rotate({
            x: 1,
            y: 0,
            z: 0,
            centerX: '50%',
            centerY: '50%',
            angle: this.mAngle
          })
            //animation只对其上面的type、width、height属性生效，时长为1000ms，曲线为Ease
          .animation({
            // 设置动画时长。默认值：1000，单位：毫秒
            duration: 1000,
            // 动画播放速度。数值越大，动画播放速度越快，数值越小，播放速度越慢。值为0时，表示不存在动画。默认值：1
            tempo: 1.0,
            // 设置动画延迟执行的时长。默认值：0，不延迟播放。单位：毫秒
            delay: 0,
            // 设置动画曲线
            curve: Curve.Linear,
            // 设置动画播放模式，默认播放完成后重头开始播放。
            // Normal：动画按正常播放。Reverse：动画反向播放。
            // Alternate：动画在奇数次（1、3、5...）正向播放，在偶数次（2、4、6...）反向播放。
            // AlternateReverse：动画在奇数次（1、3、5...）反向播放，在偶数次（2、4、6...）正向播放。
            playMode: PlayMode.Alternate,
            // 设置播放次数。默认值：1，取值范围：[-1, +∞)
            iterations: 1
          })
          .objectFit(ImageFit.Cover)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(260)

      Button('开始')
        .margin({ top: 10 })
        .onClick(() => {
          if (this.flag) {
            this.myWidth = 100
            this.myHeight = 100
            this.mAngle = 0
          } else {
            this.myWidth = 200
            this.myHeight = 200
            this.mAngle = 180
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