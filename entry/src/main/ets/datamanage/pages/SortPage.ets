import { TitleComp } from '../../common/view/TitleComp'
import promptAction from '@ohos.promptAction'
import { examples, SortMethod, sortMethods, SortType, } from '../model/SortPageData'


@Entry
@Component
struct SortPage {
  @State sortMethod: SortMethod = sortMethods[0]
  @State source: number[] = [9, 8, 7, 6, 5, 4, 3, 2, 1]
  @State sortStep: string[] = []
  @State selectedIndex: number = 0

  aboutToAppear() {
    this.doSort()
  }

  build() {
    Column() {
      TitleComp({ titleName: '排序' })

      Column() {

        Row() {
          Text('排序方式： ')
            .fontColor('#212121')
            .fontSize(14)

          Text(`${this.sortMethod.name}`)
            .fontColor('#ff4081')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Blank()

          Button('选择')
            .fontSize(12)
            .height(30)
            .width(80)
            .padding({ left: 15, right: 15 })
            .onClick(() => {
              TextPickerDialog.show({
                range: ['冒泡排序', '选择排序', '插入排序', '快速排序'],
                selected: this.selectedIndex,
                onAccept: (value: TextPickerResult) => {
                  this.selectedIndex = value.index
                  this.sortMethod = sortMethods[value.index]
                  this.doSort()
                }
              })
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Image(this.sortMethod.exampleImg)
          .width('100%')
          .margin({ top: 10 })
          .objectFit(ImageFit.Contain)

        Text(this.sortMethod.description)
          .fontColor('#212121')
          .fontSize(12)
          .margin({ top: 10 })

        this.renderExample()
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(15)
    }
    .width('100%')
    .height('100%')
  }

  @Builder renderExample() {
    Text('示例：')
      .margin({ top: 20 })
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)

    Row() {
      Text(`待排序数组：${this.source.toString()}`)
        .fontSize(12)
        .fontColor('#212121')

      Blank()

      Button('选择')
        .fontSize(12)
        .height(30)
        .width(80)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          this.showExampleDialog()
        })
    }
    .width('100%')

    Text('结果：')
      .margin({ top: 10 })
      .fontColor('#212121')
      .fontSize(14)
      .fontWeight(FontWeight.Medium)

    Column({ space: 5 }) {
      ForEach(this.sortStep, (item: string, index?: number) => {
        Text(item)
          .fontColor('#212121')
          .fontSize(12)
      }, (index?: number) => index + "")
    }
    .backgroundColor('#f5f5f5')
    .borderRadius(5)
    .padding({ left: 15, top: 10, right: 15, bottom: 10 })
    .alignItems(HorizontalAlign.Start)
  }

  showExampleDialog() {
    promptAction.showActionMenu({
      title: '选择数据',
      buttons: [
        {
          text: examples[0].toString(),
          color: '#666666',
        },
        {
          text: examples[1].toString(),
          color: '#000000',
        },
        {
          text: examples[2].toString(),
          color: '#000000',
        },
      ]
    }, (err, data) => {
      if (err) {
        console.info('showActionMenu err: ' + err);
        return;
      }
      this.source = examples[data.index]
      this.doSort()
    })
  }

  doSort() {
    this.sortStep = []

    let r = this.source.slice()
    let f = (index: number, r: number[]) => {
      this.sortStep.push(`第${index}轮排序后：${r.toString()}`)
    }
    switch (this.sortMethod.type) {
      case SortType.bubble:
        this.bubbleSort(r, f)
        break
      case SortType.selection:
        this.selectionSort(r, f)
        break
      case SortType.insert:
        this.insertSort(r, f)
        break
    }
  }

  /**
   * 冒泡排序
   * @param t
   * @param step
   */
  bubbleSort(t: number[], step?: (index: number, r: number[]) => void) {
    for (let i = 0; i < t.length - 1; i++) {
      for (let j = 0; j < t.length - 1 - i; j++) {
        if (t[j] > t[j+1]) {
          let temp = t[j]
          t[j] = t[j+1]
          t[j+1] = temp
        }
      }
      step(i + 1, t)
    }
  }

  /**
   * 选择排序
   * @param t
   * @param step
   */
  selectionSort(t: number[], step?: (index: number, r: number[]) => void) {
    for (let i = 0; i < t.length - 1; i++) {
      // 假设最小数的索引为 i
      let min = i
      // 每一个元素都和剩下的未排序的元素比较
      for (let j = i + 1; j < t.length; j++) {
        if (t[min] > t[j]) { //找到最小的数
          min = j // 将最小数的索引保存
        }
      }
      if (min != i) {
        let temp = t[min]
        t[min] = t[i]
        t[i] = temp
      }
      step(i + 1, t)
    }
  }

  /**
   * 插入排序
   * @param t
   * @param step
   */
  insertSort(arr: number[], step?: (index: number, r: number[]) => void) {
    // 示例： 9，7，2
    // 默认第一个是已经排好序的
    for (let i = 1; i < arr.length; i++) {
      let curVal = arr[i]
      let m = i - 1
      // 不断的向前比较，遇到比当前值大的，就把当前索引的值复制到下一个索引上，以此来模拟插入。
      // current=1 value=2    前面一个位置的值是7。  7<9,
      while (m >= 0 && arr[m] > curVal) {
        // 将前一个位置的值拷贝到后面位置，这里就成了 9, 9, 2
        arr[m + 1] = arr[m];
        // 索引减一，同前一个数据再对比。
        m--;
      }
      // 7、9、2
      // 这里++ 是因为上一步满足条件后，先 "--" 同前一个数据比较，但是条件不符合，所以再其后的一个位置插入
      arr[++m] = curVal
      step(i, arr)
    }
  }

  quickSort(arr: number[], step?: (index: number, r: number[]) => void) {


  }

  priQuickSort(arr: number[], low: number, high: number) {
    if (low < high) {
      let partitionIndex = this.partition(arr, low, high)
      this.priQuickSort(arr, low, partitionIndex - 1)
      this.priQuickSort(arr, partitionIndex + 1, high)
    }
  }

  partition(arr: number[], left: number, right: number): number {

    return 0
  }
  /*
      private void quickSort(int[] arr, int left, int right) {
        if (left < right) {
            int partitionIndex = partition(arr, left, right);
            quickSort(arr, left, partitionIndex - 1);
            quickSort(arr, partitionIndex + 1, right);

            renderSortProcessView(0, arr);
        }
    }
   */
}