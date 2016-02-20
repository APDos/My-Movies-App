//
//  CustomButton.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
    }

}
