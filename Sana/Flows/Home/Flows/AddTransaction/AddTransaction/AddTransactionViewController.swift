//
//  AddTransactionViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//
import Combine
import UIKit
import SwiftUI
import Networking

struct AddTransactionNavigation {
    var dismiss: (() -> Void)?
    var showCategories: ((TransactionType) -> Void)?
}

class AddTransactionViewController: ViewController {
    private let accounts: [Account]
    private let navigation: AddTransactionNavigation
    private let interactor: AddTransactionInteractor
    private let presenter: AddTransactionPresenter
    
    private lazy var viewModel = AddTransactionViewModel(accounts: accounts)
    private lazy var root: UIHostingController<AddTransactionScreen> = {
        let vc = UIHostingController(rootView: AddTransactionScreen(viewModel: viewModel, navigation: navigation))
        return vc
    }()
    
    private var bag = [AnyCancellable]()
    
    init(accounts: [Account], interactor: AddTransactionInteractor, presenter: AddTransactionPresenter, navigation: AddTransactionNavigation) {
        self.accounts = accounts
        self.interactor = interactor
        self.presenter = presenter
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(root)
        
        root.view.snp.makeConstraints { make in
            make.edges.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.title = "Add transaction"
        navigationItem.rightBarButtonItem = .init(title: "Add", style: .done, target: self, action: #selector(didTapAdd))
        
        presenter.events.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .transactionCreated:
               self.navigation.dismiss?()
            default:
                break
            }
        }.store(in: &bag)
    }
    
    func selectCategory(category: String, categoryImage: String) {
        viewModel.category = category
        viewModel.categoryImage = categoryImage
    }
    
    @objc private func didTapAdd() {
        interactor.addTransaction(transactionType: viewModel.transactionType,
                                  expense: viewModel.expense,
                                  income: viewModel.income,
                                  transferFrom: viewModel.transferFrom,
                                  category: viewModel.category,
                                  categoryImage: viewModel.categoryImage,
                                  account: viewModel.account,
                                  toAccount: viewModel.toAccount,
                                  date: viewModel.date,
                                  expenseMerchant: viewModel.expenseMerchant,
                                  incomeSource: viewModel.incomeSource,
                                  notes: viewModel.notes)
    }
}