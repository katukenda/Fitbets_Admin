//
//  LoginModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation

struct LoginModel: Encodable {
    
    let admin_name: String
    let password: String
    let device_token: String
}

struct LoginResponseModel: Codable {
    let success: Bool
    let token, expiresIn: String
    let sub: Sub
}
struct Sub: Codable {
    let id: Int
    let adminName, emailAddress, mobileNumber: String

    enum CodingKeys: String, CodingKey {
        case id
        case adminName = "admin_name"
        case emailAddress = "email_address"
        case mobileNumber = "mobile_number"
    }
}

struct LoginErrorModel: Codable {
    let success: Bool
    let message: String
    
}
