//
//  AddAccountScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import SwiftUI

enum BankType: String, CaseIterable {
    case kaspi
    case halyk
    case forte
    
    var name: String {
        switch self {
        case .kaspi:
            return "Kaspi bank"
        case .halyk:
            return "Halyk bank"
        case .forte:
            return "Forte bank"
        }
    }
}

final class AddAccountViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var initialBalance = ""
    @Published var accountType: AccountType
    @Published var bankType: BankType = .kaspi
    
    init(accountType: AccountType) {
        self.accountType = accountType
    }
}

struct AddAccountScreen: View {
    @ObservedObject var viewModel: AddAccountViewModel
    
    init(viewModel: AddAccountViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                SanaTextField(placeholder: "Title", binding: $viewModel.title)
                    .padding(.horizontal, 16)
                    .padding(.top, 40)
                SanaTextField(placeholder: "Initial balance", keyboardType: .numberPad, binding: $viewModel.initialBalance)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                accountTypeCell
                    .padding(.top, 16)
                if viewModel.accountType == .bank {
                    bankTypeCell
                        .padding(.top, 16)
                }
                Spacer()
            }
        }
    }
    
    var accountTypeCell: some View {
        Menu {
            Picker("", selection: $viewModel.accountType) {
                ForEach(AccountType.allCases, id: \.self) {
                    Text($0.name)
                }
            }
        } label: {
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Text(viewModel.accountType.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark)
                    Spacer()
                    Image("ArrowRight")
                        .foregroundColor(.dark60)
                }
                .padding(.horizontal, 16)
                Spacer()
                Rectangle()
                    .fill(Color.secondaryActive)
                    .frame(height: 1)
                    .padding(.horizontal, 16)
            }
            .frame(height: 64)
        }
        .frame(height: 64)
    }
    
    var bankTypeCell: some View {
        Menu {
            Picker("", selection: $viewModel.bankType) {
                ForEach(BankType.allCases, id: \.self) {
                    Text($0.name)
                }
            }
        } label: {
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Text(viewModel.bankType.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark)
                    Spacer()
                    Image("ArrowRight")
                        .foregroundColor(.dark60)
                }
                .padding(.horizontal, 16)
                Spacer()
                Rectangle()
                    .fill(Color.secondaryActive)
                    .frame(height: 1)
                    .padding(.horizontal, 16)
            }
            .frame(height: 64)
        }
        .frame(height: 64)
    }
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen(viewModel: .init(accountType: .cash))
    }
}
