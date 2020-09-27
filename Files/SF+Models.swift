//
//  Models.swift
//  TestStripe
//
//  Created by Saifullah on 26/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import Foundation


public struct SFCardInfo {
    let token : String
    let last4Digits : String
    let cardBrand :String
    let expireyMonth : String
    let expireyYear : String

    init(token:String,last4Digits:String,cardBrand:String,expMonth:String,expYear:String) {
        self.token = token
        self.last4Digits = last4Digits
        self.cardBrand = cardBrand
        self.expireyMonth = expMonth
        self.expireyYear = expYear
    }
    
}
