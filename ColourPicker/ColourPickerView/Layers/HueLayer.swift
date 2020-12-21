//
//  HueLayer.swift
//  ColourPicker
//
//  Created by Max Bucknell on 21/12/20.
//

import UIKit

struct HueLayer: SubLayer {
    var thumbSize: CGFloat = 60
    let layer: CALayer
    
    init() {
        self.layer = CALayer()
    }
    
    func handleResizeWithViewFrame(_ f: CGRect) {
        self.layer.frame = CGRect(x: self.thumbSize / 2,
                                  y: self.thumbSize / 2,
                                  width: f.width - self.thumbSize,
                                  height: f.height - self.thumbSize)
    }
}
