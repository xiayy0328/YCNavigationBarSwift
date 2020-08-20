//
//  ViewController.swift
//  YCNavigationBarSwift
//
//  Created by Loveying on 08/20/2020.
//  Copyright (c) 2020 Loveying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.rowHeight = 55
        }
    }
    
    let demoTitles = ["normal","profile","hide"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YCNavigationBarSwift"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

private typealias TableViewDataSource = ViewController
extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = demoTitles[indexPath.row]
        return cell!
    }
}

private typealias TableViewDelegate = ViewController
extension TableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let demoTitle = demoTitles[indexPath.row]
        
        switch demoTitle {
        case "normal":
            navigationController?.pushViewController(NormalViewController.init(), animated: true)
        case "profile":
            navigationController?.pushViewController(CommonViewController.init(nibName: "CommonViewController", bundle: Bundle.main), animated: true)
        case "hide":
            navigationController?.pushViewController(HideViewController.init(), animated: true)
        default:
            break
        }
        
        
    }
}
