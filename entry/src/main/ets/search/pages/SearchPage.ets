@Entry
@Component
struct SearchPage {
  statusBarHeight: number = AppStorage.get<number>('statusBarHeight') ?? 0

  build() {
    Column() {
      Text('搜索')
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.statusBarHeight })
  }
}