//
//  AnimationModifier.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import SwiftUI

struct AnimationModifier : ViewModifier {
    let positionOffset : Double
    let height = UIScreen.main.bounds.height

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let position = geometry.frame(in: CoordinateSpace.global).midY
            ZStack {
                Color.clear
                if height >= (position + positionOffset)  {
                    content
                }
            }
        }
    }
}
