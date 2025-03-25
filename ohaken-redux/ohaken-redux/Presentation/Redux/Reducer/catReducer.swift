//
//  catReducer.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

/// CatActionに基づいて状態を更新するReducer関数。
///
/// `catReducer` は ``CatAction`` に応じて ``CatStoreState`` を変更し、新しい状態を返します。
/// 状態の変更が不要なアクション（例: ``.fetchCat``）については、その処理を Middleware に委任します。
///
/// - Parameters:
///   - action: 現在処理する猫関連のアクション。
///   - state: 現在の状態（``CatStoreState``）。
/// - Returns: アクションに基づいて更新された新しい状態。
func catReducer(action: CatAction, state: CatStoreState) -> CatStoreState {
    var newState = state
    switch action {
    case .fetchCat:
        break // Middlewareに任せる
    case .setCat(let cat):
        newState.cat = cat
    case .setLoadingState(let loadingState):
        newState.loadingState = loadingState
    }
    return newState
}

