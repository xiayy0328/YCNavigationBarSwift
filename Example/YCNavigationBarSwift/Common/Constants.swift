//
//  Constants.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/2/24.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

struct Constants {
    
    static var iPhoneX: Bool {
        return keyWindowSafeAreaInsets != .zero
    }
    
    static var keyWindowSafeAreaInsets: UIEdgeInsets {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        return keyWindow?.safeAreaInsets ?? .zero
    }
    
    static var statusBarHeight: CGFloat {
        return iPhoneX ? 44.0: 20.0
    }
}
