/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/28 16:22
 * @Description：文件目录信息
 */
export class FileDirInfo {
  name: string
  appContextPath: string
  abilityContextPath: string
  desc?: string

  constructor(name: string, appContextPath: string, abilityContextPath: string, desc?: string) {
    this.name = name
    this.appContextPath = appContextPath
    this.abilityContextPath = abilityContextPath
    this.desc = desc
  }
}
