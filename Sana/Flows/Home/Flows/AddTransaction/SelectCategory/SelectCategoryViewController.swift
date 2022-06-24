//
//  SelectCategoryViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 06.05.2022.
//
import Combine
import UIKit
import SwiftUI

class SelectCategoryViewController: ViewController {
    var categorySelected: ((_ category: String, _ categoryImage: String) -> Void)?
    
    private let viewModel = SelectCategoryViewModel()
    private let interactor: SelectCategoryInteractor
    private let presenter: SelectCategoryPresenter
    private lazy var root: UIHostingController<SelectCategoryScreen> = {
        let vc = UIHostingController(rootView: SelectCategoryScreen(viewModel: viewModel))
        return vc
    }()
    
    private var bag = [AnyCancellable]()
    
    init(interactor: SelectCategoryInteractor,
         presenter: SelectCategoryPresenter) {
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(root)
        
        view.addSubview(root.view)
        
        root.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        root.rootView.categorySelected = categorySelected
        
        navigationItem.title = "Category"
        navigationItem.rightBarButtonItem = .init(title: "Add new", style: .done, target: self, action: #selector(addNew))
        
        presenter.events.sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .categoriesLoaded(let categories):
               self.viewModel.categories = categories
            default:
                break
            }
        }.store(in: &bag)
        interactor.fetchCategories()
    }
    
    @objc func addNew() {
        
    }
}
