//
//  ContentView.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 04.03.2022.
//

import SwiftUI

struct ContentView: View {
    @Inject var appCoordinator: AppCoordinator
    
    var body: some View {
        Text("Sana")
            .onAppear(perform: { appCoordinator.start() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
