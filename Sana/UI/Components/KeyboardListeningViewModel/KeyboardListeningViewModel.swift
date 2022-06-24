//
//  KeyboardListeningViewModel.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.04.2022.
//

import Foundation
import Combine

class KeyboardListeningViewModel: ObservableObject {
    @Published var isKeyboardShown = false
    var bag = [AnyCancellable]()
    
    init() {
        store.sink { [weak self] state in
            guard let self = self else { return }
            
            self.isKeyboardShown = state.system.keyboardHeight != 0
        }.store(in: &bag)
    }
}
