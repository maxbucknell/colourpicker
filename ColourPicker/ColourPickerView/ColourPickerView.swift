//
//  ColourPickerView.swift
//  ColourPicker
//
//  Created by Max Bucknell on 19/12/20.
//

import UIKit

@IBDesignable
class ColourPickerView: UIControl {
    @IBInspectable
    var trackSize: CGFloat = 30 {
        didSet {
            self.huePickerView?.trackSize = self.trackSize
        }
    }
    
    @IBInspectable
    var thumbSize: CGFloat = 60 {
        didSet {
            self.huePickerView?.thumbSize = self.thumbSize
            self.saturationBrightnessPickerView?.thumbSize = self.thumbSize
            
            for c in self.variableConstraints ?? [] {
                c.constant = -1 * self.thumbSize - 10
            }
            
            self.layoutIfNeeded()
        }
    }
    
    private var huePickerView: HuePickerView!
    private var saturationBrightnessPickerView: SaturationBrightnessPickerView!
    private var variableConstraints: [NSLayoutConstraint]!
    
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
    
    @objc func hueChanged(_ sender: Any) {
        self.saturationBrightnessPickerView.hue = self.huePickerView.hue
    }
    
    private func setupView() {
        self.huePickerView = HuePickerView()
        self.huePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.huePickerView)
        self.huePickerView.addTarget(self, action: #selector(self.hueChanged(_:)), for: .valueChanged)
        
        self.saturationBrightnessPickerView = SaturationBrightnessPickerView()
        self.saturationBrightnessPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.saturationBrightnessPickerView)
        
        let fixedConstraints = [
            // Fill the view with the Hue Picker
            self.widthAnchor.constraint(equalTo: self.huePickerView.widthAnchor),
            self.heightAnchor.constraint(equalTo: self.huePickerView.heightAnchor),
            self.centerXAnchor.constraint(equalTo: self.huePickerView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: self.huePickerView.centerYAnchor),
            self.centerXAnchor.constraint(equalTo: self.saturationBrightnessPickerView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: self.saturationBrightnessPickerView.centerYAnchor)
        ]
        
        self.variableConstraints = [
            self.saturationBrightnessPickerView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                       multiplier: CGFloat(2.0.squareRoot() / 2),
                                                                       constant: -1 * self.thumbSize - 10),
            self.saturationBrightnessPickerView.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                                        multiplier: CGFloat(2.0.squareRoot() / 2),
                                                                        constant: -1 * self.thumbSize - 10)
        ]
        
        NSLayoutConstraint.activate(fixedConstraints)
        NSLayoutConstraint.activate(self.variableConstraints)
        
        self.saturationBrightnessPickerView.hue = self.huePickerView.hue
    }
}
