//
//  CommonViewController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xiayingying on 2019/11/9.
//  Copyright © 2019 Codyy.YY. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var header: UIView = {
        let header = UIView()
        return header
    }()
    lazy var headerView: UIImageView = {
        let headerView = UIImageView()
        headerView.image = UIImage(named: "sunset")
        return headerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Common VC"
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        let headerFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75)
        header.frame = headerFrame
        headerView.frame = headerFrame
        header.addSubview(headerView)
        tableView.tableHeaderView = header;
        
        yc_barBackgroundColor = UIColor.red
        yc_barAlpha = 0
        yc_barTitleColor = UIColor.white
        yc_barTintColor = UIColor.white
        yc_barStyle = .black
        yc_barShadowHidden = true
    }
    func adjustHeaderFrame() {
        var imageWidth = view.bounds.width
        var imageHeight = imageWidth * 0.75
        var originY: CGFloat = 0
        let contentOffsetY = tableView.contentOffset.y
        if contentOffsetY < 0 {
            originY += contentOffsetY
            imageHeight -= contentOffsetY
            imageWidth = imageHeight / 0.75
        }
        let headViewFrame = CGRect(x: (view.bounds.width - imageWidth) / 2, y: originY, width: imageWidth, height: imageHeight)
        headerView.frame = headViewFrame
    }
}

private typealias TableViewDataSource = CommonViewController
extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}

private typealias TableViewDelegate = CommonViewController
extension TableViewDelegate: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight = view.bounds.width * 0.75
        let contentOffsetY = scrollView.contentOffset.y
        let progress = min(1, max(0, contentOffsetY / headerHeight))
        if progress < 0.1 {
            yc_barStyle = .black
            yc_barTintColor = .white
            yc_barTitleColor = UIColor(white: 0, alpha: 0)
        } else {
            yc_barStyle = .default
            yc_barTintColor = UIColor(white: 0, alpha: progress)
            yc_barTitleColor = UIColor(white: 0, alpha: progress)
        }
        yc_barAlpha = progress
        adjustHeaderFrame()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
