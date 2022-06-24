//
//  DIContainer.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 11.04.2022.
//

import Foundation
import Swinject
import UIKit
import Networking

let container = Container.shared

extension Container {
    static let shared: Container = {
        let container = Container()
        container.register(AppCoordinator.self) { _ in
            AppCoordinator(router: RouterImpl(rootController: UINavigationController()))
        }
        .inObjectScope(.container)
        container.register(APIClient.self, name: "auth") { _ in
            APIClientImpl(baseURL: "http://159.223.16.68/api")
        }
        .inObjectScope(.container)
        container.register(APIClient.self, name: "main") { _ in
            APIClientImpl(baseURL: "http://159.223.16.68/api/core/v1/web")
        }.inObjectScope(.container)
        container.register(PersistantFacade.self) { _ in
            PersistantFacadeImpl()
        }.inObjectScope(.container)
        container.register(GetTableUseCase.self) { resolver in
            GetTableUseCaseImpl()
        }.inObjectScope(.graph)
        return container
    }()
}

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Container.shared.resolve(Component.self)!
    }
}
