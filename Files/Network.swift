//
//  Network.swift
//  TestStripe
//
//  Created by Saifullah on 26/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit
protocol ParamConveritible:Encodable{

}
extension ParamConveritible {
    func params()->[String:Any]?
    {
        let data = try? JSONEncoder().encode(self)
        
        let text = String(data: data ?? Data(), encoding: .utf8)
        if let data = text?.data(using: .utf8) {
            do {
                
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
}
//MARK:- NetWork Request

//MARK:- Create Bank Account  Token
struct CreateBankTokenRequest: ParamConveritible{
    let country :String?
    let currency : String?
    let bankAccount : String?
    let routingNumber : String?
    init(bankAccount:String?,routingNumber:String?) {
        self.country = "US"
        self.bankAccount = bankAccount
        self.routingNumber = routingNumber
        self.currency = "usd"
    }
    enum CodingKeys: String, CodingKey {
        case country = "bank_account[country]"
        case bankAccount = "bank_account[account_number]"
        case routingNumber = "bank_account[routing_number]"
        case currency = "bank_account[currency]"
    }
}

//MARK:- Create Customer card Token
struct CardToken:ParamConveritible {
    let cNumber : String?
    let cExpMonth : String?
    let cExpYear : String?
    let cCvc : String?
    init(cardNum:String?,cardExpMonth:String?,cardExpYear:String?,cardCvc:String?) {
        self.cNumber = cardNum
        self.cExpMonth = cardExpMonth
        self.cExpYear = cardExpYear
        self.cCvc = cardCvc
    }
    enum CodingKeys: String, CodingKey {
        case cNumber = "card[number]"
        case cExpMonth = "card[exp_month]"
        case cExpYear = "card[exp_year]"
        case cCvc  = "card[cvc]"
    }
}





class NetWorkConstant {
 
    
    
}
class SFNetwork  {
    
    enum PaymentSDKType: CustomStringConvertible {
        case stripe
        var description: String {
            switch self {
            case .stripe:
                return "https://api.stripe.com/v1/tokens"
            }
        }
        
    }

    class func generateToken<Resp>(type sdk:PaymentSDKType,req:[String:Any],completion:@escaping (Resp?,String?)->Void) where Resp : Codable  {
        guard let url = URL(string: sdk.description) else {
           return
       }

      /* let jsonData = try! JSONEncoder().encode(req)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print("json string is \(jsonString)")*/
        //let jsonData = try? JSONSerialization.data(withJSONObject: req,options: .fragmentsAllowed)
        let jsonString = req.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        
    //let parameters = "bank_account%5Bcountry%5D=US&bank_account%5Bcurrency%5D=usd&bank_account%5Baccount_holder_name%5D=Jenny%20Rosen&bank_account%5Baccount_holder_type%5D=individual&bank_account%5Brouting_number%5D=110000000&bank_account%5Baccount_number%5D=000123456789"
    //let postData =  parameters.data(using: .utf8)
    
       var request : URLRequest = URLRequest(url: url)
       request.httpMethod = "POST"
         request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
       request.setValue("Bearer pk_test_J1qoKzc5TfTY7DxzZemAgJuj0063HLXlTt", forHTTPHeaderField:"Authorization");
       //request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
       request.httpBody = jsonData

        
    

       let config = URLSessionConfiguration.default
       let session = URLSession(configuration: config)
       // vs let session = URLSession.shared
         // make the request
       let task = session.dataTask(with: request, completionHandler: {
           (data, response, error) in
        
    
            if let error = error
           {
               print(error)
            completion(nil,"error")
           }
            else if let response = response {
               print("here is  resposne \(response)")

           }else if let data = data
            {
               print("here in data")
               print(data)
           }

           DispatchQueue.main.async { // Correct

               guard let responseData = data else {
                   print("Error: did not receive data")
                   return
               }

               let decoder = JSONDecoder()
            completion(try? decoder.decode(Resp.self, from: responseData),nil)
                 //  let todo = try decoder.decode(T.self, from: responseData)
                 //  NSAssertionHandler(.success(todo))
           }
       })
       task.resume()
        
    }
 
    
    
    
    
}
