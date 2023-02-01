//
//  CastModel.swift
//  AsyncMovieApp
//
//  Created by Barış ŞARALDI on 1.02.2023.
//

import Foundation

// MARK: - CastModel
struct CastModel: Codable {
    let id: Int?
    let cast: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: KnownForDepartment?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    
    init(adult: Bool? = nil,
         gender: Int? = nil,
         id: Int? = nil,
         knownForDepartment: KnownForDepartment? = nil,
         name: String? = "Ezgi Suhel Aktas",
         originalName: String? = nil,
         popularity: Double? = nil,
         profilePath: String? = nil,
         castID: Int? = nil,
         character: String? = nil,
         creditID: String? = nil,
         order: Int? = nil) {
        
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.order = order
    }
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case writing = "Writing"
}
