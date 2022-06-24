//
//  AddTransactionScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import SwiftUI
import Networking

class AddTransactionViewModel: ObservableObject {
    @Published var transactionType: TransactionType = .expense
    @Published var expense = ""
    @Published var income = ""
    @Published var transferFrom = ""
    
    @Published var category = ""
    @Published var categoryImage = ""
    @Published var account = ""
    @Published var toAccount = ""
    @Published var date = Date()
    @Published var expenseMerchant = ""
    @Published var incomeSource = ""
    @Published var notes = ""
    
    let accounts: [Account]
    var accountNames: [String]
    
    init(accounts: [Account]) {
        self.accounts = accounts
        self.accountNames = accounts.compactMap { $0.name }
    }
    
}

struct AddTransactionScreen: View {
    @ObservedObject var viewModel: AddTransactionViewModel
    
    private let navigation: AddTransactionNavigation
    
    init(viewModel: AddTransactionViewModel, navigation: AddTransactionNavigation) {
        self.viewModel = viewModel
        self.navigation = navigation
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    transactionSegment
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                    switch viewModel.transactionType {
                    case .expense:
                        expenseView
                    case .income:
                        incomeView
                    case .transfer:
                        transferView
                    }
                }
            }
        }
    }
    
    var expenseView: some View {
        VStack(spacing: 16) {
            transactionTextField(binding: $viewModel.expense)
            categoryCell
                .padding(.top, 8)
            accountCell
            dateCell
            merchantCell
            notesCell

        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
    
    var incomeView: some View {
        VStack(spacing: 16) {
            transactionTextField(binding: $viewModel.income)
            categoryCell
                .padding(.top, 8)
            accountCell
            dateCell
            sourceCell
            notesCell
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
    
    var transferView: some View {
        VStack(spacing: 16) {
            fromAccountCell
            transactionTextField(binding: $viewModel.transferFrom)
            toAccountCell
            transactionTextField(binding: $viewModel.transferFrom)
            dateCell
            notesCell
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
    
    var transactionSegment: some View {
        HStack(spacing: 4) {
            ForEach(TransactionType.allCases, id: \.self) { type in
                Button(action: {
                    viewModel.transactionType = type
                }) {
                    Text(type.name)
                        .font(.caption)
                        .foregroundColor(viewModel.transactionType == type ? .white : .dark60)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(viewModel.transactionType == type ? Color.accentBlue : Color.clear)
                .cornerRadius(12)

            }
        }
        .frame(maxWidth: .infinity)
    }
    
    func transactionTextField(binding: Binding<String>) -> some View {
        ZStack(alignment: .trailing) {
            SanaTextField(placeholder: "0", keyboardType: .numberPad, binding: binding)
            Text("₸")
                .font(.largeTitle)
                .foregroundColor(.dark)
                .padding(.trailing, 16)
        }
    }
    
    var categoryCell: some View {
        Button(action: { navigation.showCategories?(viewModel.transactionType) }) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(viewModel.categoryImage.isEmpty ? "unknownCategory" : viewModel.categoryImage)
                    Text(viewModel.category.isEmpty ? "Category" : viewModel.category)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark60)
                        .padding(.leading, 12)
                    Spacer()
                    Image("ArrowRight")
                }
                Rectangle()
                    .fill(Color.dark30)
                    .frame( height: 1)
                    .padding(.top, 8)
            }
        }
    }
    
    var accountCell: some View {
        Menu {
            Picker("", selection: $viewModel.account) {
                ForEach(viewModel.accountNames, id: \.self) {
                    Text($0)
                }
            }
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image("accountIcon")
                    Text(viewModel.account.isEmpty ? "Account" : viewModel.account)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark60)
                        .padding(.leading, 12)
                    Spacer()
                    Image("ArrowRight")
                }
                Rectangle()
                    .fill(Color.dark30)
                    .frame( height: 1)
                    .padding(.top, 8)
            }
        }
    }
    
    var dateCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("dateIcon")
                DatePicker(selection: $viewModel.date, displayedComponents: .date) {
                    Text("Date")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundColor(.dark60)
                }
                .padding(.leading, 12)
                Spacer()
            }
            Rectangle()
                .fill(Color.dark30)
                .frame( height: 1)
                .padding(.top, 8)
        }
    }
    
    var merchantCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("sourceIcon")
                TextField("Merchant", text: $viewModel.expenseMerchant)
                    .font(.subheadline)
                    .padding(.leading, 12)
            }
            Rectangle()
                .fill(Color.dark30)
                .frame( height: 1)
                .padding(.top, 8)
        }
    }
    
    var sourceCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("sourceIcon")
                TextField("Source", text: $viewModel.incomeSource)
                    .font(.subheadline)
                    .padding(.leading, 12)
            }
            Rectangle()
                .fill(Color.dark30)
                .frame( height: 1)
                .padding(.top, 8)
        }
    }
    
    var notesCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image("notesIcon")
                TextField("Add notes", text: $viewModel.notes)
                    .font(.subheadline)
                    .padding(.leading, 12)
            }
            Rectangle()
                .fill(Color.dark30)
                .frame( height: 1)
                .padding(.top, 8)
        }
    }
    
    var fromAccountCell: some View {
        Menu {
            Picker("", selection: $viewModel.account) {
                ForEach(viewModel.accountNames, id: \.self) {
                    Text($0)
                }
            }
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image("accountIcon")
                    Text(viewModel.account.isEmpty ? "From Account" : viewModel.account)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark60)
                        .padding(.leading, 12)
                    Spacer()
                    Image("ArrowRight")
                }
                Rectangle()
                    .fill(Color.dark30)
                    .frame( height: 1)
                    .padding(.top, 8)
            }
        }
    }
    
    var toAccountCell: some View {
        Menu {
            Picker("", selection: $viewModel.toAccount) {
                ForEach(viewModel.accountNames, id: \.self) {
                    Text($0)
                }
            }
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image("accountIcon")
                    Text(viewModel.account.isEmpty ? "To Account" : viewModel.toAccount)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark60)
                        .padding(.leading, 12)
                    Spacer()
                    Image("ArrowRight")
                }
                Rectangle()
                    .fill(Color.dark30)
                    .frame( height: 1)
                    .padding(.top, 8)
            }
        }
    }
}

struct AddTransactionScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionScreen(viewModel: .init(accounts: []), navigation: .init())
    }
}
