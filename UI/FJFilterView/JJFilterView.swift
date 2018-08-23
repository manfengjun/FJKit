//
//  CRMFilterView.swift
//  WTDistributorVersion
//
//  Created by ios on 2018/7/25.
//  Copyright © 2018年 ios. All rights reserved.
//

import UIKit
import SnapKit
class JJFilterModel {
    var id: Int = 0
    var sn: String?
    var title: String?
    var isSelected: Bool = false
    init(_ id:Int, _ title:String) {
        self.id = id
        self.title = title
    }
}
class JJFilterView: UIView {
    private let jj_cellIdentifier: String = "JJFilterTVCellIdentifier"
    //导航栏高度
    let nav_height: CGFloat = UIDevice.jj.xDiagonal() == .inch_5_8 ? 88 : 64
    typealias CRMFilterSelectedClosure = (Int,String)->()
    var filterClosure:CRMFilterSelectedClosure?
    var dataArray:[JJFilterModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedIndex:IndexPath = IndexPath(row: 0, section: 0)
    var top:CGFloat = 50
    
    var isShow:Bool = false
    fileprivate lazy var bgView: UIView = {
        let bgView = UIView(frame:  CGRect(x: 0, y: nav_height + top, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - nav_height - top))
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
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
        super.init(frame: CGRect(x: 0, y: nav_height + top, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - nav_height - top))
        self.addSubview(tableView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
    }
    /// 显示
    func show() {
        DispatchQueue.main.async {
            let height = 44 * self.dataArray.count
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(height))
            self.tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(height))
            self.bgView.addSubview(self)
            let window = UIWindow.window()
            window.addSubview(self.bgView)
            self.tableView.reloadData()
            self.isShow = true
        }
        
    }
    /// 隐藏
    @objc func dismiss() {
        DispatchQueue.main.async {
            self.isShow = false
            self.removeFromSuperview()
            self.bgView.removeFromSuperview()
        }
    }
    
    /// 清除选择
    func clearSelect() {
        self.selectedIndex = IndexPath(row: 0, section: 0)
        for model in self.dataArray {
            model.isSelected = false
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
        //        weak var weakCell = cell
        cell.selectResult {[weak self] in
            if let indexP = self?.selectedIndex{
                // 清除选中
                let oldModel = self?.dataArray[indexP.row]
                oldModel?.isSelected = false
                self?.tableView.reloadRows(at: [indexP], with: .none)
                // 设置选中状态
                model.isSelected = true
                self?.tableView.reloadRows(at: [indexPath], with: .none)
                self?.selectedIndex = indexPath
                
                if let temSelectClosure = self?.filterClosure {
                    temSelectClosure(model.id, model.title ?? "")
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    /**
     闭包回调
     */
    func selectResult(_ finished: @escaping CRMFilterSelectedClosure) {
        filterClosure = finished
    }
}
class JJFilterTVCell: UITableViewCell {
    typealias CRMFilterSelectClosure = ()->()
    var selectClosure:CRMFilterSelectClosure?
    var model: JJFilterModel?{
        didSet {
            if let title = model?.title {
                titleBtn.setTitle(title, for: .normal)
            }
            if let id = model?.id {
                titleBtn.tag = id
            }
            if let selected = model?.isSelected {
                titleBtn.isSelected = selected
                rightBtn.isSelected = selected
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup_ui()
    }
    fileprivate lazy var titleBtn:UIButton = {
        let titleBtn = UIButton(type: .custom)
        titleBtn.setTitleColor(UIColor(displayP3Red: 44/255.0, green: 49/255.0, blue: 41/255.0, alpha: 1.0), for: .normal)
        titleBtn.setTitleColor(UIColor(displayP3Red: 72/255.0, green: 152/255.0, blue: 250/255.0, alpha: 1.0), for: .selected)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleBtn.contentHorizontalAlignment = .left
        titleBtn.addTarget(self, action: #selector(selectClick(_:)), for: .touchUpInside)
        //        titleBtn.isEnabled = false
        return titleBtn
    }()
    
    fileprivate lazy var rightBtn:UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "crm_selected"), for: .selected)
        //        rightBtn.isEnabled = false
        rightBtn.addTarget(self, action: #selector(selectClick(_:)), for: .touchUpInside)
        //        rightBtn.backgroundColor = UIColor.blue
        return rightBtn
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// 初始化UI
    func setup_ui() {
        self.selectionStyle = .none
        self.contentView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        self.contentView.addSubview(titleBtn)
        titleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(rightBtn.snp.left).offset(-10)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }
    @objc func selectClick(_ sender:UIButton){
        if let temSelectClosure = self.selectClosure {
            temSelectClosure()
        }
    }
    /**
     闭包回调
     */
    func selectResult(_ finished: @escaping CRMFilterSelectClosure) {
        selectClosure = finished
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIWindow
{
    fileprivate static func window() -> UIWindow{
        let window = UIApplication.shared.windows.last!
        if(!window.isHidden){
            return window;
        }
        return (UIApplication.shared.delegate?.window!)!;
    }
}
