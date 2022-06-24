//
//  OTPPresenter.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation
import Combine

protocol OTPPresenter {
    var events: PassthroughSubject<OTPEvents, Never> { get }
}

enum OTPEvents {
    case otpValid
    case error(message: String)
    case loading
}

struct OTPPresenterImpl: OTPPresenter {
     var events = PassthroughSubject<OTPEvents, Never>()
}
