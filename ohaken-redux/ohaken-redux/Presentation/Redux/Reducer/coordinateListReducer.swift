//
//  coordinateListReducer.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

@MainActor
func coordinateListReducer(action: CatAction, state: CatStoreState) {
    switch action {
    case .fetchCat:
        // APICallするのはMiddlewareの役割のため何もしない
        break
    case .setCat(let cat):
        CatStore.shared.setCat(cat)
    case .setLoadingState(let loadingState):
        CatStore.shared.setLoadingState(loadingState)
    }
}
