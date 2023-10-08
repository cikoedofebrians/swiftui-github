//
//  UserDetailsView.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 30/09/23.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    init(user: User) {
        self.user = user
        print(user.htmlURL)
    }
    
    var body: some View {
        ZStack {
            Group {
                GeometryReader { geo in
                    AsyncImage(url: URL(string: user.avatarURL)!) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: geo.size.height)
                            
                        } else if phase.error != nil {
                            
                        } else {
                            ProgressView()
                                .bold()
                        }
                    }
                }
                Color.black.opacity(0.5)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            
            VStack {
                Text(user.login)
                    .font(.system(size: 48))
                    .foregroundStyle(.white)
                    .bold()
                Text(user.type)
                    .foregroundStyle(.white)
                    .font(.title)
                Spacer()
                NavigationLink {
                    WebView(url: URL(string: user.htmlURL)!)
                } label: {
                    Text("Check GitHub Profile")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(RoundedRectangle(cornerRadius: 20).fill(.green)
                        )
                        .padding(.horizontal, 20)
                }
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        UserDetailsView(user: User.fakeUser())
    }
}
