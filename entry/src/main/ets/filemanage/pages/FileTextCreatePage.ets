import { TitleComp } from '../../common/view/TitleComp';
import { TipsComp } from '../../common/view/TipsComp';
import fs from '@ohos.file.fs';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/3/5 17:11
 * @Description：创建文本文件
 */
@Entry
@Component
struct FileTextCreatePage {
  readonly TAG: string = 'FileTextCreatePage'
  fileName: string = ''
  fileContent: string = ''
  @State txtContext: string = ''
  @State warning: string = ''

  build() {
    Column() {
      TitleComp({ titleName: '创建文本文件' })

      Column() {
        Text('注：该页面主要介绍的是 @ohos.file.fs 模块提供的读/写功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderFileName()
        this.renderFileContent()
        this.renderCreateBtn()

        TipsComp({ tipArray: [
          '通过流（w、w+）的方式写入数据会把之前的内容给清掉，但是通过fs.write、fs.writeSync的方法写入是不会清除掉原有数据的。',
        ] })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 10, left: 10, right: 10 })
      .backgroundColor('#f5f5f5')
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderFileName() {
    Column() {
      Text('文件名称')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontSize('#212121')
      Row() {
        TextInput({ placeholder: '请输入文件名称' })
          .margin({ top: 3 })
          .layoutWeight(1)
          .fontSize(12)
          .fontColor('#212121')
          .placeholderFont({ size: 12, weight: FontWeight.Normal })
          .placeholderColor('#757575')
          .onChange((value: string) => {
            this.fileName = value
          })
        Button('读')
          .height(35)
          .margin({ left: 20 })
          .padding({ left: 20, right: 20 })
          .fontSize(12)
          .onClick(() => {
            if (this.fileName.length <= 0) {
              this.warning = '请输入文本名称'
            } else {
              this.readFileContent()
            }
          })
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
    }
    .margin({ top: 20 })
    .alignItems(HorizontalAlign.Start)
  }

  async readFileContent() {
    let filePath = `${getContext(this).filesDir}/${this.fileName}.txt`
    let isExit = await fs.access(filePath)
    if (!isExit) {
      this.warning = "文件不存在！"
      return
    }
    try {
      let content = fs.readTextSync(filePath)
      this.txtContext = content
      this.logcat(`读取成功！ 内容：${content}`)
    } catch (e) {
      this.logcat(`读取失败，error：${e}`)
    }
  }

  @Builder renderFileContent() {
    Column() {
      Text('内容')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontSize('#212121')
      TextArea({ text: this.txtContext, placeholder: '请输入内容' })
        .width('100%')
        .height('20%')
        .margin({ top: 3 })
        .fontSize(12)
        .fontColor('#212121')
        .placeholderFont({ size: 12, weight: FontWeight.Normal })
        .placeholderColor('#757575')
        .onChange((value: string) => {
          console.log(this.TAG, 'TextArea-onChange:' + value)
          this.fileContent = value
        })
    }
    .margin({ top: 15 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder renderCreateBtn() {
    Text(this.warning)
      .width('100%')
      .height(25)
      .padding({ left: 10, right: 10 })
      .textAlign(TextAlign.Start)
      .borderRadius(8)
      .fontSize(12)
      .fontColor('#ff4081')

    Row() {
      Button('write 方法写入')
        .height(40)
        .fontSize(12)
        .onClick(() => {
          this.writeFile()
        })
      Button('流方式方式写入')
        .height(40)
        .fontSize(12)
        .onClick(() => {
          this.outputFile()
        })
    }
    .width('90%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: 10 })
  }

  private writeFile() {
    if (this.fileName.length <= 0) {
      this.warning = '请输入文本名称'
    } else {
      let path = `${getContext(this).filesDir}/${this.fileName}.txt`
      fs.open(path, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
        .then((file) => {
          fs.write(file.fd, this.fileContent)
            .then((number) => {
              this.logcat(`写入成功，共写入长度：${number}`)
            })
            .catch((error) => {
              this.logcat(`写入失败，原因：${error}`)
            })
            .finally(() => {
              fs.closeSync(file.fd)
            })
        })
        .catch((error) => {
          this.logcat(`文件创建失败，原因：${error}`)
        })
    }
  }

  private async outputFile() {
    if (this.fileName.length <= 0) {
      this.warning = '请输入文本名称'
    } else {
      let path = `${getContext(this).filesDir}/${this.fileName}.txt`

      let outputStream = fs.createStreamSync(path, "w+");
      outputStream.write(this.fileContent)
        .then((number) => {
          this.logcat(`（流）写入成功，共写入长度：${number}`)
        })
        .catch((error) => {
          this.logcat(`（流）写入失败，原因：${error}`)
        })
        .finally(() => {
          outputStream.close()
        })
    }
  }

  private logcat(t: string) {
    console.log(this.TAG, t)
    this.warning = t
  }
}