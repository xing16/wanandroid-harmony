import { Car, User } from './User'

@Entry
@Component
struct ObjectLinkBasicPage {
  @State userArray: User[] = [
    new User('Jack', new Car('BMW 3 serial')),
    new User('Mike', new Car('Audi A4L'))
  ]

  build() {
    Column({ space: 10 }) {
      Button(`userArray[0].car.brand = 'Benz S class'`).onClick((event: ClickEvent) => {
        if (this.userArray.length > 0) {
          let user: User = this.userArray[0]
          if (user.car) {
            user.car.brand = 'Benz S class'
          }
        }
      })
      ForEach(this.userArray, (item: User) => {
        UserItem({ user: item })
      })
    }.width('100%')
  }
}

@Component
struct UserItem {
  @ObjectLink user: User

  build() {
    CarItem({ car: this.user.car })
  }
}

@Component
struct CarItem {
  // Car 需要被 @Observed 装饰
  @ObjectLink car: Car

  build() {
    Column() {
      Text('car: ' + this.car.brand)
    }
    .width('90%')
    .padding(20)
    .backgroundColor(Color.Pink)
  }
}