//
//  PaymentViewController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/2/24.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 67.0/255, green: 144.0/255, blue: 87.0/255, alpha: 1.0)
        navigationItem.title = "收付款"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - YCNavigationBarSwift
    override var yc_navigationBarBackgroundColor: UIColor? {
        return UIColor(red: 67.0/255, green: 144.0/255, blue: 87.0/255, alpha: 1.0)
    }
    
    override var yc_barTintColor: UIColor? {
        return UIColor.white
    }
    
    override var yc_titleTextAttributes: [NSAttributedString.Key : Any]? {
        return [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
