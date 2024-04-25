@Entry
@Component
struct ProvideConsumeArrayPage {
  @Provide stringArray: string[] = ['Android', 'iOS']

  build() {
    Column({ space: 6 }) {
      ForEach(this.stringArray, (item: string) => {
        Text(item).onClick(() => {
          this.stringArray[0] = 'update parent'
        })
      })
      ConsumeChild()
    }
    .width('100%')
  }
}

@Component
struct ConsumeChild {
  @Consume stringArray: string[]

  build() {
    Column({ space: 10 }) {
      ForEach(this.stringArray, (item: string) => {
        Text(item)
          .onClick(() => {
            this.stringArray[0] = 'update'
          })
      })
      ConsumeChildSecond()
    }
    .backgroundColor(Color.Brown)
    .padding(30)
  }
}

@Component
struct ConsumeChildSecond {
  @Consume stringArray: string[]

  build() {
    Column() {
      ForEach(this.stringArray, (item: string) => {
        Row() {
          Text(item)
            .onClick(() => {
              this.stringArray[0] = 'update second'
            })
        }.backgroundColor(Color.Gray)
      })
    }
    .backgroundColor(Color.Pink)
    .padding(30)
  }
}