//
//  AccountDetailsScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import SwiftUI
import Networking

final class AccountDetailsViewModel: ObservableObject {
    @Published var name = ""
    @Published var income = ""
    @Published var expense = ""
    @Published var total = ""
    @Published var transactionByDate = [String: [TransactionsViewModel.TransactionViewModel]]()

    init() {

    }
}

struct AccountDetailsScreen: View {
    let viewModel: AccountDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .stroke(Color.accentBlue, lineWidth: 2)
                            .frame(width: 52, height: 52)
                        Image("accountIcon")
                            .frame(width: 50, height: 50)
                    }
                    Text(viewModel.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.dark)
                        .padding(.leading, 8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 28)
                Text(viewModel.total)
                    .font(.title)
                    .bold()
                    .foregroundColor(.dark)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                Text("For June")
                    .font(.subheadline)
                    .foregroundColor(.dark)
                    .fontWeight(.semibold)
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                HStack(spacing: 16) {
                    ZStack {
                        VStack(alignment: .leading, spacing: 7) {
                            HStack {
                                Text("Income")
                                    .font(.callout)
                                    .foregroundColor(.dark60)
                                Spacer()
                                Image("iconRaise")
                            }
                            Text(viewModel.income)
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    }
                    .frame(height: 88)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
                    .cornerRadius(12)

                    ZStack {
                        VStack(alignment: .leading, spacing: 7) {
                            HStack {
                                Text("Expense")
                                    .font(.callout)
                                    .foregroundColor(.dark60)
                                Spacer()
                                Image("iconFall")
                            }
                            Text(viewModel.expense)
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    }
                    .frame(height: 88)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
                    .cornerRadius(12)

                }
                .padding(.top, 16)
                .padding(.horizontal, 16)

                ForEach(Array(viewModel.transactionByDate.keys), id: \.self) { date in
                    Text(date)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 25)
                        .padding(.top, 32)
                    VStack {
                        ForEach(viewModel.transactionByDate[date]!, id: \.self) { viewModel in
                            TransactionCell(viewModel: viewModel)
                                .padding(.horizontal, 32)
                        }
                    }
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .padding(.top, 16)
                }
            }
        }
        .background(Color.extraWhite)
    }
}