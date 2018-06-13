//
//  UIView+Extension.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import Foundation
import UIKit



enum UDLR {
    case UpLeft
    case UpRight
    case DownLeft
    case DownRight
    case Left
    case Right
    case Up
    case Down
    case all
}


extension UIView{

    
    func setLayerForNormal(cornerRadius:CGFloat,linecolorcolor:UIColor?=nil,linewidth:CGFloat?=nil) {
        if linecolorcolor != nil {
            self.layer.borderColor = linecolorcolor!.cgColor
            self.layer.borderWidth = linewidth!
        }
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func setLayer(cornerRadius:CGFloat,linecolorcolor:UIColor?=nil,linewidth:CGFloat?=nil,ReacCorner:UDLR){
        
        if linecolorcolor != nil {
            self.layer.borderColor = linecolorcolor!.cgColor
            self.layer.borderWidth = linewidth!
        }

        self.setLayerForNormal(cornerRadius: cornerRadius, linecolorcolor: linecolorcolor, linewidth: linewidth)
        
//        self.CuttingLayer(cornerRadius: cornerRadius,UDLR: ReacCorner)
        
    }
    
    func CuttingLayer(cornerRadius:CGFloat,UDLR:UDLR)  {
        
        var rectCorner = UIRectCorner.allCorners
        switch UDLR {
        case .UpLeft:
            rectCorner = [.topLeft]
        case .UpRight:
            rectCorner = [.topRight]
        case .DownLeft:
            rectCorner = [.bottomLeft]
        case .DownRight:
            rectCorner = [.bottomRight]
        case .Up:
            rectCorner = [.topLeft , .topRight]
        case .Down:
            rectCorner = [.bottomLeft , .bottomRight]
        case .Right:
            rectCorner = [.topRight , .bottomRight]
        case .Left:
            rectCorner = [.bottomLeft , .topLeft]
        default:
            rectCorner = .allCorners

        }
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let masklayer = CAShapeLayer()
        masklayer.frame =  self.bounds
        masklayer.path = path.cgPath
        self.layer.mask = masklayer
        
        

//        temp.backgroundColor = TINTCOLOR.cgColor

//        let path1 = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
//
//        let mask = CAShapeLayer.init()
//        mask.path = path1.cgPath
//        self.layer.mask = mask
//
//
//        let temp = CALayer.init()
//        temp.frame = CGRect(x: 1, y: 1, width: self.bounds.size.width-2, height: self.bounds.size.height-2)
//        temp.backgroundColor = UIColor.white.cgColor
//
//        let path2 = UIBezierPath(roundedRect: temp.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: cornerRadius-1, height: cornerRadius-1))
//        let mask2 = CAShapeLayer.init(layer: temp)
//        mask2.path = path2.cgPath
//        temp.mask = mask2
//        self.layer.addSublayer(temp)

    }
}

extension UIView{
    
    /// X坐标
    public var c_x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.c_y, width: self.c_w, height: self.c_h)
        }
    }
    
    /// Y坐标
    public var c_y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.c_x, y: value, width: self.c_w, height: self.c_h)
        }
    }
    
    /// width
    public var c_w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.c_x, y: self.c_y, width: value, height: self.c_h)
        }
    }
    
    /// height
    public var c_h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.c_x, y: self.c_y, width: self.c_w, height: value)
        }
    }
    
    public func c_maxX() -> CGFloat{
        guard superview != nil else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return self.c_w
        }
        
        return self.frame.maxX
    }
    
    public var c_Selfcenter:CGPoint{
        get{
            return CGPoint(x: self.c_w/2, y: c_h/2)
        }set(value){
            self.center = value
        }
    }
    
    public func c_maxY() -> CGFloat{
        guard superview != nil else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return self.c_h
        }
        
        return self.frame.maxY
    }

    
    /// EZSE: Centers view in superview horizontally
    public func c_centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.c_x = parentView.c_w/2 - self.c_w/2
    }
    
    /// EZSE: Centers view in superview vertically
    public func c_centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.c_y = parentView.c_h/2 - self.c_h/2
    }
    
    /// EZSE: Centers view in superview horizontally & vertically
    public func c_centerInSuperView() {
        self.c_centerXInSuperView()
        self.c_centerYInSuperView()
    }
    
    public func c_setHeight(height:CGFloat){
        var frame = self.frame
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: height)
        self.frame = frame
    }
    
    public func c_setWidth(Width:CGFloat){
        var frame = self.frame
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: Width, height: frame.height)
        self.frame = frame
    }
}
