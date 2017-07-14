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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

