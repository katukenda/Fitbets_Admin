//
//  GetAdminProfileDataResponseModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-17.
//

import Foundation


struct GetAdminProfileDataResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [GADBId]
    let message: String
}

struct GADBId: Codable {
    let id: Int
    let adminName, emailAddress, mobileNumber, hash: String
    let salt, deviceToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case adminName = "admin_name"
        case emailAddress = "email_address"
        case mobileNumber = "mobile_number"
        case hash, salt
        case deviceToken = "device_token"
    }
}
