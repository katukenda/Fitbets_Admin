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
                        if let dictionary = json as? [String: Any] {
                            if let message = dictionary["message"] as? String {
                                completionHandler(true,message)
                            }
                        }
                    }
                    else {
                        if let dictionary = json as? [String: Any] {
                            if let message = dictionary["message"] as? String {
                                completionHandler(true,message)
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
    
    
    //    func callUpdateProfile(updateprofile: UpdateProfileModel, completionHandler: @escaping (Bool, String) -> ()){
    //        let headers: HTTPHeaders = [
    //            "Authorization": TokenService.tokenInstance.getToken()
    //        ]
    //        AF.request(updateProfile_url, method: .put, parameters: updateprofile, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
    //            debugPrint(response)
    //            switch response.result{
    //            case .success(let data):
    //                do{
    //
    //                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
    //
    //                    if response.response?.statusCode == 200 {
    //
    //                        if let dictionary = json as? [String: Any] {
    //                            if let message = dictionary["message"] as? String {
    //                                completionHandler(true,message)
    //                            }
    //
    //                        }
    //                    }
    //                    else {
    //                        if let dictionary = json as? [String: Any] {
    //                            if let message = dictionary["message"] as? String {
    //                                completionHandler(true,message)
    //                            }
    //                        }
    //                    }
    //                }
    //                catch{
    //                    print(error.localizedDescription)
    //                    completionHandler(false,error.localizedDescription)
    //                }
    //
    //            case .failure(let err):
    //                print(err.localizedDescription)
    //                completionHandler(false,err.localizedDescription)
    //
    //            }
    //        }
    //    }
    //
    
    
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
    
}
