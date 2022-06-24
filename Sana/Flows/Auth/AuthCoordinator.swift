//
//  AuthCoordinator.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {
    var onFlowDidFinish: (() -> Void)?
    
    override func start() {
        showWelcomeScreen()
    }
    
    private func showWelcomeScreen() {
        let nav = WelcomeNavigation(onCreateAccountDidTap: { [weak self] in
            self?.showCreateAccount()
        },
                                    onSignInDidTap: { [weak self] in
            self?.showSignIn()
        })
        let vc = WelcomeViewController(navigation: nav)
        router.setRootModule(vc)
    }
    
    private func showCreateAccount() {
        let navigation = SignUpNavigation(showSignIn: { [weak self] in
            self?.showSignIn()
        },
                                          showOtp: { [weak self] email in
            self?.showOTP(email: email)
        })
        
        let presenter = SignUpPresenterImpl()
        let interactor = SignUpInteractorImpl(presenter: presenter)
        let vc = SignUpViewController(navigation: navigation, interactor: interactor, presenter: presenter)
        router.push(vc)
    }
    
    private func showSignIn() {
        let navigation = SignInNavigation(showSignUp: { [weak self] in
            self?.showCreateAccount()
        },
                                          runAppFlow: { [weak self] in
            self?.onFlowDidFinish?()
        })
        
        let presenter = SignInPresenterImpl()
        let interactor = SignInInteractorImpl(presenter: presenter)
        
        let vc = SignInViewController(navigation: navigation, interactor: interactor, presenter: presenter)
        router.push(vc)
    }
    
    private func showOTP(email: String) {
        let navigation = OTPNavigation(showCreatePassword: { [weak self] in
            self?.showCreatePassword(email: email)
        })
        
        let presenter = OTPPresenterImpl()
        let interactor = OTPInteractorImpl(presenter: presenter)
        
        let vc = OTPViewController(email: email, navigation: navigation, interactor: interactor, presenter: presenter)
        
        router.push(vc)
    }
    
    private func showCreatePassword(email: String) {
        let navigation = CreatePasswordNavigation(showTurnOnNotifications: { [weak self] in
            self?.showPushNotifications()
        })
        let presenter = CreatePasswordPresenterImpl()
        let interactor = CreatePasswordInteractorImpl(presenter: presenter, email: email)
        
        let vc = CreatePasswordViewController(navigation: navigation, interactor: interactor, presenter: presenter)
        router.push(vc)
    }
    
    private func showPushNotifications() {
        let navigation = PushNotificationsNavigation(showCreateTable: { [weak self] in
            self?.showFirstTable()
        })
        let vc = PushNotificationsViewController(navigation: navigation)
        
        router.push(vc)
    }
    
    private func showFirstTable() {
        let navigation = FirstTableViewNavigation(finishAuthFlow: { [weak self] in
            self?.onFlowDidFinish?()
        })
        let presenter = FirstTablePresenterImpl()
        let interactor = FirstTableInteractorImpl(presenter: presenter)
        let vc = FirstTableViewController(navigation: navigation, presenter: presenter, interactor: interactor)
        router.push(vc)
    }
}
