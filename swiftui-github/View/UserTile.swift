//
//  UserTile.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import SwiftUI

struct UserTile: View {
    let user: User
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color(UIColor.label).opacity(0.2), radius: 10, x: 0, y: 5)
            HStack (spacing: 20) {
                ZStack {
                    Circle()
                        .fill(.gray)
                    AsyncImage(url: URL(string: user.avatarURL)!) {
                        phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFit()
                        default:
                            ProgressView()
                        }
                    }
                    .font(.system(size: 40))
                }
                Text(user.login)
                Spacer()
                ZStack {
                    Circle()
                        .fill(.green)
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size: 40))
                    }     
                }
            }
            .padding(10)
        }
        
        .frame(height: 80)
        .padding(.horizontal, 10)
        
    }
    
}

#Preview {
    
    UserTile(user: User.fakeUser())
}
