import { TitleComp } from '../view/TitleComp';

@Entry
@Component
struct ProgressPage {
  @State progressValue: number = 0
  @State total: number = 100
  @State mType: ProgressType = ProgressType.Linear
  @State mWidth: number = 200
  @State mHeight: number = 50
  @State mStrokeWidth: number = 3
  @State mScaleCount: number = 20 //环形有刻度进度条总刻度数
  @State mScaleWidth: number = 3 //环形有刻度进度条刻度宽度

  build() {
    Column() {
      TitleComp({ titleName: '进度条-Progress' })

      Text('进度条样式:')
        .margin({ left: 9, top: 15 })
        .fontSize(14)

      Row() {
        Row() {
          Radio({ value: "Linear", group: "ProgressType" })
            .checked(true)
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.mType = ProgressType.Linear
              }
            })
          Text('线性')
        }.width('30%')

        Row() {
          Radio({ value: "Eclipse", group: "ProgressType" })
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.mType = ProgressType.Eclipse
              }
            })
          Text('圆形')
        }.width('30%')

        Row() {
          Radio({ value: "Capsule", group: "ProgressType" })
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.mType = ProgressType.Capsule
              }
            })
          Text('胶囊')
        }.width('30%')

      }.margin({ left: 9, top: 2 })

      Row() {
        Row() {
          Radio({ value: "Ring", group: "ProgressType" })
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.mType = ProgressType.Ring
              }
            })
          Text('环形无刻度')
        }.width('40%')

        Row() {
          Radio({ value: "ScaleRing", group: "ProgressType" })
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.mType = ProgressType.ScaleRing
              }
            })
          Text('环形有刻度')
        }.width('30%')
      }
      .width('100%')
      .margin({ left: 9, top: 2 })

      Row() {
        Text('宽度：')
        TextInput({ placeholder: '请输入', text: '200' })
          .type(InputType.Number)
          .width('28%')
          .onChange((value: string) => {
            this.mWidth = Number.parseInt(value)
          })

        Text('高度：').margin({ left: 12 })
        TextInput({ placeholder: '请输入', text: '50' })
          .type(InputType.Number)
          .width('28%')
          .onChange((value: string) => {
            this.mHeight = Number.parseInt(value)
          })
      }.margin({ left: 9, top: 10 })

      if (this.mType == ProgressType.ScaleRing || this.mType == ProgressType.Ring) {
        Row() {
          Text('进度条宽度：')
          TextInput({ placeholder: '请输入进度条宽度', text: '3' })
            .type(InputType.Number)
            .width('30%')
            .onChange((value: string) => {
              this.mStrokeWidth = Number.parseInt(value)
            })
        }.margin({ left: 9, top: 5 })
      }

      if (this.mType == ProgressType.ScaleRing) {
        Row() {
          Text('总刻度数：')
          TextInput({ placeholder: '请输入总刻度数', text: '20' })
            .type(InputType.Number)
            .width('30%')
            .onChange((value: string) => {
              this.mScaleCount = Number.parseInt(value)
            })
        }.margin({ left: 9, top: 5 })

        Row() {
          Text('刻度宽度：')
          TextInput({ placeholder: '请输入刻度宽度', text: '3' })
            .type(InputType.Number)
            .width('30%')
            .onChange((value: string) => {
              this.mScaleWidth = Number.parseInt(value)
            })
        }.margin({ left: 9, top: 5 })
      }

      Button("进度条+5")
        .margin({ top: 10, left: 9 })
        .onClick(() => {
          this.progressValue += 5
          if (this.progressValue > 100) {
            this.progressValue = 0
          }
        })

      Text("展示效果图：").margin({ left: 9, top: 20 })
      Row() {
        Progress({ value: 0, total: 100, type: this.mType })
          .width(this.mWidth)
          .height(this.mHeight)
          .style({ strokeWidth: this.mStrokeWidth, scaleCount: this.mScaleCount, scaleWidth: this.mScaleWidth })
          .borderWidth("1vp")
          .borderStyle(BorderStyle.Dashed)
          .borderColor("#212121")
          .value(this.progressValue)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 10 })

      Text('注意：')
        .fontSize(14)
        .margin({ top: 50, left: 9, right: 9 })
        .fontStyle(FontStyle.Normal)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)
      Text('1. ProgressType.Type 为 ProgressType.Capsule 时，需要设置不同的宽高，如果宽高一样大，会展现出跟圆一样的样式。另外，当高度大于宽度的时候会自适应垂直显示')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
      Text('2. ProgressType.Type 为 ProgressType.ScaleRing 时，需要设置 style，包括strokeWidth、scaleCount 和scaleWidth 属性')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
      Text('3. ProgressType.Type 为 ProgressType.Ring  时，可以设置 style 的 strokeWidth 属性来修改圆环宽度')
        .fontSize(12)
        .margin({ top: 5, left: 10, right: 10 })
        .fontStyle(FontStyle.Italic)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}