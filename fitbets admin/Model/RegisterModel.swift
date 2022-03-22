//
//  RegisterModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation

struct RegisterModel: Encodable {
    
    let admin_name: String
    let email_address: String
    let mobile_number: String
    let password: String
    let device_token: String
}

struct RegisterResponseModel:Codable {
    let success: Bool
    let code: Int
    let status: String
}

struct RegisterFaliureResponseModel:Codable {
    let success: Bool
    let code: Int
    let status: String
    let message: String
}
