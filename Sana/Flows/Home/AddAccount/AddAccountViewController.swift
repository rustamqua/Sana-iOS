//
//  AddAccountViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import UIKit
import SwiftUI
import Combine

struct AddAccountNavigation {
    var showHome: (() -> Void)?
}

class AddAccountViewController: ViewController {
    private let preselectedAccount: AccountType
    private let navigation: AddAccountNavigation
    private let presenter: AddAccountPresenter
    private let interactor: AddAccountInteractor
    
    private var bag = [AnyCancellable]()
    
    private lazy var viewModel = AddAccountViewModel(accountType: preselectedAccount)
    private lazy var root: UIHostingController<AddAccountScreen> = {
        let vc = UIHostingController(rootView: AddAccountScreen(viewModel: viewModel))
        return vc
    }()
    
    init(preselectedAccount: AccountType,
         navigation: AddAccountNavigation,
         presenter: AddAccountPresenter,
         interactor: AddAccountInteractor) {
        self.preselectedAccount = preselectedAccount
        self.navigation = navigation
        self.presenter = presenter
        self.interactor = interactor
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
            case .loading:
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            case let .error(message):
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.showMessage(message: message)
            case .accountCreated:
                self.navigation.showHome?()
            }
        }.store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        navigationItem.title = "Add account"
        navigationItem.rightBarButtonItem = .init(title: "Add", style: .done, target: self, action: #selector(didTapAddButton))
        
        add(root)
        
        view.addSubview(root.view)
        root.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func didTapAddButton() {
        guard !viewModel.title.isEmpty, !viewModel.initialBalance.isEmpty else {
            showMessage(message: "Values should not be empty")
            return
        }
        
        interactor.createAccount(accountName: viewModel.title, initialBalance: viewModel.initialBalance, accountType: viewModel.accountType, bankType: viewModel.bankType)
    }
}
