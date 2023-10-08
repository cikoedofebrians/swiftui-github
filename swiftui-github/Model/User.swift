//
//  User.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarURL: String
    let htmlURL: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case type
    }
    
    static func fakeUser() -> User {
           return User(
               id: 1,
               login: "johndoe",
               avatarURL: "https://avatars.githubusercontent.com/u/1?v=4",
               htmlURL: "https://example.com/johndoe",
               type: "user"
           )
    }
}
