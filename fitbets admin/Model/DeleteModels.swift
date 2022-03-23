//
//  DeleteModels.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import Foundation


struct DeleteResponseModel: Codable {
    let success: Bool
    let code: Int
    let status, message: String
}
