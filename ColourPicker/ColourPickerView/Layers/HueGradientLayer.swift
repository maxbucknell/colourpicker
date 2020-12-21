//
//  ColourPickerLayers.swift
//  ColourPicker
//
//  Created by Max Bucknell on 19/12/20.
//

import UIKit

struct HueGradientLayer: SubLayer {
    var trackSize: CGFloat = 30
    var thumbSize: CGFloat = 60
    
    let layer: CALayer
    let fillLayer: CALayer
    
    init() {
        self.layer = CAGradientLayer()
        
        if let l = self.layer as? CAGradientLayer {
            l.type = .conic
            
            l.startPoint = CGPoint(x: 0.5, y: 0.5)
            l.endPoint = CGPoint(x: 0.5, y: 0)
            
            l.colors = [
                CGColor(red: 1, green: 0, blue: 0, alpha: 1),
                CGColor(red: 1, green: 1, blue: 0, alpha: 1),
                CGColor(red: 0, green: 1, blue: 0, alpha: 1),
                CGColor(red: 0, green: 1, blue: 1, alpha: 1),
                CGColor(red: 0, green: 0, blue: 1, alpha: 1),
                CGColor(red: 1, green: 0, blue: 1, alpha: 1),
                CGColor(red: 1, green: 0, blue: 0, alpha: 1),
            ]
        }
        
        self.fillLayer = CALayer()
        self.fillLayer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.layer.insertSublayer(self.fillLayer, at: 0)
    }
    
    func handleResizeWithViewFrame(_ f: CGRect) {
        let diff = (self.thumbSize - self.trackSize) / 2
        
        self.layer.frame = CGRect(x: diff,
                                  y: diff,
                                  width: f.width - diff * 2,
                                  height: f.height - diff * 2)
        
        self.layer.cornerRadius = self.layer.frame.width / 2
        
        self.fillLayer.frame = CGRect(x: self.trackSize,
                                      y: self.trackSize,
                                      width: f.width - (diff + self.trackSize) * 2,
                                      height: f.height - (diff + self.trackSize) * 2)

        self.fillLayer.cornerRadius = self.fillLayer.frame.width / 2
    }
}
