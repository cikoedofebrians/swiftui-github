//
//  SwiftUIView.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var userListViewModel: UserListViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 20) {
                ForEach(userListViewModel.userList) { user in
                    UserTile(user: user)
                }
            }
        }
        .sheet(isPresented: $userListViewModel.isError) {
            VStack {
                Spacer()
                Image(systemName: "x.circle")
                    .font(.system(size: 100))
                    .foregroundStyle(.red)
                    .padding(.bottom, 10)
                
                Text(userListViewModel.errorMessage)
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Button(action: {
                    userListViewModel.dismissError()
                }, label: {
                    Text("Close")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })

            }
            .padding(.horizontal, 20)
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.visible)
        }
        .navigationTitle("SwiftUI x GitHub")
        .navigationBarTitleDisplayMode(.automatic)
    }
    
}

#Preview {
    NavigationView {
        UserListView(userListViewModel: UserListViewModel())
    }
}
