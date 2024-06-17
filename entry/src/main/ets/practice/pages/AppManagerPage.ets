import appManager from '@ohos.app.ability.appManager';
import { TitleComp } from '../../common/view/TitleComp'
import { TipsComp } from '../../common/view/TipsComp'


@Entry
@Component
struct AppManagerPage {
  @State runningInStabilityTestResult: string = ""
  @State isRamConstrainedDeviceResult: string = ""
  @State appMemorySize: string = ""
  @State runningProcessInfo: string = ""

  build() {
    Column() {
      TitleComp({ titleName: 'appManager' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.app.ability.appManager 包提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 20 })

        this.renderIsRunningInStabilityTest()
        this.renderIsRamConstrainedDevice()
        this.renderGetAppMemorySize()

        TipsComp({ tipArray: [
          "getAppMemorySize：该api只能获取自己的内存占用信息，无法获取其他app的",
          'getRunningProcessInformation：获取有关运行进程的信息。需要有权限：ohos.permission.GET_RUNNING_INFO，该demo的访问权限不足！'
        ], marginSpace: 0 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: $r('app.float.page_space_left'), right: $r('app.float.page_space_right') })
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderIsRunningInStabilityTest() {
    Row() {
      Column() {
        Text('当前是否处于稳定性测试场景')
          .fontColor('#212121')
          .fontSize(14)
        Text(`结果：${this.runningInStabilityTestResult}`)
          .fontColor('#ff4081')
          .fontSize(12)
          .margin({ top: 2 })
      }.alignItems(HorizontalAlign.Start)

      Blank()
      Text('查询')
        .fontSize(14)
        .height(30)
        .width(70)
        .textAlign(TextAlign.Center)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#ff4081')
        .borderRadius(20)
        .onClick(() => {
          appManager.isRunningInStabilityTest().then((flag) => {
            this.runningInStabilityTestResult = JSON.stringify(flag)
          }).catch((error) => {
            this.runningInStabilityTestResult = JSON.stringify(error)
          });
        })
    }
    .width('100%')
    .padding({ left: 12, top: 15, right: 12, bottom: 15 })
    .margin({ top: 20 })
    .borderRadius(12)
    .backgroundColor('#ffffff')
  }

  @Builder renderIsRamConstrainedDevice() {
    Row() {
      Column() {
        Text('是否为ram受限设备')
          .fontColor('#212121')
          .fontSize(14)
        Text(`结果：${this.isRamConstrainedDeviceResult}`)
          .fontColor('#ff4081')
          .fontSize(12)
          .margin({ top: 2 })
      }.alignItems(HorizontalAlign.Start)

      Blank()
      Text('查询')
        .fontSize(14)
        .height(30)
        .width(70)
        .textAlign(TextAlign.Center)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#ff4081')
        .borderRadius(20)
        .onClick(() => {
          appManager.isRamConstrainedDevice().then((data) => {
            this.isRamConstrainedDeviceResult = JSON.stringify(data)
          }).catch((error) => {
            this.isRamConstrainedDeviceResult = JSON.stringify(error)
          });
        })
    }
    .width('100%')
    .padding({ left: 12, top: 15, right: 12, bottom: 15 })
    .margin({ top: 10 })
    .borderRadius(12)
    .backgroundColor('#ffffff')
  }

  @Builder renderGetAppMemorySize() {
    Row() {
      Column() {
        Text('获取应用程序的内存大小')
          .fontColor('#212121')
          .fontSize(14)
        Text(`结果：${this.appMemorySize}`)
          .fontColor('#ff4081')
          .fontSize(12)
          .margin({ top: 2 })
      }.alignItems(HorizontalAlign.Start)

      Blank()
      Text('查询')
        .fontSize(14)
        .height(30)
        .width(70)
        .textAlign(TextAlign.Center)
        .fontColor('#ffffff')
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#ff4081')
        .borderRadius(20)
        .onClick(() => {
          appManager.getAppMemorySize().then((data) => {
            this.appMemorySize = JSON.stringify(data)
          }).catch((error) => {
            this.appMemorySize = JSON.stringify(error)
          });
        })
    }
    .width('100%')
    .padding({ left: 12, top: 15, right: 12, bottom: 15 })
    .margin({ top: 10 })
    .borderRadius(12)
    .backgroundColor('#ffffff')
  }
}