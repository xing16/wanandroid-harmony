import { User } from './User'

@Entry
@Component
struct StateArrayPage {
  @State stringArray: string[] = ['Java', 'Kotlin']
  @State userArray: User[] = [new User('Jack'), new User('Make')]

  build() {
    Column({ space: 10 }) {
      ForEach(this.stringArray, (item: string) => {
        Text(item)
      })
      Row({ space: 6 }) {
        Button('add').onClick((event: ClickEvent) => {
          this.stringArray.push('Typescript')
        })
        Button('remove').onClick((event: ClickEvent) => {
          if (this.stringArray.length > 0) {
            this.stringArray.splice(0, 1)
          }
        })
        Button('update').onClick((event: ClickEvent) => {
          if (this.stringArray.length > 0) {
            this.stringArray[0] = 'Javascript by updated'
          }
        })
        Button('new Array()').onClick((event: ClickEvent) => {
          this.stringArray = ['New Array1', 'New Array2']
        })
      }

      Divider().height(20).color(Color.Gray)

      ForEach(this.userArray, (item: User) => {
        Text(`name=${item.name},car=${item.car}`)
      })
      Column({ space: 10 }) {
        Button('add').onClick((event: ClickEvent) => {
          this.userArray.push(new User('Jane'))
        })
        Button('remove').onClick((event: ClickEvent) => {
          if (this.stringArray.length > 0) {
            this.userArray.splice(0, 1)
          }
        })
        Button('update userArray[0]=new User("Lace")').onClick((event: ClickEvent) => {
          if (this.stringArray.length > 0) {
            // class 数组, 可以观察到数组中元素 重新赋值
            this.userArray[0] = new User('Lace')
          }
        })
        Button('userArray[0].name="Shane"').onClick((event: ClickEvent) => {
          // class数组, 观察不到数组中 元素的属性 赋值
          this.userArray[0].name = 'Shane'
        })
      }
    }
    .width('100%')
  }
}