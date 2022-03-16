//
//  AdminDetailsModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-16.
//

import Foundation


struct GetAllAdminResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [Datum]
    let message: String
}
// MARK: - Datum
struct Datum: Codable {
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
