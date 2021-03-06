//
//  PaddingLabel.swift
//  Today
//
//  Created by UetaMasamichi on 2016/01/04.
//  Copyright © 2016年 Masamichi Ueta. All rights reserved.
//

import UIKit

final class PaddingLabel: UILabel {
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
