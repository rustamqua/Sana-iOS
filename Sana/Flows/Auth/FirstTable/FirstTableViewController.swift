//
//  FirstTableViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 23.04.2022.
//

import UIKit
import SwiftUI
import Combine

struct FirstTableViewNavigation {
    var finishAuthFlow: (() -> Void)
}

class FirstTableViewController: ViewController {
    let navigation: FirstTableViewNavigation
    let presenter: FirstTablePresenter
    let interactor: FirstTableInteractor
    
    private var bag = [AnyCancellable]()
    
    let viewModel = FirstTableScreenViewModel()
    private lazy var root: UIHostingController<FirstTableScreen> = {
        let vc = RestrictedHostingController(rootView: FirstTableScreen(viewModel: viewModel, navigation: navigation, interactor: interactor))
        return vc
    }()
    
    init(navigation: FirstTableViewNavigation, presenter: FirstTablePresenter, interactor: FirstTableInteractor) {
        self.navigation = navigation
        self.presenter = presenter
        self.interactor = interactor
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
            case .tableCreated:
                self.navigation.finishAuthFlow()
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
