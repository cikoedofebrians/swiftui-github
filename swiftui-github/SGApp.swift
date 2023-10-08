//
//  swiftui_githubApp.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import SwiftUI

@main
struct SGApp: App {
    @StateObject var userListViewModel: UserListViewModel = UserListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UserListView(userListViewModel: userListViewModel)
            }
        }
    }
}
