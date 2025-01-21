//
//  ProfileModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation

struct Profile: Codable {
    var id: UUID
    var name: String
    var age: Int
    var gender: String
    
    init(id: UUID = UUID(), name: String = "", age: Int = 0, gender: String = "") {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
    }
}
