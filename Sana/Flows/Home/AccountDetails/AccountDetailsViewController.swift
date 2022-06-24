//
//  AccountDetailsViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//
import Combine
import UIKit
import SwiftUI

class AccountDetailsViewController: ViewController {
    private let viewModel: AccountDetailsViewModel = .init()
    private let interactor: AccountDetailsInteractor
    private let presenter: AccountDetailsPresenter
    private var bag = [AnyCancellable]()
    
    private lazy var root: UIHostingController<AccountDetailsScreen> = {
        let vc = UIHostingController(rootView: AccountDetailsScreen(viewModel: viewModel))
        return vc
    }()
    
    init(interactor: AccountDetailsInteractor, presenter: AccountDetailsPresenter) {
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(root)
        view.addSubview(root.view)
        root.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        presenter.events.sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case let .accountDetailsConstructed(name, income, expense, total, transactionByDate):
                self.viewModel.name = name
                self.viewModel.income = income
                self.viewModel.expense = expense
                self.viewModel.total = total
                self.viewModel.transactionByDate = transactionByDate
            default:
                break
            }
        }.store(in: &bag)
        
        interactor.fetchAccountDetails()
    }
}
