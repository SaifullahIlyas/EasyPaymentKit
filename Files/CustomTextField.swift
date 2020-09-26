//
//  CustomTextField.swift
//  TestStripe
//
//  Created by Saifullah on 26/09/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let boundsWithClear = super.textRect(forBounds: bounds)
        let delta = CGFloat(1)
        return CGRect(x: boundsWithClear.minX, y: delta, width: boundsWithClear.width, height: boundsWithClear.height - delta/2)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let boundsWithClear = super.editingRect(forBounds: bounds)
        let delta = CGFloat(1)
        return CGRect(x: boundsWithClear.minX, y: delta, width: boundsWithClear.width, height: boundsWithClear.height - delta/2)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let delta = CGFloat(1)
        return CGRect(x: bounds.minX, y: delta, width: bounds.width, height: bounds.height - delta/2)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
