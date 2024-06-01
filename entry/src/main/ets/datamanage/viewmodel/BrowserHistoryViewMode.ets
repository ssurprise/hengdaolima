import { BrowserHistoryItem } from '../model/BrowserHistoryItem';
import relationalStore from '@ohos.data.relationalStore'; // 导入模块
import ArrayList from '@ohos.util.ArrayList';


/**
 * 浏览历史 view model, providing page display data.
 */
class BrowserHistoryViewMode {
  private readonly TAG = 'BrowserHistoryViewMode'
  private readonly STORE_CONFIG = {
    name: 'browser_history.db', // 数据库文件名
    securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
  };
  private readonly TABLE_NAME = "recently_browsed"


  /**
   * 添加浏览记录
   * @param context
   * @param item
   */
  addHistoryItem(context: Context,
                 item: {
                   name: string,
                   pagePath: string,
                   lastTime: number,
                 }
  ): void {
    console.info(this.TAG, `addHistoryItem`);
    relationalStore.getRdbStore(context, this.STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(this.TAG, `Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      let predicates = new relationalStore.RdbPredicates(this.TABLE_NAME);
      predicates.equalTo('name', item.name)
      store.query(predicates, ['name', 'pagePath', 'lastTime', 'count'])
        .then((resultSet) => {
          if (resultSet.rowCount > 0) {
            resultSet.goToFirstRow()
            // 更新数据
            const valueBucket = {
              "name": resultSet.getString(resultSet.getColumnIndex('name')),
              "pagePath": resultSet.getString(resultSet.getColumnIndex('pagePath')),
              "lastTime": resultSet.getLong(resultSet.getColumnIndex('lastTime')),
              "count": (resultSet.getLong(resultSet.getColumnIndex('count')) + 1),
            };
            this.updateHistoryItem(store, valueBucket)
          } else {
            // 插入数据
            this.insertHistoryItem(store, {
              name: item.name,
              pagePath: item.pagePath,
              lastTime: item.lastTime,
              count: 1,
            })
          }
        })
        .catch(() => {
          // 插入数据
          this.insertHistoryItem(store, {
            name: item.name,
            pagePath: item.pagePath,
            lastTime: item.lastTime,
            count: 1,
          })
        })
    });
  }

  /**
   * 插入新的历史条目
   * @param rdbStore
   * @param valueBucket
   */
  private insertHistoryItem(rdbStore: relationalStore.RdbStore, valueBucket: {
    name: string,
    pagePath: string,
    lastTime: number,
    count: number
  }) {
    console.info(this.TAG, `开始插入数据, name=${valueBucket.name}, path=${valueBucket.pagePath}, count:${valueBucket.count}`);

    rdbStore.insert(this.TABLE_NAME, valueBucket)
      .then((rowId) => {
        console.info(this.TAG, `插入数据成功, rowId = ${rowId}`);
      })
      .catch((err) => {
        console.error(this.TAG, `插入数据失败, code:${err.code}, message:${err.message}`);
      })
  }

  /**
   * 更新历史条目，以name为匹配键
   * @param rdbStore
   * @param valueBucket
   */
  private updateHistoryItem(rdbStore: relationalStore.RdbStore, valueBucket: {
    name: string,
    pagePath: string,
    lastTime: number,
    count: number
  }) {
    console.info(this.TAG, `开始更新数据，name=${valueBucket.name}, count:${valueBucket.count}`);

    let predicates = new relationalStore.RdbPredicates(this.TABLE_NAME);
    predicates.equalTo("name", valueBucket.name);
    rdbStore.update(valueBucket, predicates)
      .then(async (rows) => {
        console.info(this.TAG, `更新数据成功, row count:${rows}`);
      })
      .catch((err) => {
        console.error(this.TAG, `更新数据失败, code:${err.code}, message:${err.message}`);
      })
  }

  /**
   * 查询浏览记录
   * @param context
   * @param item
   */
  queryHistory(context: Context, asyncCallBack?: (
    data?: ArrayList<BrowserHistoryItem>,
    errCode?: number,
    errMsg?: string,
  ) => void) {
    relationalStore.getRdbStore(context, this.STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(this.TAG, `Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        asyncCallBack(null, err.code, err.message)
        return
      }
      console.info(this.TAG, `Succeeded in getting RdbStore.`);

      let predicates = new relationalStore.RdbPredicates(this.TABLE_NAME);
      store.query(predicates, ['name', 'pagePath', 'lastTime', 'count'], (queryErr, resultSet) => {
        if (queryErr) {
          console.error(this.TAG, `Failed to query data. Code:${queryErr.code}, message:${queryErr.message}`);
          asyncCallBack(null, queryErr.code, queryErr.message)
          return
        }
        console.info(this.TAG, `ResultSet rowCount:${resultSet.rowCount}, columnCount:${resultSet.columnCount}, columnNames:${resultSet.columnNames}`);

        let historyList = new ArrayList<BrowserHistoryItem>();
        while (resultSet.goToNextRow()) {
          let item = new BrowserHistoryItem()
          item.name = resultSet.getString(resultSet.getColumnIndex('name'))
          item.pagePath = resultSet.getString(resultSet.getColumnIndex('pagePath'))
          item.lastTime = resultSet.getLong(resultSet.getColumnIndex('lastTime'))
          item.count = resultSet.getLong(resultSet.getColumnIndex('count'))
          historyList.add(item)
          console.info(this.TAG, `[name:${item.name}, pagePath:${item.pagePath}, lastTime:${item.lastTime}, count:${item.count}]`);
        }
        // 当应用完成查询数据操作，不再使用结果集（ResultSet）时，请及时调用close方法关闭结果集，释放系统为其分配的内存。
        resultSet.close()
        asyncCallBack(historyList)
      })
    })
  }
}


let browserHistoryViewMode = new BrowserHistoryViewMode();

export default browserHistoryViewMode as BrowserHistoryViewMode;
