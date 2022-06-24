//
//  CreatePasswordPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation
import Combine

protocol CreatePasswordPresenter {
    var events: PassthroughSubject<CreatePasswordEvents, Never> { get }
}

enum CreatePasswordEvents {
    case passwordCreated
    case error(message: String)
    case loading
}

struct CreatePasswordPresenterImpl: CreatePasswordPresenter {
     let events = PassthroughSubject<CreatePasswordEvents, Never>()
}
