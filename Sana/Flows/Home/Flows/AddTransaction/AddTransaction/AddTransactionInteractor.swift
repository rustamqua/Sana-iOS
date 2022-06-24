//
//  AddTransactionInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation
import Combine
import Networking
import CoreData

protocol AddTransactionInteractor {
    func addTransaction(transactionType: TransactionType,
                        expense: String,
                        income: String,
                        transferFrom: String,
                        category: String,
                        categoryImage: String,
                        account: String,
                        toAccount: String,
                        date: Date,
                        expenseMerchant: String,
                        incomeSource: String,
                        notes: String)
}

final class AddTransactionInteractorImpl: AddTransactionInteractor {
    private let presenter: AddTransactionPresenter
    private let persistantFacade: PersistantFacade
    private let getTableUseCase: GetTableUseCase
    
    var bag = [AnyCancellable]()
    
    private let accounts: [Account]
    
    func addTransaction(transactionType: TransactionType,
                        expense: String,
                        income: String,
                        transferFrom: String,
                        category: String,
                        categoryImage: String,
                        account: String,
                        toAccount: String,
                        date: Date,
                        expenseMerchant: String,
                        incomeSource: String,
                        notes: String) {
        guard let selectedAccount = accounts.first(where: { acc in acc.name == account})
        else {
            return
        }
        
        let table = getTableUseCase.execute()
    
        let transaction = Transaction(context: persistantFacade.container.viewContext)
        switch transactionType {
        case .expense:
            transaction.date = date
            transaction.amount = Double(expense) ?? 0
            transaction.merchant = expenseMerchant
            transaction.category = category
            transaction.type = transactionType.rawValue
            transaction.image = categoryImage
            table.netWorth -= Double(expense) ?? 0
            selectedAccount.balance -= Double(expense) ?? 0
            selectedAccount.addToTransactions(transaction)
        case .income:
            transaction.date = date
            transaction.amount = Double(income) ?? 0
            transaction.merchant = expenseMerchant
            transaction.category = category
            transaction.type = transactionType.rawValue
            transaction.image = categoryImage
            table.netWorth += Double(income) ?? 0
            selectedAccount.balance += Double(income) ?? 0
            selectedAccount.addToTransactions(transaction)
        case .transfer:
            transaction.date = date
            transaction.amount = Double(transferFrom) ?? 0
            transaction.merchant = account
            transaction.category = toAccount
            transaction.type = transactionType.rawValue
            transaction.image = categoryImage
            if let transferToAccount = accounts.first(where: { $0.name == toAccount }) {
                selectedAccount.balance -= Double(transferFrom) ?? 0
                transferToAccount.balance += Double(transferFrom) ?? 0
                selectedAccount.addToTransactions(transaction)
                transferToAccount.addToTransactions(transaction)
            }
        }
        try? persistantFacade.container.viewContext.save()
        presenter.events.send(.transactionCreated)
    }
    
    init(accounts: [Account], presenter: AddTransactionPresenter) {
        self.accounts = accounts
        self.presenter = presenter
        self.persistantFacade = container.resolve(PersistantFacade.self)!
        self.getTableUseCase = container.resolve(GetTableUseCase.self)!
    }
}