//
//  NormalButton.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 21.03.2022.
//

import SwiftUI

struct DisabledButton: View {
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
                .foregroundColor(Color(.dark30))
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color(.extraWhite))
        .cornerRadius(12)
        .disabled(true)
        .contentShape(Rectangle())
    }
}

struct DisabledButton_Previews: PreviewProvider {
    static var previews: some View {
        DisabledButton(action: {}, title: "test")
    }   
}
