//
//  UINavigationController+YCNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2021/10/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// 关联对象的keys
    private struct AssociatedKeys {
        static var gestureDelegate = "gestureDelegate"
        static var fullscreenPopGestureDelegate = "fullscreenPopGestureDelegate"
        static var fullscreenPopGestureRecognizer = "fullscreenPopGestureRecognizer"
        static var enableSYNavigationBar = "enableSYNavigationBar"
    }
    
    /// 关联gestureDelegate
    private var yc_gestureDelegate: SYNavigationGestureRecognizerDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.gestureDelegate) as? SYNavigationGestureRecognizerDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.gestureDelegate, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 关联fullscreenPopGestureDelegate
    private var yc_fullscreenPopGestureDelegate: SYFullscreenPopGestureRecognizerDelegate {
        if let delegate = objc_getAssociatedObject(self, &AssociatedKeys.fullscreenPopGestureDelegate) as? SYFullscreenPopGestureRecognizerDelegate {
            return delegate
        }
        let delegate = SYFullscreenPopGestureRecognizerDelegate(navigationController: self)
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.fullscreenPopGestureDelegate,
                                 delegate,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return delegate
    }
    
    /// 关联fullscreenPopGestureRecognizer
    open var yc_fullscreenPopGestureRecognizer: UIPanGestureRecognizer {
        if let fullscreenPopGR = objc_getAssociatedObject(self, &AssociatedKeys.fullscreenPopGestureRecognizer) as? UIPanGestureRecognizer {
            return fullscreenPopGR
        }
        let fullscreenPopGestureRecognizer = UIPanGestureRecognizer()
        fullscreenPopGestureRecognizer.maximumNumberOfTouches = 1
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.fullscreenPopGestureRecognizer,
                                 fullscreenPopGestureRecognizer,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return fullscreenPopGestureRecognizer
    }
    
    /// 关联enableSYNavigationBar
    @objc open var yc_enableYCNavigationBar: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.enableSYNavigationBar) as? Bool) ?? true
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.enableSYNavigationBar, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// UINavigationController swizzleMethod
    static let swizzleUINavigationControllerOnce: Void = {
        let cls = UINavigationController.self
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UINavigationController.pushViewController(_:animated:)), #selector(UINavigationController.yc_pushViewController(_:animated:)))
        YCNavigationBarUtility.swizzleMethod(cls, #selector(UINavigationController.setViewControllers(_:animated:)), #selector(UINavigationController.yc_setViewControllers(_:animated:)))
    }()
    
    /// 配置NavigationBar
    func configureNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        yc_gestureDelegate = SYNavigationGestureRecognizerDelegate(navigationController: self)
        interactivePopGestureRecognizer?.delegate = yc_gestureDelegate
    }
    
    /// 自定义实现pushViewController
    @objc private func yc_pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 防止VC重复Push
        guard !viewControllers.contains(viewController) else {
            return
        }
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let backButtonItem: UIBarButtonItem
            if let customView = viewController.yc_backButtonCustomView {
                backButtonItem = UIBarButtonItem(customView: customView)
                let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonClicked))
                customView.isUserInteractionEnabled = true
                customView.addGestureRecognizer(tap)
            } else {
                let backImage = viewController.yc_backImage
                backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
            }
            viewController.navigationItem.leftBarButtonItem = backButtonItem
        }
        
        if viewController.yc_fullScreenInteractivePopEnabled {
            addCustomFullscreenPopGesture()
        }
        
        yc_pushViewController(viewController, animated: animated)
    }
    
    /// 自定义实现setViewControllers
    @objc private func yc_setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if viewControllers.count > 1 {
            for (index, viewController) in viewControllers.enumerated() {
                if index != 0 {
                    viewController.hidesBottomBarWhenPushed = true
                    
                    let backButtonItem: UIBarButtonItem
                    if let customView = viewController.yc_backButtonCustomView {
                        backButtonItem = UIBarButtonItem(customView: customView)
                        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonClicked))
                        customView.isUserInteractionEnabled = true
                        customView.addGestureRecognizer(tap)
                    } else {
                        let backImage = viewController.yc_backImage
                        backButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonClicked))
                    }
                    viewController.navigationItem.leftBarButtonItem = backButtonItem
                }
                
                if viewController.yc_fullScreenInteractivePopEnabled {
                    addCustomFullscreenPopGesture()
                }
            }
        }
        
        yc_setViewControllers(viewControllers, animated: animated)
        
    }
    
    /// 添加自定义全屏返回手势
    private func addCustomFullscreenPopGesture() {
        guard let gestureRecognizers = interactivePopGestureRecognizer?.view?.gestureRecognizers else {
            return
        }
        if !gestureRecognizers.contains(yc_fullscreenPopGestureRecognizer),
            let targets = interactivePopGestureRecognizer?.value(forKey: "targets") as? NSArray,
            let internalTarget = (targets.firstObject as? NSObject)?.value(forKey: "target") {
            let internalAction = NSSelectorFromString("handleNavigationTransition:")
            yc_fullscreenPopGestureRecognizer.delegate = yc_fullscreenPopGestureDelegate
            yc_fullscreenPopGestureRecognizer.addTarget(internalTarget, action: internalAction)
            interactivePopGestureRecognizer?.isEnabled = false
            interactivePopGestureRecognizer?.view?.addGestureRecognizer(yc_fullscreenPopGestureRecognizer)
        }
    }
    
    /// 返回按钮事件
    @objc private func backButtonClicked() {
        topViewController?.yc_backButtonClicked()
    }
    
}


// MARK: - fileprivate

/// 导航栏默认手势代理对象
fileprivate class SYNavigationGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    
    fileprivate weak var navigationController: UINavigationController?
    
    fileprivate init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController else {
            return true
        }
        if let topViewController = navigationController.viewControllers.last {
            if topViewController.yc_disableInteractivePopGesture {
                return false
            }
        }
        return true
    }
}


/// 自定义全屏返回手势代理对象
fileprivate class SYFullscreenPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    
    fileprivate weak var navigationController: UINavigationController?
    
    fileprivate init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController,
              let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        
        if navigationController.viewControllers.count <= 1 {
            return false
        }
        
        if let topViewController = navigationController.viewControllers.last {
            if !topViewController.yc_fullScreenInteractivePopEnabled {
                return false
            }
        }
        
        if let topViewController = navigationController.viewControllers.last {
            let beganPoint = gestureRecognizer.location(in: gestureRecognizer.view)
            let maxAllowedDistance = topViewController.yc_fullScreenPopMaxAllowedDistanceToLeftEdge
            if maxAllowedDistance > 0 && beganPoint.x > maxAllowedDistance {
                return false
            }
        }

        let isTransitioning = navigationController.value(forKey: "_isTransitioning") as? Bool ?? false
        if isTransitioning {
            return false
        }

        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        let multiplier: CGFloat = isLeftToRight ? 1: -1
        if translation.x * multiplier <= 0 {
            return false
        }
        return true
    }
}
