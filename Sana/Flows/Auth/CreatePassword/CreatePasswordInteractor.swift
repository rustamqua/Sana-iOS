//
//  CreatePasswordInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation
import Networking
import Combine

protocol CreatePasswordInteractor {
    func sendPassword(password: String)
}

final class CreatePasswordInteractorImpl: CreatePasswordInteractor {
    private let client: APIClient
    private let mainClient: APIClient
    private let presenter: CreatePasswordPresenter
    private let email: String
    var bag = [AnyCancellable]()
    
    init(presenter: CreatePasswordPresenter, email: String) {
        self.client = container.resolve(APIClient.self, name: "auth")!
        self.mainClient = container.resolve(APIClient.self, name: "main")!
        self.presenter = presenter
        self.email = email
    }
    
    func sendPassword(password: String) {
        presenter.events.send(.loading)
        client.dispatch(CreatePasswordRequest(body: .init(password: password))).sink { [weak self] completion in
            guard let self = self else { return }
            
            switch completion {
            case let .failure(error):
                self.presenter.events.send(.error(message: error.localizedDescription))
            case .finished:
                break
            }
        } receiveValue: { [weak self] response in
            UserDefaults.standard.set(response.email, forKey: "email")
            UserDefaults.standard.set(response.firstName, forKey: "firstName")
            UserDefaults.standard.set(response.lastName, forKey: "lastName")
            self?.login(password: password)
        }.store(in: &bag)
    }
    
    func login(password: String) {
        client.dispatch(LoginRequest(body: .init(email: email, password: password))).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter.events.send(.error(message: error.localizedDescription))
            case .finished:
                break
            }
        } receiveValue: { [weak self] res in
            UserDefaults.standard.set(res, forKey: "authToken")
            self?.client.authToken = res
            self?.mainClient.authToken = res
            self?.presenter.events.send(.passwordCreated)
        }.store(in: &bag)
    }
}
