//
//  MiddlewareFactory.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//
@MainActor
struct MiddleWareFactory {
    public static func createCatMiddleware() -> CatMiddleware {
        CatMiddlewareImpl(
            useCase: CatUseCase()
        )
    }
}
