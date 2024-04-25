@Entry
@Component
struct Flex_component {
  build() {
    Flex({
      direction: FlexDirection.Row,
      wrap: FlexWrap.Wrap,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center,
      alignContent: FlexAlign.Center
    }) {

      Text('Text1')
        .width('50%')
        .height(100)
        .backgroundColor(Color.Red)

      Text('Text2')
        .width('50%')
        .height(100)
        .backgroundColor(Color.Green)

      Text('Text3')
        .width('50%')
        .height(100)
        .backgroundColor(Color.Blue)

      Text('Text4')
        .width('50%')
        .height(100)
        .backgroundColor(Color.Pink)
    }
    .width('100%')

  }
}