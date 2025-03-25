//
//  CatActionDispatcher.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/29.
//
//
/// `CatAction` を `CatStore` にディスパッチするアクションディスパッチャ。
///
/// `CatActionDispatcher` は `ActionDispatcher` プロトコルに準拠しており、
/// 渡された `CatAction` を `CatStore` に非同期で転送します。
///
/// このクラスは `@MainActor` 属性を持つため、UI スレッド上での安全な呼び出しが保証されます。
@MainActor
final class CatActionDispatcher: ActionDispatcher {

    /// 指定されたアクションを `CatStore` に非同期でディスパッチします。
    ///
    /// - Parameter action: ディスパッチする `CatAction`。
    func dispatch(_ action: CatAction) async {
        await CatStore.shared.dispatch(action)
    }
}

