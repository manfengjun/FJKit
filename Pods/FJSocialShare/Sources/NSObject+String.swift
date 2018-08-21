//
//  NSObject+String.swift
//  CRM
//
//  Created by liyangyang on 2017/6/7.
//  Copyright © 2017年 liyangyang. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var nameOfCalss: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    class var cellIdentifier: String {
        return String(format: "%@_identifier", self.nameOfCalss)
    }
}
