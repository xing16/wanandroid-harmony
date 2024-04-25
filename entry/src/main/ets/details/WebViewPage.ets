import webview from '@ohos.web.webview';
import router from '@ohos.router';
import { NavigationBar } from '../components/NavigationBar';
import hilog from '@ohos.hilog';

@Entry
@Component
struct WebViewPage {
  @State url: string = ''
  @State title: string = ''
  controller: WebviewController = new webview.WebviewController()

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object>
    this.url = params['url'] as string
    hilog.debug(12, 'debugdebug', 'url = ' + this.url)
  }

  build() {
    Column() {
      NavigationBar({ title: this.title })
      Web({ src: this.url, controller: this.controller })
        .mixedMode(MixedMode.All)
        .javaScriptAccess(true)
        .onPageEnd(() => {

        })
        .onTitleReceive((event) => {
          if (event) {
            this.title = event.title
          }
        })
    }
    .width('100%')
    .height('100%')
  }
}