//
//  ConditionModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import Foundation

struct ConditionResponseModel: Codable {
    let success: Bool
    let code: Int
    let status: String
    let postTagDetails: PostTagDetails
    let message: String

    enum CodingKeys: String, CodingKey {
        case success, code, status
        case postTagDetails = "PostTagDetails"
        case message
    }
}

// MARK: - PostTagDetails
struct PostTagDetails: Codable {
    let rules: [Rule]
    let quipment: [Quipment]
    let challegeDetails: [ChallegeDetail]

    enum CodingKeys: String, CodingKey {
        case rules = "Rules"
        case quipment
        case challegeDetails = "ChallegeDetails"
    }
}

// MARK: - ChallegeDetail
struct ChallegeDetail: Codable {
    let id: Int
    let challengeName, object, time: String
    let subcategoryID, admincategoryID: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, challengeName, object, time, subcategoryID
        case admincategoryID = "admincategoryId"
        case type
    }
}

// MARK: - Quipment
struct Quipment: Codable {
    let equipment, type: String
}

// MARK: - Rule
struct Rule: Codable {
    let rules, type: String
}
