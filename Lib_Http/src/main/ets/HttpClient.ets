import http from '@ohos.net.http'
import { HttpBusinessError } from './HttpBusinessError'
import { HttpResult } from './HttpResult'

export class HttpClient {
  BASE_URL: string = 'https://www.wanandroid.com/'

  constructor(baseUrl?: string) {
    if (baseUrl) {
      this.BASE_URL = baseUrl
    }
  }

  async request<T>(url: string, options: http.HttpRequestOptions): Promise<T> {
    return new Promise((resolve, reject) => {
      const httpRequest: http.HttpRequest = http.createHttp()
      httpRequest.request(this.BASE_URL + url, options)
        .then((response) => {
          if (response.responseCode === http.ResponseCode.OK) {
            const result: HttpResult<T> = JSON.parse(response.result as string) as HttpResult<T>
            if (result.errorCode === 0 && result.data) {
              resolve(result.data)
            } else {
              reject(new HttpBusinessError(response.responseCode))
            }
          } else {
            reject()
          }
        })
        .catch(() => {
          reject()
        })
        .finally(() => {
          httpRequest.destroy()
        })
    })
  }
}

export const httpClient = new HttpClient()
