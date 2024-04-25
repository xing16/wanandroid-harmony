@Entry
@Component
struct LinkBasicPage {
  @State text: string = 'ArkUI'
  build() {
    Column({ space: 10 }) {
      Text('父组件：' + this.text).onClick(() => {
        this.text = 'Flutter '
      })
      LinkBasicChild({ title: $text })
    }.width('100%')
  }
}

@Component
struct LinkBasicChild {
  // @Link装饰的状态变量禁止初始化
  // @Link title: string = ''
  @Link title: string
  build() {
    Column({ space: 10 }) {
      Text('子组件：' + this.title).onClick(() => {
        this.title = 'JetpackCompose'
      })
    }
  }
}