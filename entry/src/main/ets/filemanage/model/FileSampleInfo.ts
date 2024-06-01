/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/3/5 15:30
 * @Description： 文件基本信息
 */
export class FileSampleInfo {
  path: string
  name: string
  size: number
  type: string

  toString(): string {
    return `FileSampleInfo[ name:${this.name}, path:${this.path}, size:${this.size}字节 ]`
  }
}