//
//  NormalViewController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xiayingying on 2019/11/9.
//  Copyright © 2019 Codyy.YY. All rights reserved.
//

import UIKit
import YCNavigationBarSwift

class NormalViewController: UIViewController {

    var demoTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = demoTitle
        view.backgroundColor = UIColor.white
        yc_barBackgroundColor = UIColor.orange
        yc_barTitleColor = UIColor.white
        yc_barTintColor = UIColor.white
        yc_barStyle = .black
        yc_barGestureBackBlock = { [weak self] in
            guard let `self` = self else { return }
            print("do something you like")
            self.showAlert()
        }
        yc_barPopBackBlock = {[weak self] in
            guard let `self` = self else { return }
            print("do something you like")
            self.showAlert()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func showAlert() {
        let alertViewController = UIAlertController(title: "操作尚未完成，是否取消操作？", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确定", style: .destructive) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(confirmAction)
        present(alertViewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
