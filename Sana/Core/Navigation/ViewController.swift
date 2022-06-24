import UIKit

public protocol BaseViewController: UIViewController {
    var onRemoveFromNavigationStack: (() -> Void)? { get set }
}

open class ViewController: UIViewController, BaseViewController {
    public var onRemoveFromNavigationStack: (() -> Void)?

    override public func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            onRemoveFromNavigationStack?()
        }
    }
}
