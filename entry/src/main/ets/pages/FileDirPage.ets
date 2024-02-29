import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';
import { FileDirInfo } from '../model/FileDirInfo';


@Entry
@Component
@Preview
struct FileDirPage {
  private fileDirArray: FileDirInfo[] = [
    new FileDirInfo('bundleCodeDir', '<路径前缀>/el1/bundle/', '<路径前缀>/el1/bundle/'),
    new FileDirInfo('distributedFilesDir', '<路径前缀>/el2/distributedFiles/', '<路径前缀>/el2/distributedFiles/<module-name>/'),
    new FileDirInfo('databaseDir', '<路径前缀>/<加密等级>/database/', '<路径前缀>/<加密等级>/database/<module-name>/'),
    new FileDirInfo('cacheDir', '<路径前缀>/<加密等级>/base/cache/', '<路径前缀>/<加密等级>/base/haps/<module-name>/cache/'),
    new FileDirInfo('filesDir', '<路径前缀>/<加密等级>/base/files/', '<路径前缀>/<加密等级>/base/haps/<module-name>/files/'),
    new FileDirInfo('preferencesDir', '<路径前缀>/<加密等级>/base/preferences/', '<路径前缀>/<加密等级>/base/haps/<module-name>/preferences/'),
    new FileDirInfo('tempDir', '<路径前缀>/<加密等级>/base/temp/', '<路径前缀>/<加密等级>/base/haps/<module-name>/temp/'),
  ]
  @State sampleAppTxt: string = getContext(this).getApplicationContext().databaseDir
  @State sampleAbilityTxt: string = getContext(this).databaseDir

  build() {
    Column() {
      TitleComp({ titleName: '应用文件路径' })
      Column() {
        Text('注：该页面主要介绍的是不同上下文所代表的文件存储路径')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderTableTitle()
        this.renderFilePath()
        this.renderExample()
        TipsComp({
          tipArray: [
            '通过ApplicationContext获取应用级别的应用文件路径，此路径是应用全局信息推荐的存放路径，这些文件会跟随应用的卸载而删除。',
            '通过AbilityStageContext、UIAbilityContext、ExtensionContext获取HAP级别的应用文件路径。此路径是HAP相关信息推荐的存放路径，这些文件会跟随HAP的卸载而删除，但不会影响应用级别路径的文件，除非该应用的HAP已全部卸载。',
            'base 目录下包含files/、cache/、temp/和haps/'
          ],
          marginSpace: 0
        })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 10, left: 10, right: 10 })
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderTableTitle() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Stretch
    }) {
      Text('属性')
        .padding(8)
        .layoutWeight(20)
        .fontSize(14)
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)
      Divider()
        .height(20)
        .vertical(true)
        .alignSelf(ItemAlign.Center)
        .lineCap(LineCapStyle.Round)
        .color('#757575')
      Text('App Context')
        .padding(8)
        .layoutWeight(35)
        .fontSize(14)
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)
      Divider()
        .height(20)
        .vertical(true)
        .lineCap(LineCapStyle.Round)
        .alignSelf(ItemAlign.Center)
        .color('#757575')
      Text('Ability Context')
        .padding(8)
        .layoutWeight(45)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#212121')
    }
    .margin({ top: 10 })
    .padding({ left: 6, right: 6 })
    .backgroundColor('#bdbdbd')
    .backgroundBlurStyle(BlurStyle.Regular)
  }

  @Builder renderFilePath() {
    List() {
      ForEach(this.fileDirArray, item => {
        this.listAdapterItem(item)
      }, item => item.name)
    }
    .width('100%')
    .height(300)
    .padding({ bottom: 5 })
    .alignSelf(ItemAlign.Center)
    .backgroundColor('#bdbdbd')
    .backgroundBlurStyle(BlurStyle.Regular)
  }

  @Builder listAdapterItem(data: FileDirInfo) {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Stretch
    }) {
      Text(data.name)
        .padding(10)
        .layoutWeight(20)
        .fontSize(12)
        .fontColor('#212121')
      Divider()
        .height(30)
        .vertical(true)
        .alignSelf(ItemAlign.Center)
        .lineCap(LineCapStyle.Round)
        .strokeWidth(1)
        .color('#757575')
      Text(data.appContextPath)
        .padding(10)
        .layoutWeight(35)
        .fontSize(12)
        .fontColor('#212121')
      Divider()
        .height(30)
        .vertical(true)
        .lineCap(LineCapStyle.Round)
        .alignSelf(ItemAlign.Center)
        .strokeWidth(1)
        .color('#757575')
      Text(data.abilityContextPath)
        .padding(10)
        .layoutWeight(45)
        .fontSize(12)
        .fontColor('#212121')
    }
    .margin({ top: 5, left: 6, right: 6 })
    .borderRadius(10)
    .backgroundColor('#ffffff')
  }

  @Builder renderExample() {
    Column() {
      Row() {
        Text('示例：')
          .fontColor('#212121')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Radio({ value: 'databaseDir', group: 'attr' })
          .width(15)
          .height(15)
          .margin({ left: 15 })
          .checked(true)
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.sampleAppTxt = getContext(this).getApplicationContext().databaseDir
              this.sampleAbilityTxt = getContext(this).databaseDir
            }
          })
        Text('数据库')
          .fontSize(13)
          .margin({ left: 3 })

        Radio({ value: 'filesDir', group: 'attr' })
          .width(15)
          .height(15)
          .margin({ left: 15 })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.sampleAppTxt = getContext(this).getApplicationContext().filesDir
              this.sampleAbilityTxt = getContext(this).filesDir
            }
          })
        Text('文件')
          .fontSize(13)
          .margin({ left: 3 })

        Radio({ value: 'preferencesDir', group: 'attr' })
          .width(15)
          .height(15)
          .margin({ left: 15 })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.sampleAppTxt = getContext(this).getApplicationContext().preferencesDir
              this.sampleAbilityTxt = getContext(this).preferencesDir
            }
          })
        Text('首选项')
          .fontSize(13)
          .margin({ left: 3 })

        Radio({ value: 'cacheDir', group: 'attr' })
          .width(15)
          .height(15)
          .margin({ left: 15 })
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.sampleAppTxt = getContext(this).getApplicationContext().cacheDir
              this.sampleAbilityTxt = getContext(this).cacheDir
            }
          })
        Text('缓存')
          .fontSize(13)
          .margin({ left: 3 })
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')

      Text(`App上下文: ${this.sampleAppTxt}`)
        .fontColor('#757575')
        .fontSize(12)
        .margin({ top: 3 })

      Text(`Ability上下文: ${this.sampleAbilityTxt}`)
        .margin({ top: 2 })
        .fontColor('#757575')
        .fontSize(12)
    }
    .margin({ top: 20 })
    .alignItems(HorizontalAlign.Start)
    .alignSelf(ItemAlign.Start)
  }
}


