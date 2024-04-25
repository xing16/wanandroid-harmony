import { Car, User } from './User'

@Entry
@Component
struct ObjectLinkBasicPage {
  @State user: User = new User('Jack', new Car('BMW 3 serial'))
  build() {
    Column({ space: 10 }) {
      Button(`user.car.brand = 'BMW'`).onClick((event: ClickEvent) => {
        if (this.user.car) {
          this.user.car.brand = 'Benz E class'
        }
      })
      Divider()
      CarItem({ car: this.user.car })
    }.width('100%')
  }
}

@Component
struct CarItem {
  // Car 需要被 @Observed 装饰
  @ObjectLink car: Car

  build() {
    Column() {
      Text('car: ' + this.car.brand)
      Button('car=new Car("audi")').onClick((event: ClickEvent) => {
        // 报错，@ObjectLink装饰的状态变量不允许被赋值， 可以对它的属性赋值
        // this.car = new Car('audi')
        this.car.brand = 'audi'
      })
    }
    .width('90%')
    .padding(20)
    .backgroundColor(Color.Pink)
  }
}
