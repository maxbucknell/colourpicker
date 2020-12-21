//
//  ThumbLayer.swift
//  ColourPicker
//
//  Created by Max Bucknell on 19/12/20.
//

import UIKit

struct ThumbLayer: SubLayer {
    var thumbSize: CGFloat = 60

    let layer: CALayer
    
    init() {
        self.layer = CALayer()
        
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(gray: 1, alpha: 0.9)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = CGColor(gray: 0, alpha: 0.5)
        self.layer.shadowOpacity = 1
        
        let shine = CAGradientLayer()
        shine.type = .axial
        
        shine.startPoint = CGPoint(x: 0, y: 0)
        shine.endPoint = CGPoint(x: 0.3, y: 1)
        shine.locations = [0.3, 1]
        
        shine.colors = [
            CGColor(red: 1, green: 1, blue: 1, alpha: 0),
            CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        ]
        
        self.layer.insertSublayer(shine, at: 0)
    }
    
    func handleResizeWithViewFrame(_ f: CGRect) {
        self.layer.frame = CGRect(origin: CGPoint.origin(),
                                  size: CGSize(width: self.thumbSize,
                                               height: self.thumbSize))
        
        self.layer.shadowPath = CGPath(ellipseIn: CGRect(origin: CGPoint.origin(),
                                                         size: self.layer.frame.size),
                                       transform: nil)
        
        self.layer.cornerRadius = self.layer.frame.width / 2
        
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                layer.cornerRadius = self.layer.cornerRadius
                layer.frame = CGRect(origin: CGPoint.origin(),
                                     size: self.layer.frame.size)
            }
        }
    }
}
