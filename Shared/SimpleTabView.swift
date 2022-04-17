//
//  SimpleTabView.swift
//  Sample
//
//  Created by Utah011 on 18.04.2022.
//

import SwiftUI

//MARK: Set TabView

struct SimpleTabView: View {
    var body: some View {
        TabView {
            SimpleView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Cat")
                }
            SimpleView2d()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Dog")
                }
            SimpleView3d()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Parrot")
                }
        }
    }
}

//MARK: Example of Pan call

struct SimpleView: View {
    
    @EnvironmentObject var panManager: PanManager
    
    var body: some View {
            Button("high pan") {
                withAnimation {
                    panManager.showPan(pan: .firstView)
                }
            }
    }
}

struct SimpleView2d: View {
    
    @EnvironmentObject var panManager: PanManager

    var body: some View {
        Button("half pan") {
            withAnimation {
                panManager.showPan(pan: .secondView)
            }
        }
    }
}

struct SimpleView3d: View {
    
    @EnvironmentObject var panManager: PanManager

    var body: some View {
        Button("low pan") {
            withAnimation {
                panManager.showPan(pan: .thirdView)
            }
        }
    }
}
