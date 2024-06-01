import type AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import type Want from '@ohos.app.ability.Want';
import type window from '@ohos.window';
import rdbManager from '../common/database/RdbManager';


/**
 * Lift cycle management of Ability.
 */
export default class EntryAbility extends UIAbility {
  readonly TAG = "EntryAbility"

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Create状态为在应用加载过程中，UIAbility实例创建完成时触发，系统会调用onCreate()回调。可以在该回调中进行应用初始化操作，例如变量定义资源加载等，用于后续的UI界面展示。
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onCreate');

    this.init()

    let context = this.context
    /*
    通过UIAbilityContext可以获取UIAbility的相关配置信息，如包代码路径、Bundle名称、Ability名称和应用程序需要的环境状态等属性信息，
    以及可以获取操作UIAbility实例的方法（如startAbility()、connectServiceExtensionAbility()、terminateSelf()等）
     */
  }

  onDestroy(): void {
    /*
    Destroy状态在UIAbility实例销毁时触发。可以在onDestroy()回调中进行系统资源的释放、数据的保存等操作。
    例如调用terminateSelf()方法停止当前UIAbility实例，从而完成UIAbility实例的销毁；或者用户使用最近任务列表关闭该UIAbility实例，完成UIAbility的销毁。
     */
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    /*
    1.UIAbility实例创建完成之后，在进入Foreground之前，系统会创建一个WindowStage。WindowStage创建完成后会进入onWindowStageCreate()回调，
    可以在该回调中设置UI界面加载、设置WindowStage的事件订阅。
    2.Main window is created, set main page for this ability
     */
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onWindowStageCreate');


    // 需要指定启动页面，否则应用启动后会因为没有默认加载页面而导致白屏
    windowStage.loadContent("home/page/MainPage", (err, data) => {
      if (err.code) {
        hilog.error(0x0000, this.TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, this.TAG, 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    /*
    1.在UIAbility实例销毁之前，则会先进入onWindowStageDestroy()回调，可以在该回调中释放UI界面资源
    2.Main window is destroyed, release UI related resources
     */
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // 在UIAbility的UI界面可见之前，如UIAbility切换至前台时触发。可以在onForeground()回调中申请系统需要的资源，或者重新申请在onBackground()中释放的资源。
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // 在UIAbility的UI界面完全不可见之后，如UIAbility切换至后台时候触发。可以在onBackground()回调中释放UI界面不可见时无用的资源，或者在此回调中执行较为耗时的操作，例如状态保存等。
    hilog.info(0x0000, this.TAG, '%{public}s', 'Ability onBackground');
  }

  init() {
    rdbManager.init(this)
  }
}