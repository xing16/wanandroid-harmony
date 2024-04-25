import webview from '@ohos.web.webview';
import { getHost, getScheme } from '../utils/UrlUtils';
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
import hilog from '@ohos.hilog';

@Entry
@Component
struct WebView {
  pageUrl: string = 'https://appdev.finchina.com/finchinaAPP/institution/institution.html?isData=1&function=27&type=bank'
  controller: webview.WebviewController = new webview.WebviewController();

  aboutToAppear() {
    webview.WebviewController.setWebDebuggingAccess(true)
  }

  build() {
    Column() {
      Button('request').onClick((event: ClickEvent) => {
        let request: http.HttpRequest = http.createHttp()
        request.request('https://appdev.finchina.com/finchinaAPP/getInfoAboutCompanies.action?user=&token=&companyType=bank&oldChangeFlag=true&pagesize=15&skip=0',
          {
            header: {
              'user':'dev',
              'token': '000000',
            }
          },(err, data) => {
            hilog.debug(12, 'aoaaa', 'data=  ' + data.result)
          })
      })


      Web({ src: this.pageUrl, controller: this.controller })
        .onPageBegin((event) => {
          // this.controller.setCustomUserAgent('Mozilla/5.0 (Linux; Android 7.1.1; OPPO R9sk) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36')
        })
        .onInterceptRequest((event) => {
          if (!event) {
            return null
          }
          let requestUrl = event.request.getRequestUrl()
          let requestMethod = event.request.getRequestMethod()
          let headers: Header[] = event.request.getRequestHeader()
          let headerMap: Map<string,string> = new Map()
          headerMap.set('token','000000')
          headerMap.set('user', 'dev')
          headers.forEach((value, index,arr)=>{
            headerMap.set(value.headerKey, value.headerValue)
          })


          headers.push({ headerKey: 'user', headerValue: 'dev' })
          headers.push({ headerKey: 'token', headerValue: '000000' })
          let host: string = getHost(requestUrl)
          let scheme: string = getScheme(requestUrl)
          if ('GET' === requestMethod.toUpperCase()
            && 'appdev.finchina.com' === host
            && ('http:' === scheme || 'https:' === scheme)) {
            let request: http.HttpRequest = http.createHttp()
            let webResponse: WebResourceResponse = new WebResourceResponse()
            let options: http.HttpRequestOptions = {
              method: http.RequestMethod.GET,
              readTimeout: 10000,
              connectTimeout: 10000,
              header:
              {
                'user':'dev',
                'token': '000000'
              },
              usingProtocol: http.HttpProtocol.HTTP1_1,
              expectDataType: http.HttpDataType.STRING,
              usingCache: false
            }
            webResponse.setResponseIsReady(false)
            request.request(requestUrl, options, (err: BusinessError, data: http.HttpResponse) => {
              hilog.debug(12, 'debug','url'+ requestUrl + ', data = ' + JSON.stringify(data.result))
              let map: Map<string, string> = new Map(Object.entries(data.header))
              let responseHeader: Header[] = []
              map.forEach((value, key) => {
                responseHeader.push({ headerKey: key, headerValue: value })
              })
              let contentType: string = map?.get('content-type')?.split(";")[0] ?? ''
              webResponse.setResponseCode(data.responseCode)
              webResponse.setResponseHeader(responseHeader)
              webResponse.setResponseEncoding(map?.get('content-encoding'))
              webResponse.setResponseMimeType(contentType)
              webResponse.setResponseData(data.result as string)
              webResponse.setReasonMessage('ok')
              webResponse.setResponseIsReady(true)
            })
            return webResponse
          }
          return null
        })
    }
    .width('100%')
    .height('100%')
  }
}