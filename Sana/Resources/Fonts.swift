//
//  Fonts.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 16.03.2022.
//

import UIKit
import SwiftUI

extension UIFont {
    static func hugeTitle() -> UIFont {
        return .systemFont(ofSize: 60, weight: .init(rawValue: 400))
    }

    static func hugeTitleBold() -> UIFont {
        return .systemFont(ofSize: 60, weight: .init(rawValue: 700))
    }

    static func largeTitle() -> UIFont {
        return .systemFont(ofSize: 34, weight: .init(rawValue: 400))
    }

    static func largeTitleBold() -> UIFont {
        return .systemFont(ofSize: 34, weight: .init(rawValue: 700))
    }

    static func title1() -> UIFont {
        return .systemFont(ofSize: 28, weight: .init(rawValue: 400))
    }

    static func title1Bold() -> UIFont {
        return .systemFont(ofSize: 28, weight: .init(rawValue: 700))
    }

    static func title2() -> UIFont {
        return .systemFont(ofSize: 22, weight: .init(rawValue: 700))
    }

    static func title3() -> UIFont {
        return .systemFont(ofSize: 20, weight: .init(rawValue: 400))
    }

    static func title3Bold() -> UIFont {
        return .systemFont(ofSize: 20, weight: .init(rawValue: 700))
    }

    static func headline() -> UIFont {
        return .systemFont(ofSize: 17, weight: .semibold)
    }

    static func headlineItalic() -> UIFont {
        return .systemFont(ofSize: 17, weight: .semibold).italic()
    }

    static func callout() -> UIFont {
        return .systemFont(ofSize: 16, weight: .init(rawValue: 400))
    }

    static func calloutBold() -> UIFont {
        return .systemFont(ofSize: 16, weight: .init(rawValue: 600))
    }

    static func calloutItalic() -> UIFont {
        return .systemFont(ofSize: 16, weight: .init(rawValue: 400)).italic()
    }

    static func calloutItalicBold() -> UIFont {
        return .systemFont(ofSize: 16, weight: .init(rawValue: 600)).italic()
    }

    static func subheadline() -> UIFont {
        return .systemFont(ofSize: 15, weight: .init(rawValue: 400))
    }

    static func subheadlineBold() -> UIFont {
        return .systemFont(ofSize: 15, weight: .init(rawValue: 600))
    }

    static func subheadlineItalic() -> UIFont {
        return .systemFont(ofSize: 15, weight: .init(rawValue: 400)).italic()
    }

    static func subheadlineItalicBold() -> UIFont {
        return .systemFont(ofSize: 15, weight: .init(rawValue: 600)).italic()
    }

    static func body() -> UIFont {
        return .systemFont(ofSize: 17, weight: .init(rawValue: 400))
    }

    static func bodyBold() -> UIFont {
        return .systemFont(ofSize: 17, weight: .init(rawValue: 600))
    }

    static func bodyItalic() -> UIFont {
        return .systemFont(ofSize: 17, weight: .init(rawValue: 400)).italic()
    }

    static func bodyItalicBold() -> UIFont {
        return .systemFont(ofSize: 17, weight: .init(rawValue: 600)).italic()
    }

    static func footnote() -> UIFont {
        return .systemFont(ofSize: 13, weight: .init(rawValue: 400))
    }

    static func footnoteBold() -> UIFont {
        return .systemFont(ofSize: 13, weight: .init(rawValue: 600))
    }

    static func footnoteItalic() -> UIFont {
        return .systemFont(ofSize: 13, weight: .init(rawValue: 400)).italic()
    }

    static func footnoteItalicBold() -> UIFont {
        return .systemFont(ofSize: 13, weight: .init(rawValue: 600)).italic()
    }

    static func caption1() -> UIFont {
        return .systemFont(ofSize: 12, weight: .init(rawValue: 400))
    }

    static func caption1Bold() -> UIFont {
        return .systemFont(ofSize: 12, weight: .init(rawValue: 500))
    }

    static func caption1Italic() -> UIFont {
        return .systemFont(ofSize: 12, weight: .init(rawValue: 400)).italic()
    }

    static func caption1ItalicBold() -> UIFont {
        return .systemFont(ofSize: 12, weight: .init(rawValue: 500)).bold()
    }

    static func caption2() -> UIFont {
        return .systemFont(ofSize: 11, weight: .init(rawValue: 400))
    }

    static func caption2Bold() -> UIFont {
        return .systemFont(ofSize: 11, weight: .init(rawValue: 600))
    }

    static func caption2Italic() -> UIFont {
        return .systemFont(ofSize: 11, weight: .init(rawValue: 400)).italic()
    }

    static func caption2ItalicBold() -> UIFont {
        return .systemFont(ofSize: 11, weight: .init(rawValue: 600)).italic()
    }
}

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
