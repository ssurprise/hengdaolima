import web_webview from '@ohos.web.webview'


@Entry
@Component
struct WebPage {
  // @State mUrl: string = "https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-web-0000001477981205-V3"
  @State mUrl: string = "https://developer.harmonyos.com/"
  controller: web_webview.WebviewController = new web_webview.WebviewController()

  build() {
    Column() {

      Web({ src: this.mUrl, controller: this.controller })
        .width('100%')
        .height('100%')
        .domStorageAccess(true) //设置是否开启文档对象模型存储接口（DOM Storage API）权限。
        .fileAccess(true) //设置是否开启应用中文件系统的访问，默认启用。
        .imageAccess(true) //设置是否允许自动加载图片资源，默认允许。
        .onlineImageAccess(true) //设置是否允许从网络加载图片资源（通过HTTP和HTTPS访问的资源），默认允许访问。
        .javaScriptAccess(true) //设置是否允许执行JavaScript脚本，默认允许执行。
        .zoomAccess(true) //设置是否支持手势进行缩放，默认允许执行缩放。
        .overviewModeAccess(true) //设置是否使用概览模式加载网页，默认使用该方式。
        .databaseAccess(false) //设置是否开启数据库存储API权限，默认不开启。
        .geolocationAccess(true) //设置是否开启获取地理位置权限，默认开启。
        .mediaPlayGestureAccess(true) //设置有声视频播放是否需要用户手动点击，静音视频播放不受该接口管控，默认需要。
        .multiWindowAccess(false) //设置是否开启多窗口权限，默认不开启。使能多窗口权限时，需要实现onWindowNew事件
        .horizontalScrollBarAccess(true) //设置是否显示横向滚动条，包括系统默认滚动条和用户自定义滚动条。默认显示。
        .verticalScrollBarAccess(true) //设置是否显示纵向滚动条，包括系统默认滚动条和用户自定义滚动条。默认显示。
        .cacheMode(CacheMode.Default) //设置缓存模式。
        .textZoomRatio(100) //设置页面的文本缩放百分比，默认为100%。
        .initialScale(100) //设置整体页面的缩放百分比，默认为100。
        .blockNetwork(false) //设置Web组件是否阻止从网络加载资源。默认：false
        .defaultFixedFontSize(13) //设置网页的默认等宽字体大小，单位px。默认：13
        .defaultFontSize(16) //设置网页的默认字体大小，单位px。默认：16
        .minFontSize(8) //设置网页字体大小最小值，单位px。默认：8
        .minLogicalFontSize(8) //设置网页逻辑字体大小最小值，单位px。默认：8
    }
    .width('100%')
  }
}