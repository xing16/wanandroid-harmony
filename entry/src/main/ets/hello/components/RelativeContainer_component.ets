@Entry
@Component
struct RelativeContainer_component {
  build() {
    RelativeContainer() {
      Row()
        .width(100)
        .height(100)
        .backgroundColor(Color.Red)
        .alignRules({
          // 以父容器为锚点，并且自己的顶部 和 父容器顶部 对齐
          top: { anchor: '__container__', align: VerticalAlign.Top },
          // 以父容器为锚点，并且自己的左侧 和 父容器左侧 对齐
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('row1')

      Row()
        .width(200)
        .height(200)
        .backgroundColor(Color.Green)
        .alignRules({
          // 以 row1 为锚点，自己的顶部和 row1 的底部对齐
          top: { anchor: 'row1', align: VerticalAlign.Bottom },
          // 以 row1 为锚点，自己的左侧和 row1 的右侧对齐
          left: { anchor: 'row1', align: HorizontalAlign.End }
        })
    }

  }
}