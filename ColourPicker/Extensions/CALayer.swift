//
//  CALayer.swift
//  ColourPicker
//
//  Created by Max Bucknell on 21/12/20.
//

import UIKit

extension CALayer {
    func addDebugBorder() {
        self.borderWidth = 3
        self.borderColor = CGColor(red: 1, green: 0, blue: 1, alpha: 1)
    }
}
