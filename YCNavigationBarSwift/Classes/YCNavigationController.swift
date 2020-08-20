//
//  YCNavigationController.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2020/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// custom navigationController
class YCNavigationController: UINavigationController {

    /// 中间假的导航栏
    private lazy var fakeBar: YCFakeNavigationBar = {
        let fakeBar = YCFakeNavigationBar()
        return fakeBar
    }()
    
    /// 左边假的导航栏
    private lazy var fromFakeBar: YCFakeNavigationBar = {
        let fakeBar = YCFakeNavigationBar()
        return fakeBar
    }()
    
    /// 右边假的导航栏
    private lazy var toFakeBar: YCFakeNavigationBar = {
        let fakeBar = YCFakeNavigationBar()
        return fakeBar
    }()
    
    /// 假的导航栏的父视图
    private var fakeSuperView: UIView? {
        return navigationBar.subviews.first
    }
    
    /// 正在pop的控制器
    private weak var poppingVC: UIViewController?
    
    /// 假的导航栏Frame监听
    private var fakeFrameObserver: NSKeyValueObservation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.addTarget(self, action: #selector(handleinteractivePopGesture(gesture:)))
        setupNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let coordinator = transitionCoordinator {
            guard let fromVC = coordinator.viewController(forKey: .from) else { return }
            if fromVC == poppingVC {
                yc_updateNavigationBar(for: fromVC)
            }
        } else {
            guard let topViewController = topViewController else { return }
            yc_updateNavigationBar(for: topViewController)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutFakeSubviews()
        adjustNavigationBarItemsSpacing()
    }
    
    /// override Push、Pop Method
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard !self.viewControllers.contains(viewController) else {
            return
        }
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        poppingVC = topViewController
        let viewController = super.popViewController(animated: animated)
        if let topViewController = topViewController {
            yc_updateNavigationBarTint(for: topViewController, ignoreTintColor: true)
        }
        return viewController
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        poppingVC = topViewController
        let vcArray = super.popToRootViewController(animated: animated)
        if let topViewController = topViewController {
            yc_updateNavigationBarTint(for: topViewController, ignoreTintColor: true)
        }
        return vcArray
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        poppingVC = topViewController
        let vcArray = super.popToViewController(viewController, animated: animated)
        if let topViewController = topViewController {
            yc_updateNavigationBarTint(for: topViewController, ignoreTintColor: true)
        }
        return vcArray
    }

    /// 平移手势处理
    @objc private func handleinteractivePopGesture(gesture: UIScreenEdgePanGestureRecognizer) {
        guard let coordinator = transitionCoordinator,
            let fromVC = coordinator.viewController(forKey: .from),
            let toVC = coordinator.viewController(forKey: .to) else {
                return
        }
        if gesture.state == .changed {
            navigationBar.tintColor = average(fromColor: fromVC.yc_barTintColor, toColor: toVC.yc_barTintColor, percent: coordinator.percentComplete)
        }
    }

}

// MARK: -  Private
extension YCNavigationController {
    
