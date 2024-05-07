//
//  Monara_VisionApp.swift
//  Monara_Vision
//
//  Created by Renaldi Antonio on 06/05/24.
//

import SwiftUI

@main
struct Monara_VisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

//        ImmersiveSpace(id: "ImmersiveSpace") {
//            ImmersiveView()
//        }
        
        ImmersiveSpace(id: "Jungle") {
            JungleView()
        }
    }
}
