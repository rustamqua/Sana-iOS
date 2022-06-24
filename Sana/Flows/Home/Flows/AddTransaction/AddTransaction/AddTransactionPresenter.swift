//
//  AddTransactionPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.05.2022.
//

import Foundation
import Combine

protocol AddTransactionPresenter {
    var events: PassthroughSubject<AddTransactionEvent, Never> { get }
}

enum AddTransactionEvent {
    case transactionCreated
    case error(message: String)
    case loading
}

struct AddTransactionPresenterImpl: AddTransactionPresenter {
    var events = PassthroughSubject<AddTransactionEvent, Never>()
}