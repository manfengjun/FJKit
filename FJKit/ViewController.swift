//
//  ViewController.swift
//  FJKit
//
//  Created by jun on 2017/6/24.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let codeview = FJCodeView(frame: CGRect(x: 80, y: 100, width: 100, height: 30))
        view.addSubview(codeview)
        
        let sqliteContext = FJSQLiteUtil() //如果没有,默认创建数据库及表格
        //插入数据
        sqliteContext.insertData(_name: "username", _email: "email@126.com")
        //读取全部数据
        //要想读取指定数据，可以自己自定义转换成其他模型，比如字典+元组，可以根据id查找
        let dataM = sqliteContext.readData()
        print(dataM)
        //更新数据 1 -> 用户id
        sqliteContext.updateData(userId: 1, old_name: "oldValue", new_name: "newValue")
        //删除数据
        sqliteContext.delData(userId: 1) // 1 -> 用户id
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

