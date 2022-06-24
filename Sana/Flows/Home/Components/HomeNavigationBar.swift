//
//  NavigationBar.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import SwiftUI

struct HomeNavigationBar: View {
    var onAddDidTap: (() -> Void)?
    
    private let tableName: String
    
    init(tableName: String, onAddDidTap: (() -> Void)?) {
        self.tableName = tableName
        self.onAddDidTap = onAddDidTap
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .center) {
                    Circle()
                        .stroke(Color.accentBlue10, lineWidth: 1)
                        .frame(width: 40, height: 40)
                    Circle()
                        .fill(Color.accentBlue)
                        .frame(width: 36, height: 36, alignment: .center)
                    Text(String(tableName.first ?? .init("T")))
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
                Button(action: {}) {
                    HStack(spacing: 0) {
                        Text(tableName)
                            .font(.subheadline)
                            .foregroundColor(.dark)
                            .bold()
                        Image("ArrowRight")
                            .foregroundColor(.dark)
                    }
                }
                .padding(.leading, 8)
                Spacer()
                Button(action: {}) {
                    Image("IconNotification")
                        .foregroundColor(.dark)
                }
                Button(action: { onAddDidTap?() }) {
                    Image("IconAdd")
                        .foregroundColor(.dark)
                }
                .padding(.leading, 20)
                .padding(.trailing, 24)
            }
            .padding(.top, 10)
            Spacer()
            Rectangle()
                .fill(Color.secondaryActive)
                .frame(height: 1)
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(tableName: "teet", onAddDidTap: {})
    }
}
