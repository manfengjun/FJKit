//
//  ParentViewController.swift
//  FJKit
//
//  Created by jun on 2017/7/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

/// 无参数回调
typealias NoParamsClosure = ()->()

/// 一个参数回调
typealias OneParamsClosure = (_ value:AnyObject)->()

class ParentViewController: UIViewController {

    var ResultNoClosure: NoParamsClosure?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func callBackNo(_ finished: @escaping NoParamsClosure) {
        ResultNoClosure = finished
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
