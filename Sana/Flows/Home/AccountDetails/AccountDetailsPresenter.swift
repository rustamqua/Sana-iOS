//
//  AccountDetailsPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation
import Combine
import UIKit

protocol AccountDetailsPresenter {
    var events: PassthroughSubject<AccountDetailsEvent, Never> { get }
    func constructDetails(from transactions: [Transaction], account: Account)
}

enum AccountDetailsEvent {
    case accountDetailsConstructed(name: String, income: String, expense: String, total: String, transactionByDate: [String: [TransactionsViewModel.TransactionViewModel]])
    case error(message: String)
    case loading
}

struct AccountDetailsPresenterImpl: AccountDetailsPresenter {
    var events = PassthroughSubject<AccountDetailsEvent, Never>()
    
    func constructDetails(from transactions: [Transaction], account: Account) {
        var transactionsByDate = [String: [TransactionsViewModel.TransactionViewModel]]()
    
        transactions.forEach { transaction in
            if var mapped = transactionsByDate[transaction.date?.formatted() ?? Date().formatted()] {
                transactionsByDate[transaction.date?.formatted() ?? Date().formatted()] = mapped + [TransactionsViewModel.TransactionViewModel(type: TransactionType(rawValue: transaction.type ?? "") ?? .income, icon: UIImage(named: transaction.image ?? ""), category: transaction.category ?? "", merchant: transaction.merchant ?? "", date: transaction.date?.formatted() ?? "", transaction: String(transaction.amount))]
            } else {
                transactionsByDate[transaction.date?.formatted() ?? Date().formatted()] = [TransactionsViewModel.TransactionViewModel(type: TransactionType(rawValue: transaction.type ?? "") ?? .income, icon: UIImage(named: transaction.image ?? ""), category: transaction.category ?? "", merchant: transaction.merchant ?? "", date: transaction.date?.formatted() ?? "", transaction: String(transaction.amount))]
            }
        }
        
        let total = account.balance
        var income: Double = 0
        var expenses: Double = 0
        
        transactions.forEach { transaction in
            switch TransactionType(rawValue: transaction.type ?? "") {
            case .income:
                income += transaction.amount
            case .expense:
                expenses += transaction.amount
            case .transfer:
                if transaction.merchant == account.name {
                    expenses += transaction.amount
                } else {
                    income += transaction.amount
                }
            default:
                break
            }
        }
        
        events.send(.accountDetailsConstructed(name: account.name ?? "", income: "+" + income.toCurrency(), expense: "-" + expenses.toCurrency(), total: total.toCurrency(), transactionByDate: transactionsByDate))
    }
}