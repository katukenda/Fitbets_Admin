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
