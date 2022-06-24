//
//  NormalButton.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 21.03.2022.
//

import SwiftUI

struct NormalButton: View {
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
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color(.accentBlue))
        .cornerRadius(12)
    }
}

struct NormalButton_Previews: PreviewProvider {
    static var previews: some View {
        NormalButton(action: { print("test") }, title: "test")
    }
}
