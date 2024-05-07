//
//  ContentView.swift
//  Monara_Vision
//
//  Created by Renaldi Antonio on 06/05/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showJungle = false
    @State private var jungleIsShown = false

    @Environment(\.openImmersiveSpace) var openJungle
    @Environment(\.dismissImmersiveSpace) var dismissJungle

    var body: some View {
        VStack {
            Button("To the Jungle!") {
                showJungle.toggle()
            }
        }
        .onChange(of: showJungle) { _, newValue in
            Task {
                if newValue {
                    switch await openJungle(id: "Jungle") {
                    case .opened:
                        jungleIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        jungleIsShown = false
                        showJungle = false
                    }
                } else if jungleIsShown {
                    await dismissJungle()
                    jungleIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
