//
//  RootViewController.swift
//  FJKit
//
//  Created by JUN on 2018/3/27.
//  Copyright © 2018年 JUN. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 120, height: 40)
        button.addTarget(self, action: #selector(pushAction(_:)), for: .touchUpInside)
        button.setTitle("跳转", for: .normal)
        button.backgroundColor = UIColor.orange
        view.addSubview(button)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func pushAction(_ sender:UIButton) {
        let navAnimationVC = NavAnimationFirstViewController()
        self.navigationController?.pushViewController(navAnimationVC, animated: true)
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
