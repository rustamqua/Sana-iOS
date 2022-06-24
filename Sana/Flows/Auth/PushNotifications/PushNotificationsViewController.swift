//
//  PushNotificationsViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 22.04.2022.
//

import UIKit
import SwiftUI

struct PushNotificationsNavigation {
    var showCreateTable: (() -> Void)
}

class PushNotificationsViewController: ViewController {
    private let navigation: PushNotificationsNavigation
    private lazy var root: UIHostingController<PushNotificationsScreen> = {
        let vc = RestrictedHostingController(rootView: PushNotificationsScreen(navigation: navigation))
        return vc
    }()
    
    init(navigation: PushNotificationsNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
