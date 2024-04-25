export class HttpBusinessError {
  errorCode: number
  errorMsg?: string

  constructor(code: number, msg?: string) {
    this.errorCode = code
    this.errorMsg = msg
  }
}