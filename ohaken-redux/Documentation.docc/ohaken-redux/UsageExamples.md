# ohaken-redux/UsageExamples

## Overview

### SwiftUI View での利用例

```swift
ReduxCat(viewState: ReduxCatViewState(actionDispatcher: CatActionDispatcher()))
```

### モックを使った初期化例
```swift
let mock = CatStore(middleware: MockCatMiddleware())
```
