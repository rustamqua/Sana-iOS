//
//  SignInScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 26.03.2022.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var isKeyboardShown = false
    
    @Published var email = ""
    @Published var password = ""
    @Published var isEnabled = false
    @Published var isLoading = false
    
    private var bag = [AnyCancellable]()
    
    init() {
        store.sink { [weak self] state in
            guard let self = self else { return }
            
            self.isKeyboardShown = state.system.keyboardHeight != 0
        }.store(in: &bag)
        
        Publishers
            .CombineLatest($email, $password)
            .sink(receiveValue: { [weak self]email, password in
                self?.isEnabled = email.contains("@") && email.count > 4 && password.count > 6
            })
            .store(in: &bag)
    }
}

struct SignInScreen: View {
    @ObservedObject var viewModel: SignInViewModel
    private let navigation: SignInNavigation
    private let interactor: SignInInteractor
    
    @State var showPassword = false
    
    init(viewModel: SignInViewModel,
         navigation: SignInNavigation,
         interactor: SignInInteractor) {
        self.viewModel = viewModel
        self.navigation = navigation
        self.interactor = interactor
    }
    
    var body: some View {
        ZStack {
            VStack {
                if !viewModel.isKeyboardShown {
                    HStack {
                        Text("Let’s sign you in.")
                            .font(.largeTitle.bold())
                            .foregroundColor(.dark)
                        Spacer()
                    }
                    .padding(.top, 60)
                    .padding(.horizontal, 24)

                    Spacer()
                }
                VStack(alignment: .center, spacing: 16) {
                    SanaTextField(placeholder: "Email", keyboardType: .emailAddress, binding: $viewModel.email)
                    PasswordTextField(password: $viewModel.password, showPassword: $showPassword)
                }.padding(.horizontal, 16)
                HStack {
                    Button(action: {}) {
                        Text("Forgot your password?")
                            .font(.subheadline.bold())
                            .foregroundColor(.accentBlue)
                            .padding()
                    }
                    Spacer()
                }
                .padding(.top, 4)
                .padding(.horizontal, 16)
                Spacer()
                HStack(alignment: .center) {
                    Button(action: navigation.showSignUp) {
                        Text("Don't have an account?")
                            .font(.subheadline)
                            .foregroundColor(.dark)
                            .padding()
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color.secondaryActive)
                        .frame(width: 2, height: 24)
                    Spacer()
                    Button(action: navigation.showSignUp) {
                        Text("Create account")
                            .font(.subheadline.bold())
                            .foregroundColor(.accentBlue)
                            .padding()
                    }
                }
                .padding(.horizontal, 16)
                
                ConditionalNormalButton(action: { interactor.login(email: viewModel.email,
                                                                   password: viewModel.password) },
                                        title: "Sign in",
                                        isEnabled: $viewModel.isEnabled,
                                        isLoading: $viewModel.isLoading)
                    .padding(.vertical, 40)
                    .padding(.horizontal)
            }
        }
        .animation(Animation.easeIn(duration: 0.3), value: viewModel.isKeyboardShown)
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen(viewModel: .init(), navigation: .init(showSignUp: {},
                                                           runAppFlow: {}), interactor: SignInInteractorImpl(presenter: SignInPresenterImpl()))
    }
}
