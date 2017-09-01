//
//  RoundedCornerView.swift
//  Bout Time
//
//  Created by Alex Koumparos on 01/09/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import UIKit

class RoundedCornerView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 16.0
        self.clipsToBounds = true
    }

}
