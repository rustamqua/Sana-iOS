//
//  AddTransactionCoordinator.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation
import Networking

final class AddTransactionCoordinator: BaseCoordinator {
    var onFlowDidFinish: (() -> Void)?
    
    private var addTransaction: AddTransactionViewController?
    
    func start(accounts: [Account]) {
        showAddTransaction(accounts: accounts)
    }
    
    private func showAddTransaction(accounts: [Account]) {
        let presenter = AddTransactionPresenterImpl()
        let interactor = AddTransactionInteractorImpl(accounts: accounts, presenter: presenter)
        let vc = AddTransactionViewController(accounts: accounts, interactor: interactor, presenter: presenter, navigation: .init(dismiss: { [weak self] in
            self?.onFlowDidFinish?()
        }, showCategories: { [weak self] transactionType in
            self?.showSelectCategories(transactionType: transactionType)
        }))
        self.addTransaction = vc
        router.push(vc)
    }
    
    private func showSelectCategories(transactionType: TransactionType) {
        let presenter = SelectCategoryPresenterImpl()
        let interactor = SelectCategoryInteractorImpl(presenter: presenter, transactionType: transactionType)
        let vc = SelectCategoryViewController(interactor: interactor, presenter: presenter)
        vc.categorySelected = { [weak self] category, categoryImage in
            self?.router.popModule()
            self?.addTransaction?.selectCategory(category: category, categoryImage: categoryImage)
        }
        router.push(vc)
    }
    
}
