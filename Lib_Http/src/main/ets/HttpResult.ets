export class HttpResult<T> {
  errorCode: number = -1
  errorMsg?: string
  data?: T
}