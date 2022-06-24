//
//  HomePresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import Foundation
import Combine
import UIKit
import Networking

protocol HomePresenter {
    var events: PassthroughSubject<HomeEvent, Never> { get }
    
    func constructHome(from dto: TableDetailsDTO)
    func constructHome(from table: FinancialTable, transactions: [Transaction])
}

struct AccountsViewModel: Hashable {
    var total: Double
    var totalFormatted: String {
        total.toCurrency()
    }
    
    var accounts: [AccountViewModel]
    
    struct AccountViewModel: Hashable {
        let title: String
        let balance: String
        let bankType: BankType?
    }
}

struct TransactionsViewModel: Hashable {
    var transactions: [TransactionViewModel]
    
    struct TransactionViewModel: Hashable {
        var formattedAmount: String {
            switch self.type {
            case .income:
                return "+ \(Double(transaction)?.toCurrency() ?? "")"
            case .expense:
                return "- \(Double(transaction)?.toCurrency() ?? "")"
            case .transfer:
                return Double(transaction)?.toCurrency() ?? ""
            }
        }
        
        let type: TransactionType
        let icon: UIImage?
        let category: String
        let merchant: String
        let date: String
        let transaction: String
    }
}

enum HomeEvent {
    case loaded(netWorth: String,
                name: String,
                cashAccounts: AccountsViewModel,
                bankAccounts: AccountsViewModel,
                transactions: TransactionsViewModel)
    case error(message: String)
    case loading
    case showAddTransaction([Account])
    case showAccountDetails(Account)
}

enum AccountType: String, CaseIterable {
    case cash = "0"
    case bank = "1"

    var name: String {
        switch self {
        case .cash:
            return "Cash"
        case .bank:
            return "Bank account"
        }
    }
}

enum TransactionType: String, CaseIterable {
    case income = "0"
    case expense = "1"
    case transfer = "2"
    
    var name: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        case .transfer:
            return "Transfer"
        }
    }
}

struct HomePresenterImpl: HomePresenter {
    var events = PassthroughSubject<HomeEvent, Never>()
    
    func constructHome(from table: FinancialTable, transactions: [Transaction]) {
        let netWorth = table.netWorth.toCurrency()
        let name = table.name ?? ""
    
        var cashAccountsViewModel = AccountsViewModel(total: 0, accounts: [])
        var bankAccountsViewModel = AccountsViewModel(total: 0, accounts: [])
        var transactionsViewModel = TransactionsViewModel(transactions: [])
        
        let accounts = table.accounts?.allObjects as! [Account]
        
        let bankAccounts = accounts.filter { element in
            AccountType(rawValue: element.type ?? "") == .bank
        }
        let cashAccounts = accounts.filter { element in
            AccountType(rawValue: element.type ?? "") == .cash
        }
        
        let banksAccountsTotal = bankAccounts.reduce(0) { $0 + $1.balance }
        let cashAccountsTotal = cashAccounts.reduce(0) { $0 + $1.balance }
        
        cashAccountsViewModel.total = cashAccountsTotal
        bankAccountsViewModel.total = banksAccountsTotal
        
        cashAccounts.forEach { account in
            cashAccountsViewModel.accounts.append(.init(title: account.name ?? "", balance: account.balance.toCurrency(), bankType: nil))
        }
        
        bankAccounts.forEach { account in
            bankAccountsViewModel.accounts.append(.init(title: account.name ?? "", balance: account.balance.toCurrency(), bankType: BankType(rawValue: account.bankType ?? "")))
        }
        
        var recentTransactions = Array(transactions.suffix(10).reversed())
        recentTransactions.forEach { transaction in
            transactionsViewModel.transactions.append(.init(type: TransactionType(rawValue: transaction.type ?? "") ?? .income,
                                                            icon: UIImage(named: transaction.image ?? ""),
                                                            category: transaction.category ?? "",
                                                            merchant: transaction.merchant ?? "",
                                                            date: transaction.date?.formatted() ?? "Unknown",
                                                            transaction: String(transaction.amount)))
        }
        
        events.send(.loaded(netWorth: netWorth, name: name, cashAccounts: cashAccountsViewModel, bankAccounts: bankAccountsViewModel, transactions: transactionsViewModel))
    }
    
    func constructHome(from dto: TableDetailsDTO) {
    
    }
}
