//
//  HeaderView.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI

struct FillAll: View {
    let color: Color

    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: proxy.size.width * 1.3).fixedSize()
        }
    }
}


struct HeaderViewCell: View {
    
    let user: User?
    
    private var avatarImage: Image {
        if let data = user?.avtar, let avatar = UIImage(data: data) {
            return Image(uiImage: avatar)
        } else {
            return Image(systemName: "bubble.right.fill")
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            avatarImage.resizable().aspectRatio(contentMode: .fill).frame(width: 40, height: 40).cornerRadius(20).clipped()
            Text("Bạn đang nghĩ gì... ").foregroundColor(.gray)
        }.listRowInsets(EdgeInsets())
            .background(FillAll(color: .white))
            .frame(height: 80)
            .padding([.leading, .trailing], 25)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderViewCell(user: User())
    }
}
