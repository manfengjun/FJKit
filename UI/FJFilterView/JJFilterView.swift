//
//  JJFilterView.swift
//  FJKit
//
//  Created by ios on 2018/9/15.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import SnapKit
class JJFilterView: UIView {
    private let jj_cellIdentifier: String = "JJFilterTVCellIdentifier"
    let nav_height: CGFloat = UIDevice.jj.xDiagonal() == .inch_5_8 ? 88 : 64
    
    /// 默认选中
    private var selectedIndex:Int = 0
    
    /// 头部偏移
    private var top:CGFloat = 50
    
    /// 当前是否显示
    private var isShow:Bool = false
    /// 数据源
    var dataArray:[JJFilterModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    fileprivate lazy var bgView: UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: nav_height + top, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - nav_height - top))
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bgView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
//        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.bgView.bounds, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(JJFilterTVCell.classForCoder(), forCellReuseIdentifier: jj_cellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        return tableView
    }()
    init(_ top:CGFloat = 50) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - nav_height - top))
        backgroundColor = UIColor.clear
        self.addSubview(tableView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
    }
    
    /// 设置默认选中
    ///
    /// - Parameter index: 行数(从0开始)
    func setDefaultSelected(_ index: Int) {
        if dataArray.count > index {
            selectedIndex = index
            var model = dataArray[index]
            model.isSelected = true
            tableView.reloadData()
        }
    }
    /// 显示
    func show() {
        DispatchQueue.main.async {
            let height: CGFloat = CGFloat(44 * self.dataArray.count)
            let isScreen = height > UIScreen.main.bounds.size.height - self.nav_height - self.top
            self.tableView.jj.height = isScreen ? UIScreen.main.bounds.size.height - self.nav_height - self.top : height
            self.bgView.addSubview(self)
            let vc = UIApplication.jj.currentVC
            vc?.view.addSubview(self.bgView)
            vc?.view.bringSubview(toFront: self.bgView)
            self.tableView.reloadData()
            self.isShow = true
//            self.titleView?.isSelected = true
            
        }
        
    }
    /// 隐藏
    @objc func dismiss() {
        DispatchQueue.main.async {
            self.bgView.removeFromSuperview()
            self.isShow = false
//            self.titleView?.isSelected = false
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension JJFilterView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: jj_cellIdentifier, for: indexPath) as! JJFilterTVCell
        let model = dataArray[indexPath.row]
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row != selectedIndex {
            dataArray[selectedIndex].isSelected = false
            dataArray[indexPath.row].isSelected = true
            selectedIndex = indexPath.row
            tableView.reloadData()
        }
    }
    
}
class JJFilterTVCell: UITableViewCell {
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(displayP3Red: 49/255.0, green: 44/255.0, blue: 41/255.0, alpha: 1.0)
        return titleLabel
    }()
    fileprivate lazy var icon:UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    /// 显示标题
    var model: JJFilterModel? {
        didSet {
            if let title = model?.title {
                titleLabel.text = title
            }
            if let isSelected = model?.isSelected {
                self.highlight = isSelected
            }
        }
    }
    
    /// 选中
    var highlight: Bool = false{
        didSet {
            titleLabel.textColor = highlight ? UIColor(displayP3Red: 72/255.0, green: 152/255.0, blue: 250/255.0, alpha: 1.0) : UIColor(displayP3Red: 49/255.0, green: 44/255.0, blue: 41/255.0, alpha: 1.0)
            icon.image = highlight ? UIImage() : UIImage()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup_ui()
    }
    
    
    /// UI
    func setup_ui() {
        selectionStyle = .none
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(icon.snp.left).offset(-10)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
struct JJFilterModel {
    var id: String?
    var title: String?
    var isSelected: Bool = false
    init<T>(_ id:T, _ title:String) {
        if id is Int {
            self.id = String(id as? Int ?? 0)
        }
        else
        {
            self.id = id as? String
        }
        self.title = title
    }
}

