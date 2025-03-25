//
//  MiddlewareFactory.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//
/// `CatMiddleware` のインスタンスを生成するファクトリ構造体。
///
/// `MiddleWareFactory` は、ユースケースやその他の依存関係を注入した状態で
/// `CatMiddleware` を生成します。主に DI（依存性注入）を簡潔に行うために使用されます。
///
/// - Note: 現時点では `CatUseCaseImpl` を直接注入していますが、
///         将来的にモックや別実装に切り替える際にも柔軟に対応できます。
@MainActor
struct MiddleWareFactory {

    /// `CatMiddleware` の実装インスタンスを生成します。
    ///
    /// - Returns: `CatMiddleware` に準拠したミドルウェアのインスタンス。
    public static func createCatMiddleware() -> CatMiddleware {
        CatMiddlewareImpl(
            useCase: CatUseCaseImpl()
        )
    }
}

