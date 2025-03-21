//
//  LoadingState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//
public enum LoadingState: Sendable, Equatable {
    case idle // 初期状態
    case loading // データ取得中
    case success // 正常にデータ取得完了
    case error(String) // エラー発生（エラーメッセージ付き）
}
