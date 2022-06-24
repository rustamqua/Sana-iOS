//
//  PushNotificationsScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 22.04.2022.
//

import SwiftUI

struct PushNotificationsScreen: View {
    @State var showWelcome = true

    let navigation: PushNotificationsNavigation
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(navigation: PushNotificationsNavigation) {
        self.navigation = navigation
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .trailing) {
                Image(uiImage: Asset.Assets.welcomeBackground.image)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            if showWelcome {
                welcomeView
            } else {
                notificationsView
            }
        }
        .background(Color.accentBlue60)
        .onReceive(timer) { _ in
            if showWelcome {
                showWelcome = false
            }
        }
        .animation(Animation.easeIn(duration: 0.3), value: showWelcome)
        .navigationBarHidden(true)
    }
    
    var welcomeView: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("TeamGoals")
                .padding(.top, 144)
            Group {
                Text("All in one place, ")
                    .foregroundColor(.white)
                    .bold() +
                Text("everything ")
                    .foregroundColor(.dark)
                    .bold() +
                Text("you need in a single app")
                    .foregroundColor(.white)
                    .bold()

            }
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding(.top, 70)
            .padding(.horizontal, 24)
            Spacer()
        }
    }
    
    var notificationsView: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("pushNotificationsBro")
                .padding(.top, 145)
            Text("Get the most out of Sana")
                .font(.title)
                .bold()
                .foregroundColor(.dark)
                .padding(.top, 60)
                .padding(.horizontal, 24)
            Text("Don’t miss out on essential alerts? Spending trends, pay day, and other account updates.")
                .font(.callout)
                .foregroundColor(.white)
                .padding(.top, 12)
                .padding(.horizontal, 24)
            Spacer()
            NormalButton(action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
                    DispatchQueue.main.async {
                        navigation.showCreateTable()
                    }
                }
            }, title: "Turn on notifications")
                .padding(.horizontal, 16)
            Button(action: navigation.showCreateTable) {
                Text("I’ll turn them on later")
                    .font(.body)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(Color.clear)
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
    }
}

struct PushNotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PushNotificationsScreen(navigation: .init(showCreateTable: {}))
    }
}
