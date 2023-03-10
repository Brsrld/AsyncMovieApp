//
//  CastModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

// MARK: - CastModel
struct CastModel: Codable {
    let cast, crew: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let character, creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    init(adult: Bool? = nil,
         gender: Int? = nil,
         id: Int? = nil,
         knownForDepartment: String? = nil,
         name: String? = "Ezgi Suhel Aktas",
         originalName: String? = nil,
         popularity: Double? = nil,
         profilePath: String? = nil,
         job: String? = nil,
         character: String? = nil,
         creditID: String? = nil,
         order: Int? = nil,
         department: String? = nil) {
        
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.character = character
        self.creditID = creditID
        self.order = order
        self.job = job
        self.department = department
    }
}
