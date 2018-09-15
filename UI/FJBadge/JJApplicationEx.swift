//
//  JJApplicationEx.swift
//  FJKit
//
//  Created by ios on 2018/9/15.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

class JJApplicationEx: NSObject {

}
public extension Extension where Base: UIApplication {
    
    /// 获取单例 delegate
    public static var appDelegate: UIApplicationDelegate { return UIApplication.shared.delegate! }
    
    /// 获取当前 UIViewController
    public static var currentVC: UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        if top?.presentedViewController != nil {
            top = top?.presentedViewController
        } else if top?.isKind(of: UITabBarController.classForCoder()) == true {
            top = (top as! UITabBarController).selectedViewController
            if (top?.isKind(of: UINavigationController.classForCoder()) == true) && (top as! UINavigationController).topViewController != nil {
                top = (top as! UINavigationController).topViewController
            }
        } else if (top?.isKind(of: UINavigationController.classForCoder()) == true) && (top as! UINavigationController).topViewController != nil {
            top = (top as! UINavigationController).topViewController
        }
        return top
    }
    
    // 获取当前 UINavigationController
    public static var currentNC: UINavigationController? {
        
        if let current = currentVC {
            
            return current.navigationController
        }
        
        return nil
    }
    
    // 获取当前 UITabBarController
    public static var currentTBC: UITabBarController? {
        if let top = UIApplication.shared.keyWindow?.rootViewController, top.isKind(of: UITabBarController.classForCoder()) == true {
            return (top as! UITabBarController)
        }
        return nil
    }
    
    /// 获取应用名称
    public static var appName: String {
        if let name = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
            return name
        }
        return Bundle.main.infoDictionary!["CFBundleName"] as? String ?? ""
    }
    
    /// 获取应用唯一标识
    public static var appIdentifier: String { return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String }
    
    /// 获取应用内部版本号
    public static var appBuild: String { return Bundle.main.infoDictionary!["CFBundleVersion"] as! String }
    
    /// 获取应用外部版本号
    public static var appVersion: String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String }
}
