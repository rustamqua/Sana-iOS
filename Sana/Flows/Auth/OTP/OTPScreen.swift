//
//  OTPScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 17.04.2022.
//

import SwiftUI
import Combine

final class OTPScreenViewModel: KeyboardListeningViewModel {
    @Published var otp: String = ""
    @Published var isLoading = false
    @Published var isEnabled = false
    
    let email: String
    
    init(email: String) {
        self.email = email
        super.init()
        
        $otp.sink { [weak self] val in
            if val.count >= 6 {
                self?.isEnabled = true
            } else {
                self?.isEnabled = false
            }
        }.store(in: &bag)
    }
}

struct OTPScreen: View {
    @ObservedObject var viewModel: OTPScreenViewModel
    let navigation: OTPNavigation
    let interactor: OTPInteractor
    
    @FocusState var isFocused: Bool
    
    init(viewModel: OTPScreenViewModel,
         navigation: OTPNavigation,
         interactor: OTPInteractor) {
        self.viewModel = viewModel
        self.navigation = navigation
        self.interactor = interactor
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Enter the code")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 16)
                Group {
                    Text("Enter the 6-digit code that was sent to you at ")
                        .font(.subheadline)
                        .foregroundColor(.dark60)
                    +
                    Text(viewModel.email)
                        .font(.subheadline)
                        .foregroundColor(.accentBlue)
                }
                .padding(.top, 16)
                HStack {
                    OtpRect(val: viewModel.otp[0])
                    OtpRect(val: viewModel.otp[1])
                    OtpRect(val: viewModel.otp[2])
                    OtpRect(val: viewModel.otp[3])
                    OtpRect(val: viewModel.otp[4])
                    OtpRect(val: viewModel.otp[5])
                }
                .padding(.top, 32)
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
                SecondaryButton(action: {}, title: "Get the code again")
                    .padding(.top, 52)
                TextField("", text: $viewModel.otp)
                    .keyboardType(.numberPad)
                    .frame(width: 0, height: 0)
                    .focused($isFocused)
                if !viewModel.isKeyboardShown {
                    Spacer()
                }
                ConditionalNormalButton(action: { interactor.postOTP(code: viewModel.otp) }, title: "Continue", isEnabled: $viewModel.isEnabled, isLoading: $viewModel.isLoading)
                    .padding(.bottom, 24)
                    .padding(.top, 16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
        }
        .onAppear {
            isFocused = true
        }
    }
    
    func OtpRect(val: String?) -> some View {
        Text(val ?? "")
            .font(.callout)
            .bold()
            .frame(width: 50, height: 56, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.dark30, lineWidth: 1))
    }
}

struct OTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        OTPScreen(viewModel: .init(email: "qwerty123@gmail.com"), navigation: .init(showCreatePassword: {}), interactor: OTPInteractorImpl(presenter: OTPPresenterImpl()))
    }
}
