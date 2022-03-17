//
//  Constant.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation

let app_id = ""
let rest_key = ""
let device_token = "aaaaaaa"

//base url
let base_url = "http://ec2-35-83-63-15.us-west-2.compute.amazonaws.com:8000/adminnew"

//endpoints
let login_url = "\(base_url)/login"
let register_url = "\(base_url)/register"
let logout_url = "\(base_url)/logout"
let updateProfile_url = "\(base_url)/update/"
let getAllAdmin_url = "\(base_url)/getAllAdmin"
let getAdminById_url = "\(base_url)/getAdmin/"


struct TokenKey{
    static let userLogin = "USER_LOGIN_KEY"
}

struct profileKey{
    static let userId = "USER_ID"
    static let userName = "USER_NAME"
    static let userEmail = "USER_EMAIL"
    static let userMobile = "USER_MOBILE"
}

struct SelectedAdminKey{
    static let seletedAdminId = "SELECTED_ADMIN_ID"
}

