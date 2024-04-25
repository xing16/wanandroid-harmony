import router from '@ohos.router'

@Component
export struct NavigationBar {
  onBackClick?: () => void
  @Prop title: string = ''

  build() {
    Row() {
      Image($r('app.media.back'))
        .height('100%')
        .padding(13)
        .onClick(() => {
          if (this.onBackClick) {
            this.onBackClick()
          } else {
            router.back()
          }
        })
      Text(this.title)
        .fontSize(17)
        .fontColor(Color.Black)
        .fontWeight(500)
        .maxFontSize(1)
        .margin({ left: 12, top: 16, right: 12, bottom: 16 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height(50)
    .backgroundColor(Color.White)
  }
}