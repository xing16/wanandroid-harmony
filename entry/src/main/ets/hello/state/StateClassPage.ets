import { Car, User } from './User'

@Entry
@Component
struct StateClassPage {
  @State user: User = new User('Jack')
  build() {
    Column({space: 10}) {
      Text('Class: ' + `name=${this.user.name}, car=${this.user.car?.brand}`).fontSize(17)
      Column({ space: 10 }) {
        Button(`user = new User('Mike')`).onClick((event: ClickEvent) => {
          // 有效刷新
          this.user = new User('Mike')
        })
        Button(`user.name = 'Pony New'`).onClick((event: ClickEvent) => {
          // 有效刷新
          this.user.name = 'Pony New'
        })
        Button(`user.car = new Car('Benz')`).onClick((event: ClickEvent) => {
          // 有效刷新，@State 可以观察到一级属性 car 的赋值
          this.user.car = new Car('Benz')
        })
        Button(`this.user.car.brand = 'BMW'`).onClick((event: ClickEvent) => {
          // 无效刷新， user.car.brand, user.car.engine 为二级属性, @State 观察不到, 需要使用 @Observed 和 @ObjectLink
          if (this.user.car) {
            this.user.car.brand = 'BMW'
          }
        })
      }
    }.width('100%')
  }
}