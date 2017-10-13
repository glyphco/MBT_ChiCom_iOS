//
//  UITextViewFixed.swift
//  ChicagoComedy
//
//  Created by ARO on 10/13/17.
//  Copyright © 2017 MBT. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
