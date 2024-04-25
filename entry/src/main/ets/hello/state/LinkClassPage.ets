import { Car, User } from './User'

@Entry
@Component
struct LinkClassPage {
  @State user: User = new User('Jane', new Car('Benz E'))
  build() {
    Column({ space: 10 }) {
      Text(`父组件 name=${this.user.name},car=${this.user.car?.brand}`)
      Button('user=new User("Mike")').onClick((event: ClickEvent) => {
        this.user = new User('Mike-P')
      })
      Divider()
      LinkClassChild({ user: $user })
    }.width('100%')
  }
}

@Component
struct LinkClassChild {
  // 禁止本地初始化
  @Link user: User

  build() {
    Column({ space: 10 }) {
      Text(`子组件 name=${this.user.name},car=${this.user.car?.brand}`)
      Button('user=new User("Shine")').onClick((event: ClickEvent) => {
        this.user = new User('Shine')
      })
      Button('user.car = new Car("Audi A6")').onClick((event: ClickEvent) => {
        this.user.car = new Car('Audi A6')
      })
      Button('user.car.brand="BWM 530"').onClick((event: ClickEvent) => {
        if (this.user.car) {
          this.user.car.brand = 'BWM 530'
        }
      })
    }
  }
}