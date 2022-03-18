
//
//  GetAdminProfileDataResponseModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-17.
//

import Foundation


struct GetAllUserRequestModel: Codable {

    let status: Int
    let data: [GAUList]
    let message: String
}

// MARK: - Datum
struct GAUList: Codable {
    let id: Int
    let userName, playCard :String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case playCard = "player_card_url"
    }
}

struct GetUserDetailsModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [DUDM]
    let message: String
}

// MARK: - Datum
struct DUDM: Codable {
    let id: Int
    let userName, userEmail, plyCarURL :String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case userEmail = "email_address"
        case plyCarURL = "player_card_url"
    }
}
struct DeleteUserModel: Codable {
    let success: Bool
    let code: Int
    let status, message: String
}
