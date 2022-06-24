//
//  FirstTablePresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation
import Combine

protocol FirstTablePresenter {
    var events: PassthroughSubject<FirstTableEvent, Never> { get }
}

enum FirstTableEvent {
    case tableCreated
    case error(message: String)
    case loading
}

struct FirstTablePresenterImpl: FirstTablePresenter {
     var events = PassthroughSubject<FirstTableEvent, Never>()
}
