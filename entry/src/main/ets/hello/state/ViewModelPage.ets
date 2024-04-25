import { ObservableArray } from '../../common/ObservableArray'
import { Car, User } from './User'
import { UserViewModel, UserViewModel2 } from './UserViewModel'

@Entry
@Component
struct ViewModelPage {
  @State viewModel: UserViewModel = new UserViewModel([
    new User('jack', new Car('保时捷')),
    new User('mack', new Car('奔驰'))
  ])

  build() {
    Scroll() {
      Column() {
        Flex({ wrap: FlexWrap.Wrap }) {
          Button('new Array')
            .margin(6)
            .onClick((event: ClickEvent) => {
              this.viewModel.userList = [new User('new kotlin')]
            })

          Button('add')
            .margin(6)
            .onClick((event: ClickEvent) => {
              this.viewModel.userList.push(new User('kotlin'))
            })

          Button('remove')
            .margin(6)
            .onClick((event: ClickEvent) => {
              if (this.viewModel.userList.length > 0) {
                this.viewModel.userList.splice(0, 1)
              }
            })

          Button('viewModel.userList[0]=new User("peter")')
            .margin(6)
            .onClick((event: ClickEvent) => {
              if (this.viewModel.userList.length > 0) {
                this.viewModel.userList[0] = new User('peter', new Car('马自达'))
              }
            })

          Button('viewModel.userList[0].name="张三"')
            .margin(6)
            .onClick((event: ClickEvent) => {
              if (this.viewModel.userList.length > 0) {
                this.viewModel.userList[0].name = '张三'
              }
            })

          Button('viewModel.userList[0].car.brand="XIAOMI SU7 MAX"')
            .margin(6)
            .onClick((event: ClickEvent) => {
              if (this.viewModel.userList.length > 0) {
                let car = this.viewModel.userList[0].car
                if (car) {
                  car.brand = 'XIAOMI SU7 MAX'
                }
              }
            })
        }
        ChildUser({ userList: this.viewModel.userList })
      }
    }
  }
}

@Component
struct ChildUser {
  // ObservableArray 需要被 @Observed 装饰
  @ObjectLink userList: ObservableArray<User>

  build() {
    Column() {
      ForEach(this.userList, (user: User) => {
        UserItem({ user: user })
        Divider()
      })
    }.padding(20)
  }
}

@Component
struct UserItem {
  // User 需要被 @Observed 装饰
  @ObjectLink user: User

  build() {
    Column() {
      Text('user.name: ' + this.user.name)
      CarItem({ car: this.user.car })
    }
  }
}

@Component
struct CarItem {
  // Car 需要被 @Observed 装饰
  @ObjectLink car: Car | undefined

  build() {
    Text('user.car: ' + this.car?.brand)
  }
}
