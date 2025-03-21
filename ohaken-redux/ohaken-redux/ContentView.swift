//
//  ContentView.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        ReduxCat(viewState: ReduxCatViewState(actionDispatcher: CatActionDispatcher()))
        .padding()
    }
}

#Preview {
    ContentView()
}
