//
//  JJEx.swift
//  FJKit
//
//  Created by JUN on 2018/8/21.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

public struct JSExtension<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
public protocol JSBridgeDelegate {
    func fetchData()
}
extension JSExtension: JSBridgeDelegate {
    public func fetchData() {
        
    }
}

public protocol JSCompatible {
    associatedtype CompatableType
    static var js: JSExtension<CompatableType>.Type { get set }
    var js: JSExtension<CompatableType> { get set}
}

extension JSCompatible {
    public static var js: JSExtension<Self>.Type {
        get {
            return JSExtension<Self>.self
        }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }
    public var js: JSExtension<Self> {
        get {
            return JSExtension(self)
        }
        set {
            
        }
    }
}

extension NSObject : JSCompatible {}
