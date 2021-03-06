//
//  Constant.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation

let app_id = ""
let rest_key = ""
let device_token = "12345678"

//base url
let base_url = "http://ec2-35-83-63-15.us-west-2.compute.amazonaws.com:8000/"
let admin_root = "adminnew"
let user_root = "user"
let admin_old_root = "admin"
let idols_root = "idols"
let objective_root = "objective"
//endpoints admin
let login_url = "\(base_url + admin_root)/login"
let register_url = "\(base_url + admin_root)/register"
let logout_url = "\(base_url + admin_root)/logout"
let updateProfile_url = "\(base_url + admin_root)/update/"
let getAllAdmin_url = "\(base_url + admin_root)/getAllAdmin"
let getAdminById_url = "\(base_url + admin_root)/getAdmin/"
let deleteAdminById_url = "\(base_url + admin_root)/deleteAdmin/"
let deleteUserById_url = "\(base_url + admin_root)/deleteUser/"


let getAllCatagory_url = "\(base_url + admin_old_root)/getAllCategories"
let getAllSubCategoryById_url = "\(base_url + admin_old_root)/getAllSubCategories/"
let getAllChallenges_url = "\(base_url + admin_old_root)/getAllChallengesbySub/"
let getAllChallengCondition_url = "\(base_url + admin_old_root)/getAllChallengeConditionsDetails/"
let getAllSubCategory_url = "\(base_url + admin_old_root)/getAllSubCategories"
let deleteCategoryById_url = "\(base_url + admin_old_root)/deleteCategories/"
let deleteSubCategoryById_url = "\(base_url + admin_old_root)/deleteSubCategories/"
let getAllObjectives_url = "\(base_url + objective_root)/getAllObjectives"
let deleteObjectiveById_url = "\(base_url + objective_root)/delete/"
let getObjectiveDetails_url = "\(base_url + objective_root)/getObjective/"
let getObjectiveDetailsByCategory_url = "\(base_url + objective_root)/getObjectivesById/"
let updateObjectById_url = "\(base_url + objective_root)/update/"
let createObject_url = "\(base_url + objective_root)/create"

//endpoints user
let getAllUser_url = "\(base_url + user_root)/get-all-users"
let getUserById_url = "\(base_url + user_root)/profile/"
let getIdolsByUserid_url = "\(base_url + idols_root)/idol-get/"


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
struct SelectedCategoryKey{
    static let seletedCategoryId = "SELECTED_CATEGORY_ID"
}
struct SelectedSubCategoryKey{
    static let seletedSubCategoryId = "SELECTED_SUB_CATEGORY_ID"
}
struct SelectedCommonKey{
    static let seletedCommonId = "SELECTED_COMMON_ID"
}

