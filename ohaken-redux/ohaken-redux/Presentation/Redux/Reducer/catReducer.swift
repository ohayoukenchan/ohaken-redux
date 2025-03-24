//
//  catReducer.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

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
