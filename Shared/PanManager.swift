//
//  PanManager.swift
//  Sample
//
//  Created by Utah011 on 18.04.2022.
//

import SwiftUI

class PanManager: ObservableObject {
    
    enum Pan { case firstView, secondView, thirdView, none }
    
    @Published var show = false
    @Published var pan: Pan = .none
    
    func showPan(pan: Pan) {
        self.pan = pan
        show = true
    }
}

struct PanView<Content: View>: View {
    enum PanType { case high, medium, low }
    let panType: PanType

    @EnvironmentObject var panManager: PanManager
    
    @State var panSizeState = CGSize.zero
    let transition = AnyTransition.move(edge: .bottom)
    
    let screenSize: CGRect
    let content: Content
    
    var height: CGFloat {
        switch panType {
        case .high: return screenSize.height * 0.85
        case .medium: return screenSize.height * 0.5
        case .low: return screenSize.height * 0.33
        }
    }
    
    init(screenSize: CGRect, type: PanType, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.screenSize = screenSize
        self.panType = type
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { value in
                panSizeState = value.translation
            }
            .onEnded { value in
                withAnimation(.linear) {
                    if panSizeState.height > height * 0.25 {
                        panManager.show = false
                        panSizeState = .zero
                    } else {
                        panSizeState = .zero
                    }
                }
            }
        ZStack {
            Color.clear
            VStack {
                Spacer()
                VStack {
                    content
                }
                .frame(width: screenSize.width, height: height).background(Color.green)
                .cornerRadius(16)
                .offset(y: panSizeState.height < 0 ? 0 : panSizeState.height)
                .gesture(drag)
            }
        }
        .transition(transition)
        .edgesIgnoringSafeArea(.bottom)
    }
}

