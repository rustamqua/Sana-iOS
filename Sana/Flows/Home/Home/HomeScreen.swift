//
//  HomeScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var netWorth: String = ""
    @Published var cash: AccountsViewModel?
    @Published var bank: AccountsViewModel?
    @Published var transactions: TransactionsViewModel?
}

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeViewModel
    let interactor: HomeInteractor
    let navigation: HomeNavigation
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HomeNavigationBar(tableName: interactor.financialTable?.name ?? "", onAddDidTap: { interactor.addTransaction() })
                    .background(Color.white)
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentBlue))
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            netWorth
                                .padding(.top, 24)
                            cash
                                .padding(.top, 24)
                            bankAccounts
                                .padding(.top, 16)
                            recentTransactions
                                .padding(.top, 24)
                            goalsTitle
                                .padding(.top, 24)
                            goals
                                .padding(.top, 16)
                            budgeting
                                .padding(.top, 24)
                            regularPayments
                                .padding(.top, 24)
                                .padding(.bottom, 24)
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
            .background(Color.extraWhite)
            }
        .onAppear {
            interactor.fetchHome()
        }
        .animation(Animation.spring(), value: viewModel.isLoading)
    }
    
    var netWorth: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Net worth")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(viewModel.netWorth)
                .font(.largeTitle)
                .bold()
        }
    }
    
    var cash: some View {
        ZStack {
            VStack {
                HStack(alignment: .center) {
                    Text("Cash")
                        .foregroundColor(.accentBlue)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("\(viewModel.cash?.totalFormatted ?? "0 ₸")")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                if let cashAccounts = viewModel.cash?.accounts {
                    VStack(spacing: 16) {
                        ForEach(cashAccounts, id: \.self) { account in
                            Button(action: { interactor.showAccountDetails(name: account.title) }) {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .stroke(Color.accentBlue, lineWidth: 2)
                                            .frame(width: 52, height: 52)
                                        Image("accountIcon")
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(account.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                        .padding(.leading, 12)
                                    Spacer()
                                    Text("\(account.balance)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Button(action: { navigation.showAddAccount?(.cash) }) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.accentBlue10)
                                .frame(width: 42, height: 42)
                            Image("IconAdd")
                                .foregroundColor(.accentBlue)
                        }
                        
                        Text("Add cash account")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.dark)
                    }
                }
                .padding(.bottom, 24)
                .frame(width: 180)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
    
    var bankAccounts: some View {
        ZStack {
            VStack {
                HStack(alignment: .center) {
                    Text("Bank accounts")
                        .foregroundColor(.accentBlue)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(viewModel.bank?.totalFormatted ?? "0 ₸")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                if let bankAccounts = viewModel.bank?.accounts {
                    VStack(spacing: 16) {
                        ForEach(bankAccounts, id: \.self) { account in
                            Button(action: { interactor.showAccountDetails(name: account.title) }) {
                                HStack {
                                    if let bankType = account.bankType {
                                        switch bankType {
                                        case .kaspi:
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.accentBlue, lineWidth: 2)
                                                    .frame(width: 52, height: 52)
                                                Image("kaspi")
                                            }
                                        case .halyk:
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.accentBlue, lineWidth: 2)
                                                    .frame(width: 52, height: 52)
                                                Image("halyk")
                                            }
                                        default:
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.accentBlue, lineWidth: 2)
                                                    .frame(width: 52, height: 52)
                                                Image("accountIcon")
                                                    .frame(width: 50, height: 50)
                                            }
                                        }
                                    } else {
                                        ZStack {
                                            Circle()
                                                .stroke(Color.accentBlue, lineWidth: 2)
                                                .frame(width: 52, height: 52)
                                            Image("accountIcon")
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                    Text(account.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.leading, 12)
                                        .foregroundColor(.dark)
                                    Spacer()
                                    Text("\(account.balance)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Button(action: { navigation.showAddAccount?(.bank) }) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.accentBlue10)
                                .frame(width: 42, height: 42)
                            Image("IconAdd")
                                .foregroundColor(.accentBlue)
                        }
                        
                        
                        Text("Add bank account")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.dark)
                    }
                }
                .padding(.bottom, 24)
                .frame(width: 180)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
    
    var recentTransactions: some View {
        ZStack {
            VStack {
                HStack(alignment: .center) {
                    Text("Recent Transactions")
                        .foregroundColor(.dark)
                        .font(.callout)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Button(action: {}) {
                        Text("See all")
                            .foregroundColor(.accentBlue)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                if let transactions = viewModel.transactions?.transactions, !transactions.isEmpty {
                    ForEach(transactions, id: \.self) { viewModel in
                        TransactionCell(viewModel: viewModel)
                            .padding(.horizontal, 16)
                    }
                } else {
                    Text("No transactions found")
                        .foregroundColor(.dark60)
                        .font(.footnote)
                        .frame(alignment: .center)
                        .padding(.top, 28)
                }
                
                Button(action: { interactor.addTransaction() }) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.accentBlue10)
                                .frame(width: 42, height: 42)
                            Image("IconAdd")
                                .foregroundColor(.accentBlue)
                        }
                        
                        Text("Add Transaction")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.dark)
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 24)
                .frame(width: 180)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
    
    var goalsTitle: some View {
        HStack() {
            Text("Goals")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button(action: {}) {
                Text("See all")
                    .font(.footnote)
                    .foregroundColor(.accentBlue)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var goals: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Image("savingMoney")
                    .padding(.top, 24)
                Text("Proper financial and retirement planning starts with goal setting")
                    .font(.footnote)
                    .foregroundColor(.dark60)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                SecondaryButton(action: {}, title: "Set goal")
                    .frame(width: 238, height: 54, alignment: .center)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
    
    var budgeting: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Text("Budgeting")
                    .font(.title3)
                    .foregroundColor(.dark)
                    .fontWeight(.semibold)
                    .padding(.top, 24)
                Image("personalFinance")
                    .padding(.top, 16)
                Text("Create a budget to sharpen your spending and amplify your savings")
                    .font(.footnote)
                    .foregroundColor(.dark60)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                SecondaryButton(action: {}, title: "Create budget")
                    .frame(width: 238, height: 54, alignment: .center)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
    
    var regularPayments: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Text("Regular payments")
                    .font(.title3)
                    .foregroundColor(.dark)
                    .fontWeight(.semibold)
                    .padding(.top, 24)
                Image("regularPayments")
                    .padding(.top, 16)
                Text("Don't keep everything in your head, let Sana remind you about regular payments")
                    .font(.footnote)
                    .foregroundColor(.dark60)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                SecondaryButton(action: {}, title: "Set payments")
                    .frame(width: 238, height: 54, alignment: .center)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: .init(), interactor: HomeInteractorImpl(presenter: HomePresenterImpl()), navigation: .init())
    }
}
