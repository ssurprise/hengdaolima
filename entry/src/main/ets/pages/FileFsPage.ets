import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';
import fs from '@ohos.file.fs';
import { FileSampleInfo } from '../model/FileSampleInfo';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/29 18:05
 * @Description：文件访问
 */
@Entry
@Component
struct FileFsPage {
  readonly TAG: string = 'FileFsPage'

  aboutToAppear() {
    // 查看文件列表
    let options = {
      recursion: false,
      listNum: 0,
      filter: {
        suffix: ['.png', '.jpg', '.txt'], // 匹配文件后缀名为'.png','.jpg','.txt'
        fileSizeOver: 0, // 匹配文件大小大于等于0
        lastModifiedAfter: new Date(0).getTime(), // 匹配文件最近修改时间在1970年1月1日之后
      },
    }
    let filesDir = getContext(this).filesDir;
    fs.listFile(filesDir, options)
      .then((value => {
        this.statsFileInfo(value)
      }))
      .catch((error) => {

      })

  }

  async statsFileInfo(filePathArray: string[]) {
    let fileStatArray = new Array<FileSampleInfo>()
    for (let i = 0; i < filePathArray.length; i++) {
      let path = filePathArray[i]
      let ststs = await fs.stat(path)
      let sampleInfo = new FileSampleInfo()
      sampleInfo.path = path
      sampleInfo.size = ststs.size
      fileStatArray[i] = sampleInfo
      console.info(this.TAG, `The name of file: ${filePathArray[i]}`);
    }
  }

  build() {
    Column() {
      TitleComp({ titleName: '文件管理' })

      Text('注：该页面主要介绍的是 @ohos.file.fs 模块提供的功能')
        .fontSize(12)
        .fontColor('#ff4081')
        .alignSelf(ItemAlign.Start)
        .fontWeight(FontWeight.Regular)

      Column() {
        this.renderTableTitle()
        this.renderFilePath()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 10, left: 10, right: 10 })
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderFilePath() {
    // List() {
    //   ForEach(this.fileDirArray, item => {
    //     this.listAdapterItem(item)
    //   }, item => item.name)
    // }
    // .width('100%')
    // .height(300)
    // .padding({ bottom: 5 })
    // .alignSelf(ItemAlign.Center)
    // .backgroundColor('#bdbdbd')
    // .backgroundBlurStyle(BlurStyle.Regular)
  }

  @Builder listAdapterItem(data: FileSampleInfo) {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Stretch
    }) {
      Text(data.name)
        .padding(10)
        .layoutWeight(40)
        .fontSize(12)
        .fontColor('#212121')
      Divider()
        .height(30)
        .vertical(true)
        .alignSelf(ItemAlign.Center)
        .lineCap(LineCapStyle.Round)
        .strokeWidth(1)
        .color('#757575')
      Text(data.type)
        .padding(10)
        .layoutWeight(40)
        .fontSize(12)
        .fontColor('#212121')
      Divider()
        .height(30)
        .vertical(true)
        .lineCap(LineCapStyle.Round)
        .alignSelf(ItemAlign.Center)
        .strokeWidth(1)
        .color('#757575')
      Text(`${data.size}byte`)
        .padding(10)
        .layoutWeight(40)
        .fontSize(12)
        .fontColor('#212121')
    }
    .margin({ top: 5, left: 6, right: 6 })
    .borderRadius(10)
    .backgroundColor('#ffffff')
  }

  @Builder renderTableTitle() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.SpaceAround,
      alignItems: ItemAlign.Stretch
    }) {
      Text('文件名称')
        .padding(8)
        .layoutWeight(40)
        .fontSize(14)
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)
      Divider()
        .height(20)
        .vertical(true)
        .alignSelf(ItemAlign.Center)
        .lineCap(LineCapStyle.Round)
        .color('#757575')
      Text('文件类型')
        .padding(8)
        .layoutWeight(20)
        .fontSize(14)
        .fontColor('#212121')
        .fontWeight(FontWeight.Medium)
      Divider()
        .height(20)
        .vertical(true)
        .lineCap(LineCapStyle.Round)
        .alignSelf(ItemAlign.Center)
        .color('#757575')
      Text('文件大小')
        .padding(8)
        .layoutWeight(20)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#212121')
    }
    .margin({ top: 10 })
    .padding({ left: 6, right: 6 })
    .backgroundColor('#bdbdbd')
    .backgroundBlurStyle(BlurStyle.Regular)
  }
}