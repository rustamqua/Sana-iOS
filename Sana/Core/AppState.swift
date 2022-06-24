import SwiftUI
import Combine

let store = CurrentValueSubject<AppState, Never>(AppState())

struct AppState: Equatable {
    var system: System = System()
}

extension AppState {
    struct System: Equatable {
        var keyboardHeight: CGFloat = 0
    }
}
