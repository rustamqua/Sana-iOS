//
//  SelectCategoryScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 06.05.2022.
//

import SwiftUI
import Networking

final class SelectCategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
}

struct SelectCategoryScreen: View {
    @ObservedObject var viewModel: SelectCategoryViewModel
    var categorySelected: ((String, String) -> Void)?
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondaryActive)
                    .frame(height: 40)
                TextField("Search...", text: .constant(""))
                    .font(.callout)
                    .foregroundColor(.dark60)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 20)
                HStack {
                    Spacer()
                    Image("searchIcon")
                        .padding(.trailing, 16)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.horizontal, 16)
            .padding(.top, 24)
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button(action: { categorySelected?(category.name ?? "", category.imageName ?? "") }) {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 0) {
                                    Image(category.imageName ?? "")
                                    Text(category.name ?? "")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                        .padding(.leading, 12)
                                }
                                Rectangle()
                                    .fill(Color.dark30)
                                    .frame(height: 1)
                                    .padding(.top, 8)
                            }
                        }
                        addButton
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
        }
    }
    
    var addButton: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color.accentBlue10)
                        .frame(width: 42, height: 42)
                    Image("IconAdd")
                        .foregroundColor(.accentBlue)
                }
                
                Text("Add subcategory")
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

struct SelectCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryScreen(viewModel: .init())
    }
}
