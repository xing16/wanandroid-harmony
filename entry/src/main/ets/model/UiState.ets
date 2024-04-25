@Observed
export class UiState<T> {
  data: T
  state: LoadState

  constructor(data: T) {
    this.data = data;
    this.state = LoadState.SUCCESS
  }
}

export enum LoadState {
  LOADING = 0,
  SUCCESS = 1,
  FAILURE = 2
}
