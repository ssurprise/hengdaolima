import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';
import HashMap from '@ohos.util.HashMap';

/**
 * 像素单位转换
 * px、vp、fp、lpx
 */
@Entry
@Component
struct PxAndVpPage {
  private num: number
  @State unitStr: string = 'px'
  @State unitCovertTip: string = ''
  @State mResults: Array<string> = []
  private readonly unitMap: HashMap<String, Array<string>> = new HashMap();

  aboutToAppear() {
    this.unitMap.set('px', ['vp', 'fp', 'lpx'])
    this.unitMap.set('vp', ['px'])
    this.unitMap.set('fp', ['px'])
    this.unitMap.set('lpx', ['px'])
  }

  build() {
    Column() {
      TitleComp({ titleName: '像素单位转换' })
      Column() {

        this.renderSelector()

        Row() {
          TextInput({ placeholder: '输入数字' })
            .width('50%')
            .fontSize(14)
            .placeholderFont({ size: 14 })
            .type(InputType.Number)
            .onChange((value) => {
              try {
                this.num = Number.parseInt(value)
              } catch (e) {
              }
            })

          Text(`${this.unitStr}`)
            .margin({ left: 5 })
            .fontColor('#ff4081')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)

          Blank()

          Button("转换")
            .height(30)
            .padding({ left: 20, top: 1, right: 20, bottom: 1 })
            .type(ButtonType.Normal)
            .borderRadius(8)
            .fontSize(14)
            .onClick(() => {
              this.startConvert()
            })
        }
        .width('100%')
        .margin({ top: 20 })
        .justifyContent(FlexAlign.Center)

        Text('结果：')
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
          .fontSize(16)
          .margin({ top: 50 })

        if (this.unitCovertTip != undefined && this.unitCovertTip != null && this.unitCovertTip.length > 0) {
          Text(this.unitCovertTip)
            .width('100%')
              // .padding(5)
            .fontSize(12)
            .fontColor('#ff4081')
              // .backgroundColor('#f5f5f5')
              // .borderRadius(3)
            .margin({ top: 5 })
        }

        if (this.mResults.length > 0) {
          ForEach(this.mResults, (item: string) => {
            Text(item)
              .width('100%')
              .padding({ left: 10, top: 8, bottom: 8 })
              .fontColor('#212121')
              .backgroundColor('#f5f5f5')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 8 })
          }, (index: number) => index.toString())
        }
      }
      .width('100%')
      .padding({ top: 30, left: 15, right: 15 })
      .alignItems(HorizontalAlign.Start)

      this.renderTips()
    }
    .width('100%')
    .height('100%')
  }

  startConvert() {
    let targetUnits = this.unitMap.get(this.unitStr)

    // 1.转换单位检查
    if (this.num == undefined || this.num == null) {
      this.unitCovertTip = '错误：请输入要转换的数字！'
      return
    }
    if (targetUnits == null || targetUnits.length <= 0) {
      this.unitCovertTip = '错误：未找到匹配的换算单位！'
      return
    }
    this.unitCovertTip = `系统提供了 ${this.unitStr} 对 ${targetUnits} 单位的转换`

    // 2.单位转换
    let values: string[] = new Array(targetUnits.length)
    targetUnits.forEach((item, index) => {
      let cmd: string = `${this.unitStr}2${item}`
      let result: string = ""
      switch (cmd) {
        case "px2vp":
          result = `=>vp，值：${px2vp(this.num)}`
          break
        case "px2fp":
          result = `=>fp，值：${px2fp(this.num)}`
          break
        case "px2lpx":
          result = `=>lpx，值：${px2lpx(this.num)}`
          break
        case "vp2px":
          result = `=>px，值：${vp2px(this.num)}`
          break
        case "fp2px":
          result = `=>px，值：${fp2px(this.num)}`
          break
        case "lpx2px":
          result = `=>px，值：${lpx2px(this.num)}`
          break
        default:
          result = `${cmd}? 暂未找到匹配的转换方法！`
          break
      }
      values[index] = result
    });
    // 3.渲染视图
    this.mResults = values
  }

  @Builder renderSelector() {
    Row() {
      Text("选择单位：")
        .fontSize(14)
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)

      Radio({ group: 'pxunit', value: 'px' })
        .margin({ left: 10 })
        .checked(true)
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.unitStr = 'px'
          }
        })
      Text("px")
        .margin({ left: 5 })
        .fontSize(14)

      Radio({ group: 'pxunit', value: 'vp' })
        .margin({ left: 20 })
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.unitStr = 'vp'
          }
        })
      Text("vp")
        .margin({ left: 5 })
        .fontSize(14)

      Radio({ group: 'pxunit', value: 'fp' })
        .margin({ left: 20 })
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.unitStr = 'fp'
          }
        })
      Text("fp")
        .margin({ left: 5 })
        .fontSize(14)

      Radio({ group: 'pxunit', value: 'lpx' })
        .margin({ left: 20 })
        .onChange((isChecked: boolean) => {
          if (isChecked) {
            this.unitStr = 'lpx'
          }
        })
      Text("lpx")
        .margin({ left: 5 })
        .fontSize(14)
    }
  }

  @Builder renderTips() {
    TipsComp({
      tipArray: [
        'px：屏幕物理像素单位。',
        'vp：屏幕密度相关像素，根据屏幕像素密度转换为屏幕物理像素，当数值不带单位时，默认单位vp。在实际宽度为1440物理像素的屏幕上，1vp约等于3px。在android 中对应的是dp',
        'fp：字体像素，与vp类似适用屏幕密度变化，随系统字体大小设置变化。在Android 中对应的是sp',
        'lpx：视窗逻辑像素单位，lpx单位为实际屏幕宽度与逻辑宽度（通过designWidth配置）的比值，designWidth默认值为720。当designWidth为720时，在实际宽度为1440物理像素的屏幕上，1lpx为2px大小。',
      ] })
      .margin({ top: 30 })
  }
}