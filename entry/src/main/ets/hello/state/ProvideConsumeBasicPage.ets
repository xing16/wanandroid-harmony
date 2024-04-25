@Entry
@Component
struct ProvideConsumeBasicPage {
  @Provide count: number = 1

  build() {
    Column({ space: 10 }) {
      Text(this.count.toString()).onClick(() => {
        this.count++
      })
      ProvideChild()
    }
    .width('100%')
  }
}

@Component
struct ProvideChild {
  @Consume count: number

  build() {
    Column({ space: 10 }) {
      Text(this.count.toString()).onClick(() => {
        this.count += 2
      })
      ProvideChildSecond()
    }
    .backgroundColor(Color.Brown)
    .padding(30)
  }
}

@Component
struct ProvideChildSecond {
  @Consume count: number

  build() {
    Column() {
      Text(this.count.toString()).onClick(() => {
        this.count += 3
      })
    }
    .backgroundColor(Color.Pink)
    .padding(30)
  }
}