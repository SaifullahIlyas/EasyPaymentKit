# EasyPaymentKit
### What EasyPaymentKit is?
EasyPaymentKit is a customizable payment Acccept Method comes with pre define UI to accept credit, debit card and  Bank Account.
### How To Use EasyPaymentKit?
  EasyPaymentKit is Availble through cocoapod
  Add pod in pod file by coping following line 
     
     pod 'EasyPaymentKit' 
  Run the following command to use library
    
     pod install
  if your project dont hold pod file then create pod file by pod init
   You can also intregrate manually by adding Source file to your Project
   
 ### Sample Use 
 #### Accept Card
 Add following piece of code in your view controller to show Credit or Debit card View
        
        let viewController = SFCardVC.init()
        viewController.theme.SFControllerPresentation = .full
        viewController.theme.isNegetiveButtonVisible = false
               viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
        
   make your you added you payment gateway public key to add Card by 
   
        SFConfiguartion.shared.publicKey = "YOUR_PUBLIC_KEY"
        
   Conforms your ViewController to <b>SFPaymentInfoAble</b>
   sample methods are 
   
         func didCardCreated(with info: SFCardInfo) {
  
        
        
    }
    
    func didErrorWhileGeneratingToken(reason error: String) {
 
    }
    
        
 #### Sample Accept Card  Screenshots
 
 <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.48.19.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.48.22.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.49.32.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.50.01.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.50.08.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.53.24.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.53.43.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-09-28%20at%2015.54.39.png" width=200>
 
 #### Accept/Add Account 
 Add following piece of code in your view controller to show Credit or Debit card View
 SFConfiguartion.shared.publicKey = "YOUR_PUBLIC_KEY"
  let viewController = SFAccountVC.init()
        viewController.theme.isCardNameFieldVisible = true
        viewController.theme.SFControllerPresentation = .full
        viewController.theme.isNegetiveButtonVisible = false
               viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)

Conforms your ViewController to <b>SFPaymentInfoAble</b>
   sample methods are 
   
        
       func didBankAccountCreated(with token:String){
        
    }
    func didErrorWhileGeneratingToken(reason error: String) {
 
    }
#### Accept/Add Account Screenshots

 <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/easypaymentkit-Account/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-10-24%20at%2023.50.24.png" width=200> <img src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/easypaymentkit-Account/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20Max%20-%202020-10-24%20at%2023.50.44.png" width=200>
