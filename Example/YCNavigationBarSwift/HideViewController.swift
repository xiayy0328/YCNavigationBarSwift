//
//  HideViewController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xiayingying on 2019/11/9.
//  Copyright © 2019 Codyy.YY. All rights reserved.
//

import UIKit
import YCNavigationBarSwift

class HideViewController: UIViewController {
    
    lazy var customNav: UIView = {
        let customNav = UIView()
        customNav.backgroundColor = .yellow
        return customNav
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.purple
        return contentView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "whiteBack"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    let statuBarHeight = UIApplication.shared.statusBarFrame.height

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 260)
        view.addSubview(contentView)
        view.backgroundColor = UIColor.white
        
        contentView.addSubview(backButton)
        backButton.frame = CGRect(x: 0, y: statuBarHeight, width: 40, height: 40)
    }
    

    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
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

extension HideViewController {
    
    override var yc_navigationBarBackgroundColor: UIColor? {
        return UIColor.clear
    }
    
    override var yc_tintColor: UIColor? {
        return UIColor.clear
    }
}
