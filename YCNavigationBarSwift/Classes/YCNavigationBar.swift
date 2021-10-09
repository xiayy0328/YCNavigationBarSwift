//
//  YCNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2021/10/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// 导航栏默认样式
public struct YCNavigationBarStyle {
    /// 导航栏返回按钮图片
    public static var backImage: UIImage? = YCNavigationBarUtility.backImage
    /// 自定义视图定制导航栏返回按钮
    public static var backButtonCustomView: UIView? = nil
    /// 导航栏背景图片
    public static var backgroundImage: UIImage? = nil
    /// 导航栏背景颜色
    public static var backgroundColor: UIColor = UIColor(white: 237.0/255, alpha: 1.0)
    /// 导航栏标题设置
    public static var titleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 18),
        .foregroundColor: UIColor.black
    ]
    /// 导航栏的tintColor
    public static var tintColor: UIColor = UIColor(white: 24.0/255, alpha: 1.0)
    /// 导航栏底部阴影图片
    public static var shadowImage: UIImage? = UIImage()
    /// 是否全屏左滑手势(自定义)
    public static var fullScreenPopGestureEnabled = false
    /// 调整导航栏 BarButtonItem 距离屏幕左右的间距(0 使用系统的间距 其他动态调整间距)
    public static var itemSpace: CGFloat = 0
}

/// 自定义导航栏视图
public class YCNavigationBar: UIView {

    /// 背景图片
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 底部分割线
    lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 内容视图
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 毛玻璃背景
    lazy var visualEffectView: UIVisualEffectView = {
        let effect: UIBlurEffect
        if #available(iOS 13, *) {
            effect = UIBlurEffect(style: .systemChromeMaterial)
        } else {
            effect = UIBlurEffect(style: .extraLight)
        }
        
        let effectView = UIVisualEffectView(effect: effect)
        effectView.isHidden = true
        effectView.contentView.backgroundColor = YCNavigationBarStyle.backgroundColor.withAlphaComponent(0.5)
        return effectView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        addSubview(visualEffectView)
        addSubview(shadowImageView)
        addSubview(containerView)
        
        backgroundImageView.image = YCNavigationBarStyle.backgroundImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        visualEffectView.frame = bounds
        backgroundImageView.frame = bounds
        
        var safeAreaTop: CGFloat = 20.0
        if #available(iOS 11, *) {
            safeAreaTop = YCNavigationBarUtility.keyWindow?.safeAreaInsets.top ?? 44.0
        }
        containerView.frame = CGRect(x: 0, y: safeAreaTop, width: bounds.width, height: bounds.height - safeAreaTop)
        
        let lineHeight = 1 / UIScreen.main.scale
        shadowImageView.frame = CGRect(x: 0,
                                       y: bounds.height - lineHeight,
                                       width: bounds.width,
                                       height: lineHeight)
    }
    
    /// 是否使用毛玻璃效果
    public func enableBlurEffect(_ enabled: Bool) {
        if enabled {
            backgroundColor = .clear
            backgroundImageView.isHidden = true
            visualEffectView.isHidden = false
        }
    }
    
    /// 内容视图添加子视图
    public func add(_ subView: UIView) {
        containerView.addSubview(subView)
    }
    
    /// 初始化在 didFinishLaunchingWithOptions
    public class func setup() {
        UINavigationBar.swizzleUINavigationBarOnce
        UIViewController.swizzleUIViewControllerOnce
        UINavigationController.swizzleUINavigationControllerOnce
    }
}
