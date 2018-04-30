//
//  WTIndexHomeTopView.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

class WTIndexHomeTopView: UICollectionReusableView {
    fileprivate lazy var todayBtn: UIButton = {
        let todayBtn = UIButton(type: .custom)
        todayBtn.setTitle("今天V", for: .normal)
        todayBtn.setTitleColor(UIColor.hexStringColor(hex: "#ffffff"), for: .normal)
        todayBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        todayBtn.backgroundColor = UIColor.hexStringColor(hex: "#ffffff", alpha: 0.2)
        return todayBtn
    }()
    fileprivate lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        timeBtn.setTitle("2018.4.26-2018.4.26∨", for: .normal)
        timeBtn.setTitleColor(UIColor.hexStringColor(hex: "#ffffff"), for: .normal)
        timeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        timeBtn.backgroundColor = UIColor.hexStringColor(hex: "#ffffff", alpha: 0.2)
        return timeBtn
    }()
    fileprivate lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hex: "#F8BE19")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.cornerRadius = 5;
        view.layer.shadowOffset =  CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.3;
        view.layer.shadowColor =  UIColor.hexStringColor(hex: "#F8BE19").cgColor
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_ui()
        setLayer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - 初始化UI
extension WTIndexHomeTopView {
    
    /// 设置渐变色
    func setLayer() {
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.hexStringColor(hex: "#18ceb4", alpha: 1)
        let buttomColor = UIColor.hexStringColor(hex: "#f2f3f7", alpha: 1)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.3, 0.95]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 10)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    /// 初始化UI
    func setup_ui() {
        backgroundColor = UIColor.hexStringColor(hex: "#f2f3f7")
        addSubview(todayBtn)
        todayBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(30)
            make.height.equalTo(16)
            make.width.equalTo(40)
        }
        todayBtn.layer.masksToBounds = true
        todayBtn.layer.cornerRadius = 8
        todayBtn.layer.borderColor = UIColor.hexStringColor(hex: "#ffffff").cgColor
        todayBtn.layer.borderWidth = 1

        addSubview(timeBtn)
        timeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(todayBtn.snp.right).offset(10)
            make.centerY.equalTo(todayBtn.snp.centerY)
            make.height.equalTo(16)
            make.width.equalTo(140)
        }
        timeBtn.layer.masksToBounds = true
        timeBtn.layer.cornerRadius = 8
        timeBtn.layer.borderColor = UIColor.hexStringColor(hex: "#ffffff").cgColor
        timeBtn.layer.borderWidth = 1

        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(60)
            make.bottom.equalTo(-10)
        }
    }
}
