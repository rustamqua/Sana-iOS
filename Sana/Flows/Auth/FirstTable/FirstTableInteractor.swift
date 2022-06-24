//
//  FirstTableInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation
import Networking
import Combine

protocol FirstTableInteractor {
    func createTable(tableName: String)
}

final class FirstTableInteractorImpl: FirstTableInteractor {
    private let persistantFacade: PersistantFacade
    private let client: APIClient
    private let presenter: FirstTablePresenter
    var bag = [AnyCancellable]()
    
    init(presenter: FirstTablePresenter) {
        self.client = container.resolve(APIClient.self, name: "main")!
        self.persistantFacade = container.resolve(PersistantFacade.self)!
        self.presenter = presenter
    }
    
    func createTable(tableName: String) {
        createTableLocally(tableName: tableName)
    }
    
    private func createTableFromApi(tableName: String) {
        client.dispatch(PostTableRequest(body: .init(name: tableName))).sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.presenter.events.send(.error(message: error.localizedDescription))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] table in
                UserDefaults.standard.set(table.id, forKey: "tableId")
                self?.presenter.events.send(.tableCreated)
            }.store(in: &bag)
    }
    
    private func createTableLocally(tableName: String) {
        presenter.events.send(.loading)
        let table = FinancialTable(context: persistantFacade.container.viewContext)
        table.name = tableName
        table.netWorth = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            try? self.persistantFacade.container.viewContext.save()
            self.presenter.events.send(.tableCreated)
        }
    }
}
