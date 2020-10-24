//
//  SF+SFAccountVC.swift
//  EasyPaymentKit
//
//  Created by Saifullah on 29/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit
 public  class SFAccountVC: UIViewController {
    
   @IBOutlet private  var accountNumber: UITextField?
    @IBOutlet private  var accountHolderName : UITextField?
    
   // @IBOutlet private  var expireyDateTF: UITextField?
    
    @IBOutlet private  var routingNumber: UITextField?
    
    
    @IBOutlet private var positiveActionBtn: UIButton?
    
    @IBOutlet private var negetiveActionBtn: UIButton?
    
    private  var fieldStackView = UIStackView()
   public weak var delegate : SFPaymentInfoAble?
    public var theme = SFTheme()
    
    public var isPlaceHolderImageEnabled = true
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.accountNumber?.delegate = self
        self.accountHolderName?.delegate = self
        self.routingNumber?.delegate = self
        self.accountNumber?.addLine(position: .bottom, color: .gray, width: 1)
        self.accountHolderName?.addLine(position: .bottom, color: .gray, width: 1)
        self.routingNumber?.addLine(position: .bottom, color: .gray, width: 1)
        //MARk:- Set Place Holder
        self.accountHolderName?.placeholder = "Account Holder Name e.g JOHN"
        self.accountNumber?.placeholder = "Account Number e.g 0123456789"
        self.routingNumber?.placeholder = "Routing Nummber e.g 123"
        self.accountHolderName?.isHidden = !(theme.isCardNameFieldVisible)
        self.positiveActionBtn?.backgroundColor = theme.postiveActionBackColor
        self.negetiveActionBtn?.backgroundColor = theme.negitiveActionBackColor
        self.positiveActionBtn?.setTitleColor(theme.buttontitleColor, for: .normal)
        
        self.negetiveActionBtn?.setTitleColor(theme.buttontitleColor, for: .normal)
        self.positiveActionBtn?.setTitle(theme.postiveActionButtonTitle, for: .normal)
        self.negetiveActionBtn?.setTitle(theme.negetiveActionButtonTitle, for: .normal)
        
        self.positiveActionBtn?.isUserInteractionEnabled = false
        self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95

        //self.view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }

    
    public init() {
        super.init(nibName: nil, bundle: nil)
        if theme.SFControllerPresentation == SFControllerPresentation.bottomSheet{
            self.modalPresentationStyle = .overCurrentContext
        }
        else if theme.SFControllerPresentation == SFControllerPresentation.full{
        self.modalPresentationStyle = .fullScreen
        }
        else if theme.SFControllerPresentation == SFControllerPresentation.popupCenter{
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    public override func loadView() {
        
        self.view = UIView()
        if theme.SFControllerPresentation == SFControllerPresentation.bottomSheet{
            self.view.backgroundColor = .clear
        }
        else if theme.SFControllerPresentation == SFControllerPresentation.full{
          self.view.backgroundColor = .white
        }
        else if theme.SFControllerPresentation == SFControllerPresentation.popupCenter{
                 self.view.backgroundColor = .clear
               }
       //
        setUpView()
       
    }

    
    private func setUpView() {
        
        let viewTopMargin = self.navigationController != nil ? (self.navigationController?.navigationBar.frame.height ?? 0.0) + 10 : 0
       
        let SFFieldsInputView = UIView()
        SFFieldsInputView.backgroundColor = .white
        self.view.addSubview(SFFieldsInputView)
        
        //MARK:- Add fields to inputView
        SFFieldsInputView.addSubview(fieldStackView)
        //self.view.addSubview(fieldStackView)
        self.modalPresentationStyle = .overCurrentContext
        fieldStackView.alignment = .fill
        fieldStackView.spacing = 20
        fieldStackView.distribution = .fillEqually
        fieldStackView.axis = .vertical
        //fieldStackView.backgroundColor = .green
        SFFieldsInputView.translatesAutoresizingMaskIntoConstraints = false
        SFFieldsInputView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: theme.SFControllerPresentation == SFControllerPresentation.popupCenter ? 20 : 0).isActive = true
        SFFieldsInputView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: theme.SFControllerPresentation == SFControllerPresentation.popupCenter ? -20 : 0).isActive = true
        
        if theme.SFControllerPresentation == .full {
        SFFieldsInputView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: viewTopMargin).isActive = true
        }
        else if theme.SFControllerPresentation == .bottomSheet {
          SFFieldsInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        }
        else if theme.SFControllerPresentation == .popupCenter {
            SFFieldsInputView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            SFFieldsInputView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
            
               }
        //MARK:- Input stackViewConstarint
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.leftAnchor.constraint(equalTo: SFFieldsInputView.leftAnchor, constant: 20).isActive = true
               fieldStackView.rightAnchor.constraint(equalTo: SFFieldsInputView.rightAnchor, constant: -20).isActive = true
        fieldStackView.topAnchor.constraint(equalTo: SFFieldsInputView.topAnchor, constant: 40).isActive = true
        fieldStackView.bottomAnchor.constraint(equalTo: SFFieldsInputView.bottomAnchor, constant: -40).isActive = true
        
        if theme.isCardNameFieldVisible == true {
            
            accountHolderName = UITextField()
            fieldStackView.addArrangedSubview(accountHolderName!)
        }
        accountNumber = UITextField()
        
        fieldStackView.addArrangedSubview(accountNumber!)
        
        routingNumber = UITextField()
        fieldStackView.addArrangedSubview(routingNumber!)
        
        //MARK:- If Negetive Action Button visible then add in Horizontal Stack
        if theme.isNegetiveButtonVisible  == true {
          
            let buttonStack  = UIStackView()
            buttonStack.alignment = .fill
            buttonStack.axis = .horizontal
            buttonStack.distribution = .fillEqually
            buttonStack.spacing = 50
            negetiveActionBtn = UIButton()
            negetiveActionBtn?.addTarget(self, action: #selector(negetiveAction), for: .touchUpInside)
            buttonStack.addArrangedSubview(negetiveActionBtn!)
            positiveActionBtn = UIButton()
            positiveActionBtn?.addTarget(self, action: #selector(positiveAction), for: .touchUpInside)
            buttonStack.addArrangedSubview(positiveActionBtn!)
            fieldStackView.addArrangedSubview(buttonStack)
        }
        else {
            positiveActionBtn = UIButton()
            positiveActionBtn?.addTarget(self, action: #selector(positiveAction), for: .touchUpInside)
            fieldStackView.addArrangedSubview(positiveActionBtn!)
        }
        
      
        self.view.layoutIfNeeded()
    }
    
    @objc func positiveAction() {
        
        self.positiveActionBtn?.isUserInteractionEnabled = false
          self.positiveActionBtn?.addLoader()
        /*guard let month = self.expireyDateTF?.text?.split(separator: "/")[0],let year = self.expireyDateTF?.text?.split(separator: "/")[1] else{return}*/
      //  SFNetwork.generateToken(type: .stripe, req: CardToken.init(cardNum: self.accountNumber?.text, cardExpMonth:"\(month)", cardExpYear: "\(year)", cardCvc: self.routingNumber?.text).params() ?? [:], completion:handleCreditCardResponse(cardInfo:error:))
    }
    
func handleCreditCardResponse(cardInfo:StripeCardResponse?, error:String?) {
    guard error == nil else{
        delegate?.didErrorWhileGeneratingToken(reason: error ?? "")
        positiveActionBtn?.isUserInteractionEnabled = true
           positiveActionBtn?.removeLoader()
      return
    }
    guard let token = cardInfo?.card?.id ,let last4Digits = cardInfo?.card?.last4 ,let brand = cardInfo?.card?.brand ,let expMonth = cardInfo?.card?.expMonth , let expYear = cardInfo?.card?.expYear else {return}
    
    delegate?.didCardCreated(with: SFCardInfo.init(token: token, last4Digits: last4Digits, cardBrand: brand, expMonth: expMonth.description, expYear: expYear.description))
    positiveActionBtn?.removeLoader()
    if self.isModal {
            self.dismiss(animated: true, completion: nil)
           }
           else {
               self.navigationController?.popViewController(animated: true)
           }
    
    }
    
    @objc func negetiveAction() {
        if self.isModal {
         self.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        
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
extension SFAccountVC :UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard (textField.text?.replacingOccurrences(of: " ", with: "").count) != nil else {return}
        
        guard !(self.accountNumber?.text?.isEmpty ?? false) && !(self.routingNumber?.text?.isEmpty ?? false) else {
            self.positiveActionBtn?.isUserInteractionEnabled = false
            self.positiveActionBtn?.alpha = self.positiveActionBtn?.isUserInteractionEnabled == true ? 1.0 : 0.95
            return
        }
        let brand = Helper.single.cardValidator.type(from: self.accountNumber?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        let isValid = Helper.single.cardValidator.validate(string: self.accountNumber?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
        
        if isValid {
            var cardFieldCount = 0
            switch brand?.name {
            case SFCardType.visa.description:
                cardFieldCount = SFCardType.visa.digits
            default:
                break
            }
            
           guard self.accountNumber?.text?.replacingOccurrences(of: " ", with: "").count == cardFieldCount && self.routingNumber?.text?.count == 3  else{
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
        if textField == self.accountNumber {
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
        else if textField == accountHolderName {
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
        else if textField == routingNumber {
         
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
