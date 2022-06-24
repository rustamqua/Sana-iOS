//
//  SanaTextField.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 23.03.2022.
//

import SwiftUI

struct SanaTextField: View {
    var placeholder: String
    var keyboardType: UIKeyboardType
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default, binding: Binding<String>) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._binding = binding
    }
    
    @Binding var binding: String
    
    @State var isEmpty = true
    
    var body: some View {
        TextField(placeholder, text: $binding)
            .keyboardType(keyboardType)
            .font(isEmpty ? .callout : .callout.bold())
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(isEmpty ? Color.secondaryActive : Color.accentBlue, lineWidth: 1))
            .frame(maxWidth: .infinity)
            .onChange(of: binding) { newValue in
                isEmpty = newValue.isEmpty
            }
    }
}

struct SanaSecureTextField: View {
    var placeholder: String
    @Binding var binding: String
    
    @State var isEmpty = true
    
    var body: some View {
        SecureField(placeholder, text: $binding)
            .font(isEmpty ? .callout : .callout.bold())
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(isEmpty ? Color.secondaryActive : Color.accentBlue, lineWidth: 1))
            .frame(maxWidth: .infinity)
            .onChange(of: binding) { newValue in
                isEmpty = newValue.isEmpty
            }
    }
}

struct SanaTextField_Previews: PreviewProvider {
    static var previews: some View {
        SanaTextField(placeholder: "Placeholder", binding: .constant("Test"))
    }
}
