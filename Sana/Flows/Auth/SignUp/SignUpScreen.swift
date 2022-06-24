//
//  SignUpScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 26.03.2022.
//

import SwiftUI
import Combine

class SignUpViewModel: KeyboardListeningViewModel {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var isEnabled = false
    @Published var isLoading = false
    
    override init() {
        super.init()
        Publishers
            .CombineLatest3($firstName, $lastName, $email)
            .sink(receiveValue: { [weak self] firstName, lastName, email in
                self?.isEnabled = email.contains("@") && email.count > 4 && !firstName.isEmpty && !lastName.isEmpty
            })
            .store(in: &bag)
    }
}

struct SignUpScreen: View {
    @ObservedObject var viewModel: SignUpViewModel
    let navigation: SignUpNavigation
    let interactor: SignUpInteractor
    
    init(viewModel: SignUpViewModel,
         navigation: SignUpNavigation,
         interactor: SignUpInteractor) {
        self.viewModel = viewModel
        self.navigation = navigation
        self.interactor = interactor
    }
    
    var body: some View {
        VStack {
            if !viewModel.isKeyboardShown {
                Text("Let's create an\naccount")
                        .font(.largeTitle.bold())
                        .foregroundColor(.dark)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 60)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 16) {
                SanaTextField(placeholder: "First name", binding: $viewModel.firstName)
                SanaTextField(placeholder: "Last name", binding: $viewModel.lastName)
                SanaTextField(placeholder: "Email", keyboardType: .emailAddress,  binding: $viewModel.email)
                Text("You will receive a letter with code for verification.")
                    .font(.subheadline)
                    .foregroundColor(.dark60)
            }
            .padding(.horizontal, 16)
            Spacer()
            HStack(alignment: .center) {
                Button(action: navigation.showSignIn) {
                    Text("Already have account?")
                        .font(.subheadline)
                        .foregroundColor(.dark)
                        .padding()
                }
                Spacer()
                Rectangle()
                    .fill(Color.secondaryActive)
                    .frame(width: 2, height: 24)
                Spacer()
                Button(action: navigation.showSignIn) {
                    Text("Sign in")
                        .font(.subheadline.bold())
                        .foregroundColor(.accentBlue)
                        .frame(minWidth: 100)
                        .padding()
                }
            }
            .padding(.horizontal, 16)
            ConditionalNormalButton(action: {
                interactor.register(body: .init(firstName: viewModel.firstName,
                                                lastName: viewModel.lastName,
                                                email: viewModel.email))
            },
                                    title: "Continue",
                                    isEnabled: $viewModel.isEnabled,
                                    isLoading: $viewModel.isLoading)
                .padding(.vertical, 40)
                .padding(.horizontal, 16)
        }
        .animation(Animation.easeIn(duration: 0.3), value: viewModel.isKeyboardShown)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen(viewModel: .init(), navigation: .init(showSignIn: {}, showOtp: { _ in }), interactor: SignUpInteractorImpl(presenter: SignUpPresenterImpl()))
    }
}
