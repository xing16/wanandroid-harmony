@Component
export struct ArticleItem {
  @Prop title: string
  @Prop author: string
  @Prop date: string

  build() {
    Column() {
      Text(this.title).fontSize(17).fontColor(Color.Black).fontWeight(500)
      Blank().height(12)
      Row({ space: 10 }) {
        Text(this.date).fontSize(12).fontColor('#666666')
        Text(this.author)
          .fontSize(12)
          .fontColor('#666666')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width('100%')
    .padding({ left: 15, top: 20, right: 15, bottom: 20 })
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}