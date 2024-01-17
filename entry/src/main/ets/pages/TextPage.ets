import { TitleComp } from '../view/TitleComp';

@Entry
@Component
struct TextPage {
  @State txt: string = 'Hello, 世界'
  @State message: string = '组件（Component）是界面搭建与显示的最小单位，HarmonyOS ArkUI声明式开发范式为开发者提供了丰富多样的UI组件，我们可以使用这些组件轻松的编写出更加丰富、漂亮的界面。'

  build() {
    Row() {
      Column() {
        TitleComp().height("56vp").backgroundColor(0xffffff)

        Text(this.txt)

        Text(this.txt)
          .fontColor(Color.Blue)
          .fontSize("20fp")
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)
          .fontFamily("Arial，sans-serif")

        Text(this.txt)
          .fontColor(Color.Red)
          .fontSize("14fp")
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)
          .fontFamily("Arial，sans-serif")
          .textAlign(TextAlign.Start)
          .decoration({ type: TextDecorationType.Underline, color: Color.Black })
          .width("100%")

        Text(this.txt)
          .fontColor(Color.Red)
          .fontSize("14fp")
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)
          .fontFamily("Arial，sans-serif")
          .decoration({ type: TextDecorationType.LineThrough, color: Color.Black })
          .textAlign(TextAlign.Center)

        Text(this.txt)
          .fontColor(Color.Red)
          .fontSize("14fp")
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)
          .fontFamily("Arial，sans-serif")
          .decoration({ type: TextDecorationType.Overline, color: Color.Black })
          .textAlign(TextAlign.End)
          .width("100%")

        Text(this.message)
          .fontSize("14fp")
          .fontStyle(FontStyle.Normal)
          .fontWeight(FontWeight.Regular)
          .fontFamily("Arial，sans-serif")
          .textAlign(TextAlign.Center)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width("70%")

      }.width('100%')
      .backgroundColor(0xF1F3F5)
    }
  }
}