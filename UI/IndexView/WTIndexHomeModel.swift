//
//  WTIndexHomeModel.swift
//  FJKit
//
//  Created by ios on 2018/4/30.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import ObjectMapper
class WTIndexHomeModel: Mappable {
    var title: String?
    var list: [WTImageButtonModel]?
    func mapping(map: Map) {

        title         <-        map["title"]
        list        <-        map["list"]
        
    }
    required init?(map: Map) {
        
    }
}
class WTImageButtonModel: Mappable {
    var title: String?
    var pic: String?
    
    func mapping(map: Map) {
        title        <-        map["title"]
        pic          <-        map["pic"]
        
    }
    required init?(map: Map) {
        
    }
    
}
