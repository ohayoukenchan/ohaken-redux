//
//  Cat.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//

import Foundation

/// 猫に関する情報を表すモデル。
///
/// `Cat` は猫のID、タグ、作成日時、画像URL、MIMEタイプなどの情報を保持します。
/// `Codable` に準拠しているため、JSONとのエンコード・デコードが可能です。
/// また、`Equatable` に準拠しているため、等価比較もできます。
///
/// - Note: JSONの `created_at` キーは Swift の `createdAt` プロパティにマッピングされます。
struct Cat: Codable, Equatable {

    /// 猫の一意な識別子。
    var id: String

    /// 猫に関連付けられたタグのリスト。
    var tags: [String]

    /// この猫の情報が作成された日時（文字列形式）。
    ///
    /// JSON上の `created_at` キーからデコードされます。
    var createdAt: String

    /// 猫の画像やリソースへのURL。
    var url: String

    /// 猫画像のMIMEタイプ（例: `"image/jpeg"` や `"image/png"`）。
    var  mimetype: String

    /// JSONとプロパティ間のマッピングを行うための `CodingKeys`。
    ///
    /// 特に `created_at` を `createdAt` にマッピングするために使用されます。
    enum CodingKeys: String, CodingKey {
        case id
        case tags
        case createdAt = "created_at"
        case url
        case mimetype
    }
}

