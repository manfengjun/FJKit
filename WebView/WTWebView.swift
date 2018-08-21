
//
//  WTWebView.swift
//  WTDistributorVersion
//
//  Created by ios on 2018/6/4.
//  Copyright © 2018年 ios. All rights reserved.
//

import UIKit
import WebKit
/// 注册JS&Swift 交互对象名称
let handle:String = "agent"
class WTWebView: NSObject {
    /// 自定义设置
    lazy var webViewConfig:WKWebViewConfiguration = {
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = WKUserContentController()
        webViewConfig.preferences.minimumFontSize = 0.0;
        return webViewConfig
    }()
    /// WKWebView
    lazy var webView:WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: STATUSBAR_HEIGHT, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - STATUSBAR_HEIGHT), configuration: webViewConfig)
        webView.loadHTMLString("", baseURL: nil)
        if #available(iOS 11.0, *){
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        return webView
    }()
    
    static var `default` = WTWebView()
    private override init() {
        
    }
    
    /// 获取WKWebView
    ///
    /// - Parameter target:
    /// - Returns:
    func wkWebView() -> WKWebView {
        webViewConfig.userContentController.removeScriptMessageHandler(forName: handle)
        webView.loadHTMLString("", baseURL: nil)
        return webView
    }
}
extension WKWebView {
    func load(_ filePath:String) {
        if let url = URL(string: filePath) {
            self.load(URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30))
        }
    }
}
