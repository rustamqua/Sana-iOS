//
//  NormalButton.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 21.03.2022.
//

import SwiftUI

struct SecondaryActiveButton: View {
    private let action: () -> Void
    private let title: String
    
    init(action: @escaping () -> Void, title: String) {
        self.action = action
        self.title = title
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .foregroundColor(.accentBlue)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color.secondaryActive)
        .cornerRadius(12)
        .contentShape(Rectangle())
    }
}

struct SecondaryActiveButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryActiveButton(action: {}, title: "test")
    }
}
