//
//  Redux.swift
//  LayeredModule
//
//  Created by ohayoukenchan on 2025/01/29.
//
//

@MainActor
protocol Dispatchable {
    associatedtype ActionType: ReduxAction
    func dispatch(_ action: ActionType) async
}

/// **ReduxのAction**
protocol ReduxAction: Sendable {}

/// **Reduxの `dispatch` を実装するプロトコル**
protocol ActionDispatcher: Sendable {
    associatedtype ActionType: ReduxAction
    func dispatch(_ action: ActionType) async
}
