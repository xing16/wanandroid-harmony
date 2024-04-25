@Preview
@Component
struct Row_component {
  build() {
    Column() {
      Row({ space: 20 }) {
        Text('Text1')
          .backgroundColor(Color.Red)
          .width(100)
          .height(130)
        Text('Text2')
          .backgroundColor(Color.Green)
          .width(100)
          .height(130)
        Text('Text3')
          .backgroundColor(Color.Blue)
          .width(100)
          .height(130)
        Text('Text4')
          .backgroundColor(Color.Orange)
          .width(100)
          .height(130)
      }
      //
      Row() {
        Text('Title')
          .fontSize(16)
        Blank()
        Toggle({
          type: ToggleType.Switch,
          isOn: true
        })
      }
      .width('100%')
      .backgroundColor(Color.Gray)
      .borderRadius(10)
      .margin(20)
      .padding(16)
    }
  }
}