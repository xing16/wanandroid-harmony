import { HomeModel } from '../model/HomeModel';
import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import { httpClient } from 'library'
import { BannerModel } from '../model/BannerModel';
import { TabModel } from '../model/TabModel';

export class HomeDataSource {
  /**
   * home tabs
   * @returns
   */
  async getHomeTab(): Promise<Array<TabModel>> {
    return httpClient.request('project/tree/json', {
      method: http.RequestMethod.GET
    })
  }

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