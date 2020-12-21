//
//  BrightnessLayer.swift
//  ColourPicker
//
//  Created by Max Bucknell on 20/12/20.
//

import UIKit

struct BrightnessLayer: SubLayer {
    var thumbSize: CGFloat = 60
    let layer: CALayer
    
    init() {
        self.layer = CAGradientLayer()
        
        if let l = self.layer as? CAGradientLayer {
            l.type = .axial
            
            l.startPoint = CGPoint(x: 0, y: 1)
            l.endPoint = CGPoint(x: 1, y: 1)
            l.locations = [0, 1]
            
            l.colors = [
                CGColor(red: 0, green: 0, blue: 0, alpha: 0),
                CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            ]
        }
    }
    
    func handleResizeWithViewFrame(_ f: CGRect) {
        self.layer.frame = CGRect(x: self.thumbSize / 2,
                                  y: self.thumbSize / 2,
                                  width: f.width - self.thumbSize,
                                  height: f.height - self.thumbSize)
    }
}

