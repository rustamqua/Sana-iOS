//
// Created by Rustam-Deniz Emirali on 21.06.2022.
//

import Foundation
import UIKit
import SwiftUI

class AnalyticsViewController: ViewController {
    override func viewDidLoad() {
        let vc = RestrictedHostingController(rootView: AnalyticsScreen())
        add(vc)
        view.addSubview(vc.view)
        
        vc.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
