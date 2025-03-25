//
//  LoadingState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//
/// 非同期処理における読み込み状態を表す列挙型。
///
/// `LoadingState` はデータ取得処理などの進行状況を表現し、
/// UI 表示や状態遷移の管理に使用されます。
///
/// - Note: `Sendable` に準拠しているため、並行処理にも安全に利用可能です。
/// - SeeAlso: `CatStoreState`, `CatAction`
public enum LoadingState: Sendable, Equatable {

    /// 初期状態。まだ処理が開始されていない状態。
    case idle

    /// データ取得中の状態。
    case loading

    /// データ取得が正常に完了した状態。
    case success

    /// エラーが発生した状態。メッセージ付き。
    ///
    /// - Parameter String: エラーメッセージ。
    case error(String)
}

