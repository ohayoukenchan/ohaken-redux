//
//  CatUseCase.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import Foundation

/// `CatUseCase` を実装した具体的なクラス。
///
/// Cataas API（https://cataas.com）から猫のデータを非同期で取得します。
/// 本実装は DI（依存性注入）を簡略化する目的で Repository の注入処理などは省略しています。
final class CatUseCaseImpl: CatUseCase {

    /// 猫のデータを API から取得します。
    ///
    /// Cataas API にリクエストを送り、JSON形式で猫の情報を受け取ります。
    /// デコードには `JSONDecoder` を使用し、`Cat` モデルにマッピングされます。
    ///
    /// - Returns: `Cat` モデルオブジェクト。
    /// - Throws: 通信エラー、デコードエラーなどが発生した場合はそのまま throw されます。
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
