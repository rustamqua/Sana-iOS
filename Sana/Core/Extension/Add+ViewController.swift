//
//  Add+ViewController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import UIKit

extension UIViewController {
    func add(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: vc)
    }
}
