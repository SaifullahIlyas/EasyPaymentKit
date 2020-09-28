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
 Add following code in your view controller to show Credit or Debit card View
        
        let viewController = SFCardVC.init()
        viewController.theme.SFControllerPresentation = .full
        viewController.theme.isNegetiveButtonVisible = false
               viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
        
   make your you added you payment gateway public key to add Card by 
   
        SFConfiguartion.shared.publicKey = "YOUR_PUBLIC_KEY"
        
 ### Sample Output
 
 

