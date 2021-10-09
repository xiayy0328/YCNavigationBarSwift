//
//  ChatRoomViewController_CustomBackButton.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/3/5.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class ChatRoomViewController_CustomBackButton: ChatRoomViewController {
    
    override var yc_backButtonCustomView: UIView? {
        
        let label = UILabel()
        label.text = "back"
        label.textAlignment = .center
        
        return label
    }
    
    override func yc_backButtonClicked() {
        print("Back button Clicked")
        
        let alert = UIAlertController(title: "Are you sure to exit", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}
