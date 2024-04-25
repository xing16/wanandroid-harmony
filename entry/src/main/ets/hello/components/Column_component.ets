@Entry
@Component
struct Column_component {
  build() {
    Column({ space: 20 }) {
      Text('Text1')
        .width(100)
        .height(200)
        .backgroundColor(Color.Red)

      Text('Text2')
        .width(100)
        .height(260)
        .backgroundColor(Color.Green)

      Text('Text3')
        .width(100)
        .height(300)
        .backgroundColor(Color.Blue)
      Text('Text4')
        .width(100)
        .height(600)
        .backgroundColor(Color.Orange)

      Text('Text5')
        .width(100)
        .height(100)
        .backgroundColor(Color.Pink)

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
  }
}