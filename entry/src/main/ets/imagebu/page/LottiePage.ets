import { TitleComp } from '../../common/view/TitleComp'
import lottie, { AnimationItem } from '@ohos/lottie'


/**
 * lottie官方文档：https://gitee.com/openharmony-tpc/lottieArkTS
 *
 * 加载动画时，path 参数和 animationData 参数，二者选其一。
 * - path 参数：只支持加载entry/src/main/ets 文件夹下的相对路径，不支持跨包查找文件。
 * - animationData 参数：可结合ResourceManager进行读取资源文件内容进行设置。
 */
@Entry
@Component
struct LottiePage {
  readonly TAG: string = 'LottiePage'

  // 初始化渲染上下文
  private renderingSettings: RenderingContextSettings = new RenderingContextSettings(true) // 设置开启抗锯齿
  private renderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings) // 创建2D渲染上下文
  private animateItem: AnimationItem | null = null;
  private animateName: string = 'hh';
  @State frameCount: number = 0;

  build() {
    Column() {
      TitleComp({ titleName: 'json动画-Lottie' })

      Column() {
        Text('注：该页面主要介绍的是第三方库 @ohos/lottie 提供的动画功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)
          .margin({ top: 10 })

        Canvas(this.renderingContext)
          .backgroundColor('#22757575')
          .width('70%')
          .height(160)
          .alignSelf(ItemAlign.Center)
          .onReady(() => {
            console.info(this.TAG, 'Canvas-onReady')
          })
          .onAppear(() => {
            console.info(this.TAG, 'Canvas-onAppear')
          })
          .onDisAppear(() => {
            console.info(this.TAG, 'Canvas-onDisAppear')
            lottie.destroy(this.animateName);
          })
          .margin({ top: 20 })

        Text(`动画总帧数：${this.frameCount}`)
          .fontSize(10)
          .fontStyle(FontStyle.Italic)

        this.renderController()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 15, right: 15 })
      .backgroundColor('#f5f5f5')
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder renderController() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Stretch, justifyContent: FlexAlign.SpaceEvenly }) {
      Button('播放')
        .onClick(() => {
          if (this.animateItem !== null) {
            this.animateItem.destroy();
            this.animateItem = null;
          }
          this.animateItem = lottie.loadAnimation({
            container: this.renderingContext, //渲染上下文
            renderer: 'canvas', // 渲染方式
            loop: 5, // 是否循环播放,默认true
            autoplay: true, // 是否自动播放，默认true
            name: this.animateName, // 动画名称
            path: 'imagebu/anim/anim.json' // json路径. 注：加载动画时，path 参数和 animationData 参数，二者选其一。
          });
          // let AnimationEventName = 'enterFrame' | 'loopComplete' | 'complete' | 'segmentStart' | 'destroy' | 'DOMLoaded';
          this.animateItem.addEventListener("enterFrame", function () {
            console.info(this.TAG, 'enterFrame')
          })
          this.animateItem.addEventListener("loopComplete", function () {
            console.info(this.TAG, 'loopComplete')
          })
          this.animateItem.addEventListener("complete", function () {
            console.info(this.TAG, 'complete')
          })

          this.frameCount = this.animateItem.getDuration(true)
        })
      Button('暂停')
        .onClick(() => {
          if (this.animateItem != null) {
            this.animateItem.pause(this.animateName)
          }
        })
      Button('切换')
        .onClick(() => {
          if (this.animateItem != null) {
            this.animateItem.togglePause(this.animateName)
          }
        })
      Button('停止')
        .onClick(() => {
          if (this.animateItem != null) {
            this.animateItem.stop(this.animateName)
          }
        })
    }
    .margin({ top: 15 })
  }
}