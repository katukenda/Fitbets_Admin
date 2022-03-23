//
//  ObjectiveModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-23.
//

import Foundation

struct GetAllObjectiveResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [GetAllObjective]
    let message: String
}

// MARK: - Datum
struct GetAllObjective: Codable {
    let id, categoryID, subCategoryID: Int
    let objectiveName: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case objectiveName = "objective_name"
    }
}

struct ObjectDetailsResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: [ObjectDetails]
    let message: String
}

// MARK: - Datum
struct ObjectDetails: Codable {
    let id, categoryID, subCategoryID: Int
    let objectiveName: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case objectiveName = "objective_name"
    }
}

struct ObjectRequestModel: Codable {
    let categoryID, subCategoryID: Int
    let objectiveName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case objectiveName = "objective_name"
    }
}

struct ObjectUpdateResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let data: UpdateResponse
    let message: String
}

// MARK: - DataClass
struct UpdateResponse: Codable {
    let id: String
    let categoryID, subCategoryID: Int
    let objectiveName: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case objectiveName = "objective_name"
    }
}
