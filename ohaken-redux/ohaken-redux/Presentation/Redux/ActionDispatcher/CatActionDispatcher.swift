//
//  CatActionDispatcher.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/29.
//
//
@MainActor
final class CatActionDispatcher: ActionDispatcher {
    func dispatch(_ action: CatAction) async {
        await CatStore.shared.dispatch(action)
    }
}
