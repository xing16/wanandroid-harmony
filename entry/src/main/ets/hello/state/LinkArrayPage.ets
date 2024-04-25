@Entry
@Component
struct LinkArrayPage {
  @State list: string[] = ['Android', 'iOS', 'Harmony']
  build() {
    Column({ space: 10 }) {
      ForEach(this.list, (item: string) => {
        Text(item)
      })
      Button('new Array').onClick((event: ClickEvent) => {
        this.list = new Array<string>('Benz', 'BMW', 'Audi')
      })
      Button('Add').onClick((event: ClickEvent) => {
        this.list.push('parent add')
      })
      Button('remove').onClick((event: ClickEvent) => {
        if (this.list.length > 0) {
          this.list.splice(0, 1)
        }
      })
      Button('update').onClick((event: ClickEvent) => {
        if (this.list.length > 0) {
          this.list[0] = 'parent update'
        }
      })
      Divider()
      LinkArrayChild({ childList: $list })
    }.width('100%')
  }
}

@Component
struct LinkArrayChild {
  @Link childList: string[]
  build() {
    Column({ space: 10 }) {
      ForEach(this.childList, (item: string) => {
        Text(item)
      })
      Button('new Array').onClick((event: ClickEvent) => {
        this.childList = new Array<string>('Kotlin', 'Swift', 'ArkTS')
      })
      Button('Add').onClick((event: ClickEvent) => {
        this.childList.push('child Add')
      })
      Button('remove').onClick((event: ClickEvent) => {
        if (this.childList.length > 0) {
          this.childList.splice(0, 1)
        }
      })
      Button('update').onClick((event: ClickEvent) => {
        if (this.childList.length > 0) {
          this.childList[0] = 'child update'
        }
      })
    }
  }
}
