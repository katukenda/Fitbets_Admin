//
//  ApIManager.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-11.
//

import Foundation
import Alamofire

enum APIErrors: Error{
    case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void

class APIManager{
    static let shareInstance = APIManager()
    
    func callRegisterAPI(register: RegisterModel, completionHandler: @escaping (Bool, String) -> ()){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        let jsonS = try JSONDecoder().decode(RegisterResponseModel.self, from: data!)
                        
                        if (jsonS as! RegisterResponseModel).success {
                            completionHandler(true,"Successfuly Registerd")
                        }
                        else{
                            let jsonF = try JSONDecoder().decode(RegisterFaliureResponseModel.self, from: data!)
                            completionHandler(false,(jsonF as! RegisterFaliureResponseModel).message)
                        }
                    }
                    else {
                        if let dictionary = json as? [String: Any] {
                            if let message = dictionary["message"] as? String {
                                completionHandler(false,message)
                            }
                        }
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completionHandler(false,"Pleaese Try Again")
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false,"Pleaese Try Again")
            }
        }
    }
    
    func callLoginAPI(login: LoginModel, completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(LoginResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callingLogOutAPI(vc: UIViewController){
        let headers: HTTPHeaders = [
            "user_token": "\(TokenService.tokenInstance.getToken)"
        ]
        AF.request(login_url, method: .get, headers: headers).response{
            response in
            switch response.result{
            case .success(_):
                TokenService.tokenInstance.removeToken()
                vc.navigationController?.popToRootViewController(animated: true)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func callUpdateProfile(updateProfile: UpdateProfileModel, completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let id = TokenService.tokenInstance.getId()
        AF.request(updateProfile_url + "\(id)", method: .put, parameters: updateProfile, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ProfileUpdateresponse.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetAllAdmin(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        AF.request(getAllAdmin_url,method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetAllAdminResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetAdminById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_adminId = TokenService.tokenInstance.getAdminId()
        AF.request(getAdminById_url + "\(selected_adminId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetAdminProfileDataResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetAllUsers(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        
        AF.request(getAllUser_url,method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetAllUserRequestModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetuserById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_userId = TokenService.tokenInstance.getAdminId()
        AF.request(getUserById_url + "\(selected_userId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetUserDetailsModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
   
    func callgetAllCategory(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        AF.request(getAllCatagory_url,method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetCategoryResponsModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetAllSubCategory(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
       
        AF.request(getAllSubCategory_url ,method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(AllSubCategoryResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetSubCategoryById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_CategoryId = TokenService.tokenInstance.getCategoryId()
        AF.request(getAllSubCategoryById_url + "\(selected_CategoryId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetSubCategoryResponsModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetChallengeBySubCategoryId(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        
        let selected_SubCategoryId = TokenService.tokenInstance.getSubCategoryId()
        AF.request(getAllChallenges_url + "\(selected_SubCategoryId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetAllChallengesResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callgetChaConditionBySubCategoryId(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_CategoryId = TokenService.tokenInstance.getCategoryId()
        let selected_SubCategoryId = TokenService.tokenInstance.getSubCategoryId()
        AF.request(getAllChallengCondition_url + "\(selected_CategoryId)/\(selected_SubCategoryId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ConditionResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    func callgetIdolsByUserId(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_UserId = TokenService.tokenInstance.getAdminId()
      
        AF.request(getIdolsByUserid_url + "\(selected_UserId)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetIdolsByIdModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    //delete....................................................................................................
    func callDeleteAdminById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_adminId = TokenService.tokenInstance.getAdminId()
        AF.request(deleteAdminById_url + "\(selected_adminId)",method: .delete, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(DeleteAdminModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }

    func callDeleteUserById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_userId = TokenService.tokenInstance.getAdminId()
        AF.request(deleteUserById_url + "\(selected_userId)",method: .delete, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(DeleteUserModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }

    func callDeleteSubCategoryById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_SubCatId = TokenService.tokenInstance.getSubCategoryId()
        AF.request(deleteSubCategoryById_url + "\(selected_SubCatId)",method: .delete, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(DeleteResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    func callDeleteCategoryById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_CatId = TokenService.tokenInstance.getCategoryId()
        AF.request(deleteCategoryById_url + "\(selected_CatId)",method: .delete, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(DeleteResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callGetAllObjective(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
       
        AF.request(getAllObjectives_url,method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(GetAllObjectiveResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    func callDeleteObjectivesById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_Common_Id = TokenService.tokenInstance.getCommonId()
        AF.request(deleteObjectiveById_url + "\(selected_Common_Id)",method: .delete, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(DeleteResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callGetObjectiveById(completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let selected_Common_Id = TokenService.tokenInstance.getCommonId()
        AF.request(getObjectiveDetails_url + "\(selected_Common_Id)",method: .get, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ObjectDetailsResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }

    func callUpdateObjective(updateObjective: ObjectRequestModel, completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
        let id = TokenService.tokenInstance.getCommonId()
        AF.request(updateObjectById_url + "\(id)", method: .put, parameters: updateObjective, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ObjectUpdateResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
    func callCreateObjective(createObjective: ObjectRequestModel, completionHandler: @escaping Handler){
        let headers: HTTPHeaders = [
            "Authorization": TokenService.tokenInstance.getToken()
        ]
       
        AF.request(createObject_url , method: .post, parameters: createObjective, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ObjectUpdateResponseModel.self, from: data!)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
            case .failure(let err):
                completionHandler(.failure(.custom(message: "Please try again")))
            }
        }
    }
    
}

