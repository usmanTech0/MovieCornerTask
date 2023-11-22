//
//  ResponseFailure.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

// MARK: - ResponseFailure
struct ResponseFailure: Codable {
    let success: Bool!
        let statusCode: Int!
        let statusMessage: String!

        enum CodingKeys: String, CodingKey {
            case success
            case statusCode = "status_code"
            case statusMessage = "status_message"
        }
}
