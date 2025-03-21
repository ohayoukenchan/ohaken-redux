//
//  CatUseCase.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import Foundation

final class CatUseCase {
    /// Repositoryの接続は本来DIサンプルのためここでは割愛しています

    func fetchCat() async throws -> Cat {
        do {
            let url = URL(string: "https://cataas.com/cat?json=true")! // ← JSON取得には ?json=true が必要
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let (data, _) = try await URLSession.shared.data(from: url)
            let cat = try decoder.decode(Cat.self, from: data)
            return cat
        } catch {
            print("(^θ^) + \(error)")
            throw error
        }
    }

}
