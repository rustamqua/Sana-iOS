//
//  ConditionalNormalButton.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.04.2022.
//

import SwiftUI

struct ConditionalNormalButton: View {
    var action: (() -> Void)
    var title: String
    
    @Binding var isLoading: Bool
    @Binding var isEnabled: Bool
    
    init(action: @escaping (() -> Void), title: String, isEnabled: Binding<Bool>) {
        self.action = action
        self.title = title
        self._isEnabled = isEnabled
        self._isLoading = .constant(false)
    }
    
    init(action: @escaping (() -> Void), title: String, isEnabled: Binding<Bool>, isLoading: Binding<Bool>) {
        self.action = action
        self.title = title
        self._isEnabled = isEnabled
        self._isLoading = isLoading
    }
    
    var body: some View {
        ZStack {
            if isEnabled {
                ZStack {
                    NormalButton(action: action, title: title)
                    if isLoading {
                        loadingView
                    }
                }
            } else {
                DisabledButton(action: {}, title: title)
            }
        }
    }
    
    var loadingView: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color(.accentBlue))
        .cornerRadius(12)
    }
}
