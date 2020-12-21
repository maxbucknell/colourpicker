//
//  SaturationBrightnessPickerView.swift
//  ColourPicker
//
//  Created by Max Bucknell on 15/12/20.
//

import UIKit

@IBDesignable
class SaturationBrightnessPickerView: UIControl {
    var thumbSize: CGFloat = 60 {
        didSet {
            self.hueLayer?.thumbSize = self.thumbSize
            self.saturationLayer?.thumbSize = self.thumbSize
            self.brightnessLayer?.thumbSize = self.thumbSize
            self.thumbLayer?.thumbSize = self.thumbSize
            
            self.layoutSubviews()
        }
    }
    
    var hueLayer: HueLayer!
    var saturationLayer: SaturationLayer!
    var brightnessLayer: BrightnessLayer!
    var thumbLayer: ThumbLayer!
    
    var panHandler: UIPanGestureRecognizer!
    
    private(set) var saturationAndBrightness: (saturation: CGFloat, brightness: CGFloat) = (1, 1) {
        didSet {
            self.positionThumb()
            self.sendActions(for: .valueChanged)
        }
    }
    
    var hue: CGFloat = 0 {
        didSet {
            self.setBackgroundColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    private func setupView() {
        self.hueLayer = HueLayer()
        self.saturationLayer = SaturationLayer()
        self.brightnessLayer = BrightnessLayer()
        self.thumbLayer = ThumbLayer()
        
        self.layer.insertSublayer(self.hueLayer.layer, at: 1)
        self.layer.insertSublayer(self.saturationLayer.layer, at: 2)
        self.layer.insertSublayer(self.brightnessLayer.layer, at: 3)
        self.layer.insertSublayer(self.thumbLayer.layer, at: 4)
        
        self.panHandler = UIPanGestureRecognizer()
        self.panHandler.maximumNumberOfTouches = 1
        self.panHandler.minimumNumberOfTouches = 1
        self.panHandler.addTarget(self, action: #selector(wasDragged(_:)))
        
        self.addGestureRecognizer(self.panHandler)
    }
    
    override func layoutSubviews() {
        self.hueLayer.handleResizeWithViewFrame(self.frame)
        self.saturationLayer.handleResizeWithViewFrame(self.frame)
        self.brightnessLayer.handleResizeWithViewFrame(self.frame)
        self.thumbLayer.handleResizeWithViewFrame(self.frame)
        self.positionThumb()
    }
    
    func positionThumb() {
        let saturation = self.saturationAndBrightness.saturation
        let brightness = self.saturationAndBrightness.brightness
        
        let x = (self.layer.frame.width - self.thumbSize) * (1 - brightness)
        let y = (self.layer.frame.height - self.thumbSize) * saturation
        
        let frame = CGRect(origin: CGPoint(x: x, y: y),
                           size: self.thumbLayer.layer.frame.size)

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.thumbLayer.layer.frame = frame
        self.thumbLayer.layer.backgroundColor = UIColor(hue: self.hue, saturation: saturation, brightness: brightness, alpha: 1).cgColor
        
        CATransaction.commit()
    }
    
    func setBackgroundColor() {
        self.hueLayer.layer.backgroundColor = UIColor(hue: self.hue, saturation: 1, brightness: 1, alpha: 1).cgColor
        self.thumbLayer.layer.backgroundColor = UIColor(hue: self.hue, saturation: self.saturationAndBrightness.saturation, brightness: self.saturationAndBrightness.brightness, alpha: 1).cgColor
    }
    
    @objc func wasDragged(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .cancelled, .ended, .failed:
            return
        default:
            break
        }
        
        let touchLocation = sender.location(ofTouch: 0, in: self)

        let saturation = ((touchLocation.y - self.thumbSize / 2) / (self.layer.frame.height - self.thumbSize)).boundBetween(0, and: 1)
        let brightness = 1 - ((touchLocation.x - self.thumbSize / 2) / (self.layer.frame.height - self.thumbSize)).boundBetween(0, and: 1)
        
        self.saturationAndBrightness = (saturation: saturation, brightness: brightness)
    }
}
