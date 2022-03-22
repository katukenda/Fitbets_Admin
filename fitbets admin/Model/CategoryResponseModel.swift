//
//  CategoryResponseModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-21.
//

import Foundation

struct GetCategoryResponsModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [GAC]
    let message: String
}

struct GAC: Codable {
    let id: Int
    let categoryImageFile: String
    let categoryName, equipment: String
}

struct GetSubCategoryResponsModel : Codable {
    let code: Int
    let data: [GASC]
    let message: String
}
struct GASC: Codable {
    let id, categoryID: Int
    let subcategoryImageFile: String
    let subcategoryName: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "categoryId"
        case subcategoryImageFile, subcategoryName
    }
}
