//
//  JSBridge+Common.swift
//  FJKit
//
//  Created by ios on 2018/9/6.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import WebKit

public enum Common: String {
    case back = "back"
    func fetchData() {
        switch self {
        case .back:
            WKWebView().js.back()
        }
    }
    
}

public extension JSExtension where Base: WKWebView {
    public func back() {
        print("back")
    }
}
