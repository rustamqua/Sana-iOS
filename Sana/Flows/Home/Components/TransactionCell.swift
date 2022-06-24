//
//  TransactionCell.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import SwiftUI

struct TransactionCell: View {
    var viewModel: TransactionsViewModel.TransactionViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                Image(uiImage: viewModel.icon ?? UIImage(named: "sourceIcon")!)
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.merchant)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark)
                    Text(viewModel.category)
                        .font(.caption)
                        .foregroundColor(.dark)
                }
                .padding(.leading, 12)
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(viewModel.formattedAmount)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.dark)
                    Text(viewModel.date)
                        .font(.caption)
                        .foregroundColor(.dark)
                }
            }
            Rectangle()
                .fill(Color.dark30)
                .frame(height: 1)
        }
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCell(viewModel: .init(type: .income, icon: .init(named: "accountIcon"), category: "Grocery", merchant: "Magnum", date: "March 11, 2022", transaction: "10000"))
    }
}
