//
//  CoordinateListStoreState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/01/28.
//
//

/// 猫情報の状態を表すストアのステート構造体。
///
/// `CatStoreState` は、現在の猫データとローディング状態を保持します。
/// この構造体は Reducer によって更新され、View や Middleware に渡されます。
struct CatStoreState {

    /// 現在の猫の情報。未取得の場合は `nil`。
    var cat: Cat?

    /// 現在のローディング状態。初期値は `.idle`。
    var loadingState: LoadingState = .idle
}

