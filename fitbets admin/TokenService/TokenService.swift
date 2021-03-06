//
//  TokenService.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-13.
//

import UIKit

class TokenService{
    static let tokenInstance = TokenService()
    let userDefault = UserDefaults.standard
    
    //save
    func saveToken(token: String){
        userDefault.set(token, forKey: TokenKey.userLogin)
    }
    func saveAdminId(id: Int){
        userDefault.set(id, forKey: SelectedAdminKey.seletedAdminId)
    }
    func saveProfileDeatails(name: String,email: String, mobile: String, id: Int){
        userDefault.set(name, forKey: profileKey.userName)
        userDefault.set(email, forKey: profileKey.userEmail)
        userDefault.set(mobile, forKey: profileKey.userMobile)
        userDefault.set(id, forKey: profileKey.userId)
    }
    func saveCategoryId(id: Int){
        userDefault.set(id, forKey: SelectedCategoryKey.seletedCategoryId)
    }
    func saveSubCategoryId(id: Int){
        userDefault.set(id, forKey: SelectedSubCategoryKey.seletedSubCategoryId)
    }
    func saveCommonId(id: Int){
        userDefault.set(id, forKey: SelectedCommonKey.seletedCommonId)
    }

    //get
    func getToken() -> String{
        if let token = userDefault.object(forKey: TokenKey.userLogin) as? String {
            return token
        }
        else {
            return ""
        }
    }
    func getAdminId() -> Int{
        if let id = userDefault.object(forKey: SelectedAdminKey.seletedAdminId) as? Int {
            return id
        }
        else {
            return -1
        }
    }
    func getCategoryId() -> Int{
        if let id = userDefault.object(forKey: SelectedCategoryKey.seletedCategoryId) as? Int {
            return id
        }
        else {
            return -1
        }
    }
    func getSubCategoryId() -> Int{
        if let id = userDefault.object(forKey: SelectedSubCategoryKey.seletedSubCategoryId) as? Int {
            return id
        }
        else {
            return -1
        }
    }
    func getCommonId() -> Int{
        if let id = userDefault.object(forKey: SelectedCommonKey.seletedCommonId) as? Int {
            return id
        }
        else {
            return -1
        }
    }
    
    func getId() -> Int{
        if let id = userDefault.object(forKey: profileKey.userId) as? Int {
            return id
        }
        else {
            return -1
        }
    }
    func getName() -> String{
        if let adminName = userDefault.object(forKey: profileKey.userName) as? String {
            return adminName
        }
        else {
            return ""
        }
    }
    func getEmail() -> String{
        if let adminMail = userDefault.object(forKey: profileKey.userEmail) as? String {
            return adminMail
        }
        else {
            return ""
        }
    }
    
    func getMobile() -> String{
        if let adminMobile = userDefault.object(forKey: profileKey.userMobile) as? String {
            return adminMobile
        }
        else {
            return ""
        }
    }
    
    //check
    func checkForLogin() -> Bool {
        if getToken() == "" {
            return false
        }
        else {
            return true
        }
    }
    //remove
    func removeToken(){
        userDefault.removeObject(forKey: TokenKey.userLogin)
    }
    func removeselectedAdminId(){
        userDefault.removeObject(forKey: SelectedAdminKey.seletedAdminId)
    }
    func removeProfileDeatails(){
        userDefault.removeObject(forKey: profileKey.userName)
        userDefault.removeObject(forKey: profileKey.userEmail)
        userDefault.removeObject(forKey: profileKey.userMobile)
        userDefault.removeObject(forKey: profileKey.userId)
    }
    func removeCategoryId(){
        userDefault.removeObject(forKey: SelectedCategoryKey.seletedCategoryId)
    }
    func removeSubCategoryId(){
        userDefault.removeObject(forKey: SelectedSubCategoryKey.seletedSubCategoryId)
    }
    func removeCommonId(){
        userDefault.removeObject(forKey: SelectedCommonKey.seletedCommonId)
    }

    
}

