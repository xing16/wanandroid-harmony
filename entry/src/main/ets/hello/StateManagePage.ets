import { TestModel } from './models/TestModel'
import router from '@ohos.router'

@Entry
@Component
struct StateManagePage {
  list: TestModel[] = [
    new TestModel('State', 'hello/state/StateBasicPage'),
    new TestModel('State Class', 'hello/state/StateClassPage'),
    new TestModel('State Array', 'hello/state/StateArrayPage'),
    new TestModel('Prop', 'hello/state/PropPage'),
    new TestModel('Link', 'hello/state/LinkBasicPage'),
    new TestModel('Link Class', 'hello/state/LinkClassPage'),
    new TestModel('Link Array', 'hello/state/LinkArrayPage'),
    new TestModel('Provide Consume', 'hello/state/ProvideConsumeBasicPage'),
    new TestModel('Provide Consume Class', 'hello/state/ProvideConsumeClassPage'),
    new TestModel('Provide Consume Array', 'hello/state/ProvideConsumeArrayPage'),
    new TestModel('Object Link', 'hello/state/ObjectLinkClassPage'),
    new TestModel('Object Link Array', 'hello/state/ObjectLinkArrayPage'),
    new TestModel('ViewModel', 'hello/state/ViewModelPage')
  ]

  build() {
    Column() {
      List() {
        ForEach(this.list, (item: TestModel) => {
          ListItem() {
            Column() {
              Text(item.title)
                .fontSize(16)
                .padding(15)
                .onClick(() => {
                  router.pushUrl({ url: item.url })
                })
              Divider()
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
        })
      }.width('100%')
      .height('100%')
    }
    .width('100%')
  }
}