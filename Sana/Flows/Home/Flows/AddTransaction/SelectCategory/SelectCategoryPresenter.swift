//
// Created by Rustam-Deniz Emirali on 20.06.2022.
//

import Foundation
import Combine

protocol SelectCategoryPresenter {
    var events: PassthroughSubject<SelectCategoryEvent, Never> { get }
}

enum SelectCategoryEvent {
    case error(message: String)
    case loading
    case categoriesLoaded([Category])
}

struct SelectCategoryPresenterImpl: SelectCategoryPresenter {
    var events = PassthroughSubject<SelectCategoryEvent, Never>()
}