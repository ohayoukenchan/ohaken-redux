//
//  CatStore.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2024/11/21.
//
//
import Combine
import SwiftUI

/// 猫情報の状態を一元的に管理する Redux 風ストア。
///
/// `CatStore` は `CatAction` に基づいて状態を更新し、
/// 必要に応じて `CatMiddleware` を通じて副作用を実行します。
/// 状態は `@Published` によって SwiftUI とリアクティブに連携されます。
///
/// - Note: `@MainActor` で実行されるため、UIスレッド上での安全な操作が保証されます。
@MainActor
final class CatStore: ObservableObject, Dispatchable {

    /// 取り扱うアクションの型。
    typealias ActionType = CatAction

    /// 現在の猫の情報（読み取り専用）。
    @Published private(set) var cat: Cat?

    /// 現在のローディング状態（読み取り専用）。
    @Published private(set) var loadingState = LoadingState.idle

    /// アクションの副作用処理を担うミドルウェア。
    private let middleware: CatMiddleware

    /// シングルトンとして使用される共有インスタンス。
    public static let shared = CatStore(
        middleware: MiddleWareFactory.createCatMiddleware()
    )

    /// ストアの初期化。
    ///
    /// - Parameter middleware: アクションの副作用を処理するミドルウェア。
    init(middleware: CatMiddleware) {
        self.middleware = middleware
    }

    /// アクションをディスパッチします。
    ///
    /// Reducer を通じて状態を更新し、その後 Middleware で副作用を処理します。
    ///
    /// - Parameter action: ディスパッチする `CatAction`。
    func dispatch(_ action: CatAction) async {
        await recursiveDispatch(action)
    }

    /// アクションを再帰的に処理し、状態更新と副作用の処理を行います。
    ///
    /// - Parameter newAction: 実行するアクション。
    private func recursiveDispatch(_ newAction: CatAction) async {
        let currentState = createCatState()
        let newState = catReducer(action: newAction, state: currentState)
        apply(state: newState)

        await middleware.handleAction(
            action: newAction,
            state: newState,
            dispatch: { await self.recursiveDispatch($0) }
        )
    }

    /// 現在の状態を `CatStoreState` として生成します。
    ///
    /// - Returns: 現在の状態を表す `CatStoreState`。
    func createCatState() -> CatStoreState {
        CatStoreState(
            cat: cat,
            loadingState: loadingState
        )
    }

    /// 新しい状態をストアに適用します。
    ///
    /// - Parameter state: 更新後の状態。
    func apply(state: CatStoreState) {
        self.cat = state.cat
        self.loadingState = state.loadingState
    }
}
