//
//  CatMiddlewareImpl.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

@MainActor
class CatMiddlewareImpl: CatMiddleware {

    private let useCase: CatUseCase

    public init(useCase: CatUseCase) {
        self.useCase = useCase
    }

    func handleAction(action: CatAction, state: CatStoreState, dispatch: @escaping @MainActor @Sendable (CatAction) async -> Void) async {
        switch action {
        case .fetchCat:
            await dispatch(.setLoadingState(state: .loading))

            do {
                let response = try await useCase.fetchCat()

                await dispatch(
                    .setCat(
                        cat: response
                    )
                )

                await dispatch(.setLoadingState(state: .success))
            } catch {
                await dispatch(.setLoadingState(state: .error("データの取得に失敗しました")))
            }
        case .setLoadingState(_):
            // StoreにセットするのはReducerの責務のため何もしない
            break
        case .setCat(_):
            // StoreにセットするのはReducerの責務のため何もしない
            break
        }
    }
}
