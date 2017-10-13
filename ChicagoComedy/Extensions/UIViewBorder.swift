//
//  UIViewBorder.swift
//  ChicagoComedy
//
//  Created by ARO on 10/13/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

class UIViewBorder: UIView {
    //@IBInspectable var borderTop: bool = false
    @IBInspectable var borderColor: UIColor? = UIColor.black
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let border = UIView()
        border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: 1)
        border.backgroundColor = borderColor
        self.addSubview(border)
    }
}
