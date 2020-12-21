//
//  CGFloat.swift
//  ColourPicker
//
//  Created by Max Bucknell on 21/12/20.
//

import UIKit

extension CGFloat {
    func boundBetween(_ lowerBound: CGFloat, and upperBound: CGFloat) -> CGFloat {
        if (self < lowerBound) {
            return lowerBound
        }
        
        if (self > upperBound) {
            return upperBound
        }
        
        return self
    }
}
