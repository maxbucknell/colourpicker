//
//  CGVector.swift
//  ColourPicker
//
//  Created by Max Bucknell on 17/12/20.
//

import Foundation
import CoreGraphics

extension CGVector {
    var r: CGFloat {
        return sqrt(self.dx * self.dx + self.dy * self.dy)
    }
    
    var θ: CGFloat {
        switch (self.dx, self.dy) {
        case (0, 0):
            return 0
        case (0, let y) where y < 0:
            return (3/2) * CGFloat.pi
        case (0, let y) where y > 0:
            return CGFloat.pi / 2
        case (let x, 0) where x < 0:
            return CGFloat.pi
        case (let x, 0) where x > 0:
            return 0
        case (let x, let y) where x > 0 && y > 0:
            return atan(y / x)
        case (let x, let y) where x < 0 && y > 0:
            return (CGFloat.pi / 2) + atan(-x / y)
        case (let x, let y) where x < 0 && y < 0:
            return CGFloat.pi + atan(-y / -x)
        case (let x, let y) where x > 0 && y < 0:
            return (3/2) * CGFloat.pi + atan(x / -y)
        default:
            fatalError("Unexpected vector")
        }
    }
    
    init(r: CGFloat, θ: CGFloat) {
        let dx = r * cos(θ)
        let dy = r * sin(θ)

        self.init(dx: dx, dy: dy)
    }
    
    init(between from: CGPoint, and to: CGPoint) {
        self.init(dx: to.x - from.x, dy: to.y - from.y)
    }
}
