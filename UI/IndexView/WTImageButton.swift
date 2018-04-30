//
//  WTImageButton.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import SnapKit

/// 配置
struct WTImageButtonAttribute {
    /// 标题字体
    var font = UIFont.systemFont(ofSize: 12)
    /// 标题颜色
    var titleColor = UIColor.black
    /// 文字背景颜色
    var titleBgColor = UIColor.clear
    /// 对齐方式
    var textAlignment: NSTextAlignment = .center
    /// 背景颜色
    var backgroundColor = UIColor.white
    /// 标题高度
    var titleHeight:CGFloat = 15
    /// 顶部间距
    var topPadding:CGFloat = 15
    /// 中间间距
    var centerPadding:CGFloat = 10
    /// 底部间距
    var bottomPadding:CGFloat = 15
}
class WTImageButton: UIView {
    /// 标题
    open var title = "销售订单" {
        didSet {
            self.titleL.text = title
        }
    }
    /// 图标
    open var image = UIImage(named: "index_xsdd.png"){
        didSet {
            self.icon.image = image
        }
    }
    private var attribute: WTImageButtonAttribute = WTImageButtonAttribute()
    private var width: CGFloat = UIScreen.main.bounds.size.width/4
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView(image: image)
        return icon
    }()
    
    fileprivate lazy var titleL: UILabel = {
        let titleL = UILabel()
        titleL.text = title
        titleL.font = attribute.font
        titleL.textColor = attribute.titleColor
        titleL.backgroundColor = attribute.titleBgColor
        titleL.textAlignment = attribute.textAlignment
        return titleL
    }()
    init(attribute: WTImageButtonAttribute, width: CGFloat) {
        self.attribute = attribute
        self.width = width
        super.init(frame: CGRect(x:0, y:0, width:width, height:width))
        setup_ui()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_ui()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
// MARK: - 初始化UI
extension WTImageButton {
    /// 初始化UI
    func setup_ui() {
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.width.height.equalTo(width - attribute.titleHeight - attribute.topPadding - attribute.centerPadding - attribute.bottomPadding)
            make.top.equalTo(attribute.topPadding)
            make.centerX.equalToSuperview()
            
        }
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(attribute.centerPadding)
            make.height.equalTo(attribute.titleHeight)
        }
        
    }
    
}
