//
//  NormalButton.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 21.03.2022.
//

import SwiftUI

struct SecondaryButton: View {
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
                .foregroundColor(Color(.accentBlue))
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color(.extraWhite))
        .cornerRadius(12)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(action: {}, title: "Button text")
    }
}
