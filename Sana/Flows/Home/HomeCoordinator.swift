//
//  HomeCoordinator.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import Foundation
import Networking

final class HomeCoordinator: BaseCoordinator {
    private var homeInteractor: HomeInteractor?
    
    override func start() {
        showHome()
    }
    
    private func showHome() {
        let presenter = HomePresenterImpl()
        let interactor = HomeInteractorImpl(presenter: presenter)
        let navigation = HomeNavigation(showAddAccount: { [weak self] accountType in
            self?.showAddAccount(accountType: accountType)
        },
                                        runAddTransaction: { [weak self] accounts in
            self?.runAddTransactionFlow(accounts: accounts)
        }, showAccountDetails: { [weak self] account in
            self?.showAccountDetails(account: account)
        })
        self.homeInteractor = interactor
        
        let vc = HomeViewController(navigation: navigation, presenter: presenter, interactor: interactor)
        router.setRootModule(vc)
    }
    
    private func showAddAccount(accountType: AccountType) {
        let presenter = AddAccountPresenterImpl()
        let interactor = AddAccountIneractorImpl(presenter: presenter)
        let navigation = AddAccountNavigation(showHome: { [weak self] in
            self?.router.popModule()
            self?.homeInteractor?.fetchHome()
        })
        
        let vc = AddAccountViewController(preselectedAccount: accountType,
                                          navigation: navigation,
                                          presenter: presenter,
                                          interactor: interactor)
        vc.hidesBottomBarWhenPushed = true
        router.push(vc)
    }
    
    private func showAccountDetails(account: Account) {
        let presenter = AccountDetailsPresenterImpl()
        let interactor = AccountDetailsInteractorImpl(account: account, presenter: presenter)
        let vc = AccountDetailsViewController(interactor: interactor, presenter: presenter)
        router.push(vc)
    }
    
    private func runAddTransactionFlow(accounts: [Account]) {
        let coordinator = AddTransactionCoordinator(router: router)
        addDependency(coordinator)
        
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            self?.router.popModule()
            self?.removeDependency(coordinator)
        }
        
        coordinator.start(accounts: accounts)
    }
}
