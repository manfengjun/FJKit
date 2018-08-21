//
//  JJUILabelEx.swift
//  FJKit
//
//  Created by JUN on 2018/8/21.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
public extension Extension where Base: UILabel {
    
    /// 计算宽度 calculate width
    ///
    /// - Parameters:
    /// - Returns: CGFloat
    public func calculateWidth() -> CGFloat {
        if self.base.text?.isEmpty == true { return 0.0 }
        var attributes : [NSAttributedStringKey: AnyObject] = [.font : self.base.font]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        let size = CGSize(width: CGFloat(Double.greatestFiniteMagnitude), height: height)
        return ceil((self.base.text! as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes:attributes, context: nil).width)
    }
}
