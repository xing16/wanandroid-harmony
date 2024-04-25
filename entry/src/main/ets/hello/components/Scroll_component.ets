@Entry
@Component
struct Scroll_component {
  private scroller: Scroller = new Scroller()
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  build() {
    Scroll(this.scroller) {
      Column() {
        ForEach(this.arr, (item: number, index: number) => {
          Text(`Text - ${index}`)
            .width('100%')
            .height(60)
            .borderRadius(15)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .margin(16)
        })
      }
      .width('100%')
    }
    .backgroundColor(Color.Gray)
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.On)
    .scrollBarColor(Color.Blue)
    .scrollBarWidth(10)
    .edgeEffect(EdgeEffect.Fade)
  }
}