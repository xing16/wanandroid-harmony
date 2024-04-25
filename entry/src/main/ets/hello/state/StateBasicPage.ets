@Entry
@Component
struct StatePage {
  @State text: string = 'HarmonyOS'
  @State count: number = 0

  build() {
    Column({ space: 10 }) {
      Text('string: ' + this.text).fontSize(17)
      Text('number: ' + this.count)
      Button('text = "Android"').onClick((event: ClickEvent) => {
        this.text = 'Android'
      })
      Button('count++').onClick((event: ClickEvent) => {
        this.count++
      })
    }
    .width('100%')
    .height('100%')
  }
}