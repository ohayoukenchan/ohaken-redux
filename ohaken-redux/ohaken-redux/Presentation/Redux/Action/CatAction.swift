//
//  CatAction.swift
//  LayeredModule
//
//  Created by ohayoukenchan on 2025/01/28.
//
//
import Foundation

enum CatAction: ReduxAction, Sendable {
    case fetchCat
    case setLoadingState(state: LoadingState)
    case setCat(cat: Cat)
}

extension CatAction: Equatable {
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
