//
//  HomeInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import Foundation
import Combine
import Networking
import CoreData

protocol HomeInteractor {
    func fetchHome()
    func addTransaction()
    func showAccountDetails(name: String)
    
    var financialTable: FinancialTable? { get set }
    var tableDetails: TableDetailsDTO? { get set }
}

final class HomeInteractorImpl: HomeInteractor {
    private let presenter: HomePresenter
    private let persistantFacade: PersistantFacade
    private let getTableUseCase: GetTableUseCase
    private let client: APIClient
    
    var bag = [AnyCancellable]()
    var financialTable: FinancialTable?
    var tableDetails: TableDetailsDTO?
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        self.client = container.resolve(APIClient.self, name: "main")!
        self.persistantFacade = container.resolve(PersistantFacade.self)!
        self.getTableUseCase = container.resolve(GetTableUseCase.self)!
    }
   
    func fetchHome() {
        fetchHomeLocally()
    }
    
    func showAccountDetails(name: String) {
        let accountRequest = Account.fetchRequest()
        accountRequest.predicate = NSPredicate(format: "name == %@", name)
        guard let account = try? persistantFacade.container.viewContext.fetch(accountRequest).first else { return }
        self.presenter.events.send(.showAccountDetails(account))
    }
    
    func addTransaction() {
        let accountRequest = Account.fetchRequest()
        guard let accounts = try? persistantFacade.container.viewContext.fetch(accountRequest) else { return }
        self.presenter.events.send(.showAddTransaction(accounts))
    }
    
    private func fetchHomeLocally() {
        presenter.events.send(.loading)
        financialTable = getTableUseCase.execute()
        let transactionsRequest = Transaction.fetchRequest()
        let transactions = try? persistantFacade.container.viewContext.fetch(transactionsRequest)
        presenter.constructHome(from: self.financialTable!, transactions: transactions ?? [])
    }
    
    private func fetchHomeFromApi() {
        guard let tableId = UserDefaults.standard.string(forKey: "tableId") else { return }
    
        client.dispatch(GetTableByIdReqeust(id: tableId)).sink { [weak self] output in
                switch output {
                case let .failure(error):
                    self?.presenter.events.send(.error(message: error.localizedDescription))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] tableDetails in
                self?.tableDetails = tableDetails
                self?.presenter.constructHome(from: tableDetails)
            }.store(in: &bag)
    }
}
