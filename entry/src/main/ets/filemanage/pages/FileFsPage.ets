import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';
import fs from '@ohos.file.fs';
import { FileSampleInfo } from '../model/FileSampleInfo';
import ArrayList from '@ohos.util.ArrayList';

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
  @State fileInfoArray: Array<FileSampleInfo> = new Array()

  aboutToAppear() {
    // 查看文件列表
    let options = {
      recursion: false, // 是否递归子目录下文件名，默认为false。
      listNum: 0, // 列出文件名数量。当设置0时，列出所有文件，默认为0。
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
        console.log(this.TAG, error)
      })
  }

  async statsFileInfo(filePathArray: string[]) {
    let fileStatList: ArrayList<FileSampleInfo> = new ArrayList()
    for (let i = 0; i < filePathArray.length; i++) {
      let path = `${getContext(this).filesDir}/${filePathArray[i]}`
      let splitArray = filePathArray[i].split('.')
      let stats = fs.statSync(path)
      let sampleInfo = new FileSampleInfo()
      sampleInfo.name = splitArray[0]
      sampleInfo.path = path
      sampleInfo.size = stats.size
      if (splitArray.length > 1) {
        sampleInfo.type = splitArray[1]
      } else {
        sampleInfo.type = '未知'
      }
      fileStatList.add(sampleInfo)
      console.info(this.TAG, `i=${i} sampleInfo=${sampleInfo}`);
    }
    this.fileInfoArray = fileStatList.convertToArray()
  }

  build() {
    Column() {
      TitleComp({ titleName: '文件管理' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.file.fs 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderTableTitle()
        this.renderFilePath()
        TipsComp({ marginSpace: 0, tipArray: [
          'fs.listFile 方法是列出文件夹下的所有文件名，只是文件名，不是完整路径。 如：abc.txt，而不是 xx/xx/xx/abc.txt'
        ] })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 15, left: 15, right: 15 })
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderFilePath() {
    List() {
      ForEach(this.fileInfoArray, item => {
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
        .height(20)
        .vertical(true)
        .alignSelf(ItemAlign.Center)
        .lineCap(LineCapStyle.Round)
        .strokeWidth(1)
        .color('#757575')
      Text(data.type)
        .padding(10)
        .layoutWeight(20)
        .fontSize(12)
        .fontColor('#212121')
      Divider()
        .height(20)
        .vertical(true)
        .lineCap(LineCapStyle.Round)
        .alignSelf(ItemAlign.Center)
        .strokeWidth(1)
        .color('#757575')
      Text(`${data.size} byte`)
        .padding(10)
        .layoutWeight(20)
        .fontSize(12)
        .fontColor('#212121')
    }
    .margin({ top: 5, left: 6, right: 6 })
    .borderRadius(8)
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
    .margin({ top: 15 })
    .padding({ left: 6, right: 6 })
    .backgroundColor('#bdbdbd')
    .backgroundBlurStyle(BlurStyle.Regular)
  }
}