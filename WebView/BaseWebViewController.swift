//
//  BaseWebViewController.swift
//  JSSwiftBridge
//
//  Created by JUN on 2018/5/25.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import WebKit
enum StatusColorType{
    case normal//空白
    case main//主色调
}
class BaseWebViewController: UIViewController {
    open var webViewConfig = WTWebView.default.webViewConfig
    open var webView = WTWebView.default.wkWebView()
    var normalHtml:[String] = ["login.html"]
    open lazy var statusView:UIView = {
        let statusView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: STATUSBAR_HEIGHT))
        return statusView
    }()
    
    /// 页面地址
    open var filePath:String = ""
    
    /// 初始化方法
    ///
    /// - Parameter filePath: 页面加载地址
    init(filePath:String) {
        super.init(nibName: nil, bundle: nil)
        self.filePath = filePath
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup_ui()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.webView.loadHTMLString("", baseURL: nil); self.webView.configuration.userContentController.removeScriptMessageHandler(forName: handle)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UI
extension BaseWebViewController {
    /// 自定义UI
    func setup_ui() {
        setttingWebView()
        view.backgroundColor = UIColor.white
        view.addSubview(self.statusView)
        view.addSubview(self.webView)
    }
    func setttingWebView() {
        webViewConfig.userContentController.add(self, name: handle)
        webView.loadFileURL(URL(fileURLWithPath: filePath), allowingReadAccessTo: nil)
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    func updateStatusViewColor(type:StatusColorType) {
        switch type {
        case .main:
            
            UIView.animate(withDuration: 0.045) {
                self.statusView.backgroundColor = UIColor(Hex: "#4898fa")
            }
        case .normal:
            UIView.animate(withDuration: 0.08) {
                self.statusView.backgroundColor = UIColor.white
            }
        }
    }
}
// MARK: - JS & Swift 交互
extension BaseWebViewController:WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    /// 解析方法名
    ///
    /// - Parameter message:
    /// - Returns: String
    func getMethod(message:WKScriptMessage) -> String {
        let dic = message.body as! [String:Any]
        let result = dic["method"] as? String
        return result ?? ""
    }
    
    /// 解析传递的参数
    ///
    /// - Parameter message:
    /// - Returns: Dictionary
    func getParameter(message:WKScriptMessage) -> [Any] {
        let dic = message.body as! [String:Any]
        let result = dic["parameter"] as? [Any]
        return result ?? []
    }
}
extension BaseWebViewController:WKNavigationDelegate {
    /// 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    /// 内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    /// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    /// 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    
    /// 接收到跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    /// 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    /// 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}
extension BaseWebViewController:WKUIDelegate {
    
}
