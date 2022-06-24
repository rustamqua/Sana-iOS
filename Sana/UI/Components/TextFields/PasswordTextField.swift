//
//  PasswordTextField.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.04.2022.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if showPassword {
                SanaTextField(placeholder: "Password", binding: $password)
            } else {
                SanaSecureTextField(placeholder: "Password", binding: $password)
            }
            
            Button(action: { showPassword.toggle() }) {
                showPassword ? Image("passwordHide") : Image("passwordShow")
            }
            .frame(width: 24, height: 40, alignment: .trailing)
            .padding(.horizontal, 16)
        }
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(password: .constant(""), showPassword: .constant(true))
    }
}
