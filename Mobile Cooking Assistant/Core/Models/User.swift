//
//  User.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let photo: Data?
    let recipes: [Recipe]?
    let loginData: LoggingData?
}
