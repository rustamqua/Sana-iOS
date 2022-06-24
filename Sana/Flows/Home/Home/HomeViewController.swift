//
//  HomeViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import UIKit
import SwiftUI
import Combine
import Networking

struct HomeNavigation {
    var showAddAccount: ((AccountType) -> Void)?
    var runAddTransaction: (([Account]) -> Void)?
    var showAccountDetails: ((Account) -> Void)?
}

class HomeViewController: ViewController {
    private let navigation: HomeNavigation
    private let presenter: HomePresenter
    private let interactor: HomeInteractor
    private let viewModel: HomeViewModel = .init()
    
    private var bag = [AnyCancellable]()
                                     
    private lazy var root: UIHostingController<HomeScreen> = {
        let vc = RestrictedHostingController(rootView: HomeScreen(viewModel: viewModel, interactor: interactor, navigation: navigation))
        return vc
    }()
    
    init(navigation: HomeNavigation,
         presenter: HomePresenter,
         interactor: HomeInteractor) {
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
                self.viewModel.isLoading = true
            case let .error(message):
                self.showMessage(message: message)
            case let .loaded(netWorth, name, cashAccounts, bankAccounts, transactions):
                self.viewModel.isLoading = false
                self.viewModel.netWorth = netWorth
                self.viewModel.cash = cashAccounts
                self.viewModel.bank = bankAccounts
                self.viewModel.transactions = transactions
            case let .showAddTransaction(accounts):
                self.navigation.runAddTransaction?(accounts)
            case let .showAccountDetails(account):
                self.navigation.showAccountDetails?(account)
            }
        }.store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupUI() {
        add(root)
                
        view.backgroundColor = .white
        
        view.addSubview(root.view)
        root.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
