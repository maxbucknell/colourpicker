//
//  SaturationBrightnessPickerView.swift
//  ColourPicker
//
//  Created by Max Bucknell on 15/12/20.
//

import UIKit

class SaturationBrightnessPickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    public func setHue(_ hue: CGFloat) {
        self.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
    }

    private func setupView() {
        let saturationLayer = CAGradientLayer()
        saturationLayer.type = .axial
        
        saturationLayer.startPoint = CGPoint(x: 0, y: 1)
        saturationLayer.endPoint = CGPoint(x: 0, y: 0)
        saturationLayer.locations = [0, 1]
        
        saturationLayer.colors = [
            CGColor(red: 1, green: 1, blue: 1, alpha: 0),
            CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        
        self.layer.insertSublayer(saturationLayer, at: 2)
        
        let brightnessLayer = CAGradientLayer()
        brightnessLayer.type = .axial
        
        brightnessLayer.startPoint = CGPoint(x: 0, y: 1)
        brightnessLayer.endPoint = CGPoint(x: 1, y: 1)
        brightnessLayer.locations = [0, 1]
        
        brightnessLayer.colors = [
            CGColor(red: 0, green: 0, blue: 0, alpha: 0),
            CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        self.layer.insertSublayer(brightnessLayer, at: 3)
    }
    
    override func layoutSubviews() {
        if let layers = self.layer.sublayers {
            for layer in layers {
                layer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
            }
        }
    }
}
