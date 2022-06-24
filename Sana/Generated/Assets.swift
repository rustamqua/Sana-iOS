// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let arrowRight = ImageAsset(name: "ArrowRight")
    internal static let circleLogo = ImageAsset(name: "CircleLogo")
    internal static let iconAdd = ImageAsset(name: "IconAdd")
    internal static let iconNotification = ImageAsset(name: "IconNotification")
    internal static let positiveThinkingBro1 = ImageAsset(name: "Positive thinking-bro 1")
    internal static let tabAnalytics = ImageAsset(name: "TabAnalytics")
    internal static let tabHome = ImageAsset(name: "TabHome")
    internal static let tabServices = ImageAsset(name: "TabServices")
    internal static let tabSettings = ImageAsset(name: "TabSettings")
    internal static let teamGoals = ImageAsset(name: "TeamGoals")
    internal static let accountIcon = ImageAsset(name: "accountIcon")
    internal static let background = ImageAsset(name: "background")
    internal static let dateIcon = ImageAsset(name: "dateIcon")
    internal static let expenseAutoAndTransport = ImageAsset(name: "expenseAutoAndTransport")
    internal static let expenseBillsAndUtility = ImageAsset(name: "expenseBillsAndUtility")
    internal static let expenseBusinessServices = ImageAsset(name: "expenseBusinessServices")
    internal static let expenseEducation = ImageAsset(name: "expenseEducation")
    internal static let expenseEntertainment = ImageAsset(name: "expenseEntertainment")
    internal static let expenseFoodAndDining = ImageAsset(name: "expenseFoodAndDining")
    internal static let expenseGiftAndDontations = ImageAsset(name: "expenseGiftAndDontations")
    internal static let expenseHealth = ImageAsset(name: "expenseHealth")
    internal static let expenseHobbies = ImageAsset(name: "expenseHobbies")
    internal static let expenseHome = ImageAsset(name: "expenseHome")
    internal static let expenseKids = ImageAsset(name: "expenseKids")
    internal static let expensePersonalCare = ImageAsset(name: "expensePersonalCare")
    internal static let expensePets = ImageAsset(name: "expensePets")
    internal static let expenseShopping = ImageAsset(name: "expenseShopping")
    internal static let expenseSubscriptions = ImageAsset(name: "expenseSubscriptions")
    internal static let expenseTaxes = ImageAsset(name: "expenseTaxes")
    internal static let expenseTravel = ImageAsset(name: "expenseTravel")
    internal static let foodIcon = ImageAsset(name: "foodIcon")
    internal static let halyk = ImageAsset(name: "halyk")
    internal static let iconFall = ImageAsset(name: "iconFall")
    internal static let iconRaise = ImageAsset(name: "iconRaise")
    internal static let income = ImageAsset(name: "income")
    internal static let kaspi = ImageAsset(name: "kaspi")
    internal static let notesIcon = ImageAsset(name: "notesIcon")
    internal static let passwordHide = ImageAsset(name: "passwordHide")
    internal static let passwordShow = ImageAsset(name: "passwordShow")
    internal static let personalFinance = ImageAsset(name: "personalFinance")
    internal static let pushNotificationsBro = ImageAsset(name: "pushNotificationsBro")
    internal static let regularPayments = ImageAsset(name: "regularPayments")
    internal static let savingMoney = ImageAsset(name: "savingMoney")
    internal static let searchIcon = ImageAsset(name: "searchIcon")
    internal static let shoppingIcon = ImageAsset(name: "shoppingIcon")
    internal static let sourceIcon = ImageAsset(name: "sourceIcon")
    internal static let unknownCategory = ImageAsset(name: "unknownCategory")
    internal static let welcomeBackground = ImageAsset(name: "welcomeBackground")
  }
  internal enum Colors {
    internal static let accentActive = ColorAsset(name: "AccentActive")
    internal static let accentBlue = ColorAsset(name: "AccentBlue")
    internal static let accentBlue10 = ColorAsset(name: "AccentBlue10")
    internal static let accentBlue30 = ColorAsset(name: "AccentBlue30")
    internal static let accentBlue60 = ColorAsset(name: "AccentBlue60")
    internal static let accentBlue80 = ColorAsset(name: "AccentBlue80")
    internal static let bad = ColorAsset(name: "Bad")
    internal static let dangerous = ColorAsset(name: "Dangerous")
    internal static let dark = ColorAsset(name: "Dark")
    internal static let dark30 = ColorAsset(name: "Dark30")
    internal static let dark60 = ColorAsset(name: "Dark60")
    internal static let dark80 = ColorAsset(name: "Dark80")
    internal static let extraWhite = ColorAsset(name: "ExtraWhite")
    internal static let good = ColorAsset(name: "Good")
    internal static let secondaryActive = ColorAsset(name: "SecondaryActive")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
