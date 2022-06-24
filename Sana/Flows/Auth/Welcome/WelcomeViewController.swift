//
//  WelcomeViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import UIKit
import SwiftUI

struct WelcomeNavigation {
    var onCreateAccountDidTap: (() -> Void)
    var onSignInDidTap: (() -> Void)
}

class WelcomeViewController: ViewController {
    private let navigation: WelcomeNavigation
    
    private lazy var root: RestrictedHostingController<WelcomeScreen> = {
        let vc = RestrictedHostingController(rootView: WelcomeScreen(navigation: navigation))
        return vc
    }()
    
    init(navigation: WelcomeNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupUI() {
        add(root)
        
        root.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
