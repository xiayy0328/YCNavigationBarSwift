//
//  UINavigationBar+YCNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2021/10/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// 定义导航栏尺寸改变的回调
typealias YCNavigationBarFrameDidUpdated = (CGRect) -> Void

extension UINavigationBar {
    
    /// 关联对象Keys
    private struct AssociatedKeys {
        static var frameDidUpdated = "frameDidUpdated"
    }
    
    /// UINavigationBar swizzleMethod
    static let swizzleUINavigationBarOnce: Void = {
        let cls = UINavigationBar.self
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UINavigationBar.layoutSubviews), #selector(UINavigationBar.sy_layoutSubviews))
    }()
    
    /// frame改变的回调
    var frameDidUpdated: YCNavigationBarFrameDidUpdated? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.frameDidUpdated) as? YCNavigationBarFrameDidUpdated
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.frameDidUpdated, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// 加载布局
    @objc private func sy_layoutSubviews() {
        frameDidUpdated?(frame)
        sy_layoutSubviews()
        
        /// UIBarButtonItem 距离屏幕的左右间距
        if YCNavigationBarStyle.itemSpace > 0 {
            for subView in subviews {
                if NSStringFromClass(subView.classForCoder).contains("ContentView") {
                    let space = YCNavigationBarStyle.itemSpace
                    if #available(iOS 13.0, *) {
                        let margins  = subView.layoutMargins
                        var tmpFrame = CGRect(x: 0,
                                           y: margins.top,
                                           width: 0,
                                           height: subView.frame.height)
                        tmpFrame.origin.x   = -margins.left + space
                        tmpFrame.size.width = margins.left + margins.right + subView.frame.width - 2 * space
                        subView.frame       = tmpFrame
                    } else {
                        subView.layoutMargins = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
                    }
                    break
                }
            }
        }
    }
}
