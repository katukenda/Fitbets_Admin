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
                        completionHandler(true,"Admin registerd successfully")
                    }
                    else {
                        completionHandler(false, "Pleaese Try Again")
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
                   // print(json)
                  //  let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }
                    else {
                        completionHandler(.failure(.custom(message: "Please check the network connectivity")))
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completionHandler(.failure(.custom(message: "Please try again")))
                }
                
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(.custom(message: "Please try again")))
                
            }
        }
    }
}
