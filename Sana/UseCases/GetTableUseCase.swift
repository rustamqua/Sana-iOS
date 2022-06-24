//
// Created by Rustam-Deniz Emirali on 20.06.2022.
//

import Foundation

protocol GetTableUseCase {
    func execute() -> FinancialTable
}

struct GetTableUseCaseImpl: GetTableUseCase {
    private let persistantFacade: PersistantFacade
    
    init() {
        self.persistantFacade = container.resolve(PersistantFacade.self)!
    }
    
    func execute() -> FinancialTable {
        let fetchRequest = FinancialTable.fetchRequest()
        let tables = try? persistantFacade.container.viewContext.fetch(fetchRequest)
        return tables?.first ?? FinancialTable()
    }
}
