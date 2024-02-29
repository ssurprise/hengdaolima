import UIAbility from '@ohos.app.ability.UIAbility';
import relationalStore from '@ohos.data.relationalStore'; // 导入模块


/**
 * 数据库管理类
 */
export class RdbManager {
  private readonly TAG = 'RdbManager'

  init(ctx: UIAbility) {
    this.createBrowserHistoryDb(ctx)
    // 其他数据库...
  }

  /**
   * 创建浏览历史数据库表
   * @param ctx 上下文
   */
  private createBrowserHistoryDb(ctx: UIAbility) {
    const STORE_CONFIG = {
      name: 'browser_history.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S2 // 数据库安全级别
    };
    relationalStore.getRdbStore(ctx.context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(this.TAG, `Failed to get RdbStore. code:${err.code}, message:${err.message}`);
        return;
      }
      const SQL_CREATE_TABLE = 'create table if not exists recently_browsed (id integer primary key autoincrement , name text not null, pagePath text, lastTime integer, count integer)'; // 建表Sql语句
      // 创建数据表
      store.executeSql(SQL_CREATE_TABLE);
    });
  }
}

let rdbManager = new RdbManager();

export default rdbManager as RdbManager;