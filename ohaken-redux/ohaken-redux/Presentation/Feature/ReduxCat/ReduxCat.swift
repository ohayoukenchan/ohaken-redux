//
//  ReduxCat.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import SwiftUI

/// 猫の情報を Redux 風アーキテクチャで表示する SwiftUI ビュー。
///
/// `ReduxCat` は `ReduxCatViewState` を監視し、状態に応じて UI を切り替えます。
/// ビュー表示時に `.fetchCat` アクションを自動でディスパッチし、
/// 非同期で猫の画像を取得します。
///
/// - 表示内容:
///   - `idle`: 初期状態を示すテキスト表示。
///   - `loading`: 読み込み中インジケーター（`ProgressView`）。
///   - `success`: 取得した猫の画像を表示（なければ "No cat"）。
///   - `error`: エラーメッセージを表示。
///
/// - Note: このビューは `ReduxCatViewState<CatActionDispatcher>` を外部から受け取ります。
struct ReduxCat: View {
    /// 状態およびアクションディスパッチャを保持する `@ObservedObject`。
    @ObservedObject private var viewState: ReduxCatViewState<CatActionDispatcher>

    /// `ReduxCat` ビューの初期化。
    ///
    /// - Parameter viewState: 状態管理とアクションディスパッチャを含むオブジェクト。
    public init(viewState: ReduxCatViewState<CatActionDispatcher>) {
        self.viewState = viewState
    }

    var body: some View {
        VStack {
            switch viewState.loadingState {
            case .idle:
                Text("idle")
            case .loading:
                ProgressView()
            case .success:
                if let cat = viewState.cat {
                    AsyncImage(url: URL(string: cat.url))
                } else {
                    Text("No cat")
                }
            case .error(let message):
                Text("\(message)")
            }
        }
        .task {
            viewState.dispatch(.fetchCat)
        }
    }
}


#Preview {
    ReduxCat(viewState: ReduxCatViewState(actionDispatcher: CatActionDispatcher()))
}

