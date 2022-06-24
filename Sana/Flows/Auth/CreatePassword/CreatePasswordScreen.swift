//
//  CreatePasswordScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.04.2022.
//

import SwiftUI

final class CreatePasswordViewModel: KeyboardListeningViewModel {
    @Published var password = ""
    @Published var isPasswordValid = false
    @Published var isLoading = false
    
    override init() {
        super.init()
        $password.sink { [weak self] val in
            guard let self = self else { return }
            
            self.isPasswordValid = val.count >= 6
        }.store(in: &bag)
    }
}

struct CreatePasswordScreen: View {
    @ObservedObject var viewModel: CreatePasswordViewModel
    let navigation: CreatePasswordNavigation
    let interactor: CreatePasswordInteractor
    
    @State var showPassword = false
    
    init(viewModel: CreatePasswordViewModel,
         navigation: CreatePasswordNavigation,
         interactor: CreatePasswordInteractor) {
        self.viewModel = viewModel
        self.navigation = navigation
        self.interactor = interactor
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Create Password")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 24)
                Text("You will need it to sign in to the application")
                    .font(.subheadline)
                    .foregroundColor(.dark60)
                    .padding(.top, 16)
                PasswordTextField(password: $viewModel.password, showPassword: $showPassword)
                    .padding(.top, 60)
                if !viewModel.isKeyboardShown {
                    Spacer()
                }
                policy
                ConditionalNormalButton(action: { interactor.sendPassword(password: viewModel.password) },
                                        title: "Create Account",
                                        isEnabled: $viewModel.isPasswordValid,
                                        isLoading: $viewModel.isLoading)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var policy: some View {
        ZStack {
            Group {
                Text("By tapping Create Account, you agree to our Terms ")
                    .foregroundColor(.dark60) +
                Text("and have read and acknowledge our ")
                    .foregroundColor(.dark60) +
                Text("Global Privacy Statement.")
                    .foregroundColor(.accentBlue)
                    .bold()
            }
                .font(.footnote)
        }
    }
}

struct CreatePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordScreen(viewModel: .init(), navigation: .init(showTurnOnNotifications: {}), interactor: CreatePasswordInteractorImpl(presenter: CreatePasswordPresenterImpl(), email: ""))
    }
}
