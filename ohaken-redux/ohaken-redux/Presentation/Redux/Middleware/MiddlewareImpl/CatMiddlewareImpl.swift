//
//  CatMiddlewareImpl.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

/// `CatAction` に応じて副作用（サイドエフェクト）を処理するミドルウェアの実装。
///
/// `CatMiddlewareImpl` は `CatUseCase` を使って API から猫のデータを取得し、
/// 取得結果に応じて `setCat` や `setLoadingState` などのアクションをディスパッチします。
///
/// - Note: `@MainActor` 属性が付いており、UIスレッドでの安全な処理が保証されています。
@MainActor
class CatMiddlewareImpl: CatMiddleware {

    /// 猫データ取得に使用するユースケース。
    private let useCase: CatUseCase

    /// 初期化メソッド。
    ///
    /// デフォルトでは `CatUseCaseImpl` を使用しますが、テストなどで差し替え可能です。
    ///
    /// - Parameter useCase: 猫のデータ取得に使用するユースケース。
    public init(useCase: CatUseCase = CatUseCaseImpl()) {
        self.useCase = useCase
    }

    /// アクションに応じた副作用処理を実行します。
    ///
    /// `fetchCat` アクションを受け取ると、ローディング状態を `loading` に変更した後、
    /// 非同期で API 通信を行い、成功時には `setCat` と `success` を、
    /// 失敗時には `error` をディスパッチします。
    ///
    /// - Parameters:
    ///   - action: 現在受け取ったアクション。
    ///   - state: 現在のストア状態（読み取り専用）。
    ///   - dispatch: 新しいアクションを非同期に送るためのクロージャ。
    func handleAction(
        action: CatAction,
        state: CatStoreState,
        dispatch: @escaping @MainActor @Sendable (CatAction) async -> Void
    ) async {
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

        case .setLoadingState:
            // StoreにセットするのはReducerの責務
            break

        case .setCat:
            // StoreにセットするのはReducerの責務
            break
        }
    }
}
