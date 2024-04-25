import { User } from './User'

@Entry
@Component
struct ProvideConsumeClassPage {
  @Provide user: User = new User('Apple')
  build() {
    Column({ space: 10 }) {
      Text('父组件：' + this.user.name)
      Button('user.name="parent"').onClick((event: ClickEvent) => {
        this.user.name = 'parent'
      })
      Divider()
      ProvideClassChild()
    }.width('100%')
  }
}

@Component
struct ProvideClassChild {
  @Consume user: User
  build() {
    Column({ space: 10 }) {
      Text('孩子组件：' + this.user.name)
      Divider()
      ProvideClassChildSecond()
    }
  }
}

@Component
struct ProvideClassChildSecond {
  @Consume user: User
  build() {
    Column({ space: 10 }) {
      Text('孙子组件：' + this.user.name)
      Divider()
      ProvideClassChildThird()
    }
  }
}

@Component
struct ProvideClassChildThird {
  @Consume user: User
  build() {
    Column({ space: 10 }) {
      Text('曾孙子：' + this.user.name)
      Button('user=new User("曾孙子")').onClick((event: ClickEvent) => {
        this.user = new User('曾孙子')
      })
      Button('user.name="曾孙name：sx"').onClick((event: ClickEvent) => {
        this.user.name="曾孙name：sx"
      })
      Button('user.car.brand = "曾孙.name.car: Benz S"').onClick((event: ClickEvent) => {
        if (this.user.car) {
          this.user.car.brand = '曾孙.name.car: Benz S'
        }
      })
    }
  }
}