import url from '@ohos.url';

export function getHost(urlString: string) {
  let tempUrl = url.URL.parseURL(urlString)
  return tempUrl.host
}

export function getScheme(urlString: string) {
  let tempUrl = url.URL.parseURL(urlString)
  return tempUrl.protocol
}