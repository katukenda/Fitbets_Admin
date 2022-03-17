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
let base_url = "http://ec2-35-83-63-15.us-west-2.compute.amazonaws.com:8000/"
let admin_root = "adminnew"
let user_root = "user"
//endpoints admin
let login_url = "\(base_url + admin_root)/login"
let register_url = "\(base_url + admin_root)/register"
let logout_url = "\(base_url + admin_root)/logout"
let updateProfile_url = "\(base_url + admin_root)/update/"
let getAllAdmin_url = "\(base_url + admin_root)/getAllAdmin"
let getAdminById_url = "\(base_url + admin_root)/getAdmin/"
let deleteAdminById_url = "\(base_url + admin_root)/deleteAdmin/"
let deleteUserById_url = "\(base_url + admin_root)/deleteUser/"

//endpoints user
let getAllUser_url = "\(base_url + user_root)/get-all-users"
let getUserById_url = "\(base_url + user_root)/profile/"


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

