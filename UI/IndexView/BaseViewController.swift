//
//  BaseViewController.swift
//  WTFoodTrade
//
//  Created by sxq on 2018/2/26.
//  Copyright © 2018年 sxq. All rights reserved.
//

import UIKit
public enum UserType {
    case supplier// 供应商
    case purchasers// 采购商
}


class BaseViewController: UIViewController {
    
    var imageList:[Any] = []
    var moveView:UIView?
    var changeDelegate:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStringColor(hex: "#18ceb4")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
//        self.navigationController?.navigationBar.setBackgroundImage(imageFromColor(color: UIColor.hexStringColor(hex: "#18ceb4")), for: UIBarPosition.any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
    }
    
    open func imageFromColor(color: UIColor) -> UIImage {
        
        let rect: CGRect = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        
        return image!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BaseViewController:UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
}


