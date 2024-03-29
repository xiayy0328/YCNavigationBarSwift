//
//  YCNavigationBarUtility.swift
//  YCNavigationBarSwift_Example
//
//  Created by Xyy on 2021/10/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// YCNavigationBar 工具类
class YCNavigationBarUtility {
    
    /// 导航栏返回按钮图片
    static var backImage: UIImage? = {
        let backButtonImageBase64 = "iVBORw0KGgoAAAANSUhEUgAAABIAAAAkCAYAAACE7WrnAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAEqADAAQAAAABAAAAJAAAAAC0yP9zAAABSElEQVRIDa2WO0oEQRCGF99vT+AewQN4DXNBUFQwMDAw2GADgw0MBGMjwUAQBEVBFEQRBPEUnsPH1zA/DIUIf281/FQVU/11T/d09XQ6SW10SM4J/bvoYxjOMZ1/0DfaqAUdNZACKjqtAQ0C5Ix4xAUdBsg5sb3O/QC5qIH0AuSSeAxZ7YBsLWqxV2jcIpC8j9qQG+IJF7IXIHfEky5kN0DuiadcyHaAPBJPu5BNOpRPXuvyhD+DrLZOdhvyQjxrEUheQ19IM3nFn0NWWyW7DXkjXrAITfInVjN5x1+sgdin9r9B0l6tDJKy2Jpt3P5nHtjbL1jKBynYDo52sdiqIyJYyqEVLJaRWx7YZUSwWNiueWAXNsFSSq1gKcVfsD5OezerriPBUi5Iwf68su3rFtoDmkcrDXkZu9T4VSblt0Yjlx+tLQUp9heUA33Up/m/hAAAAABJRU5ErkJggg=="
        if let data = Data(base64Encoded: backButtonImageBase64, options: .ignoreUnknownCharacters) {
            return UIImage(data: data, scale: 2.0)
        }
        return nil
    }()
    
    /// 获取应用程序的主窗口
    static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? nil
        }

        return UIApplication.shared.delegate?.window ?? nil
    }
    
    /// 获取导航栏高度
    static var navigationBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if let top = keyWindow?.safeAreaInsets.top {
                return top + 44.0
            }
            return 64.0
        } else {
            return 64.0
        }
    }
    
    /// 颜色转图片
    public class func imageFrom(color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 方法交换
    public class func swizzleMethod(_ cls: AnyClass, _ originSelector: Selector, _ newSelector: Selector) {
        guard let oriMethod = class_getInstanceMethod(cls, originSelector),
            let newMethod = class_getInstanceMethod(cls, newSelector) else {
                return
        }
        
        let isAddedMethod = class_addMethod(cls, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
        if isAddedMethod {
            class_replaceMethod(cls, newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
        } else {
            method_exchangeImplementations(oriMethod, newMethod)
        }
    }
}

