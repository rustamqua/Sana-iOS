//
//  SignInPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 29.04.2022.
//

import Foundation
import Combine

protocol SignInPresenter {
    var events: PassthroughSubject<SignInEvents, Never> { get }
}

enum SignInEvents {
    case signedIn
    case error(message: String)
    case loading
}

struct SignInPresenterImpl: SignInPresenter {
     var events = PassthroughSubject<SignInEvents, Never>()
}
