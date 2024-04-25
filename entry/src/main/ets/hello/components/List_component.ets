@Entry
@Component
struct List_component {
  list: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  build() {
    Column() {
      List() {
        ListItem() {
          Text('Text1')
        }

        ListItem() {
          Text('Text2')
        }
      }
      .width('100%')
      .listDirection(Axis.Vertical)
      .alignListItem(ListItemAlign.Center)

      List({ space: 10 }) {
        ForEach(this.list, (item: number, index: number) => {
          ListItem() {
            Column() {
              Text(`Text - ${item}`)
              Text(`${index + 1}`)
            }
            .padding(10)
          }
        })
      }
      .width('100%')
      .divider({
        strokeWidth: 1,
        startMargin: 10,
        endMargin: 10,
        color: Color.Grey
      })
      .scrollBar(BarState.Auto)

    }

  }
}