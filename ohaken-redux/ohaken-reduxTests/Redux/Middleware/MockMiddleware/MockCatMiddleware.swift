//
//  MockCatMiddleware.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//

@testable import ohaken_redux

final class MockCatMiddleware: CatMiddleware {
    private let useCase: MockCatUseCase

    init(useCase: MockCatUseCase) {
        self.useCase = useCase
    }

    func handleAction(action: CatAction, state: CatStoreState, dispatch: @escaping @MainActor (CatAction) async -> Void) async {
        switch action {
        case .fetchCat:
            await dispatch(.setLoadingState(state: .loading))
            do {
                let response = try await useCase.fetchCat()
                await dispatch(.setCat(cat: response))
                await dispatch(.setLoadingState(state: .success))
            } catch {
                await dispatch(.setLoadingState(state: .error("データの取得に失敗しました")))
            }
        default:
            break
        }
    }
}
