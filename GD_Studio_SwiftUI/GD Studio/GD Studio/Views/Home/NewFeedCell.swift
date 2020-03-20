//
//  NewFeedCell.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.5:1)
    }
}

struct NewFeedCell: View {
    
    @State private var isPressLike = false
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            userView
            Text(post.content)
                .font(.system(size: 14))
                .padding([.leading, .trailing], 25)
            Image(uiImage: UIImage(data: post.image!)!).resizable().frame(width: UIScreen.main.bounds.width, height: 250)
            likeAndCommentView
        }.listRowInsets(EdgeInsets())
    }
    
    var userView: some View {
        return HStack(spacing: 10) {
            Image(uiImage: UIImage(data: post.user.avtar!)!).resizable().aspectRatio(contentMode: .fill).frame(width: 40, height: 40).cornerRadius(20).clipped()
            VStack(alignment: .leading, spacing: 5) {
                Text(post.user.userName)
                Text("3 gio truoc, gan ha noi").foregroundColor(.gray).font(.caption)
            }
            Spacer()
            Button(action: {
                self.isPressLike = !self.isPressLike
            }, label: {
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }).buttonStyle(ScaleButtonStyle())
        }.padding([.leading,.top,.bottom], 25)
    }
    
    var likeAndCommentView: some View {
        return HStack(spacing: 5) {
            Button(action: {
                self.isPressLike = !self.isPressLike
            }, label: {
                Text("Reply").foregroundColor(.gray).font(.caption)
            }).buttonStyle(ScaleButtonStyle())
            
            Button(action: {
                self.isPressLike = !self.isPressLike
            }, label: {
                Text("Like").foregroundColor(.gray).font(.caption)
            }).buttonStyle(ScaleButtonStyle())
            
            Text("3").foregroundColor(.gray).font(.caption)
            Image(systemName: "star.fill").foregroundColor(.gray)
            
            Button(action: {
                self.isPressLike = !self.isPressLike
            }, label: {
                HStack {
                Text("3").foregroundColor(.gray).font(.caption)
                Image(systemName: "heart.fill").foregroundColor(.gray)
                }
            }).buttonStyle(ScaleButtonStyle())
            Spacer()
        }.padding(25)
            .frame(width: nil, height: 60)
    }
    
}

struct NewFeedCell_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedCell(post: Post())
    }
}
