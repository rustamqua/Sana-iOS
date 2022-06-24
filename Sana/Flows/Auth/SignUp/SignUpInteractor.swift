//
//  SignUpInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 26.04.2022.
//

import Foundation
import Networking
import Combine

protocol SignUpInteractor {
    func register(body: RegisterRequestBody)
}

class SignUpInteractorImpl: SignUpInteractor {
    let client: APIClient
    let mainClient: APIClient
    let presenter: SignUpPresenter
    var bag = [AnyCancellable]()
    
    init(presenter: SignUpPresenter) {
        self.presenter = presenter
        self.client = container.resolve(APIClient.self, name: "auth")!
        self.mainClient = container.resolve(APIClient.self, name: "main")!
    }
    
    func register(body: RegisterRequestBody) {
        presenter.events.send(.loading)
        client.dispatch(RegisterRequest(body: body.asDictionary)).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter.events.send(.error(message: error.localizedDescription))
            default:
                break
            }
        } receiveValue: { [weak self] val in
            UserDefaults.standard.set(val, forKey: "authToken")
            self?.client.authToken = val
            self?.mainClient.authToken = val
            self?.presenter.events.send(.didRegister)
        }.store(in: &bag)
    }
}
