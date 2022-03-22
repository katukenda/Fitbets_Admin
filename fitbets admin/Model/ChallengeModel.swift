//
//  ChallengeModel.swift
//  fitbets admin
//
//  Created by Janitha Katukenda on 2022-03-22.
//

import Foundation

import Foundation
struct GetAllChallengesResponseModel: Codable {
    let code: Int
    let data: [GACBS]
    let message: String
}

// MARK: - Datum
struct GACBS: Codable {
    let id: Int
    let challengeName, object, time: String
    let subcategoryID, admincategoryID: Int

    enum CodingKeys: String, CodingKey {
        case id, challengeName, object, time, subcategoryID
        case admincategoryID = "admincategoryId"
    }
}
