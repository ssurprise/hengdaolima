/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/21 11:03
 * @Description： 自定义选择框组件，系统自有的 CheckBox组件没有携带文本
 */
@Component
export struct CheckBoxComp {
  @State txt: string | Resource = ''
  private options?: CheckboxOptions
  // private checkBoxAttr?: CheckboxAttribute
  private select: boolean = false
  private onChangeEvent: (value: boolean) => void

  build() {
    Row() {
      Checkbox(this.options)
        .select(this.select)
        .onChange(this.onChangeEvent)

      Text(this.txt)
        .margin({ left: 3 })
        .fontSize(14)
        .fontColor('#212121')
    }
  }
}