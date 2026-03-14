//
//  SettingsViewController.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation
import UIKit

public enum Directions {
    case Right
    case Left
    case Top
    case Bottom
}

extension UIView {
    
    @discardableResult func setGradientColor( direction: Directions, colors: [UIColor], locations: [NSNumber] = [0.0, 1.0], cornerRadius: CGFloat? = nil, layerIdentifier: String = "gradient_layer") -> CAGradientLayer {
        
        if let layerExist = self.layer.sublayers?.first(where: {$0.name == layerIdentifier}) {
            layerExist.removeFromSuperlayer()
        }
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        if let cornerRadius = cornerRadius {
            gradientLayer.cornerRadius = cornerRadius
        }
        
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.locations = locations
        
        let startEndPoint = getDirectionFor(direction: direction)
        gradientLayer.startPoint = startEndPoint.startPoint
        gradientLayer.endPoint = startEndPoint.endPoint
        
        gradientLayer.name = layerIdentifier
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
    private func getDirectionFor(direction: Directions) -> (startPoint: CGPoint, endPoint: CGPoint) {
        var startPoint = CGPoint(x: 0.0, y: 0.5)
        var endPoint = CGPoint(x: 1.0, y: 0.5)
        switch direction {
        case Directions.Right:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case Directions.Left:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
            
        case Directions.Bottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case Directions.Top:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
        }
        return (startPoint, endPoint)
    }
}

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
         return T(nibName: String(describing: self), bundle: nil)
    }
}
