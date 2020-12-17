//
//  CGRect.swift
//  ColourPicker
//
//  Created by Max Bucknell on 17/12/20.
//

import CoreGraphics

extension CGRect {
    public func translate(by vector: CGVector) -> CGRect {
        return CGRect(x: self.minX + vector.dx,
                      y: self.minY + vector.dy,
                      width: self.width,
                      height: self.height)
    }
}
