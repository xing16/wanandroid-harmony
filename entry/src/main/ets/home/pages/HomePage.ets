import { ObservableArray } from '../../common/ObservableArray'
import { StateView } from '../../components/StateView'
import { LoadState, UiState } from '../../model/UiState'
import { BannerModel } from '../data/model/BannerModel'
import { ArticleItem } from '../data/model/HomeModel'
import { HomeViewModel } from '../viewmodel/HomeViewModel'

@Component
export struct HomePage {
  @State homeViewModel: HomeViewModel = new HomeViewModel()

  aboutToAppear() {
    this.homeViewModel.getHomeArticles()
    this.homeViewModel.getBanner()
  }

  build() {
    Column() {
      SearchBar({
        onSearchClick: () => {
          this.homeViewModel.openPage({
            url: 'search/pages/SearchPage'
          })
        }
      })
      Content({
        homeListState: this.homeViewModel.homeListState,
        bannerList: this.homeViewModel.bannerList,
        onItemClick: (item: ArticleItem): void => {
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
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SearchBar {
  onSearchClick: () => void = () => {
  }

  build() {
    Row() {
      Row({ space: 10 }) {
        Image($r('app.media.search'))
          .width(20)
          .height(20)
          .fillColor(Color.Gray)

        Text('请输入关键字').fontColor(Color.Gray).fontSize(13)
      }
      .height(32)
      .layoutWeight(1)
      .margin({ left: 20, right: 20 })
      .padding({ left: 13, right: 13 })
      .backgroundColor('#eee')
      .borderRadius(15)
      .onClick(() => {
        this.onSearchClick()
      })
    }
    .width('100%')
    .height(50)
  }
}

@Component
struct Content {
  @ObjectLink homeListState: UiState<ObservableArray<ArticleItem>>
  @ObjectLink bannerList: ObservableArray<BannerModel>
  onItemClick: (item: ArticleItem) => void = () => {
  }
  onBannerClick: (item: ArticleItem) => void = () => {
  }

  build() {
    // StateView({
    //   state: LoadState.SUCCESS,
    //   content: this.HomeContent
    // })
    HomeListView({
      homeList: this.homeListState.data,
      bannerList: this.bannerList,
      onItemClick: this.onItemClick,
      onBannerClick: this.onBannerClick
    })
  }
}

@Component
struct HomeListView {
  @ObjectLink bannerList: ObservableArray<BannerModel>
  @ObjectLink homeList: ObservableArray<ArticleItem>
  onBannerClick: (item: BannerModel) => void = () => {
  }
  onItemClick: (item: ArticleItem) => void = () => {
  }

  build() {
    List() {
      ListItem() {
        Banner({
          bannerList: this.bannerList,
          onBannerClick: this.onBannerClick
        })
      }

      ForEach(this.homeList, (item: ArticleItem) => {
        ListItem() {
          HomeItem({ item: item, onItemClick: this.onItemClick })
        }
      }, (item: ArticleItem) => {
        return JSON.stringify(item)
      })
    }
    .width('100%')
    .height('100%')
    .divider({ strokeWidth: 10, color: '#f9f9f9' })
  }
}

@Component
struct Banner {
  private swiperController: SwiperController = new SwiperController()
  @ObjectLink bannerList: ObservableArray<BannerModel>
  onBannerClick: (item: BannerModel) => void = () => {
  }

  build() {
    Swiper(this.swiperController) {
      ForEach(this.bannerList, (item: BannerModel) => {
        Image(item.imagePath)
          .width('100%')
          .height(160)
          .onClick(() => {
            this.onBannerClick(item)
          })
      })
    }
    .cachedCount(2)
    .index(0)
    .autoPlay(true)
    .interval(2000)
    .itemSpace(10)
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
  }
}

@Component
struct HomeItem {
  @ObjectLink item: ArticleItem
  onItemClick: (item: ArticleItem) => void = () => {
  }

  build() {
    Column() {
      Text(this.item.title).fontSize(18).fontColor(Color.Black).fontWeight(500)
      Blank().height(12)
      Row({ space: 10 }) {
        Text(this.item.niceShareDate).fontSize(12).fontColor('#666666')
        Text(this.item.shareUser ?? this.item.author)
          .fontSize(12)
          .fontColor('#666666')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width('100%')
    .padding({ left: 15, top: 20, right: 15, bottom: 20 })
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
    .onClick(() => {
      this.onItemClick(this.item)
    })
  }
}
