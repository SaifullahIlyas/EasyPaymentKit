
import UIKit

enum SFControllerPresentation {
    case full
    case popupCenter
    case bottomSheet
    
}
public class Helper {
    
    
   static let single = Helper()
    let cardValidator  = CreditCardValidator()
}
public class SFConfiguartion  {
   public var publicKey = ""
  public  static let shared = SFConfiguartion()
   public let ui : UserInterface = UserInterface()
}
public struct UserInterface {
    
    var InputFieldHeight : CGFloat =  50;
    var isCardNameFieldVisible = false
    var  textFieldsTint : UIColor = .blue
    var textColor : UIColor = .blue
    var font : UIFont = UIFont.systemFont(ofSize: 14)
   var postiveActionButtonTitle : String = "Add"
   var negetiveActionButtonTitle : String = "Cancel"
    var postiveActionBackColor : UIColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var negitiveActionBackColor : UIColor = .red
    var isNegetiveButtonVisible = false
    var buttontitleColor : UIColor = .white
    var SFControllerPresentation : SFControllerPresentation = .popupCenter
    
}
extension Collection {
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
        withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
    func expDateValidation() {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(self.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(self.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(self) // This is MM/YY Entered by user

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
            } else {
                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                } else {
                   print("Entered Date Is Wrong")
                }
            } else {
                print("Entered Date Is Wrong")
            }
        } else {
           print("Entered Date Is Wrong")
        }

    }
}

extension UITextField {
    static let bottomBorderLayerName = "BOTTOMLayer"
    enum LinePosition {
        case top
        case bottom
    }
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.name = UITextField.bottomBorderLayerName
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        self.layoutIfNeeded()
    }
        func addLine(position: LinePosition, color: UIColor, width: Double) {
            self.borderStyle = .none
            let lineView = UIView()
            lineView.backgroundColor = color
            lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
            self.addSubview(lineView)

            let metrics = ["width" : NSNumber(value: width)]
            let views = ["lineView" : lineView]
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

            switch position {
            case .top:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                break
            case .bottom:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                break
            }
        }
   
    
}

extension UIView{
    
    static let loaderTrackLayerName = "loadertracklayer"
    static let loaderShapeLayerName = "loaderShapeLayerName"
    func addLoader() {
        self.layoutIfNeeded()
        let trackLayer = CAShapeLayer()
        trackLayer.name = UIView.loaderTrackLayerName
        //trackLayer.position = CGPoint(x: self.frame.w - 40 , y: 0)
        //trackLayer.frame = CGRect(x: self.frame.maxX - self.frame.height, y:self.frame.height/2 , width: self.frame.height/2, height: self.frame.height/2)
        trackLayer.frame = CGRect(x: self.bounds.maxX - self.bounds.height/2, y:self.bounds.height/2 , width: self.bounds.height/2, height: self.bounds.height/2)
        
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.lineWidth = 2
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 0.5).cgColor
        trackLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        trackLayer.path = UIBezierPath(arcCenter: .zero, radius: 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = UIView.loaderShapeLayerName
       // shapeLayer.position = CGPoint(x: 50, y: 50)
        shapeLayer.frame =  CGRect(x: self.bounds.maxX - self.bounds.height/2, y:self.bounds.height/2 , width: self.bounds.height/2, height: self.bounds.height/2)
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 246 / 255, green: 250 / 255, blue: 251 / 255, alpha: 0.9).cgColor
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shapeLayer.path = UIBezierPath(arcCenter: .zero, radius: 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
       // shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
        shapeLayer.strokeEnd = 1
         self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
       animation.duration = 2
         animation.autoreverses = true
        animation.repeatCount = .infinity
        let animation1 = CABasicAnimation(keyPath: "strokeEnd")
         animation1.fromValue = 0
         animation1.toValue = 1
        animation1.duration = 2
          animation1.autoreverses = true
         animation1.repeatCount = .infinity
        shapeLayer.add(animation, forKey: "line")
        trackLayer.add(animation1, forKey: "line")
        
    }
    
    func removeLoader() {
        
        for layer in self.layer.sublayers ?? []{
            if layer.name == UIView.loaderTrackLayerName || layer.name == UIView.loaderShapeLayerName {
                layer.removeFromSuperlayer()
            }
        }
        self.layoutIfNeeded()
    }
    
      func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))

        self.layer.add(animation, forKey: "position")
    }
    func scaleUpAndDown(withDuration:Double=0.25,pointx:Double = 0.05 , pointy:Double=0.05) {
         
           UIView.animate(withDuration: withDuration, delay: 0.05, options: .autoreverse, animations: {
               self.transform = CGAffineTransform.init(scaleX: CGFloat(1+pointx), y: CGFloat(1+pointy))
           }, completion: { _ in
               self.transform = CGAffineTransform.identity
           })
       }
}
