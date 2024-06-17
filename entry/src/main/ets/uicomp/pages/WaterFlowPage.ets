import { TitleComp } from '../../common/view/TitleComp';


@Entry
@Component
struct WaterFlowPage {
  @State dataArray: Resource[] = [
  $r('app.media.image_01'),
  $r('app.media.image_02'),
  $r('app.media.image_03'),
  $r('app.media.image_04'),
  $r('app.media.image_05'),
  $r('app.media.image_06'),
  $r('app.media.image_07'),
  $r('app.media.image_08'),
  $r('app.media.image_01'),
  $r('app.media.image_02'),
  $r('app.media.image_03'),
  $r('app.media.image_04'),
  $r('app.media.image_05'),
  $r('app.media.image_06'),
  $r('app.media.image_07'),
  $r('app.media.image_08')
  ]

  build() {
    Column() {

      TitleComp({ titleName: 'WaterFlow' })

      Column() {
        WaterFlow() {
          ForEach(this.dataArray, (item, index) => {
            FlowItem() {
              Image(item)
                .width('100%')
                .height('100%')
                .objectFit(ImageFit.Cover)
            }
            .height(this.genRandomHeight())

          }, (item: any, index?: number) => index + "")

        }
        .width('100%')
        .layoutDirection(FlexDirection.Column) // 设置布局的主轴方向。默认值：FlexDirection.Column
        .columnsGap(5) // 设置列与列的间距。默认值：0
        .rowsGap(5) // 设置行与行的间距。默认值：0
        .columnsTemplate('1fr 1fr')
        .itemConstraintSize({ maxHeight: 200 }) // 设置约束尺寸，子组件布局时，进行尺寸范围限制。
      }
      .width('100%')
      .layoutWeight(1)
      .padding(15)
    }
    .height('100%')
  }

  genRandomHeight(): number {
    var randomHeight = this.getRandomNumber(0, 1)
    var height: number
    if (0 == randomHeight) {
      height = 150
    } else {
      height = 200
    }
    return height
  }

  getRandomNumber(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
}