//
//  OTPViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 17.04.2022.
//

import UIKit
import SwiftUI
import Combine

struct OTPNavigation {
    var showCreatePassword: (() -> Void)
}

class OTPViewController: ViewController {
    private let email: String
    private let navigation: OTPNavigation
    private let interactor: OTPInteractor
    private let presenter: OTPPresenter
    private var bag = [AnyCancellable]()
    
    private lazy var viewModel = OTPScreenViewModel(email: email)
    
    private lazy var root: UIHostingController<OTPScreen> = {
        let vc = UIHostingController(rootView: OTPScreen(viewModel: viewModel, navigation: navigation, interactor: interactor))
        return vc
    }()
    
    init(email: String, navigation: OTPNavigation, interactor: OTPInteractor, presenter: OTPPresenter) {
        self.email = email
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
        
        presenter.events.sink { [unowned self] event in
            switch event {
            case .loading:
                self.viewModel.isLoading = true
            case .otpValid:
                self.viewModel.isLoading = false
                self.navigation.showCreatePassword()
            case let .error(message):
                self.viewModel.isLoading = false
                self.showMessage(message: message)
            }
        }.store(in: &bag)
    }
    
    private func setupUI() {
        add(root)
        
        root.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
