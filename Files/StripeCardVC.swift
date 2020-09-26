//
//  StripeCardVC.swift
//  TestStripe
//
//  Created by Saifullah on 25/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit


public protocol SFPaymentInfoAble : class{
    func  didCardCreated(with info:SFCardInfo)
    func didBankAccountTokenGenerated()
    func didErrorWhileGeneratingToken()
}

extension SFPaymentInfoAble {
    func didBankAccountTokenGenerated(){
        //MARK:- Default implementation
    }
    func  didCardCreated(with info:SFCardInfo) {
        
    }
}


 public  class StripeCardVC: UIViewController {
    
    
   @IBOutlet private weak var cardNumberTF: UITextField?
    @IBOutlet private weak var cardHolderNameTF : UITextField?
    
    @IBOutlet private weak var expireyDateTF: UITextField?
    
    @IBOutlet private weak var cvcTF: UITextField?
    
    
    @IBOutlet weak var positiveActionBtn: UIButton?
    
    @IBOutlet weak var negetiveActionBtn: UIButton!
    
    
   public weak var delegate : SFPaymentInfoAble?
    
    public var isPlaceHolderImageEnabled = true
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.cardNumberTF?.delegate = self
        self.cardHolderNameTF?.delegate = self
        self.expireyDateTF?.delegate = self
        self.cvcTF?.delegate = self
        self.cardNumberTF?.addLine(position: .bottom, color: .gray, width: 1)
        self.cardHolderNameTF?.addLine(position: .bottom, color: .gray, width: 1)
        self.expireyDateTF?.addLine(position: .bottom, color: .gray, width: 1)
        self.cvcTF?.addLine(position: .bottom, color: .gray, width: 1)
        
        //MARk:- Set Place Holder
        self.cardHolderNameTF?.placeholder = "John"
        self.cardNumberTF?.placeholder = "Card Number"
        self.expireyDateTF?.placeholder = "MM/YY"
        self.cvcTF?.placeholder = "123"
        self.cardHolderNameTF?.isHidden = !(SFConfiguartion.shared.ui.isCardNameFieldVisible)
        self.positiveActionBtn?.backgroundColor = SFConfiguartion.shared.ui.postiveActionBackColor
        self.negetiveActionBtn?.backgroundColor = SFConfiguartion.shared.ui.negitiveActionBackColor
        SFConfiguartion.shared.ui.isNegetiveButtonActionVisible == false ? self.negetiveActionBtn.removeFromSuperview(): print("")
        self.positiveActionBtn?.isUserInteractionEnabled = false
        self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95
        
        //self.view.layoutIfNeeded()
        
        // Do any additional setup after loading the view.
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    public override func loadView() {
        self.modalPresentationStyle = .fullScreen
        let bundle = Bundle(identifier: "com.saifuu.EasyPaymentKit")
        bundle?.loadNibNamed("StripeCardVC", owner: self, options: nil)
       
    }

    
    
    @IBAction func positiveAction(_ sender: Any) {
        
        self.positiveActionBtn?.isUserInteractionEnabled = false
          self.positiveActionBtn?.addLoader()
        guard let month = self.expireyDateTF?.text?.split(separator: "/")[0],let year = self.expireyDateTF?.text?.split(separator: "/")[1] else{return}
        SFNetwork.generateToken(type: .stripe, req: CardToken.init(cardNum: self.cardNumberTF?.text, cardExpMonth:"\(month)", cardExpYear: "\(year)", cardCvc: self.cvcTF?.text).params() ?? [:], completion:handleCreditCardResponse(cardInfo:error:))
    }
    
func handleCreditCardResponse(cardInfo:StripeCardResponse?, error:String?) {
    
    guard let token = cardInfo?.card?.id ,let last4Digits = cardInfo?.card?.last4 ,let brand = cardInfo?.card?.brand ,let expMonth = cardInfo?.card?.expMonth , let expYear = cardInfo?.card?.expYear else {return}
    
    delegate?.didCardCreated(with: SFCardInfo.init(token: token, last4Digits: last4Digits, cardBrand: brand, expMonth: expMonth.description, expYear: expYear.description))
    positiveActionBtn?.isUserInteractionEnabled = true
    positiveActionBtn?.removeLoader()
    
    }
    
    @IBAction func negetiveAction(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StripeCardVC :UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard (textField.text?.replacingOccurrences(of: " ", with: "").count) != nil else {return}
        
        guard !(self.cardNumberTF?.text?.isEmpty ?? false) && !(self.cvcTF?.text?.isEmpty ?? false) && !(self.expireyDateTF?.text?.isEmpty ?? false) else {
            self.positiveActionBtn?.isUserInteractionEnabled = false
            self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95
            return
        }
        let brand = Helper.single.cardValidator.type(from: self.cardNumberTF?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        let isValid = Helper.single.cardValidator.validate(string: self.cardNumberTF?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
        
        if isValid {
            var cardFieldCount = 0
            switch brand?.name {
            case SFCardType.visa.description:
                cardFieldCount = SFCardType.visa.digits
            default:
                break
            }
            
           guard self.cardNumberTF?.text?.replacingOccurrences(of: " ", with: "").count == cardFieldCount && self.cvcTF?.text?.count == 3 && self.expireyDateTF?.text?.count == 5 else{
            self.positiveActionBtn?.isUserInteractionEnabled = false
            self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95
            return
            }
            self.positiveActionBtn?.isUserInteractionEnabled = true
            self.positiveActionBtn?.scaleUpAndDown()
        }
        self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.cardNumberTF {
            guard string.compactMap({ Int(String($0)) }).count ==
                string.count else {
                    return false }

            let text = textField.text ?? ""

            if string.count == 0 {
                textField.text = String(text.dropLast()).chunkFormatted()
            }
            else {
                let newText = String((text + string)
                    .filter({ $0 != " " }).prefix(16))
                textField.text = newText.chunkFormatted()
            }
        }
        else if textField == cardHolderNameTF {
            let characterSet = CharacterSet.letters
            if range.location == 0 && string == " " { // prevent space on first character
                return false
            }

            if textField.text?.last == " " && string == " " { // allowed only single space
                return false
            }

            if string == " " { return true } // now allowing space between name
            
            if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }
            return true
        }
        else if textField == self.expireyDateTF {
  
            guard string.compactMap({ Int(String($0)) }).count ==
                string.count else { return false }

            var text = textField.text ?? ""

            if string.count == 0 {
                textField.text = String(text.dropLast()).chunkFormatted(withChunkSize: 2, withSeparator: "/")
            }
            else {
                if text.count == 0 && string > "1"{
                    text = "0\(text)"
                }
                else if text.count == 2 && string < "2"
                {
                   text = "\(text)2"
                }
                let newText = String((text + string)
                    .filter({ $0 != "/" }).prefix(4))
                textField.text = newText.chunkFormatted(withChunkSize: 2, withSeparator: "/")
            }
           /* print("count is \(textField.text?.count)")
            let text = textField.text ?? ""
            if text.count == 0 && string > "1" {
            textField.text = "0\(string)/"
            return false
            }
            else if text.count == 3 && string > "1"{
            return true
            }
            else if text.count == 4 && string >= "0"{
            return true
            }
            else if text.count == 5 {
                return true
            }
            
            return false*/
        }
        else if textField == cvcTF {
         
            guard string.compactMap({ Int(String($0)) }).count ==
                string.count else { return false }

            let text = textField.text ?? ""

            if string.count == 0 {
                textField.text = String(text.dropLast()).chunkFormatted(withChunkSize: 3, withSeparator: " ")
            }
            else {
    
               let newText = String((text + string)
                    .filter({ $0 != " " }).prefix(3))
               textField.text = newText.chunkFormatted(withChunkSize: 3, withSeparator: " ")
                
                  
            }
        }
        return false
    }
}
