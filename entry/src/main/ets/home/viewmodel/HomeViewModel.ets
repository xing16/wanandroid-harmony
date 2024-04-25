import { ObservableArray } from '../../common/ObservableArray'
import { ArticleItem, HomeModel } from '../data/model/HomeModel'
import { HomeRepository } from '../data/repository/HomeRepository'
import hilog from '@ohos.hilog'
import { LoadState, UiState } from '../../model/UiState'
import router from '@ohos.router'
import { BannerModel } from '../data/model/BannerModel'
import { RouterOptions } from '@system.router'

@Observed
export class HomeViewModel {
  private homeRepository: HomeRepository = new HomeRepository()
  // homeList: ObservableArray<ArticleItem> = []
  // 要使用 new ObservableArray([]) 才行
  homeList: ObservableArray<ArticleItem> = new ObservableArray([])
  homeListState: UiState<ObservableArray<ArticleItem>> = new UiState(new ObservableArray([]))
  // banner
  bannerList: ObservableArray<BannerModel> = new ObservableArray([])

  getBanner() {
    this.homeRepository.getBanner()
      .then((value) => {
        value.forEach((item: BannerModel) => {
          this.bannerList.push(item)
          hilog.debug(12, 'debugdebug', 'list =' + this.bannerList)
        })
      })
      .catch(() => {

      })
  }

  getHomeArticles() {
    this.homeListState.state = LoadState.LOADING
    this.homeRepository.getHomeArticles()
      .then((value) => {
        this.homeListState.state = LoadState.SUCCESS
        if (value && value.datas) {
          value.datas.forEach((item: ArticleItem) => {
            this.homeListState.data.push(item)
          })
        }
      }).catch(() => {
      this.homeListState.state = LoadState.FAILURE
    })
  }

  openPage(options: router.RouterOptions) {
    router.pushUrl(options)
  }
}