//
//  AddAccountPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation
import Combine

protocol AddAccountPresenter {
    var events: PassthroughSubject<AddAccountEvent, Never> { get }
}

enum AddAccountEvent {
    case accountCreated
    case error(message: String)
    case loading
}

struct AddAccountPresenterImpl: AddAccountPresenter {
     var events = PassthroughSubject<AddAccountEvent, Never>()
}
