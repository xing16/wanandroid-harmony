import { HomeModel } from '../model/HomeModel';
import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import { httpClient } from 'library'
import { BannerModel } from '../model/BannerModel';

export class HomeDataSource {
  /**
   * banner
   * @returns
   */
  async getBanner(): Promise<Array<BannerModel>> {
    return httpClient.request('banner/json', {
      method: http.RequestMethod.GET
    })
  }

  /**
   * 首页文章列表
   * @returns
   */
  async getHomeArticles(): Promise<HomeModel> {
    return httpClient.request('article/list/0/json', {
      method: http.RequestMethod.GET,
      expectDataType: http.HttpDataType.STRING
    })
  }
}