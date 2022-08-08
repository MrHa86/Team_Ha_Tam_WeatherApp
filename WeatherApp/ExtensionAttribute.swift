//
//  Extension.swift
//  Note App
//
//  Created by Vu Nam Ha on 19/07/2022.
//

import UIKit


extension UIView {
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    public func animateIn() {
        guard isHidden else { return }
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    public func animateOut() {
        guard !isHidden else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.isHidden = finished
        }
    }
    
    public func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    class public func fromNib<T: UIView>() -> T {
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else {
            return T()
        }
        return view
    }
    
    public func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    public func circle() {
        layoutIfNeeded()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func layerGradient(colors: [CGColor]) {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint.init(x: 0, y: 0)
        layer.colors = colors
        self.layer.insertSublayer(layer, at: 0)
    }
//    
//    public func makeSnapshot() -> UIImage? {
//        if #available(iOS 10.0, *) {
//            let renderer = UIGraphicsImageRenderer(size: frame.size)
//            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
//        } else {
//            return layer.makeSnapshot()
//        }
//    }
}
