//
//  CatUseCase.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//
//
/// 猫に関するビジネスロジックを定義するユースケースプロトコル。
///
/// `CatUseCase` は猫の情報を取得する機能を提供するインターフェースです。
/// 実装側では、データソース（API、ローカルDBなど）から猫の情報を非同期で取得する処理を記述します。
protocol CatUseCase {

    /// 猫の情報を取得します。
    ///
    /// 非同期で猫データを取得し、``Cat`` モデルとして返します。
    /// データ取得中にエラーが発生した場合は `throw` されます。
    ///
    /// - Returns: ``Cat`` モデルオブジェクト。
    /// - Throws: データ取得に失敗した場合のエラー。
    func fetchCat() async throws -> Cat
}

