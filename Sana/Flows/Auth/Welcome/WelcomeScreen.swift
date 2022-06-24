//
//  WelcomeScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 25.03.2022.
//

import SwiftUI

struct WelcomeScreen: View {
    private let navigation: WelcomeNavigation
    
    init(navigation: WelcomeNavigation) {
        self.navigation = navigation
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .trailing) {
                Image(uiImage: Asset.Assets.welcomeBackground.image)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            VStack(alignment: .leading) {
                Spacer()
                Text("Welcome to your space of consciousness!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.dark)
                    .padding(.horizontal, 24)
                ZStack(alignment: .center) {
                    Image.init(uiImage: Asset.Assets.positiveThinkingBro1.image)
                }.frame(maxWidth: .infinity)
                Spacer()
                VStack(alignment: .center, spacing: 16) {
                    NormalButton(action: { navigation.onCreateAccountDidTap() }, title: "Create account")
                    SecondaryButton(action: { navigation.onSignInDidTap() }, title: "Sign In")
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 16)
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(navigation: .init(onCreateAccountDidTap: {}, onSignInDidTap: {}))
    }
}
