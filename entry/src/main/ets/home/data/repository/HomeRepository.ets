import { HomeDataSource } from '../datasource/HomeDataSource';
import { BannerModel } from '../model/BannerModel';
import { HomeModel } from '../model/HomeModel';

export class HomeRepository {
  private dataSource: HomeDataSource = new HomeDataSource();

  async getHomeArticles(): Promise<HomeModel> {
    return this.dataSource.getHomeArticles();
  }

  async getBanner(): Promise<Array<BannerModel>> {
    return this.dataSource.getBanner();
  }
}