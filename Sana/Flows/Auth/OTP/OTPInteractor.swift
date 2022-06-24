//
//  OTPInteractor.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation
import Networking
import Combine

protocol OTPInteractor {
    func postOTP(code: String)
}

final class OTPInteractorImpl: OTPInteractor {
    private let client: APIClient
    private let mainClient: APIClient

    private let presenter: OTPPresenter
    var bag = [AnyCancellable]()
    
    init(presenter: OTPPresenter) {
        self.client = container.resolve(APIClient.self, name: "auth")!
        self.mainClient = container.resolve(APIClient.self, name: "main")!
        
        self.presenter = presenter
    }
    
    func postOTP(code: String) {
        presenter.events.send(.loading)
        client.dispatch(VerifyOTPRequest(code: code)).sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter.events.send(.error(message: error.localizedDescription))
            case .finished:
                break
            }
        } receiveValue: { [weak self] token in
            UserDefaults.standard.set(token, forKey: "authToken")
            self?.client.authToken = token
            self?.mainClient.authToken = token
            self?.presenter.events.send(.otpValid)
        }.store(in: &bag)
    }
}
