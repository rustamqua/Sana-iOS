//
//  AppCoordinator.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import Foundation
import UIKit
import SwiftUI
import Networking

final class AppCoordinator: BaseCoordinator {
    var window: UIWindow? {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    }
    
    override func start() {
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            let mainClient = container.resolve(APIClient.self, name: "main")!
            mainClient.authToken = token
            
            startAppFlow()
        } else {
            startAuthFlow()
        }
    }
    
    private func startAuthFlow() {
        guard let window = window else { return }
        
        let authNavigationController = UINavigationController()
        let authRouter = RouterImpl(rootController: authNavigationController)
        let coordinator = AuthCoordinator(router: authRouter)
        coordinator.onFlowDidFinish = { [weak self] in
            self?.startAppFlow()
        }
        addDependency(coordinator)
        
        window.rootViewController = authNavigationController
        window.makeKeyAndVisible()
        coordinator.start()
    }
    
    private func startAppFlow() {
        guard let window = window else {
            return
        }
       
        let tabBarController = makeTabBar()
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func makeTabBar() -> UITabBarController {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor.dark60)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor.dark)], for: .selected)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(cgColor: .accentBlue)
        tabBarController.view.backgroundColor = .white
        let viewControllers = [makeHome(), makeAnalytics(), makeServices(), makeSettings()]
        tabBarController.setViewControllers(viewControllers, animated: false)
        return tabBarController
    }
    
    private func makeHome() -> UINavigationController {
        let homeNav = UINavigationController()
        homeNav.tabBarItem = .init(title: "Home", image: .init(named: "TabHome"), tag: 1)
        homeNav.view.backgroundColor = .white
        let router = RouterImpl(rootController: homeNav)
        let coordinator = HomeCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
        
        return homeNav
    }
    
    private func makeAnalytics() -> UINavigationController {
        let analyticsNav = UINavigationController()
        analyticsNav.tabBarItem = .init(title: "Analytics", image: .init(named: "TabAnalytics"), tag: 2)
        
        let router = RouterImpl(rootController: analyticsNav)
        let coordinator = AnalyticsCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
        
        return analyticsNav
    }
    
    private func makeServices() -> UINavigationController {
        let servicesNav = UINavigationController()
        servicesNav.tabBarItem = .init(title: "Services", image: .init(named: "TabServices"), tag: 3)
        
        let router = RouterImpl(rootController: servicesNav)
        let coordinator = ServicesCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
        
        return servicesNav
    }
    
    private func makeSettings() -> UINavigationController {
        let settingsNav = UINavigationController()
        settingsNav.tabBarItem = .init(title: "Settings", image: .init(named: "TabSettings"), tag: 4)
        
        let router = RouterImpl(rootController: settingsNav)
        let coordinator = SettingsCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
        
        return settingsNav
    }
}
