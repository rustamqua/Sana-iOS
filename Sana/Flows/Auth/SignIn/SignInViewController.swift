//
//  SignInViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 15.04.2022.
//

import UIKit
import SwiftUI
import Combine

struct SignInNavigation {
    var showSignUp: (() -> Void)
    var runAppFlow: (() -> Void)
}

class SignInViewController: ViewController {
    private let navigation: SignInNavigation
    private let interactor: SignInInteractor
    private let presenter: SignInPresenter
    
    private var bag = [AnyCancellable]()
    
    private lazy var viewModel = SignInViewModel()
    
    private lazy var root: UIHostingController<SignInScreen> = {
        let vc = UIHostingController(rootView: SignInScreen(viewModel: viewModel, navigation: navigation, interactor: interactor))
        return vc
    }()
    
    init(navigation: SignInNavigation, interactor: SignInInteractor, presenter: SignInPresenter) {
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
        
        presenter.events.sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case let .error(message):
                self.viewModel.isLoading = false
                self.showMessage(message: message)
            case .loading:
                self.viewModel.isLoading = true
            case .signedIn:
                self.viewModel.isLoading = false
                self.navigation.runAppFlow()
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
