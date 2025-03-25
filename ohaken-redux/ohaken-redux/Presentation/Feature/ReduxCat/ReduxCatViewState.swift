//
//  ReduxCatViewState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import SwiftUI

/// `Cat`と`LoadingState`を監視し、アクションをディスパッチする ViewModel。
///
/// `ReduxCatViewState` は `CatStore` の `@Published` プロパティ（`cat`、`loadingState`）を購読し、
/// SwiftUI ビューにリアクティブに反映します。
///
/// また、`CatAction` を `ActionDispatcher` を通じて非同期にディスパッチする機能も提供します。
///
/// - Note: このクラスは `@MainActor` 指定されており、UI スレッド上で安全に動作します。
/// - Important: ジェネリクス `D` は `ActionDispatcher` プロトコルに準拠し、
///   `D.ActionType` は `CatAction` に一致している必要があります。
@MainActor
final class ReduxCatViewState<D: ActionDispatcher>: ObservableObject where D.ActionType == CatAction {

    /// アクションのディスパッチャ。
    private let actionDispatcher: D

    /// 現在の猫の情報。
    @Published var cat: Cat?

    /// 現在の読み込み状態。
    @Published var loadingState: LoadingState = .idle

    /// `ReduxCatViewState` の初期化。
    ///
    /// `CatStore` の状態を監視し、ビューに反映させるよう購読をセットアップします。
    ///
    /// - Parameter actionDispatcher: アクションをディスパッチするためのインスタンス。
    public init(actionDispatcher: D) {
        self.actionDispatcher = actionDispatcher
        CatStore.shared.$cat.assign(to: &$cat)
        CatStore.shared.$loadingState.assign(to: &$loadingState)
    }

    /// 指定されたアクションを非同期にディスパッチします。
    ///
    /// - Parameter action: 実行したい `CatAction`。
    public func dispatch(_ action: CatAction) {
        Task {
            await actionDispatcher.dispatch(action)
        }
    }
}

