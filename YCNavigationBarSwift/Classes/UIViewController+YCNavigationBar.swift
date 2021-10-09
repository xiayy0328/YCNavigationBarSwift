//
//  UIViewController+YCNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2021/10/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// 关联对象的Keys
    private struct AssociatedKeys {
        static var navigationBar = "navigationBar"
        static var navigationBarBackgroundColor = "navigationBarBackgroundColor"
        static var navigationBarBackgroundImage = "navigationBarBackgroundImage"
        static var barTintColor = "barTintColor"
        static var tintColor = "tintColor"
        static var titleTextAttributes = "titleTextAttributes"
        static var useSystemBlurNavBar = "useSystemBlurNavBar"
        static var shadowImage = "shadowImage"
        static var shadowImageTintColor = "shadowImageTintColor"
        static var backButtonCustomView = "backButtonCustomView"
        static var backImage = "backImage"
        static var disableInteractivePopGesture = "disableInteractivePopGesture"
        static var fullScreenInteractiveEnabled = "fullScreenInteractivePopEnabled"
        static var fullScreenPopMaxAllowedDistanceToLeftEdge = "fullScreenPopMaxAllowedDistanceToLeftEdge"
        static var automaticallyHideSYNavBarInChildViewController = "automaticallyHideSYNavBarInChildViewController"
        static var viewWillDisappear = "viewWillDisappear"
    }
    
    /// 自定义导航栏
    open var yc_navigationBar: YCNavigationBar {
        if let bar = objc_getAssociatedObject(self, &AssociatedKeys.navigationBar) as? YCNavigationBar {
            return bar
        }
        let bar = YCNavigationBar(frame: .zero)
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBar, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    /// 导航栏背景色
    @objc open var yc_navigationBarBackgroundColor: UIColor? {
        if let color = objc_getAssociatedObject(self, &AssociatedKeys.navigationBarBackgroundColor) as? UIColor {
            return color
        }
        let color = YCNavigationBarStyle.backgroundColor
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBarBackgroundColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return color
    }
    
    /// 导航栏背景图片
    @objc open var yc_navigationBarBackgroundImage: UIImage? {
        if let backgroundImage = objc_getAssociatedObject(self, &AssociatedKeys.navigationBarBackgroundImage) as? UIImage {
            return backgroundImage
        }
        let backgroundImage = YCNavigationBarStyle.backgroundImage
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBarBackgroundImage, backgroundImage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return backgroundImage
    }
    
    /// 是否使用系统毛玻璃的导航栏
    @objc open var yc_useSystemBlurNavBar: Bool {
        if let useSystemBlurNavBar = objc_getAssociatedObject(self, &AssociatedKeys.useSystemBlurNavBar) as? Bool {
            return useSystemBlurNavBar
        }
        let useSystemBlurNavBar = false
        objc_setAssociatedObject(self, &AssociatedKeys.useSystemBlurNavBar, useSystemBlurNavBar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return useSystemBlurNavBar
    }
    
    /// 导航栏颜色
    @objc open var yc_barTintColor: UIColor? {
        if let barBarTintColor = objc_getAssociatedObject(self, &AssociatedKeys.barTintColor) as? UIColor {
            return barBarTintColor
        }
        let barBarTintColor: UIColor? = nil
        objc_setAssociatedObject(self, &AssociatedKeys.barTintColor, barBarTintColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return barBarTintColor
    }
    
    /// 导航栏内容颜色
    @objc open var yc_tintColor: UIColor? {
        if let barTintColor = objc_getAssociatedObject(self, &AssociatedKeys.tintColor) as? UIColor {
            return barTintColor
        }
        let barTintColor = YCNavigationBarStyle.tintColor
        objc_setAssociatedObject(self, &AssociatedKeys.tintColor, barTintColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return barTintColor
    }
    
    /// 导航栏标题属性配置
    @objc open var yc_titleTextAttributes: [NSAttributedString.Key: Any]? {
        if let attributes = objc_getAssociatedObject(self, &AssociatedKeys.titleTextAttributes) as? [NSAttributedString.Key: Any] {
            return attributes
        }
        let attributes = YCNavigationBarStyle.titleTextAttributes
        objc_setAssociatedObject(self, &AssociatedKeys.titleTextAttributes, attributes, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return attributes
    }
    
    /// 导航栏阴影图片
    @objc open var yc_shadowImage: UIImage? {
        if let shadowImage = objc_getAssociatedObject(self, &AssociatedKeys.shadowImage) as? UIImage {
            return shadowImage
        }
        let shadowImage = YCNavigationBarStyle.shadowImage
        objc_setAssociatedObject(self, &AssociatedKeys.shadowImage, shadowImage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return shadowImage
    }
    
    /// 导航栏阴影图片颜色
    @objc open var yc_shadowImageTintColor: UIColor? {
        if let shadowImageTintColor = objc_getAssociatedObject(self, &AssociatedKeys.shadowImageTintColor) as? UIColor {
            return shadowImageTintColor
        }
        let shadowImageTintColor: UIColor? = nil
        objc_setAssociatedObject(self, &AssociatedKeys.shadowImageTintColor, shadowImageTintColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return shadowImageTintColor
    }

    /// 导航栏返回按钮图片
    @objc open var yc_backImage: UIImage? {
        if let backImage = objc_getAssociatedObject(self, &AssociatedKeys.backImage) as? UIImage {
            return backImage
        }
        let backImage = YCNavigationBarStyle.backImage
        objc_setAssociatedObject(self, &AssociatedKeys.backImage, backImage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return backImage
    }
    
    /// 自定义导航栏返回视图
    @objc open var yc_backButtonCustomView: UIView? {
        if let backButtonCustomView = objc_getAssociatedObject(self, &AssociatedKeys.backButtonCustomView) as? UIView {
            return backButtonCustomView
        }
        let backButtonCustomView = YCNavigationBarStyle.backButtonCustomView
        objc_setAssociatedObject(self, &AssociatedKeys.backButtonCustomView, backButtonCustomView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return backButtonCustomView
    }
    
    /// 系统默认导航栏Pop返回手势是否可用 yc_disableInteractivePopGesture/yc_fullScreenInteractivePopEnabled只能使用一个
    @objc open var yc_disableInteractivePopGesture: Bool {
        if let disableInteractivePopGesture = objc_getAssociatedObject(self, &AssociatedKeys.disableInteractivePopGesture) as? Bool {
            return disableInteractivePopGesture
        }
        let disableInteractivePopGesture = false
        objc_setAssociatedObject(self, &AssociatedKeys.disableInteractivePopGesture, disableInteractivePopGesture, .OBJC_ASSOCIATION_ASSIGN)
        return disableInteractivePopGesture
    }
    
    /// 导航栏全局返回手势是否可用
    @objc open var yc_fullScreenInteractivePopEnabled: Bool {
        if let fullScreenInteractivePopEnabled = objc_getAssociatedObject(self, &AssociatedKeys.fullScreenInteractiveEnabled) as? Bool {
            return fullScreenInteractivePopEnabled
        }
        let fullScreenInteractivePopEnabled = YCNavigationBarStyle.fullScreenPopGestureEnabled
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.fullScreenInteractiveEnabled,
                                 fullScreenInteractivePopEnabled,
                                 .OBJC_ASSOCIATION_ASSIGN)
        return fullScreenInteractivePopEnabled
    }
    
    /// 导航栏全局返回手势响应的左边距离
    @objc open var yc_fullScreenPopMaxAllowedDistanceToLeftEdge: CGFloat {
        if let fullScreenPopMaxAllowedDistanceToLeftEdge =  objc_getAssociatedObject(self, &AssociatedKeys.fullScreenPopMaxAllowedDistanceToLeftEdge) as? CGFloat {
            return fullScreenPopMaxAllowedDistanceToLeftEdge
        }
        let fullScreenPopMaxAllowedDistanceToLeftEdge = CGFloat(0.0)
        objc_setAssociatedObject(self, &AssociatedKeys.fullScreenPopMaxAllowedDistanceToLeftEdge, fullScreenPopMaxAllowedDistanceToLeftEdge, .OBJC_ASSOCIATION_ASSIGN)
        return fullScreenPopMaxAllowedDistanceToLeftEdge
    }
    
    /// 子视图是否自动隐藏YCNavigationBae(默认True)
    @objc open var yc_automaticallyHideSYNavBarInChildViewController: Bool {
        if let automaticallyHideSYNavBarInChildViewController = objc_getAssociatedObject(self, &AssociatedKeys.automaticallyHideSYNavBarInChildViewController) as? Bool {
            return automaticallyHideSYNavBarInChildViewController
        }
        let automaticallyHideSYNavBarInChildViewController = true
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.automaticallyHideSYNavBarInChildViewController,
                                 automaticallyHideSYNavBarInChildViewController,
                                 .OBJC_ASSOCIATION_ASSIGN)
        return automaticallyHideSYNavBarInChildViewController
    }
}

// MARK: - Private Work
extension UIViewController {
    
    /// UIViewController swizzleMethod
    static let swizzleUIViewControllerOnce: Void = {
        let cls = UIViewController.self
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UIViewController.viewDidLoad), #selector(UIViewController.yc_viewDidLoad))
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UIViewController.viewWillAppear(_:)), #selector(UIViewController.yc_viewWillAppear(_:)))
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UIViewController.viewDidAppear(_:)), #selector(UIViewController.yc_viewDidAppear(_:)))
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UIViewController.viewWillDisappear(_:)), #selector(UIViewController.yc_viewWillDisappear(_:)))
    }()
    
    /// 记录视图是否将要消失
    private var yc_viewWillDisappear: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewWillDisappear) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewWillDisappear, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 视图已经加载
    @objc private func yc_viewDidLoad() {
        if navigationController != nil && navigationController!.yc_enableYCNavigationBar {
            navigationController?.configureNavigationBar()
            /// 配置假的导航栏
            yc_navigationBar.backgroundColor = yc_navigationBarBackgroundColor
            yc_navigationBar.shadowImageView.image = yc_shadowImage
            if let color = yc_shadowImageTintColor {
                yc_navigationBar.shadowImageView.image = YCNavigationBarUtility.imageFrom(color: color)
            }
            yc_navigationBar.backgroundImageView.image = yc_navigationBarBackgroundImage
            yc_navigationBar.frame = CGRect(x: 0,
                                            y: 0,
                                            width: view.bounds.width,
                                            height: YCNavigationBarUtility.navigationBarHeight)
            yc_navigationBar.enableBlurEffect(yc_useSystemBlurNavBar)
            
            /// 处理根视图是UIScrollView的布局问题
            if view is UIScrollView {
                navigationController?.view.insertSubview(yc_navigationBar, at: 1)
            } else {
                view.addSubview(yc_navigationBar)
            }
            
            /// 子控制器自动隐藏yc_navigationBar
            if let parent = parent, !(parent is UINavigationController)  && yc_automaticallyHideSYNavBarInChildViewController {
                yc_navigationBar.isHidden = true
            }
        }
        
        yc_viewDidLoad()
    }
    
    /// 视图将要出现
    @objc private func yc_viewWillAppear(_ animated: Bool) {
        if navigationController != nil && navigationController!.yc_enableYCNavigationBar {
            navigationController?.navigationBar.barTintColor = yc_barTintColor
            navigationController?.navigationBar.tintColor = yc_tintColor
            navigationController?.navigationBar.titleTextAttributes = yc_titleTextAttributes
            view.bringSubviewToFront(yc_navigationBar)
            
            navigationController?.navigationBar.frameDidUpdated = { [weak self] frame in
                guard let self = self else { return }
                /// 避免手势返回，view 布局发生改变
                if self.yc_viewWillDisappear {
                    return
                }
                let newFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height + frame.origin.y)
                self.yc_navigationBar.frame = newFrame
            }
        }
        yc_viewWillDisappear = false
        yc_viewWillAppear(animated)
    }
    
    /// 视图将要消失
    @objc private func yc_viewWillDisappear(_ animated: Bool) {
        yc_viewWillDisappear = true
        yc_viewWillDisappear(animated)
    }
    
    /// 视图已经出现
    @objc private func yc_viewDidAppear(_ animated: Bool) {
        if let navigationController = self.navigationController, navigationController.yc_enableYCNavigationBar {
            let interactivePopGestureRecognizerEnabled = navigationController.viewControllers.count > 1
            navigationController.interactivePopGestureRecognizer?.isEnabled = interactivePopGestureRecognizerEnabled
        }
        yc_viewDidAppear(animated)
    }
    
    /// 返回按钮的点击事件（子类可重写）
    @objc open func yc_backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

