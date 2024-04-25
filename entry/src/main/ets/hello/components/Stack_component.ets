@Entry
@Component
struct Stack_component {
  build() {
    Stack() {
      Text('Text')
        .width('20')
        .height('20')
        .backgroundColor(Color.Pink)
        .zIndex(100)

      Text('Text1')
        .width('200')
        .height('200')
        .backgroundColor(Color.Red)

      Text('Text2')
        .width('190')
        .height('190')
        .backgroundColor(Color.Green)

      Text('Text3')
        .width('180')
        .height('180')
        .backgroundColor(Color.Blue)

      Text('Text4')
        .width('160')
        .height('160')
        .backgroundColor(Color.Orange)
    }
    .margin(16)
    .backgroundColor(Color.Gray)
    .alignContent(Alignment.Center)
  }
}