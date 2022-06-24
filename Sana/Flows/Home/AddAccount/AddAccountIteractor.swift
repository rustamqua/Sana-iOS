//
//  AddAccountIteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation

import Networking
import Combine

protocol AddAccountInteractor {
    func createAccount(accountName: String,
                       initialBalance: String,
                       accountType: AccountType,
                       bankType: BankType?)
}

final class AddAccountIneractorImpl: AddAccountInteractor {
    private let client: APIClient
    private let persistanceFacade: PersistantFacade
    private let getTableUseCase: GetTableUseCase
    private let presenter: AddAccountPresenter
    var bag = [AnyCancellable]()
    
    init(presenter: AddAccountPresenter) {
        self.client = container.resolve(APIClient.self, name: "main")!
        self.getTableUseCase = container.resolve(GetTableUseCase.self)!
        self.persistanceFacade = container.resolve(PersistantFacade.self)!
        self.presenter = presenter
    }
    
    func createAccount(accountName: String, initialBalance: String, accountType: AccountType, bankType: BankType?) {
        createAccountLocally(accountName: accountName, initialBalance: initialBalance, accountType: accountType, bankType: bankType)
    }
    
    private func createAccountLocally(accountName: String, initialBalance: String, accountType: AccountType, bankType: BankType?) {
        presenter.events.send(.loading)
        let table = getTableUseCase.execute()
        let account = Account(context: persistanceFacade.container.viewContext)
        account.name = accountName
        account.balance = Double(initialBalance) ?? 0
        account.type = accountType.rawValue
        account.bankType = bankType?.rawValue ?? ""
        table.addToAccounts(account)
        table.netWorth += Double(initialBalance) ?? 0
        try? persistanceFacade.container.viewContext.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter.events.send(.accountCreated)
        }
    }
    
    private func createAccountFromApi(accountName: String, initialBalance: String, accountType: AccountType, bankType: BankType) {
        guard let tableId = UserDefaults.standard.string(forKey: "tableId") else { return }
        
        presenter.events.send(.loading)
        client.dispatch(PostAccountRequest(tableId: tableId,
                                           body: .init(name: accountName, type: accountType.rawValue, currency: "0", initialBalance: initialBalance))).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter.events.send(.error(message: error.localizedDescription))
            case .finished:
                break
            }
        } receiveValue: { [weak self] res in
            self?.presenter.events.send(.accountCreated)
        }.store(in: &bag)
    }
}
