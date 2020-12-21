//
//  SubLayer.swift
//  ColourPicker
//
//  Created by Max Bucknell on 19/12/20.
//

import UIKit

protocol SubLayer {
    var layer: CALayer { get }
    
    func handleResizeWithViewFrame(_: CGRect) -> Void
}
