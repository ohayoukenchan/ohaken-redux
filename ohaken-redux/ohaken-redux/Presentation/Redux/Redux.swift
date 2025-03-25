//
//  Redux.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/29.
//
//

/// アクションをディスパッチ可能なオブジェクトを定義するプロトコル。
///
/// `Store` など、状態の更新処理を持つコンポーネントが準拠します。
///
/// - Note: `@MainActor` 指定により、UI スレッド上での安全な呼び出しが保証されます。
@MainActor
protocol Dispatchable {
    /// 扱うアクションの型。
    associatedtype ActionType: ReduxAction

    /// 指定されたアクションを非同期でディスパッチします。
    ///
    /// - Parameter action: 実行するアクション。
    func dispatch(_ action: ActionType) async
}


/// Redux アーキテクチャにおけるアクションの基底プロトコル。
///
/// すべてのアクション型（例: `CatAction`）はこのプロトコルに準拠します。
/// `Sendable` に準拠しており、並列処理環境でも安全に扱えます。
protocol ReduxAction: Sendable {}


/// アクションをストアなどにディスパッチする責務を持つオブジェクトのためのプロトコル。
///
/// `ViewModel` や `Middleware` からアクションを送る際に使用されます。
/// 汎用的なアクションの中継役として、ジェネリクスな構成を持ちます。
///
/// - Note: `Sendable` に準拠しているため、非同期や並列環境でも安全です。
protocol ActionDispatcher: Sendable {
    /// 扱うアクションの型。
    associatedtype ActionType: ReduxAction

    /// 指定されたアクションを非同期でディスパッチします。
    ///
    /// - Parameter action: 実行するアクション。
    func dispatch(_ action: ActionType) async
}
