import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';
import fs from '@ohos.file.fs';
import picker from '@ohos.file.picker';
import ArrayList from '@ohos.util.ArrayList';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/29 18:05
 * @Description：文件访问
 */
@Entry
@Component
struct FilePickerPage {
  readonly TAG: string = 'FilePickerPage'

  build() {
    Column() {
      TitleComp({ titleName: '文件选择器' })
      Column() {
        Text('注：该页面主要介绍的是 @ohos.file.picker 模块提供的功能')
          .fontSize(12)
          .fontColor('#ff4081')
          .alignSelf(ItemAlign.Start)
          .fontWeight(FontWeight.Regular)

        this.renderPicker()
        TipsComp({ marginSpace: 0, tipArray: [
          'select返回的URI权限是只读权限，不能在picker的回调里直接使用此URI进行打开文件操作！',
          '目前 DocumentSelectOptions、AudioSelectOptions 不支持参数配置，默认可以选择所有类型的用户文件。',
          '在选择器页面点击关闭按钮后，不走picker 的回调！！！ 想在重新回到页面进行一些提示或者其他操作的话，可能要另谋他法了'
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

  @Builder renderPicker() {
    Row() {
      Button('图片类')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          const photoSelectOptions = new picker.PhotoSelectOptions();
          photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
          photoSelectOptions.maxSelectNumber = 5; // 选择媒体文件的最大数目

          const photoViewPicker = new picker.PhotoViewPicker();
          photoViewPicker.select(photoSelectOptions)
            .then((photoSelectResult) => {
              console.info(this.TAG, 'photoViewPicker.select to file succeed and URI is:' + photoSelectResult.photoUris[0]);
            })
            .catch((err) => {
              console.error(this.TAG, `Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
            })
        })
      Button('文档类')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          const documentSelectOptions = new picker.DocumentSelectOptions();
          const documentViewPicker = new picker.DocumentViewPicker(); // 创建文件选择器实例
          documentViewPicker.select(documentSelectOptions)
            .then((documentSelectResult) => {
              console.info(this.TAG, 'documentViewPicker.select to file succeed and URI is:' + documentSelectResult[0]);
            })
            .catch((err) => {
              console.error(this.TAG, `Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
            })
        })

      Button('音频类')
        .height(30)
        .fontSize(12)
        .onClick(() => {
          const audioSelectOptions = new picker.AudioSelectOptions();
          const audioViewPicker = new picker.AudioViewPicker();
          audioViewPicker.select(audioSelectOptions)
            .then((audioSelectResult: Array<string>) => {
              console.info(this.TAG, 'audioViewPicker.select to file succeed and URI is:' + audioSelectResult[0]);
            })
            .catch((err) => {
              console.error(this.TAG, `Invoke audioViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
            })
        })
    }
    .width('100%')
    .margin({ top: 15 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}