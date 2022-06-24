//
//  SignInInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 29.04.2022.
//

import Foundation
import Networking
import Combine

protocol SignInInteractor {
    func login(email: String, password: String)
}

final class SignInInteractorImpl: SignInInteractor {
    private let authClient: APIClient
    private let mainClient: APIClient
    private let presenter: SignInPresenter
    var bag = [AnyCancellable]()
    
    init(presenter: SignInPresenter) {
        self.authClient = container.resolve(APIClient.self, name: "auth")!
        self.mainClient = container.resolve(APIClient.self, name: "main")!
        self.presenter = presenter
    }
    
    func login(email: String, password: String) {
        presenter.events.send(.loading)
        authClient.dispatch(LoginRequest(body: .init(email: email, password: password))).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter.events.send(.error(message: error.localizedDescription))
            case .finished:
                break
            }
        } receiveValue: { [weak self] token in
            UserDefaults.standard.set(token, forKey: "authToken")
            self?.authClient.authToken = token
            self?.mainClient.authToken = token
            self?.presenter.events.send(.signedIn)
        }.store(in: &bag)
    }
}
