//
//  HomeView.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI

struct GradientText: View {
    let title: String
    let colors: [Color]
    let font: Font
    
    var body: some View {
        RadialGradient(gradient: Gradient(colors: colors),
                       center: .center,
                       startRadius: 0,
                       endRadius: 300)
            .frame(height: 65)
            .mask(Text("\(self.title)")
                .font(font)
        )
    }
}



struct HomeView: View {
    
    @EnvironmentObject var env: AppObject
    
    @State private var isShowNewPostScreen = false
    
    @ObservedObject var posts = BindableResults(results: RealmDBManager.shared.allpost())
    
    var body: some View {
        NavigationView {
            List {
                listHeader
                ForEach(posts.results) { post in
                    NewFeedCell(post: post)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("News Feed"), displayMode: .large)
            .navigationBarItems(leading: navigationItems)
        }
    }
    
    
    var navigationItems: some View {
        return HStack {
            GradientText(title: "GD Studio", colors: [.red, .green, .pink], font: .largeTitle)
                .padding()
                .shadow(radius: 5)
                .frame(width: UIScreen.main.bounds.width, height: 50)
        }
    }
    
    var listHeader: some View {
        return HeaderViewCell(user: RealmDBManager.shared.isUserExist(username: env.username))
            .onTapGesture {
                self.isShowNewPostScreen = true
        }.sheet(isPresented: $isShowNewPostScreen, content: {
            NewPostView().environmentObject(self.env)
        })
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
