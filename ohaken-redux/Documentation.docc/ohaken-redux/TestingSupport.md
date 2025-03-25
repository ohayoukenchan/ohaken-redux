# ohaken-redux/TestingSupport

ユニットテスト・モック注入のしやすさについて

## Overview

`ohaken-redux` は以下のような理由でテストしやすく設計されています：

- `CatUseCase` や `CatMiddleware` はプロトコルベース → モックで差し替え可能
- `Reducer` は副作用のない純粋関数 → 状態遷移テストが簡単
- Middleware は非同期クロージャ（@Sendable）対応 → テスト用の `dispatch` を差し込める

