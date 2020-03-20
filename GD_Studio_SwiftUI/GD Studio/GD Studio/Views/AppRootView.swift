//
//  AppRootView.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI

class AppObject: ObservableObject {
    @Published var isAuth = false
    var username: String = ""
}

struct AppRootView: View {

    @EnvironmentObject var env: AppObject
    
    var body: some View {
        Group {
            if env.isAuth {
                HomeView()
            } else {
                ContentView()
            }
        }.animation(.spring())
    }
}
