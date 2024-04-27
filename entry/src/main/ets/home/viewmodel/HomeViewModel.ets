import { ObservableArray } from '../../common/ObservableArray'
import { HomeRepository } from '../data/repository/HomeRepository'
import hilog from '@ohos.hilog'
import { LoadState, UiState } from '../../model/UiState'
import router from '@ohos.router'
import { BannerModel } from '../data/model/BannerModel'
import { Article } from '../data/model/HomeModel'
import { TabModel } from '../data/model/TabModel'

@Observed
export class HomeViewModel {
  private homeRepository: HomeRepository = new HomeRepository()
  /**
   * 首页 Tabs
   */
  tabList: ObservableArray<TabModel> = new ObservableArray([])
  // homeList: ObservableArray<ArticleItem> = []
  // 要使用 new ObservableArray([]) 才行
  /**
   * 首页文章列表
   */
  homeList: ObservableArray<Article> = new ObservableArray([])
  homeListState: UiState<ObservableArray<Article>> = new UiState(new ObservableArray([]))
  // banner
  bannerList: ObservableArray<BannerModel> = new ObservableArray([])
  curBannerImageUrl: string = ''

  getHomeTab() {
    this.homeRepository.getHomeTab()
      .then((value) => {
        this.tabList = new ObservableArray([])
        this.tabList.push(new TabModel(TabModel.recommend_id, '推荐'))
        this.tabList.push(new TabModel(TabModel.question_id, '问答'))
        value.forEach((item: TabModel) => {
          this.tabList.push(item)
        })
      })
  }

  getBanner() {
    this.homeRepository.getBanner()
      .then((value) => {
        value.forEach((item: BannerModel) => {
          this.bannerList.push(item)
          if (this.bannerList.length > 0) {
            this.curBannerImageUrl = this.bannerList[0].imagePath ?? ''
          }
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
          value.datas.forEach((item: Article) => {
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