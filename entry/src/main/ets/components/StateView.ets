import { LoadState } from '../model/UiState'

@Component
export struct StateView {
  @Prop state: LoadState
  @BuilderParam
  content: () => void
  @BuilderParam
  empty: () => void = this.emptyView
  @BuilderParam
  loading: () => void = this.loadingView

  build() {
    Stack() {
      this.content()
      Stack() {
        this.loading()
      }
      .width('100%')
      .height('100%')
      .visibility(this.state == LoadState.LOADING ? Visibility.Visible : Visibility.None)
    }
  }

  @Builder
  loadingView() {
    LoadingProgress()
      .width(50)
      .height(50)
      .visibility(this.state == LoadState.LOADING ? Visibility.Visible : Visibility.None)
  }

  @Builder
  emptyView() {

  }
}