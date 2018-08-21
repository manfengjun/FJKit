//
//  JJEx.swift
//  FJKit
//
//  Created by JUN on 2018/8/21.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

public struct Extension<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JJCompatible {
    associatedtype CompatableType
    static var jj: Extension<CompatableType>.Type { get set }
    var jj: Extension<CompatableType> { get set}
}

extension JJCompatible {
    public static var jj: Extension<Self>.Type {
        get {
            return Extension<Self>.self
        }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }
    public var jj: Extension<Self> {
        get {
            return Extension(self)
        }
        set {
        
        }
    }
}

extension NSObject : JJCompatible {}
