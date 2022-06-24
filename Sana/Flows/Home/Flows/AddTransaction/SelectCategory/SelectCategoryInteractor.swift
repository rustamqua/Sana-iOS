//
// Created by Rustam-Deniz Emirali on 20.06.2022.
//

import Foundation

protocol SelectCategoryInteractor {
    func fetchCategories()
}

final class SelectCategoryInteractorImpl: SelectCategoryInteractor {
    private let presenter: SelectCategoryPresenter
    private let transactionType: TransactionType
    private let persistantFacade: PersistantFacade
    
    init(presenter: SelectCategoryPresenter, transactionType: TransactionType) {
        self.presenter = presenter
        self.transactionType = transactionType
        self.persistantFacade = container.resolve(PersistantFacade.self)!
    }
    
    func fetchCategories() {
        let categoryRequest = Category.fetchRequest()
        let predicate = NSPredicate(format: "type == %@", transactionType.rawValue)
        categoryRequest.predicate = predicate
        guard let categories = try? persistantFacade.container.viewContext.fetch(categoryRequest) else { return }
        
        if categories.isEmpty {
            createInitialCategories()
            guard let categories = try? persistantFacade.container.viewContext.fetch(categoryRequest) else { return }
            presenter.events.send(.categoriesLoaded(categories))
        } else {
            presenter.events.send(.categoriesLoaded(categories))
        }
    }
}

extension SelectCategoryInteractorImpl {
    func createInitialCategories() {
        let expenseCategories = [("Auto and Transport", "expenseAutoAndTransport"), ("Bills and Utilities", "expenseBillsAndUtility"), ("Business Services", "expenseBusinessServices"), ("Education", "expenseEducation"), ("Entertainment", "expenseEntertainment"), ("Food and Dining", "expenseFoodAndDining"), ("Gift and Donations", "expenseGiftAndDontations"), ("Health and Fitness", "expenseHealth"), ("Home", "expenseHome"), ("Hobbies", "expenseHobbies"), ("Kids", "expenseKids"), ("Personal Care", "expensePersonalCare"), ("Pets", "expensePets"), ("Shopping", "expenseShopping"), ("Subscriptions", "expenseSubscriptions"), ("Taxes", "expenseTaxes"), ("Travel", "expenseTravel")]
        let incomeCategories = [("Income", "income"), ("Allowance", "income"), ("Salary", "income"), ("Scholarship", "income")]
        
        expenseCategories.forEach { s, s2 in
            let category = Category(context: persistantFacade.container.viewContext)
            category.name = s
            category.imageName = s2
            category.type = TransactionType.expense.rawValue
        }
        
        incomeCategories.forEach { s, s2 in
            let category = Category(context: persistantFacade.container.viewContext)
            category.name = s
            category.imageName = s2
            category.type = TransactionType.income.rawValue
        }
        try? persistantFacade.container.viewContext.save()
    }
}