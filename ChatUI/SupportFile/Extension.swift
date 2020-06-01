//
//  Extension.swift
//  ChatUI
//
//  Created by Anand Khanpara on 01/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor:UIColor {
        get {
            return self.borderColor
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
}


extension UIViewController {
    
    func loadNibNamed(fileName name:String) -> Any {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as Any
    }
}
