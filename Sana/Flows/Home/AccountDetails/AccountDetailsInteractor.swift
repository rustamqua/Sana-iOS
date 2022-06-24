//
//  AccountDetailsInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation

import Networking
import Combine

protocol AccountDetailsInteractor {
    func fetchAccountDetails()
}

final class AccountDetailsInteractorImpl: AccountDetailsInteractor {
    private let persistanceFacade: PersistantFacade
    private let presenter: AccountDetailsPresenter
    private let account: Account
    
    var bag = [AnyCancellable]()
    
    init(account: Account, presenter: AccountDetailsPresenter) {
        self.persistanceFacade = container.resolve(PersistantFacade.self)!
        self.presenter = presenter
        self.account = account
    }
    
    func fetchAccountDetails() {
        guard let transactions = account.transactions?.allObjects as? [Transaction] else { return }
        presenter.constructDetails(from: transactions, account: account)
    }
}