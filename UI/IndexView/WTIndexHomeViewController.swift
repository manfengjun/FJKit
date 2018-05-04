//
//  WTIndexHomeViewController.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import ObjectMapper
class WTIndexHomeViewController: BaseViewController {
    var nav_alpha:CGFloat = 0
    var dataArray:[WTIndexHomeModel] = []
    /// 首页按钮列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = SBCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.01
        layout.minimumInteritemSpacing = 0.01
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#f2f3f7")
        collectionView.register(WTIndexHomeMenuCVCell.classForCoder(), forCellWithReuseIdentifier: WTIndexHomeMenuCVCell.cellIdentifier)
        collectionView.register(WTIndexHomeMenuHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WTIndexHomeMenuHeaderView.cellIdentifier)
        collectionView.register(WTIndexHomeTopView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WTIndexHomeTopView.cellIdentifier)

        // 从顶部滚动
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        return collectionView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 导航栏透明
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(color: UIColor.hexStringColor(hex: "#18ceb4", alpha: nav_alpha)), for: UIBarPosition.any, barMetrics: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 导航栏恢复
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(color: UIColor.hexStringColor(hex: "#18ceb4", alpha: 1)), for: UIBarPosition.any, barMetrics: .default)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        loadData()

    }
    func loadData() {
        let path = Bundle.main.path(forResource:"content", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let json:Any = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
            let array = json as! [[String:Any]]
            for item in array {
                let model = Mapper<WTIndexHomeModel>().map(JSON: item)
                self.dataArray.append(model!)

            }
            self.collectionView.reloadData()
        }catch{
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UICollectionViewDelegate
extension WTIndexHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return (dataArray[section - 1].list?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTIndexHomeMenuCVCell.cellIdentifier, for: indexPath) as! WTIndexHomeMenuCVCell
        let model = dataArray[indexPath.section - 1].list![indexPath.row]
        cell.model = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/4 - 0.01, height: UIScreen.main.bounds.size.width/4)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let topView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WTIndexHomeTopView.cellIdentifier, for: indexPath) as! WTIndexHomeTopView
                reusableView = topView
            }
            else
            {
                let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WTIndexHomeMenuHeaderView.cellIdentifier, for: indexPath) as! WTIndexHomeMenuHeaderView
                headView.title = dataArray[indexPath.section - 1].title!
                reusableView = headView
            }
        }
        return reusableView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 218)
        }
        return CGSize(width: UIScreen.main.bounds.size.width, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if #available(iOS 11.0, *) {
            if elementKind == UICollectionElementKindSectionHeader {
                view.layer.zPosition = 0
            }
        }
    }
}
extension WTIndexHomeViewController:SBCollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    /// 设置分区颜色
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - collectionViewLayout:
    ///   - section:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    /// 导航栏动态变色
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let progress = scrollView.contentOffset.y/50
//        progress = progress < 0 ? 1 : progress
//        progress = progress > 1 ? 1 : progress
        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(color: UIColor.hexStringColor(hex: "#18ceb4", alpha: progress)), for: UIBarPosition.any, barMetrics: .default)
        nav_alpha = progress
    }
}

