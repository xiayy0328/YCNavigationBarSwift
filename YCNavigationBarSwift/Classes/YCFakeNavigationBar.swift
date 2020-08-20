//
//  YCFakeNavigationBar.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2020/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class YCFakeNavigationBar: UIView {

    private lazy var fakeBackgroundImageView: UIImageView = {
        let fakeBackgroundImageView = UIImageView()
        fakeBackgroundImageView.isUserInteractionEnabled = false
        fakeBackgroundImageView.contentScaleFactor = 1
        fakeBackgroundImageView.contentMode = .scaleToFill
        fakeBackgroundImageView.backgroundColor = .clear
        return fakeBackgroundImageView
    }()
    
    private lazy var fakeBackgroundEffectView: UIVisualEffectView = {
        let fakeBackgroundEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        fakeBackgroundEffectView.isUserInteractionEnabled = false
        return fakeBackgroundEffectView
    }()
    
    private lazy var fakeShadowImageView: UIImageView = {
        let fakeShadowImageView = UIImageView()
        fakeShadowImageView.isUserInteractionEnabled = false
        fakeShadowImageView.contentScaleFactor = 1
        return fakeShadowImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fakeBackgroundEffectView.frame = bounds
        fakeBackgroundImageView.frame = bounds
        fakeShadowImageView.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(fakeBackgroundEffectView)
        addSubview(fakeBackgroundImageView)
        addSubview(fakeShadowImageView)
    }
}

// MARK: - 更新视图的方法
extension YCFakeNavigationBar {
    
    func yc_updateFakeBarBackground(for viewController: UIViewController) {
        fakeBackgroundEffectView.subviews.last?.backgroundColor = viewController.yc_barBackgroundColor
        fakeBackgroundImageView.image = viewController.yc_barBackgroundImage
        if viewController.yc_barBackgroundImage != nil {
            fakeBackgroundEffectView.alpha = 0
        } else {
            fakeBackgroundEffectView.alpha = viewController.yc_barAlpha
        }
        fakeBackgroundImageView.alpha = viewController.yc_barAlpha
        fakeShadowImageView.alpha = viewController.yc_barAlpha
    }
    
    func yc_updateFakeBarShadow(for viewController: UIViewController) {
        fakeShadowImageView.isHidden = viewController.yc_barShadowHidden
        fakeShadowImageView.backgroundColor = viewController.yc_barShadowColor
    }
    
}
