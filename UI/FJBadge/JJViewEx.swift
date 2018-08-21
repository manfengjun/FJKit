//
//  JJUIViewEx.swift
//  FJKit
//
//  Created by JUN on 2018/8/21.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

public extension Extension where Base: UIView {
    
    var x: CGFloat {
        
        get { return self.base.frame.origin.x }
        
        set(value) { self.base.frame.origin.x = value }
    }
    
    var y: CGFloat {
        
        get { return self.base.frame.origin.y }
        
        set(value) { self.base.frame.origin.y = value }
    }
    
    var width: CGFloat {
        
        get { return self.base.frame.size.width }
        
        set(value) { self.base.frame.size.width = value }
    }
    
    var height: CGFloat {
        
        get { return self.base.frame.size.height }
        
        set(value) { self.base.frame.size.height = value }
    }
    
    var left: CGFloat {
        
        get { return self.base.frame.origin.x }
        
        set(value) { self.base.frame.origin.x = value }
    }
    
    var right: CGFloat {
        
        get { return self.base.frame.origin.x + self.base.frame.size.width }
        
        set(value) { self.base.frame.origin.x = value - self.base.frame.size.width }
    }
    
    var top: CGFloat {
        
        get { return self.base.frame.origin.y }
        
        set(value) { self.base.frame.origin.y = value }
    }
    
    var bottom: CGFloat {
        
        get { return self.base.frame.origin.y + self.base.frame.size.height }
        
        set(value) { self.base.frame.origin.y = value - self.base.frame.size.height }
    }
    
    var centerX: CGFloat {
        
        get { return self.base.center.x }
        
        set(value) { self.base.center.x = value }
    }
    
    var centerY: CGFloat {
        
        get { return self.base.center.y }
        
        set(value) { self.base.center.y = value }
    }
    
    var origin: CGPoint {
        
        get { return self.base.frame.origin }
        
        set(value) { self.base.frame.origin = value }
    }
    
    var size: CGSize {
        
        get { return self.base.frame.size }
        
        set(value) { self.base.frame.size = value }
    }
    
    func leftOffset(_ to: CGFloat) -> CGFloat {
        
        self.base.frame.origin.x = self.base.frame.origin.x + to
        
        return x
    }
    
    func rightOffset(_ to: CGFloat) -> CGFloat {
        
        self.base.frame.origin.x = self.base.frame.origin.x + self.base.frame.size.width + to
        
        return x
    }
    
    func topOffset(_ to: CGFloat) -> CGFloat {
        
        self.base.frame.origin.y = self.base.frame.origin.y + to
        
        return y
    }
    
    func bottomOffset(_ to: CGFloat) -> CGFloat {
        
        self.base.frame.origin.y = self.base.frame.origin.y + self.base.frame.size.height + to
        
        return y
    }
}
// MARK: - Badge
private var jjBadgeLabel = "jjBadgeLabel"

extension UIView {
    var badgeLabel: JJBadgeLabel {
        get {
            if let aValue = objc_getAssociatedObject(self, &jjBadgeLabel) as? JJBadgeLabel {
                return aValue
            } else {
                let badgeLabel = JJBadgeLabel.default()
                badgeLabel.center = CGPoint(x: self.jj.width, y: 0)
                self.addSubview(badgeLabel)
                self.bringSubview(toFront: badgeLabel)
                self.badgeLabel = badgeLabel
                return badgeLabel
            }
        }
        set {
            objc_setAssociatedObject(self, &jjBadgeLabel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
public extension Extension where Base: UIView {
    
    /// 添加文本内容badge
    ///
    /// - Parameter text: 文本
    public func addBadge(text: String) {
        self.base.badgeLabel.text = text
    }
    /// 添加数字内容badge
    ///
    /// - Parameter text: 数字
    public func addBadge(number: Int) {
        if number <= 0 {
            addBadge(text: "0")
            hiddenBadge()
            return
        }
        if number > 99 {
            addDot()
            return
        }
        addBadge(text: "\(number)")
    }
    
    /// 红点
    ///
    /// - Parameter color: 颜色
    public func addDot(color:UIColor = UIColor.init(red: 1.00, green: 0.17, blue: 0.15, alpha: 1.0)) {
        self.base.badgeLabel.backgroundColor = color
        addBadge(text: "")
        setBadge(height: 8.0)
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
    ///
    /// Set Badge offset, Badge center point defaults to the top right corner of its parent view
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
    public func moveBadge(x: CGFloat, y: CGFloat) {
        
        self.base.badgeLabel.offset = CGPoint(x: x, y: y)
        self.base.badgeLabel.jj.y = -self.base.badgeLabel.jj.height*0.5/*badge的y坐标*/ + y
        
        switch self.base.badgeLabel.flexMode {
        case .left:
            self.base.badgeLabel.jj.right = self.base.badgeLabel.superview!.jj.width + self.base.badgeLabel.jj.height*0.5 + x
        case .right:
            self.base.badgeLabel.jj.x = (self.base.jj.width - self.base.badgeLabel.jj.height*0.5)/*badge的x坐标*/ + x
        case .middle:
            self.base.badgeLabel.center = CGPoint(x: self.base.jj.width+x, y: y)
        case .normal:
            break
        }
    }
    /// 设置Bage的属性
    ///
    /// Set properties for Badge
    ///
    /// - Parameter attributes: 将badgeLabel对象回调出来的闭包
    public func setBadgeLabel(attributes: (JJBadgeLabel)->()) {
        attributes(self.base.badgeLabel)
    }
    /// 设置Badge伸缩的方向
    ///
    /// Setting the direction of Badge expansion
    public func setBadge(flexMode: JJBadgeViewFlexMode = .normal) {
        self.base.badgeLabel.flexMode = flexMode
        self.moveBadge(x: self.base.badgeLabel.offset.x, y: self.base.badgeLabel.offset.y)
    }
    /// 设置Badge高度
    ///
    /// - Parameter height: 高度
    public func setBadge(height: CGFloat) {
        let scale = height / self.base.badgeLabel.jj.height
        self.base.badgeLabel.transform = self.base.badgeLabel.transform.scaledBy(x: scale, y: scale)
    }
    
    /// 显示Badge
    public func showBadge() {
        self.base.badgeLabel.isHidden = false
    }
    
    /// 隐藏Badge
    public func hiddenBadge() {
        self.base.badgeLabel.isHidden = true
    }
    /// badge数字加1
    public func increase() {
        increaseBy(number: 1)
    }
    
    /// badge数字加number
    public func increaseBy(number: Int) {
        let label = self.base.badgeLabel
        let result = (Int(label.text ?? "0") ?? 0) + number
        if result > 0 {
            showBadge()
        }
        label.text = "\(result)"
    }
    
    /// badge数字减1
    public func decrease() {
        decreaseBy(number: 1)
    }
    
    /// badge数字减number
    public func decreaseBy(number: Int) {
        let label = self.base.badgeLabel
        let result = (Int(label.text ?? "0") ?? 0) - number
        if (result <= 0) {
            hiddenBadge()
            label.text = "0"
            return
        }
        label.text = "\(result)"
    }
}

