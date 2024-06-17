import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';
import permissionUtils from '../../common/utils/PermissionUtils';
import LinkedList from '@ohos.util.LinkedList';
import { Permissions } from '@ohos.abilityAccessCtrl';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/3/8 11:02
 * @Description： 权限访问
 */
@Entry
@Component
struct PermissionPage {
  private readonly TAG: string = 'PermissionUtils'
  private readonly permissionArray: Array<PermissionShowInfo> = new Array<PermissionShowInfo>()
  private selected: LinkedList<Permissions> = new LinkedList<Permissions>()
  @State result: string = ''

  aboutToAppear() {
    this.permissionArray[0] = {
      name: "ohos.permission.APPROXIMATELY_LOCATION", nickname: "模糊位置", label: "approximately", select: false
    }
    this.permissionArray[1] = {
      name: "ohos.permission.LOCATION", nickname: "定位", label: "location", select: false
    }
    this.permissionArray[2] = {
      name: "ohos.permission.CAMERA", nickname: "相机", label: "camera", select: false
    }
    this.permissionArray[3] = {
      name: "ohos.permission.MICROPHONE", nickname: "麦克风", label: "microphone", select: false
    }
    this.permissionArray[4] = {
      name: "ohos.permission.READ_MEDIA", nickname: "读-外部存储", label: "read_media", select: false
    }
    this.permissionArray[5] = {
      name: 'ohos.permission.WRITE_MEDIA', nickname: "写-外部存储", label: "write_media", select: false
    }
  }

  build() {
    Column() {
      TitleComp({ titleName: '权限管理' })

      Column() {
        Text('注：该页面主要介绍的是 @ohos.abilityAccessCtrl 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)
        this.renderPermissionsPicker()

        Text(this.result)
          .width('100%')
          .height(150)
          .margin({ top: 10 })
          .align(Alignment.TopStart)
          .textAlign(TextAlign.Start)
          .padding(10)
          .fontSize(12)
          .backgroundColor('#bdbdbd')

        TipsComp({ marginSpace: 0, tipArray: [
          '遇到个小插曲，没有在module.json5 文件中配置权限，然后调用requestPermissionsFromUser请求权限，返回的结果既不是-1，也不是0，而是2！'
        ] })

        TipsComp({ label: '疑问', marginSpace: 0, tipArray: [
          '测试场景：没有读写权限，先申请读权限，然后检查写权限，结果：写权限没有授权，符合预期。然后调用授权方法，但是却没有弹窗框？ 然后直接收到授权成功的异步回调',
          '测试场景：没有读写权限，先申请写权限，然后检查读权限，结果：已授权。所以是有写权限就有读权限？？？'
        ] })

      }
      .width('100%')
      .padding({ left: 15, top: 15, right: 15 })
      .layoutWeight(1)
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderPermissionsPicker() {
    List() {
      ForEach(this.permissionArray, (item, index) => {
        ListItem() {
          Row() {
            Checkbox({ name: item.label, group: 'permissions' })
              .onChange((value) => {
                item.select = value
                if (value) {
                  this.selected.add(item.name)
                } else {
                  this.selected.remove(item.name)
                }
              })
            Text(item.nickname)
              .margin({ left: 3 })
              .fontColor('#212121')
              .fontSize(12)
          }
          .height('100%')
          .alignItems(VerticalAlign.Center)
        }
        .height(30)
      }, item => item.name)
    }
    .width('100%')
    .margin({ top: 10 })
    .listDirection(Axis.Vertical)
    .lanes(2)

    Row() {
      Button('权限检查')
        .width(100)
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.result = '开始检查权限'
          for (let i = 0; i < this.selected.length; i++) {
            let p = this.selected.get(i)
            permissionUtils.checkPermission(p)
              .then((grantStatus) => {
                let result: string;
                if (grantStatus == 0) {
                  result = "已授权"
                } else {
                  result = "未授权"
                }
                this.result = `${this.result}\n检查权限：${p}\n结果：${result}`
              })
          }
        })

      Button('请求授权')
        .width(100)
        .height(30)
        .fontSize(14)
        .onClick(() => {
          this.result = '开始请求授权'
          permissionUtils.requestPermissions(getContext(this), this.selected.convertToArray())
            .then((requestResult) => {
              let r: string = '';

              for (let index = 0; index < requestResult.results.length; index++) {
                const element = requestResult.results[index];
                console.info(this.TAG, `权限：${element.name}， 结果：${element.authResult}`);
                r = `${r}\n权限：${element.name} 结果：${element.authResult}`
              }
              this.result = `${this.result}${r}\n结束`
            })
            .catch((error) => {
              console.info(this.TAG, `请求授权-error=${error}`);
            })
        })
    }
    .width('100%')
    .margin({ top: 20 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}

declare type PermissionShowInfo = {
  name: string,
  label: string
  nickname: string,
  select: boolean
}
