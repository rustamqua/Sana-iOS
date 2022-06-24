//
//  AppDelegate.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import UIKit
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    private var bag = [AnyCancellable]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UINavigationBar.appearance().tintColor = UIColor(cgColor: .accentBlue)
        let titleAttributes = [NSAttributedString.Key.font: UIFont.title3()]
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        installKeyboardHeightObserver()
        return true
    }
    
    private func installKeyboardHeightObserver() {
        NotificationCenter.default.keyboardHeightPublisher
            .sink { height in
                #warning("Refactor to change states via keypathes")
                var copy = store.value
                copy.system.keyboardHeight = height
                store.send(copy)
            }
            .store(in: &bag)
    }
}
