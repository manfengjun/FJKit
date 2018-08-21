//
//  FJBadgeLabel.swift
//  FJKit
//
//  Created by JUN on 2018/8/21.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
public enum JJBadgeViewFlexMode {
    case left     // 左伸缩 left Flex    : <==●
    case right    // 右伸缩 right Flex    : ●==>
    case middle   // 左右伸缩 middle Flex : <=●=>
    case normal   // 不伸缩 normal Flex  : =●=
}
open class JJBadgeLabel: UILabel {
    /// 记录Badge的偏移量 Record the offset of Badge
    public var offset: CGPoint = CGPoint(x: 0, y: 0)
    
    /// Badge伸缩的方向, Default is FJBadgeViewFlexModeNormal
    public var flexMode: JJBadgeViewFlexMode = .normal
    
    open override var text: String? {
        didSet {
            if flexMode != .normal {
                let string_width = self.jj.calculateWidth()                
                if self.jj.height > string_width + self.jj.height*10/18 {
                    self.frame.size.width = self.jj.height
                    return
                }
                self.frame.size.width = self.jj.height*5/18 + string_width + self.jj.height*5/18
            }
        }
    }
    
    public static func `default`() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup_ui()

    }
    func setup_ui() {
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 11)
        self.textAlignment = NSTextAlignment.center
        self.layer.cornerRadius = self.jj.height * 0.5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.init(red: 1.00, green: 0.17, blue: 0.15, alpha: 1.0)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
