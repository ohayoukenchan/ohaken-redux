//
//  CatMiddleware.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//
/// `CatAction` に対して副作用処理を実行するためのミドルウェアプロトコル。
///
/// `CatMiddleware` は `fetchCat` のような副作用（API通信など）を必要とするアクションに対して、
/// 非同期に処理を行い、結果に応じた新しいアクションを `dispatch` 関数を通じて送信します。
///
/// - Important: `@MainActor` が付いており、UI スレッド上で安全に使用できます。
/// - Note: クロージャ `dispatch` は `@Sendable` であり、並列環境でも安全に利用できます。
@MainActor
protocol CatMiddleware: AnyObject {

    /// アクションに応じた副作用処理を非同期で実行します。
    ///
    /// - Parameters:
    ///   - action: 現在処理する `CatAction`。
    ///   - state: 現在の状態（読み取り専用）。
    ///   - dispatch: 副作用の結果としてアクションを送信するための非同期関数。
    func handleAction(
        action: CatAction,
        state: CatStoreState,
        dispatch: @escaping @MainActor @Sendable (CatAction) async -> Void
    ) async
}

