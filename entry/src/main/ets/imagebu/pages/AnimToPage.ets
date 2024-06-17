import { TipsComp } from '../../common/view/TipsComp';
import { TitleComp } from '../../common/view/TitleComp';


@Entry
@Component
struct AnimToPage {
  // 用于控制Column的alignItems属性
  @State itemAlign: HorizontalAlign = HorizontalAlign.Start;
  allAlign: HorizontalAlign[] = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End];
  alignIndex: number = 0;

  build() {
    Column() {
      TitleComp({ titleName: '显式动画' })

      Column({ space: 10 }) {
        Button("1").width(100).height(50)
        Button("2").width(100).height(50)
        Button("3").width(100).height(50)
      }
      .margin(20)
      .alignItems(this.itemAlign)
      .borderWidth(1)
      .borderColor('#212121')
      .width("90%")
      .height(200)

      Button("click").onClick(() => {
        // 动画时长为1000ms，曲线为EaseInOut
        animateTo({ duration: 1000, curve: Curve.EaseInOut }, () => {
          this.alignIndex = (this.alignIndex + 1) % this.allAlign.length;
          // 在闭包函数中修改this.itemAlign参数，使Column容器内部孩子的布局方式变化，使用动画过渡到新位置
          this.itemAlign = this.allAlign[this.alignIndex];
        });
      })

      this.renderTips()
    }
    .width('100%')
  }

  @Builder renderTips() {
    TipsComp({ tipArray: [
      '显式动画把要执行动画的属性的修改放在闭包函数中触发动画，而属性动画则无需使用闭包',
      '怎么感觉本质上还是属性动画呢？在 animateTo 闭包中修改的也是组件的属性，像宽高这些，只是和 animation(value: AnimateParam) 的实现方式不同。'
    ] })
  }
}