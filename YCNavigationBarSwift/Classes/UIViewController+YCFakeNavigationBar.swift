//
//  UIViewController+YCFakeNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2020/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// 导航栏返回的回调(手势返回、系统按钮返回)
public typealias YCNavigationBackBlock = () -> Void

// MARK: - AssociatedObjectKeys
fileprivate struct YCNavigationBarKeys {
    static var barStyle             = "YCNavigationBarKeys_barStyle"
    static var barBackgroundColor   = "YCNavigationBarKeys_barBackgroundColor"
    static var barBackgroundImage   = "YCNavigationBarKeys_barBackgroundImage"
    static var barTintColor         = "YCNavigationBarKeys_barTintColor"
    static var barAlpha             = "YCNavigationBarKeys_barAlpha"
    static var barTitleColor        = "YCNavigationBarKeys_barTitleColor"
    static var barTitleFont         = "YCNavigationBarKeys_barTitleFont"
    static var barHidden            = "YCNavigationBarKeys_barHidden"
    static var barShadowHidden      = "YCNavigationBarKeys_barShadowHidden"
    static var barShadowColor       = "YCNavigationBarKeys_barShadowColor"
    static var barEnablePopGesture  = "YCNavigationBarKeys_barEnablePopGesture"
    static var barGestureBackBlock  = "YCNavigationBarKeys_barGestureBackBlock"
    static var barPopBackBlock      = "YCNavigationBarKeys_barPopBackBlock"
}


// MARK: - UIViewController + AssociatedObject
public extension UIViewController {
    
    /// 导航栏样式，默认样式
    var yc_barStyle: UIBarStyle {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barStyle) as? UIBarStyle ?? UINavigationBar.appearance().barStyle
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barStyle, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            yc_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏前景色（item的文字图标颜色），默认黑色
    var yc_barTintColor: UIColor {
        get {
            if let tintColor = objc_getAssociatedObject(self, &YCNavigationBarKeys.barTintColor) as? UIColor {
                return tintColor
            }
            if let tintColor = UINavigationBar.appearance().tintColor {
                return tintColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            yc_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏标题文字颜色，默认黑色
    var yc_barTitleColor: UIColor {
        get {
            if let titleColor = objc_getAssociatedObject(self, &YCNavigationBarKeys.barTitleColor) as? UIColor {
                return titleColor
            }
            
            if let titleColor = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor {
                return titleColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            yc_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏标题文字字体，默认18号粗体
    var yc_barTitleFont: UIFont {
        get {
            if let titleFont = objc_getAssociatedObject(self, &YCNavigationBarKeys.barTitleFont) as? UIFont {
                return titleFont
            }
            if let titleFont = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] as? UIFont {
                return titleFont
            }
            return UIFont.boldSystemFont(ofSize: 18)
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barTitleFont, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            yc_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏背景色，默认白色
    var yc_barBackgroundColor: UIColor {
        get {
            if let backgroundColor = objc_getAssociatedObject(self, &YCNavigationBarKeys.barBackgroundColor) as? UIColor {
                return backgroundColor
            }
            if let backgroundColor = UINavigationBar.appearance().barTintColor {
                return backgroundColor
            }
            return .white
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            yc_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景图片
    var yc_barBackgroundImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barBackgroundImage) as? UIImage ?? UINavigationBar.appearance().backgroundImage(for: .default)
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barBackgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            yc_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景透明度，默认1
    var yc_barAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barAlpha) as? CGFloat ?? 1
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barAlpha, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            yc_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏底部分割线是否隐藏，默认不隐藏 (设置隐藏其他属性设置无效)
    var yc_barShadowHidden: Bool {
        get {

            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barShadowHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barShadowHidden, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            yc_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 导航栏底部分割线颜色
    var yc_barShadowColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barShadowColor) as? UIColor ?? UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barShadowColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            yc_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 是否开启手势返回，默认开启
    var yc_barEnablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barEnablePopGesture) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barEnablePopGesture, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 手势返回的回调
    var yc_barGestureBackBlock: YCNavigationBackBlock? {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barGestureBackBlock) as? YCNavigationBackBlock
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barGestureBackBlock, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    /// 系统默认返回按钮点击的回调
    var yc_barPopBackBlock: YCNavigationBackBlock? {
        get {
            return objc_getAssociatedObject(self, &YCNavigationBarKeys.barPopBackBlock) as? YCNavigationBackBlock
        }
        set {
            objc_setAssociatedObject(self, &YCNavigationBarKeys.barPopBackBlock, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}


// MARK: - 更新视图的方法
extension UIViewController {
    
    /// 整体更新
    func yc_setNeedsNavigationBarUpdate() {
        guard let naviController = navigationController as? YCNavigationController else { return }
        naviController.yc_updateNavigationBar(for: self)
    }
    
    /// 更新文字、title颜色
    func yc_setNeedsNavigationBarTintUpdate() {
        guard let naviController = navigationController as? YCNavigationController else { return }
        naviController.yc_updateNavigationBarTint(for: self)
    }

    /// 更新背景
    func yc_setNeedsNavigationBarBackgroundUpdate() {
        guard let naviController = navigationController as? YCNavigationController else { return }
        naviController.yc_updateNavigationBarBackground(for: self)
    }
    
    /// 更新shadow
    func yc_setNeedsNavigationBarShadowUpdate() {
        guard let naviController = navigationController as? YCNavigationController else { return }
        naviController.yc_updateNavigationBarShadow(for: self)
    }
}
