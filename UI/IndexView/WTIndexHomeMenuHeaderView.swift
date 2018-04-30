//
//  WTIndexHomeMenuHeaderView.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

class WTIndexHomeMenuHeaderView: UICollectionReusableView {
    
    /// 设置数据
    open var title:String = "标题" {
        didSet {
            titleL.text = title
        }
    }
    /// 标题
    fileprivate lazy var titleL: UILabel = {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 14)
        titleL.textColor = UIColor.hexStringColor(hex: "#312c29")
        titleL.backgroundColor = UIColor.clear
        titleL.textAlignment = .left
        titleL.text = title
        return titleL
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_ui()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - 初始化UI
extension WTIndexHomeMenuHeaderView {
    /// 初始化UI
    func setup_ui() {
        addSubview(titleL)
        titleL.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.height.equalTo(16)
            make.bottom.equalTo(-5)
            make.right.equalTo(-15)
        }
    }
    
}
