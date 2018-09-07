//
//  JSBridge+Common.swift
//  FJKit
//
//  Created by ios on 2018/9/6.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import WebKit
public enum Order: String {
    case order = "order"
    func fetchData() {
        switch self {
        case .order:
            WKWebView().js.back()
        }
    }
    
}
public extension JSExtension where Base: WKWebView {
    public func order() {
        print("order")
    }
}
