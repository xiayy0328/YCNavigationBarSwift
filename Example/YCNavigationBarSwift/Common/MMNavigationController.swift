//
//  MMNavigationController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xu.shuifeng on 2020/5/20.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit
import YCNavigationBarSwift

class MMNavigationController: UINavigationController {
    
}


extension MMNavigationController {
    
    override var yc_enableYCNavigationBar: Bool {
        get {
            return true
        }
        set {
            super.yc_enableYCNavigationBar = newValue
        }
    }
}
