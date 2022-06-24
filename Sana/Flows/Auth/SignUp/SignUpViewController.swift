//
//  SignUpViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import UIKit
import SwiftUI
import SnapKit
import Combine
import SwiftMessages

struct SignUpNavigation {
    var showSignIn: (() -> Void)
    var showOtp: ((_ email: String) -> Void)
}

final class SignUpViewController: ViewController {
    let navigation: SignUpNavigation
    let interactor: SignUpInteractor
    let presenter: SignUpPresenter
    
    var bag = [AnyCancellable]()
    
    private lazy var signUpViewModel = SignUpViewModel()
    
    private lazy var root: UIHostingController<SignUpScreen> = {
        let vc = UIHostingController(rootView: SignUpScreen(viewModel: signUpViewModel, navigation: navigation, interactor: interactor))
        return vc
    }()
    
    init(navigation: SignUpNavigation,
         interactor: SignUpInteractor,
         presenter: SignUpPresenter
    ) {
        self.navigation = navigation
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.events.sink { [weak self] events in
            guard let self = self else { return }
            
            switch events {
            case .loading:
                self.signUpViewModel.isLoading = true
            case let .error(message):
                self.signUpViewModel.isLoading = false
                self.showMessage(message: message)
            case .didRegister:
                self.signUpViewModel.isLoading = false
                self.navigation.showOtp(self.signUpViewModel.email)
            }
        }.store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        add(root)
        
        root.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
