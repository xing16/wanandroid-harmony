import { ObservableArray } from '../../common/ObservableArray'
import { ArticleItem } from '../../components/ArticleItem'
import { UiState } from '../../model/UiState'
import { BannerModel } from '../data/model/BannerModel'
import { Article } from '../data/model/HomeModel'
import { HomeViewModel } from '../viewmodel/HomeViewModel'
import { Constants } from '../../utils/Constant'

@Component
export struct RecommendPage {
  private statusBarHeight: number = AppStorage.get<number>('statusBarHeight') ?? 0
  @State homeViewModel: HomeViewModel = new HomeViewModel()
  @Link sumScrollOffset: number

  aboutToAppear() {
    this.homeViewModel.getHomeArticles()
    this.homeViewModel.getBanner()
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Image(this.homeViewModel.curBannerImageUrl)
        .width('100%')
        .height(200)
        .align(Alignment.TopStart)
        .blur(50)
      Row()
        .width('100%')
        .height(200)
        .backgroundColor('#36000000')
      Column() {
        RecommendContent({
          homeListState: this.homeViewModel.homeListState,
          bannerList: this.homeViewModel.bannerList,
          onItemClick: (item: Article): void => {
            this.homeViewModel.openPage({
              url: 'details/WebViewPage',
              params: { url: item.link }
            })
          },
          onBannerClick: (item: BannerModel) => {
            this.homeViewModel.openPage({
              url: 'details/WebViewPage',
              params: { url: item.url }
            })
          },
          onBannerChange: (imageUrl: string) => {
            this.homeViewModel.curBannerImageUrl = imageUrl
          },
          onScroll: (scrollOffset: number, scrollState: ScrollState) => {
            this.sumScrollOffset += scrollOffset
            // this.searchBarBgColor = this.sumScrollOffset > Constants.bannerHeight ? Color.White : Color.Transparent
            // this.searchTextColor = this.sumScrollOffset > Constants.bannerHeight ? Color.Gray : Color.White
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding({ top: px2vp(this.statusBarHeight) + Constants.searchBarHeight + Constants.tabBarHeight })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct RecommendContent {
  @ObjectLink homeListState: UiState<ObservableArray<Article>>
  @ObjectLink bannerList: ObservableArray<BannerModel>
  onItemClick: (item: Article) => void = () => {
  }
  onBannerClick: (item: Article) => void = () => {
  }
  onBannerChange: (imageUrl: string) => void = () => {
  }
  onScroll: (scrollOffset: number, scrollState: ScrollState) => void = () => {
  }

  build() {
    // StateView({
    //   state: LoadState.SUCCESS,
    //   content: this.HomeContent
    // })
    RecommendListView({
      homeList: this.homeListState.data,
      bannerList: this.bannerList,
      onItemClick: this.onItemClick,
      onBannerClick: this.onBannerClick,
      onBannerChange: this.onBannerChange,
      onScroll: this.onScroll,
    })
  }
}

@Component
struct RecommendListView {
  @ObjectLink bannerList: ObservableArray<BannerModel>
  @ObjectLink homeList: ObservableArray<Article>
  onBannerClick: (item: BannerModel) => void = () => {
  }
  onBannerChange: (imageUrl: string) => void = () => {
  }
  onItemClick: (item: Article) => void = () => {
  }
  onScroll: (scrollOffset: number, scrollState: ScrollState) => void = () => {
  }

  build() {
    List() {
      ListItem() {
        Banner({
          bannerList: this.bannerList,
          onBannerClick: this.onBannerClick,
          onBannerChange: this.onBannerChange
        })
      }

      ForEach(this.homeList, (item: Article) => {
        ListItem() {
          RecommendItem({ item: item, onItemClick: this.onItemClick })
        }
      }, (item: ArticleItem) => {
        return JSON.stringify(item)
      })
    }
    .width('100%')
    .height('100%')
    .edgeEffect(EdgeEffect.None)
    .divider({ strokeWidth: 10, color: '#f9f9f9' })
    .onScroll((scrollOffset: number, scrollState: ScrollState) => {
      this.onScroll(scrollOffset, scrollState)
    })
  }
}

@Component
struct Banner {
  private swiperController: SwiperController = new SwiperController()
  @ObjectLink bannerList: ObservableArray<BannerModel>
  onBannerClick: (item: BannerModel) => void = () => {
  }
  onBannerChange: (imageUrl: string) => void = () => {
  }

  build() {
    Swiper(this.swiperController) {
      ForEach(this.bannerList, (item: BannerModel) => {
        Image(item.imagePath)
          .width('100%')
          .height(Constants.bannerHeight)
          .onClick(() => {
            this.onBannerClick(item)
          })
      })
    }
    .borderRadius(6)
    .margin({ left: 20, right: 20 })
    .cachedCount(1)
    .index(0)
    .autoPlay(true)
    .interval(3600)
    .itemSpace(10)
    .displayMode(SwiperDisplayMode.STRETCH)
    .effectMode(EdgeEffect.Spring)
    .indicator(Indicator.dot()
      .right(0)
      .bottom(0)
      .itemWidth(6)
      .itemHeight(6)
      .selectedItemWidth(6)
      .selectedItemHeight(6)
      .color(Color.Gray)
      .selectedColor(Color.Black))
    .loop(true)
    .duration(1000)
    .itemSpace(0)
    .displayArrow(false)
    .onChange((index: number) => {
      this.onBannerChange(this.bannerList[index].imagePath)
    })
  }
}

@Component
struct RecommendItem {
  @ObjectLink item: Article
  onItemClick: (item: Article) => void = () => {
  }

  build() {
    ArticleItem({
      title: this.item.title,
      date: this.item.niceShareDate,
      author: this.item.shareUser ?? this.item.author }
    ).onClick(() => {
      this.onItemClick(this.item)
    })
  }
}
