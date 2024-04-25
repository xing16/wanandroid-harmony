@Observed
export class ObservableArray<T> extends Array<T> {
  constructor(args: T[]) {
    if (args instanceof Array) {
      super(...args);
    } else {
      super(args)
    }
  }
}