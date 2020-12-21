//
//  HuePicker.swift
//  ColourPicker
//
//  Created by Max Bucknell on 15/12/20.
//

import UIKit

class HuePickerView: UIControl {
    var trackSize: CGFloat = 30 {
        didSet {
            self.gradient?.trackSize = self.trackSize
        }
    }
    
    var thumbSize: CGFloat = 60 {
        didSet {
            self.gradient?.thumbSize = self.thumbSize
            self.thumb?.thumbSize = self.thumbSize
        }
    }
    
    var gradient: HueGradientLayer!
    var thumb: ThumbLayer!
    
    var panHandler: UIPanGestureRecognizer!
    
    private(set) var hue: CGFloat = 0 {
        didSet {
            self.positionThumb()
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
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    private func setupView() {
        self.gradient = HueGradientLayer()
        self.thumb = ThumbLayer()
        
        self.layer.insertSublayer(self.gradient.layer, at: 1)
        self.layer.insertSublayer(self.thumb.layer, at: 2)
        
        self.panHandler = UIPanGestureRecognizer()
        self.panHandler.maximumNumberOfTouches = 1
        self.panHandler.minimumNumberOfTouches = 1
        self.panHandler.addTarget(self, action: #selector(wasDragged(_:)))
        
        self.addGestureRecognizer(self.panHandler)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2

        self.gradient.handleResizeWithViewFrame(self.frame)
        self.thumb.handleResizeWithViewFrame(self.frame)
        
        self.positionThumb()
    }
    
    func positionThumb() {
        let angle = (2 * CGFloat.pi * self.hue) - (CGFloat.pi / 2)
        let radius = (self.frame.width - self.thumbSize) / 2
        let translation = CGVector(r: radius, θ: angle)
        
        let frame = CGRect(x: ((self.frame.width - self.thumbSize) / 2) + translation.dx,
                           y: ((self.frame.height - self.thumbSize) / 2) + translation.dy,
                           width: self.thumbSize,
                           height: self.thumbSize)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.thumb.layer.frame = frame
        self.thumb.layer.backgroundColor = UIColor(hue: self.hue, saturation: 1, brightness: 1, alpha: 1).cgColor
        
        CATransaction.commit()
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
            let lowerBound = self.frame.width / 2 - self.thumbSize
            
            if vector.r < lowerBound {
                sender.state = .cancelled
                return
            }
        }
        
        self.hue = (vector.θ + (CGFloat.pi / 2)) / (CGFloat.pi * 2)
    }
}
