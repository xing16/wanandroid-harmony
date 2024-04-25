import { Car, User } from './User'

@Entry
@Component
struct PropPage {
  @State text: string = 'ArkUI'
  @State user: User = new User('Jane', new Car('Benz E'))

  build() {
    Column({ space: 10 }) {
      Text(this.text).onClick(() => {
        this.text = 'Flutter '
      })
      Text(`name:${this.user.name},car=${this.user.car?.brand}`)
        .onClick(()=> {
          this.user = new User('parent User')
        })
      Divider().height(20)
      PropChild({ title: this.text, user: this.user })
    }.width('100%')
  }
}

@Component
struct PropChild {
  /**
   * 修改父组件的状态变量可以同步刷新子组件, 而修改子组件的状态变量不会同步刷新父组件
   */
  @Prop title: string = 'default'
  @Prop user: User

  build() {
    Column({ space: 10 }) {
      Text(this.title).onClick(() => {
        this.title = 'JetpackCompose'
      })
      Text(`name:${this.user.name},car=${this.user.car?.brand}`)
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