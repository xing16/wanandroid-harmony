import hilog from '@ohos.hilog';
import { HomePage } from './home/pages/HomePage';

let storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct Index {
  navigationBarHeight: number = AppStorage.get<number>('navigationBarHeight') ?? 0
  tabDatas: TabItem[] = [
    new TabItem('首页', $r('app.media.home_fill'), $r('app.media.home'), () => {
    }),
    new TabItem('项目', $r("app.media.project_fill"), $r("app.media.project"), () => {
    }),
    new TabItem('发现', $r('app.media.discover_fill'), $r('app.media.discover'), () => {
    }),
    new TabItem('我的', $r('app.media.me_fill'), $r('app.media.me'), () => {
    }),
  ]
  @State currentIndex: number = 0
  controller: TabsController = new TabsController()

  aboutToAppear() {
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      index: this.currentIndex,
      controller: this.controller
    }) {
      ForEach(this.tabDatas, (item: TabItem, index: number) => {
        TabContent() {
          if (index === 0) {
            HomePage()
          } else {
            Column() {
              Text('我的内容')
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#007DFF')
          }
        }
        .tabBar(this.tabBuilder(item.title, index, item.selectedIcon, item.normalIcon))
      })
    }
    .scrollable(false)
  }

  @Builder
  tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column({ space: 6 }) {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 20, height: 20 })
      Text(title)
        .fontSize(11)
        .fontColor(this.currentIndex === targetIndex ? '#000000' : '#666666')
    }
    .width('100%')
    .height(this.navigationBarHeight + vp2px(50) + 'px')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (this.currentIndex === targetIndex) {
        hilog.debug(12, 'debugde', 'navigationBarHeight = ' + this.navigationBarHeight)
        return
      }
      this.currentIndex = targetIndex
    })
  }
}

export class TabItem {
  title: string
  selectedIcon: Resource
  normalIcon: Resource
  content: () => void

  constructor(title: string, selectedIcon: Resource, normalIcon: Resource, content: () => void) {
    this.title = title
    this.selectedIcon = selectedIcon
    this.normalIcon = normalIcon
    this.content = content
  }
}
