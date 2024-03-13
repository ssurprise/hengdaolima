import bundleManager from '@ohos.bundle.bundleManager';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'
import common from '@ohos.app.ability.common';
import ArrayList from '@ohos.util.ArrayList';


/**
 * @Author： shiguotao
 * @E-mail: skxdad@163.com
 * @DATE： 2024/3/11 11:25
 * @Description： 权限管理工具
 */
class PermissionUtils {
  readonly TAG: string = 'PermissionUtils'

  /**
   * 检查权限
   * @param permission 需要校验的权限名称
   * @param tokenId 应用的身份标识
   * @param atManager
   * @returns
   */
  public async checkPermission(permission: Permissions, tokenId?: number, atManager?: abilityAccessCtrl.AtManager): Promise<abilityAccessCtrl.GrantStatus> {
    try {
      // 获取应用程序的accessTokenID，系统应用可以通过bundleManager.getApplicationInfo获取,普通应用可以通过bundleManager.getBundleInfoForSelf获取
      if (tokenId == null || tokenId == undefined) {
        let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
        let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
        tokenId = appInfo.accessTokenId;
      }
    } catch (err) {
      console.error(this.TAG, `getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`);
    }

    if (atManager == null || atManager == undefined) {
      // 获取访问token的对象
      atManager = abilityAccessCtrl.createAtManager();
    }

    // 校验应用是否被授予权限
    return atManager.checkAccessToken(tokenId, permission);
  }

  /**
   * 权限请求
   * @param ability  ability上下文
   * @param permissions
   * @returns 返回未授权成功的列表，如果是空说明全部被授权。
   */
  public async requestPermissions(ability: common.Context, permissions: Array<Permissions>): Promise<PermissionResult> {
    // 1.获取应用程序的accessTokenID
    let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
    let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
    let tokenId = appInfo.accessTokenId;

    let atManager = abilityAccessCtrl.createAtManager()
    // 需要申请的权限
    let requestPermissions = new ArrayList<Permissions>()
    // 权限检查结果。
    let resultObj: PermissionResult = {
      results: new ArrayList(),
      deniedPermissions: null,
    }

    // 2.检索未申请或者被拒绝的权限
    for (let i = 0;i < permissions.length; i++) {
      let permission = permissions[i];
      let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkPermission(permission, tokenId, atManager);
      if (grantStatus == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        resultObj.results.add({ name: permission, authResult: 0 })
        console.info(this.TAG, `权限：${permission} 已授权`);
      } else {
        resultObj.results.add({ name: permission, authResult: -1 })
        requestPermissions.add(permission);
        console.info(this.TAG, `权限：${permission} 未授权, grantStatus=${grantStatus}`);
      }
    }

    // 3.对未通过的权限进行请求授权
    if (!requestPermissions.isEmpty()) {
      try {
        let result = await atManager.requestPermissionsFromUser(ability, requestPermissions.convertToArray())
        const deniedPermissions: ArrayList<Permissions> = new ArrayList<Permissions>();
        for (let i = 0; i < result.permissions.length; i++) {
          let p = result.permissions[i]
          let r = result.authResults[i]
          console.info(this.TAG, `请求授权：${p}， 授权结果：${r}`);

          for (let index = 0; index < resultObj.results.length; index++) {
            const element = resultObj.results[index];
            if (p === element.name) {
              element.authResult = r
            }
          }
          if (r != 0) {
            deniedPermissions.add(p as Permissions)
          }
        }

        if (!deniedPermissions.isEmpty()) {
          resultObj.deniedPermissions = deniedPermissions.convertToArray()
        }
      } catch (err) {
        console.error(this.TAG, `requestPermissions failed, code is ${err.code}, message is ${err.message}`);
      }
    }
    return new Promise((resolve) => {
      resolve(resultObj)
    })
  }
}

export interface PermissionResult {
  results: ArrayList<{
    name: Permissions,
    authResult: number
  }>,
  deniedPermissions: Array<Permissions> | null
}

let permissionUtils = new PermissionUtils();

export default permissionUtils as PermissionUtils;