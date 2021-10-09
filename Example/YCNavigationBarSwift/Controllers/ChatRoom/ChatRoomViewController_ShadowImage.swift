//
//  ChatRoomViewController_ShadowImage.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/3/3.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class ChatRoomViewController_ShadowImage: ChatRoomViewController {
 
    override var yc_shadowImage: UIImage? {
        return UIImage(named: "icon_shadow")
    }
    
    override var yc_shadowImageTintColor: UIColor? {
        return .red
    }
    
    override var yc_navigationBarBackgroundColor: UIColor? {
        return .secondarySystemBackground
    }
    
}
