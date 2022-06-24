//
//  RestrictedHostingController.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 23.04.2022.
//

import SwiftUI

final class RestrictedHostingController<Content>: UIHostingController<Content> where Content: View {
    override var navigationController: UINavigationController? {
        nil
    }
}
