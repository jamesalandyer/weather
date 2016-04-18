//
//  CAGradientLayer.swift
//  weather
//
//  Created by James Dyer on 4/16/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func blueColor() -> CAGradientLayer {
        
        let topColor = UIColor(red: 128/255.0, green: 195/255.0, blue: 243/255.0, alpha: 1)
        let bottomColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}
