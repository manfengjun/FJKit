//
//  RootViewController.swift
//  FJKit
//
//  Created by JUN on 2018/3/27.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    fileprivate lazy var filterView:JJFilterView = {
        let filterView = JJFilterView(50)
        return filterView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterView.dataArray = [JJFilterModel(1, "测试1"),JJFilterModel(2, "测试2"),JJFilterModel(3, "测试3")]
        self.filterView.show()
    }
    @IBAction func btnClicked(_ sender: UIButton) {
        
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
extension RootViewController{
    
}
