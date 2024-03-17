import deviceInfo from '@ohos.deviceInfo'
import { TitleComp } from '../view/TitleComp'
import { TipsComp } from '../view/TipsComp'

@Entry
@Component
struct DeviceInfoPage {
  build() {
    Column() {
      TitleComp({ titleName: '设备信息' })
      Column() {

        Text('注：该页面主要介绍的是 @ohos.deviceInfo 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .padding(10)
          .backgroundColor('#f5f5f5')
          .fontWeight(FontWeight.Regular)
          .margin({ top: 10 })

        this.createTextComp('设备类型', `${deviceInfo.deviceType}`, 20)
        this.createTextComp('设备厂家名称', `${deviceInfo.manufacture}`)
        this.createTextComp('设备品牌名称', `${deviceInfo.brand}`)
        this.createTextComp('产品系列', `${deviceInfo.productSeries}`)
        this.createTextComp('认证型号', `${deviceInfo.productModel}`)
        this.createTextComp('内部软件子型号', `${deviceInfo.softwareModel}`)
        this.createTextComp('硬件版本号', `${deviceInfo.hardwareModel}`)
        this.createTextComp('Bootloader版本号', `${deviceInfo.bootloaderVersion}`)
        this.createTextComp('安全补丁级别', `${deviceInfo.securityPatchTag}`)
        this.createTextComp('产品版本', `${deviceInfo.displayVersion}`)
        this.createTextComp('差异版本号', `${deviceInfo.incrementalVersion}`)

        this.createTextComp('系统版本', `${deviceInfo.osFullName}`, 10)
        this.createTextComp('Major版本号', `${deviceInfo.majorVersion}`)
        this.createTextComp('Feature版本号', `${deviceInfo.featureVersion}`)
        this.createTextComp('Build版本号', `${deviceInfo.buildVersion}`)
        this.createTextComp('版本ID', `${deviceInfo.versionId}`)
        this.createTextComp('系统发布类型', `${deviceInfo.osReleaseType}`)
        this.createTextComp('系统软件API版本', `${deviceInfo.sdkApiVersion}`)
        this.createTextComp('首个版本系统软件API版本', `${deviceInfo.firstApiVersion}`)

        // this.createTextComp('设备序列号serial', `${deviceInfo.serial}`, 10)
        // this.createTextComp('设备Udid', `${deviceInfo.udid}`)
        TipsComp({
          tipArray: [
            '设备序列号-serial、设备Udid 需要 ohos.permission.sec.ACCESS_UDID 权限，但是该权限为系统权限，仅对系统应用开放。'
          ],
          marginSpace: 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: $r('app.float.page_space_left'), right: $r('app.float.page_space_right') })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }

  @Builder createTextComp(key: string, value: string, marginTop: number = 2) {
    Text() {
      Span(`${key}：`)
        .fontColor('#212121')
        .fontSize(14)
      Span(value)
        .fontColor('#757575')
        .fontSize(12)
    }
    .margin({ top: marginTop })
    .textAlign(TextAlign.Start)
  }
}