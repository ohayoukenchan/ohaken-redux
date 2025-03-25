//
//  CatAction.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//
import Foundation

/// Catの状態管理に使用する Redux アクション。
///
/// `CatAction` は、Catのデータ取得やローディング状態の更新など、
/// `CatStore` の状態を変更するためのアクションを表します。
///
/// - Note: 並列処理にも対応できるよう `Sendable` に準拠しています。
enum CatAction: ReduxAction, Sendable {

    /// 猫のデータを非同期に取得するアクション。
    case fetchCat

    /// 現在のローディング状態を設定するアクション。
    ///
    /// - Parameter state: 新しいローディング状態。
    case setLoadingState(state: LoadingState)

    /// 取得した猫の情報を状態に反映するアクション。
    ///
    /// - Parameter cat: APIなどから取得された `Cat` モデル。
    case setCat(cat: Cat)
}

extension CatAction: Equatable {
    /// `CatAction` 同士が等価であるかを比較します。
    ///
    /// アクションの種類と関連する値が同じである場合に `true` を返します。
    static func == (lhs: CatAction, rhs: CatAction) -> Bool {
        switch (lhs, rhs) {
        case (.fetchCat, .fetchCat):
            return true
        case (.setLoadingState(let state1), .setLoadingState(let state2)):
            return state1 == state2
        case (.setCat(let cat1), .setCat(let cat2)):
            return cat1 == cat2
        default:
            return false
        }
    }
}

