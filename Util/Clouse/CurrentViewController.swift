//
//  CurrentViewController.swift
//  FJKit
//
//  Created by jun on 2017/7/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class CurrentViewController: ParentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pushAction(_ sender: UIButton) {
        performSegue(withIdentifier: "currentToNew", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentToNew" {
            let vc = segue.destination as! NewViewController
            vc.callBackNo({ 
                self.view.backgroundColor = UIColor.red
            })
            
        }
    }
 

}
