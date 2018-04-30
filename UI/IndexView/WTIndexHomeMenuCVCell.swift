//
//  WTIndexHomeMenuCVCell.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import SnapKit
extension NSObject
{
    class var nameOfCalss: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    class var cellIdentifier: String {
        return String(format: "%@_identifier", self.nameOfCalss)
    }
}
class WTIndexHomeMenuCVCell: UICollectionViewCell {
    
    var model: WTImageButtonModel?{
        didSet {
            if let text = model?.title {
                wtImageButton.title = text
            }
            if let text = model?.pic {
                wtImageButton.image = UIImage(named: text)
            }
        }
    }
    fileprivate lazy var wtImageButton : WTImageButton = {
        var attribute = WTImageButtonAttribute()
        attribute.font = UIFont.systemFont(ofSize: 12)
        attribute.titleColor = UIColor.hexStringColor(hex: "#312c29")
        let wtImageButton = WTImageButton(attribute: attribute, width: frame.size.width)
        return wtImageButton
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(wtImageButton)
        wtImageButton.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 初始化UI
extension WTIndexHomeMenuCVCell {
    /// 初始化UI
    func setup_ui() {
        
    }
}
