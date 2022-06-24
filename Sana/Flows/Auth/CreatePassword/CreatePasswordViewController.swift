//
//  CreatePasswordViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.04.2022.
//

import UIKit
import SwiftUI
import Combine

struct CreatePasswordNavigation {
    var showTurnOnNotifications: (() -> Void)
}

final class CreatePasswordViewController: ViewController {
    let navigation: CreatePasswordNavigation
    let interactor: CreatePasswordInteractor
    let presenter: CreatePasswordPresenter
    
    private var bag = [AnyCancellable]()
    
    private lazy var viewModel = CreatePasswordViewModel()
    
    private lazy var root: UIHostingController<CreatePasswordScreen> = {
        let vc = UIHostingController(rootView: CreatePasswordScreen(viewModel: viewModel, navigation: navigation, interactor: interactor))
        return vc
    }()
    
    init(navigation: CreatePasswordNavigation,
         interactor: CreatePasswordInteractor,
         presenter: CreatePasswordPresenter) {
        self.navigation = navigation
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.events.sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .passwordCreated:
                self.viewModel.isLoading = false
                self.navigation.showTurnOnNotifications()
            case .loading:
                self.viewModel.isLoading = true
            case let .error(message):
                self.viewModel.isLoading = false
                self.showMessage(message: message)
            }
        }.store(in: &bag)
    }
    
    private func setupUI() {
        add(root)
        
        root.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
