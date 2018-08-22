//
//  JJTabbarItem.swift
//  FJKit
//
//  Created by JUN on 2018/8/22.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

public extension Extension where Base: UIBarButtonItem {
    /// 添加带文本内容的Badge, 默认右上角, 红色, 18pts
    ///
    /// - Parameter text: 文本字符串
    public func addBadge(text: String) {
        _bottomView.jj.addBadge(text: text)
        _bottomView.jj.moveBadge(x: 4, y: 3)
    }
    
    /// 添加带数字的Badge, 默认右上角,红色,18pts
    ///
    /// - Parameter number: 整形数字
    public func addBadge(number: Int) {
        _bottomView.jj.addBadge(number: number)
        _bottomView.jj.moveBadge(x: 4, y: 3)
    }
    
    /// 添加带颜色的小圆点, 默认右上角, 红色, 8pts
    ///
    /// - Parameter color: 颜色
    public func addDot(color:UIColor = UIColor.init(red: 1.00, green: 0.17, blue: 0.15, alpha: 1.0)) {
        _bottomView.jj.addDot(color: color)
    }
    
    /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
    ///
    /// - Parameters:
    ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
    ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
    public func moveBadge(x: CGFloat, y: CGFloat) {
        _bottomView.jj.moveBadge(x: x, y: y)
    }
    
    /// 设置Badge伸缩的方向
    ///
    /// - Parameter flexMode : Default is JJBadgeViewFlexMode
    public func setBadge(flexMode: JJBadgeViewFlexMode = .normal) {
        _bottomView.jj.setBadge(flexMode: flexMode)
    }
    
    /// 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
    ///
    /// - Parameter height: 高度大小
    public func setBadge(height: CGFloat) {
        _bottomView.jj.setBadge(height: height)
    }
    
    /// 设置Bage的属性
    ///
    /// Set properties for Badge
    ///
    /// - Parameter attributes: 将badgeLabel对象回调出来的闭包
    public func setBadgeLabel(attributes: (JJBadgeLabel)->()) {
        _bottomView.jj.setBadgeLabel(attributes: attributes)
    }
    
    /// 显示Badge
    public func showBadge() {
        _bottomView.jj.showBadge()
    }
    
    /// 隐藏Badge
    public func hiddenBadge() {
        _bottomView.jj.hiddenBadge()
    }
    
    // MARK: - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
    // MARK: - Digital increase /decrease, note: the following method ajjlies only to cases where the Badge content is purely numeric
    /// badge数字加1
    public func increase() {
        _bottomView.jj.increase()
    }
    
    /// badge数字加number
    public func increaseBy(number: Int) {
        _bottomView.jj.increaseBy(number: number)
    }
    
    /// badge数字加1
    public func decrease() {
        _bottomView.jj.decrease()
    }
    
    /// badge数字减number
    public func decreaseBy(number: Int) {
        _bottomView.jj.decreaseBy(number: number)
    }
    
    /// 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图
    private var _bottomView: UIView {
        let navigationButton = (self.base.value(forKey: "_view") as? UIView) ?? UIView()
        let systemVersion = (UIDevice.current.systemVersion as NSString).doubleValue
        let controlName = (systemVersion < 11.0 ? "UIImageView" : "UIButton" )
        for subView in navigationButton.subviews {
            if subView.isKind(of: NSClassFromString(controlName)!) {
                subView.layer.masksToBounds = false
                return subView
            }
        }
        return navigationButton
    }
}
