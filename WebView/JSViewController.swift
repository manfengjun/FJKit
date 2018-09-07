//
//  JSViewController.swift
//  FJKit
//
//  Created by ios on 2018/9/7.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit
import WebKit

class JSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let common = Common(rawValue: "back") {
            common.fetchData()
        }
        // Do any additional setup after loading the view.
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
