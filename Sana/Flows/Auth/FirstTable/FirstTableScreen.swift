//
//  FirstTableScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 23.04.2022.
//

import SwiftUI

final class FirstTableScreenViewModel: KeyboardListeningViewModel {
    @Published var tableName = ""
    @Published var isTableNameValid = false
    @Published var isLoading = false
    
    override init() {
        super.init()
        
        $tableName.sink { [weak self] val in
            self?.isTableNameValid = !val.isEmpty
        }.store(in: &bag)
    }
}

struct FirstTableScreen: View {
    @ObservedObject var viewModel: FirstTableScreenViewModel
    private let navigation: FirstTableViewNavigation
    private let interactor: FirstTableInteractor
    
    init(viewModel: FirstTableScreenViewModel, navigation: FirstTableViewNavigation, interactor: FirstTableInteractor) {
        self.viewModel = viewModel
        self.navigation = navigation
        self.interactor = interactor
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Image("CircleLogo")
                    .padding(.top, 120)
                Text("Welcome to Sana!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.dark)
                    .padding(.top, 20)
                    .padding(.horizontal, 44)
                Text("Let’s start by creating your first financial table")
                    .font(.subheadline)
                    .foregroundColor(.dark60)
                    .padding(.horizontal, 22)
                    .padding(.top, 16)
                SanaTextField(placeholder: "Table name", binding: $viewModel.tableName)
                    .padding(.top, 40)
                    .padding(.horizontal, 16)
                if !viewModel.isKeyboardShown {
                    Spacer()
                }
                ConditionalNormalButton(action: { interactor.createTable(tableName: viewModel.tableName) }, title: "Let's start", isEnabled: $viewModel.isTableNameValid, isLoading: $viewModel.isLoading)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
            }
        }
    }
}

struct FirstTableScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstTableScreen(viewModel: .init(), navigation: .init(finishAuthFlow: {}), interactor: FirstTableInteractorImpl(presenter: FirstTablePresenterImpl()))
    }
}
