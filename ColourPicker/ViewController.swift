//
//  ViewController.swift
//  ColourPicker
//
//  Created by Max Bucknell on 13/12/20.
//

import UIKit
import Metal
import MetalKit

class ViewController: UIViewController {
    var hue: Double = 0
    var saturation: Double = 1
    var lightness: Double = 1
    
    @IBOutlet weak var huePicker: HuePicker!
    @IBOutlet weak var saturationBrightnessPicker: SaturationBrightnessPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.saturationBrightnessPicker.setHue(0.8)
    }
    
    @IBAction func hueChanged(_ sender: Any) {
        self.saturationBrightnessPicker.setHue(self.huePicker.hue)
    }
}

