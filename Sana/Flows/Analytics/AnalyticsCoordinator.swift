//
//  AnalyticsCoordinator.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 03.05.2022.
//

import Foundation

final class AnalyticsCoordinator: BaseCoordinator {
    override func start() {
        showAnalytics()
    }
    
    private func showAnalytics() {
        let vc = AnalyticsViewController()
        router.push(vc)
    }
}
