import { TitleComp } from '../view/TitleComp';
import { TipsComp } from '../view/TipsComp';

/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/2/21 18:13
 * @Description： 异步并发-Promise
 */
@Entry
@Component
struct PromisePage {
  readonly TAG: string = 'PromisePage'

  build() {
    Column() {
      TitleComp({ titleName: 'Promise' })

      Button('Go')
        .width(60)
        .height(30)
        .onClick(() => {
          console.info(this.TAG, '开始~')

          // this.execute()
          this.test()
          console.info(this.TAG, '结束？')
        })
    }
    .width('100%')
  }

  execute() {
    let promise = new Promise((resolve, reject) => {
      console.info(this.TAG, '000000')

      setTimeout(() => {
        console.info(this.TAG, '111111')
        const randomNumber = Math.random();
        if (randomNumber > 0.5) {
          resolve('恭喜发财~')
        } else {
          reject(new Error('Random number is too small'));
        }
        console.info(this.TAG, '222222')
      }, 3000);
    });

    console.info(this.TAG, '333333=>' + String(promise))

    promise.then((value) => {
      console.info(this.TAG, '444-111 =>' + value);

    }).catch(() => {
      console.info(this.TAG, '444-222');

    })
    console.info(this.TAG, '55555');
  }

   testAsync() {
    return new Promise((resolve, reject)=>{})
  }

  async test() {
    console.info(this.TAG, '111111');
    let a = await this.testAsync()
    console.info(this.TAG, '333333 -' + String(a));
  }
}