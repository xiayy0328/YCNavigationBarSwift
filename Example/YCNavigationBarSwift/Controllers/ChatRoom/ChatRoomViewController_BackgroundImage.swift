//
//  ChatRoomViewController_BackgroundImage.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/3/3.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class ChatRoomViewController_BackgroundImage: ChatRoomViewController {
    
    override var yc_navigationBarBackgroundImage: UIImage? {
        return UIImage(named: "icon_nav_bg")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
