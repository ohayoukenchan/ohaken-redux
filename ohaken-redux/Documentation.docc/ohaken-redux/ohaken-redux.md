# ohaken-redux

A lightweight and testable Redux-like state management architecture for Swift and SwiftUI.

---

## Overview

`ohaken-redux` は、Swift + SwiftUI 向けに設計された軽量な Redux 風アーキテクチャです。  
アクション・状態・副作用（ミドルウェア）を分離して扱うことで、宣言的でテストしやすい状態管理を実現します。

このパターンでは次の要素を中心に構成されています：

- 🧠 **Store**: アプリの状態を一元管理し、アクションを受け取る
- 🧾 **Action**: 状態の変更や副作用のトリガーを表す
- ⚙️ **Reducer**: アクションに応じて状態を変化させる純粋関数
- 🌐 **Middleware**: 非同期処理や API 通信など副作用を処理
- 📦 **UseCase**: ビジネスロジックの単位
- 👀 **ViewState**: View 向けのラッパー（状態+ディスパッチャ）

---

## Topics

### 🏗️ アーキテクチャ構成

- <doc:CatStore>
- <doc:CatAction>
- <doc:catReducer>
- <doc:CatMiddleware>
- <doc:CatUseCase>
- <doc:ReduxCatViewState>
- <doc:ReduxCat>

---

### 🔧 モデルとユーティリティ

- <doc:Cat>
- <doc:CatStoreState>
- <doc:LoadingState>
- <doc:CatActionDispatcher>
- <doc:MiddleWareFactory>

---

### Testing

- <doc:TestingSupport>

### Usage Examples

- <doc:UsageExamples>

## See Also

- <doc:CatStore>
- <doc:ReduxCat>
- <doc:LoadingState>
