//
//  ContentView.swift
//  Shared
//
//  Created by Utah011 on 18.02.2022.
//

import SwiftUI

//MARK: Prepare pans using enum PanManager.Pan

struct ContentView: View {
    
    @StateObject var panManager = PanManager()
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            SimpleTabView()
            
            if panManager.show {
                switch panManager.pan {
                case .firstView:
                    PanView(screenSize: screenSize, type: .high) {
                        PresentedView()
                    }
                case .secondView:
                    PanView(screenSize: screenSize, type: .medium) {
                        PresentedView()
                    }
                case .thirdView:
                    PanView(screenSize: screenSize, type: .low) {
                        PresentedView()
                    }
                case .none:
                    EmptyView()
                }
            }
        }.environmentObject(panManager)
    }
}
