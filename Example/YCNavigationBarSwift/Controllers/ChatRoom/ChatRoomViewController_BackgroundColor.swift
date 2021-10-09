//
//  ChatRoomViewController_BackgroundColor.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/3/3.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class ChatRoomViewController_BackgroundColor: ChatRoomViewController {
    
    override var yc_navigationBarBackgroundColor: UIColor? {
        return .systemRed
    }
    
    override var yc_barTintColor: UIColor? {
        return .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
