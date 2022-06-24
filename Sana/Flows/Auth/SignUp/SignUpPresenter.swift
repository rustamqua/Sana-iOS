//
//  SignUpPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 27.04.2022.
//

import Foundation
import Combine

protocol SignUpPresenter {
    var events: PassthroughSubject<SignUpEvents, Never> { get }
}

enum SignUpEvents {
    case didRegister
    case error(message: String)
    case loading
}

struct SignUpPresenterImpl: SignUpPresenter {
     var events = PassthroughSubject<SignUpEvents, Never>()
}
