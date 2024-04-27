import { Constants } from '../../utils/Constant'
import { TabModel } from '../data/model/TabModel'
import { HomeViewModel } from '../viewmodel/HomeViewModel'
import { RecommendPage } from './RecommendPage'

@Component
export struct HomePage {
  @State viewModel: HomeViewModel = new HomeViewModel()
  @State sumScrollOffset: number = 0
  @State currentIndex: number = 0
  private tabController: TabsController = new TabsController()

  aboutToAppear() {
    this.viewModel.getHomeTab()
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
        ForEach(this.viewModel.tabList, (item: TabModel, index: number) => {
          if (item.id === TabModel.recommend_id) {
            TabContent() {
              RecommendPage({ sumScrollOffset: this.sumScrollOffset })
            }
            .tabBar(item.name)
          } else {
            TabContent() {
              Column() {
                Text(item.name).fontSize(30).fontWeight(600)
              }
              .justifyContent(FlexAlign.Center)
            }
          }
        })
      }
      .vertical(false)
      .scrollable(true)
      .barHeight(0)
      .tabIndex(this.currentIndex)
      .barMode(BarMode.Scrollable)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .height('100%')
      .width('100%')

      Column() {
        SearchBar({
          searchTextColor: this.sumScrollOffset > Constants.bannerHeight ? Color.Gray : Color.White,
          onSearchClick: () => {
            this.viewModel.openPage({
              url: 'search/pages/SearchPage'
            })
          }
        })
        List() {
          ForEach(this.viewModel.tabList, (item: TabModel, index: number) => {
            ListItem() {
              Column({ space: 0 }) {
                Text(item.name)
                  .layoutWeight(1)
                  .fontColor(index === this.currentIndex ? Color.Black : Color.Gray)
                  .fontWeight(index === this.currentIndex ? 600 : 400)
                  .fontSize(index === this.currentIndex ? 20 : 16)
                  .padding({
                    left: index === 0 ? 16 : 10,
                    right: index === this.viewModel.tabList.length - 1 ? 16 : 10
                  })
                Divider()
                  .offset({ y: -5 })
                  .width(20)
                  .height(3)
                  .backgroundColor(Color.Red)
                  .strokeWidth(3)
                  .color(Color.Black)
                  .opacity(this.currentIndex === index ? 1 : 0)
              }.onClick(() => {
                if (this.currentIndex === index) {
                  return
                }
                this.currentIndex = index
                this.tabController.changeIndex(this.currentIndex)
              })
            }
          })
        }
        .width('100%')
        .height(Constants.tabBarHeight)
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
      }
      .backgroundColor(this.sumScrollOffset > Constants.bannerHeight ? Color.White : Color.Transparent)
    }
  }

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? Color.Black : Color.Gray)
        .fontSize(this.currentIndex === index ? 17 : 16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .maxLines(1)
      Divider()
        .strokeWidth(2)
        .color(Color.Black)
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    .width(50)
  }
}

@Component
struct SearchBar {
  statusBarHeight: number = AppStorage.get<number>('statusBarHeight') ?? 0
  @Prop searchTextColor: Color
  onSearchClick: () => void = () => {
  }

  build() {
    Row() {
      Row({ space: 10 }) {
        Image($r('app.media.search'))
          .width(20)
          .height(20)
          .fillColor(this.searchTextColor)
        Text('请输入关键字')
          .fontColor(this.searchTextColor)
          .fontSize(13)
      }
      .height(32)
      .layoutWeight(1)
      .margin({ left: 20, right: 20 })
      .padding({ left: 13, right: 13 })
      .backgroundColor('#55eeeeee')
      .borderRadius(15)
      .onClick(() => {
        this.onSearchClick()
      })
    }
    .backgroundColor(Color.Transparent)
    .height(Constants.searchBarHeight + px2vp(this.statusBarHeight))
    .padding({ top: px2vp(this.statusBarHeight) })
  }
}