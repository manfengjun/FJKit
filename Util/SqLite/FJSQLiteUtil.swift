
//
//  SQLiteUtil.swift
//  FJKit
//
//  Created by jun on 2017/7/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import SQLite
class FJSQLiteUtil: NSObject {
    fileprivate var db:Connection!
    fileprivate let users = Table("users")
    fileprivate let id = Expression<Int64>("id")
    fileprivate let name = Expression<String>("name")
    fileprivate let email = Expression<String>("email")
    
    override init() {
        super.init()
        createdSqlite3()
    }
    
    /// 创建库创建表
    ///
    /// - Parameter filePath: filePath description
    func createdSqlite3(filePath: String = "/Documents") {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        do {
            db = try Connection(sqlFilePath)
            try db.run(users.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })
        } catch { print(error) }
       
    }
    /// 插入数据
    func insertData(_name: String, _email: String){
        do {
            
            let insert = users.insert(name <- _name, email <- _email)
            try db.run(insert)
        } catch {
            print(error)
        }
    }
    
    /// 读取数据
    func readData() -> [(id: String, name: String, email: String)] {
        var userData = (id: "", name: "", email: "")
        var userDataArr = [userData]
        for user in try! db.prepare(users) {
            userData.id = String(user[id])
            userData.name = user[name]
            userData.email = user[email]
            userDataArr.append(userData)
        }
        return userDataArr
    }
    
    /// 更新数据
    func updateData(userId: Int64, old_name: String, new_name: String) {
        let currUser = users.filter(id == userId)
        do {
            try db.run(currUser.update(name <- name.replace(old_name, with: new_name)))
        } catch {
            print(error)
        }
        
    }
    
    /// 删除数据
    func delData(userId: Int64) {
        let currUser = users.filter(id == userId)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
}