    private func setupNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        setupFakeSubviews()
    }
    
    private func setupFakeSubviews() {
        guard let fakeSuperView = fakeSuperView else { return }
        if fakeBar.superview == nil {
            fakeFrameObserver = fakeSuperView.observe(\.frame, changeHandler: { [weak self] (obj, changed) in
                guard let `self` = self else { return }
                self.layoutFakeSubviews()
            })
            fakeSuperView.insertSubview(fakeBar, at: 0)
        }
    }
    
    private func layoutFakeSubviews() {
        guard let fakeSuperView = fakeSuperView else { return }
        fakeBar.frame = fakeSuperView.bounds
        fakeBar.setNeedsLayout()
    }
    
    private func showViewController(_ viewController: UIViewController, coordinator: UIViewControllerTransitionCoordinator) {
        guard let fromVC = coordinator.viewController(forKey: .from),
            let toVC = coordinator.viewController(forKey: .to) else {
                return
        }
        resetButtonLabels(in: navigationBar)
        coordinator.animate(alongsideTransition: { (context) in
            self.yc_updateNavigationBarTint(for: viewController, ignoreTintColor: context.isInteractive)
            if viewController == toVC {
                self.showTempFakeBar(fromVC: fromVC, toVC: toVC)
            } else {
                self.yc_updateNavigationBarBackground(for: viewController)
                self.yc_updateNavigationBarShadow(for: viewController)
            }
        }) { (context) in
            if context.isCancelled {
                self.yc_updateNavigationBar(for: fromVC)
            } else {
                self.yc_updateNavigationBar(for: viewController)
            }
            if viewController == toVC {
                self.clearTempFakeBar()
            }
        }
    }
    
    private func showTempFakeBar(fromVC: UIViewController, toVC: UIViewController) {
        UIView.setAnimationsEnabled(false)
        fakeBar.alpha = 0
        /// from
        fromVC.view.addSubview(fromFakeBar)
        fromFakeBar.frame = fakerBarFrame(for: fromVC)
        fromFakeBar.setNeedsLayout()
        fromFakeBar.yc_updateFakeBarBackground(for: fromVC)
        fromFakeBar.yc_updateFakeBarShadow(for: fromVC)
        /// to
        toVC.view.addSubview(toFakeBar)
        toFakeBar.frame = fakerBarFrame(for: toVC)
        toFakeBar.setNeedsLayout()
        toFakeBar.yc_updateFakeBarBackground(for: toVC)
        toFakeBar.yc_updateFakeBarShadow(for: toVC)
        UIView.setAnimationsEnabled(true)
    }
    
    private func clearTempFakeBar() {
        fakeBar.alpha = 1
        fromFakeBar.removeFromSuperview()
        toFakeBar.removeFromSuperview()
    }
    
    private func fakerBarFrame(for viewController: UIViewController) -> CGRect {
        guard let fakeSuperView = fakeSuperView else {
            return navigationBar.frame
        }
        var frame = navigationBar.convert(fakeSuperView.frame, to: viewController.view)
        frame.origin.x = viewController.view.frame.origin.x
        return frame
    }
    
    private func resetButtonLabels(in view: UIView) {
        let viewClassName = view.classForCoder.description().replacingOccurrences(of: "_", with: "")
        if viewClassName == "UIButtonLabel" {
            view.alpha = 1
        } else {
            if view.subviews.count > 0 {
                for subview in view.subviews {
                    resetButtonLabels(in: subview)
                }
            }
        }
    }

    /// 计算平均颜色
    private func average(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        let red = fromRed + (toRed - fromRed) * percent
        let green = fromGreen + (toGreen - fromGreen) * percent
        let blue = fromBlue + (toBlue - fromBlue) * percent
        let alpha = fromAlpha + (toAlpha - fromAlpha) * percent
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// ios11调整navigationBar上按钮的左右按钮以及标题View左右间距,默认左右各20
    private func adjustNavigationBarItemsSpacing() {
        if #available(iOS 11, *) {
            for subview in self.navigationBar.subviews {
                let name =  type(of: subview).description()
                if name.contains("UINavigationBarContentView") {
                    let spaceConsts: [CGFloat] = [8,-8,12,-12,16,-16,20,-20]
                    for constant in subview.constraints {
                        if spaceConsts.contains(constant.constant) {
                            constant.constant = 0
                        }
                    }
                }
            }
        }
    }
    
}


// MARK: -  UINavigationControllerDelegate
extension YCNavigationController: UINavigationControllerDelegate {
 
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = transitionCoordinator {
            showViewController(viewController, coordinator: coordinator)
        } else {
            if !animated && viewControllers.count > 1 {
                let lastButOneVC = viewControllers[viewControllers.count - 2]
                showTempFakeBar(fromVC: lastButOneVC, toVC: viewController)
                return
            }
            yc_updateNavigationBar(for: viewController)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if !animated {
            yc_updateNavigationBar(for: viewController)
            clearTempFakeBar()
        }
        poppingVC = nil
    }
    
}

// MARK: - UINavigationBarDelegate
extension YCNavigationController: UINavigationBarDelegate {
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        if let topViewController = topViewController {
            if let barPopBackBlock = topViewController.yc_barPopBackBlock {
                barPopBackBlock()
                return false
            }
        }
        return true
    }
    
}

// MARK: -  UIGestureRecognizerDelegate
extension YCNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        if let topViewController = topViewController {
            if let barGestureBackBlock = topViewController.yc_barGestureBackBlock {
                barGestureBackBlock()
                return false
            }
            return topViewController.yc_barEnablePopGesture
        }
        return true
    }
    
}

// MARK: - 更新视图的方法
extension YCNavigationController {
    
    func yc_updateNavigationBar(for viewController: UIViewController) {
        setupFakeSubviews()
        yc_updateNavigationBarTint(for: viewController)
        yc_updateNavigationBarBackground(for: viewController)
        yc_updateNavigationBarShadow(for: viewController)
    }
    
    func yc_updateNavigationBarTint(for viewController: UIViewController, ignoreTintColor: Bool = false) {
        guard viewController == topViewController else { return }
        UIView.setAnimationsEnabled(false)
        navigationBar.barStyle = viewController.yc_barStyle
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: viewController.yc_barTitleColor,
            NSAttributedString.Key.font: viewController.yc_barTitleFont
        ]
        navigationBar.titleTextAttributes = titleTextAttributes
        if !ignoreTintColor {
            navigationBar.tintColor = viewController.yc_barTintColor
        }
        UIView.setAnimationsEnabled(true)
    }
    
    func yc_updateNavigationBarBackground(for viewController: UIViewController) {
        guard viewController == topViewController else { return }
        fakeBar.yc_updateFakeBarBackground(for: viewController)
    }
    
    func yc_updateNavigationBarShadow(for viewController: UIViewController) {
        guard viewController == topViewController else { return }
        fakeBar.yc_updateFakeBarShadow(for: viewController)
    }
    
}
