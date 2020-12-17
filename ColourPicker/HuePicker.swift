//
//  HuePicker.swift
//  ColourPicker
//
//  Created by Max Bucknell on 15/12/20.
//

import UIKit

class HuePicker: UIControl {
    var gradient: CAGradientLayer!
    var white: CALayer!
    var thumb: CALayer!
    
    var panHandler: UIPanGestureRecognizer!
    
    let inset: CGFloat = 30
    
    private var _hue: CGFloat = 0.5
    
    private(set) var hue: CGFloat{
        get {
            return self._hue
        }
        
        set(newHue) {
            self._hue = newHue
            
            let angle = (2 * CGFloat.pi * newHue) - (CGFloat.pi / 2)
            let radius = (self.frame.width - self.inset) / 2
            let translation = CGVector(r: radius, θ: angle)
            
            let frame = CGRect(x: ((self.frame.width - self.inset - 10) / 2) + translation.dx,
                                y: ((self.frame.height - self.inset - 10) / 2) + translation.dy,
                                width: self.inset + 10,
                                height: self.inset + 10)
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            self.thumb.frame = frame
            self.thumb.backgroundColor = UIColor(hue: self._hue, saturation: 1, brightness: 1, alpha: 1).cgColor
            
            CATransaction.commit()
            
            self.sendActions(for: .valueChanged)
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
    
    private func setupView() {
//        self.layer.actions = ["sublayers": NSNull()]
        self.gradient = CAGradientLayer()
        self.gradient.type = .conic
        
        self.gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.gradient.endPoint = CGPoint(x: 0.5, y: 0)
        
        self.gradient.colors = [
            CGColor(red: 1, green: 0, blue: 0, alpha: 1),
            CGColor(red: 1, green: 1, blue: 0, alpha: 1),
            CGColor(red: 0, green: 1, blue: 0, alpha: 1),
            CGColor(red: 0, green: 1, blue: 1, alpha: 1),
            CGColor(red: 0, green: 0, blue: 1, alpha: 1),
            CGColor(red: 1, green: 0, blue: 1, alpha: 1),
            CGColor(red: 1, green: 0, blue: 0, alpha: 1),
        ]
        
        self.white = CALayer()
        self.white.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.thumb = CALayer()
//        self.thumb.actions = ["content": NSNull()]
        self.thumb.cornerRadius = (self.inset / 2) + 5
        self.thumb.backgroundColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.thumb.borderWidth = 2
        self.thumb.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        
        let shine = CAGradientLayer()
        shine.type = .axial
        
        shine.startPoint = CGPoint(x: 0, y: 0)
        shine.endPoint = CGPoint(x: 0, y: 1)
        shine.locations = [0.3, 1]
        
        shine.colors = [
            CGColor(red: 1, green: 1, blue: 1, alpha: 0),
            CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        ]
        
        self.thumb.insertSublayer(shine, at: 1)
        self.thumb.masksToBounds = true
        
        self.layer.insertSublayer(self.gradient, at: 0)
        self.layer.insertSublayer(self.white, at: 1)
        self.layer.insertSublayer(self.thumb, at: 2)
        
        self.panHandler = UIPanGestureRecognizer()
        self.panHandler.maximumNumberOfTouches = 1
        self.panHandler.minimumNumberOfTouches = 1
        self.panHandler.addTarget(self, action: #selector(wasDragged(_:)))
        
        self.addGestureRecognizer(self.panHandler)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        
        self.gradient.cornerRadius = self.frame.width / 2
        self.gradient.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
        
        self.white.cornerRadius = (self.frame.width / 2) - self.inset
        self.white.frame = CGRect(x: self.inset,
                                  y: self.inset,
                                  width: self.frame.width - self.inset * 2 ,
                                  height: self.frame.height - self.inset * 2)
        
        self.thumb.frame = CGRect(x: (self.frame.width - self.inset - 10) / 2,
                                  y: (self.frame.height - self.inset - 10) / 2,
                                  width: self.inset + 10,
                                  height: self.inset + 10)
        
        if let thumbLayers = self.thumb.sublayers {
            for layer in thumbLayers {
                layer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.thumb.frame.size)
            }
        }
        
        self.hue = self._hue
    }
    
    @objc func wasDragged(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .cancelled, .ended, .failed:
            return
        default:
            break
        }
        
        let touchLocation = sender.location(ofTouch: 0, in: self)
        let origin = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let vector = CGVector(between: origin, and: touchLocation)
        
        if sender.state == .began {
            let upperBound = self.frame.width / 2
            let lowerBound = upperBound - self.inset
            
            if vector.r < lowerBound || vector.r > upperBound {
                sender.state = .cancelled
                return
            }
        }
        
        self.hue = (vector.θ + (CGFloat.pi / 2)) / (CGFloat.pi * 2)
    }
}
