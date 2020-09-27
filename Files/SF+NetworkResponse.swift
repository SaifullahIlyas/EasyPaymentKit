//
//  NetworkResponse.swift
//  TestStripe
//
//  Created by Saifullah on 26/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import Foundation

// MARK: - StripeCardResponse
struct StripeCardResponse: Codable {
    let id, object: String?
    let card: Card?
    let created: Int?
    let livemode: Bool?
    let type: String?
    let used: Bool?
}

// MARK: - Card
struct Card: Codable {
    let id, object, brand, country: String?
    let cvcCheck: String?
    let expMonth, expYear: Int?
    let fingerprint, funding, last4: String?

    enum CodingKeys: String, CodingKey {
        case id, object, brand, country
        case cvcCheck = "cvc_check"
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case fingerprint, funding, last4
    }
}

