import { ObservableArray } from '../../common/ObservableArray';
import { User } from './User';

export class UserViewModel {
  userList: ObservableArray<User> = []

  constructor(users: User[]) {
    this.userList = new ObservableArray(users);
  }
}

export class UserViewModel2 {
  userList: User[]
  constructor(users: User[]) {
    this.userList = users;
  }
}