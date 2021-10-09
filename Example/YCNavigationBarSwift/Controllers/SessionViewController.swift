//
//  SessionViewController.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/2/23.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

    private var tableView: UITableView!
    
    private var dataSource: [Session] = Session.allCases
    
    private lazy var menuFloatView: SessionMoreFrameFloatView = {
        let y = Constants.statusBarHeight + 44
        let frame = CGRect(x: 0, y: y, width: view.bounds.width, height: view.bounds.height - y)
        let floatView = SessionMoreFrameFloatView(frame: frame)
        floatView.delegate = self
        return floatView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(image: UIImage(named: "icons_outlined_addoutline"), style: .done, target: self, action: #selector(handleRightBarButtonTapped(_:)))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(white: 0, alpha: 0.15)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(tableView)
    }

    @objc private func handleRightBarButtonTapped(_ sender: Any) {
        if self.menuFloatView.superview != nil {
            hideMoreMenu()
        } else {
            showMoreMenu()
        }
    }
    
    private func showMoreMenu() {
        menuFloatView.show(in: self.view)
    }
    
    private func hideMoreMenu(animated: Bool = true) {
        menuFloatView.hide(animated: animated)
    }
    
    // MARK: - YCNavigationBarSwift
    override var yc_navigationBarBackgroundColor: UIColor? {
        return .secondarySystemBackground
    }
}

// MARK: - UITableViewDataSource
extension SessionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}

// MARK: - UITableViewDelegate
extension SessionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let session = dataSource[indexPath.row]
        switch session {
        case .transparent:
            let vc = ChatRoomViewController_Transparent(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .backgroundImage:
            let vc = ChatRoomViewController_BackgroundImage(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .backgroundColor:
            let vc = ChatRoomViewController_BackgroundColor(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .customBackButtonImage:
            let vc = ChatRoomViewController_CustomBackButtonImage(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .customBackButton:
            let vc = ChatRoomViewController_CustomBackButton(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .shadowImage:
            let vc = ChatRoomViewController_ShadowImage(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .translucent:
            let vc = ChatRoomViewController_Translucent(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .disableInteractivePopGesture:
            let vc = ChatRoomViewController_DisableInteractivePopGesture(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .fullscreenInteractivePopGesture:
            let vc = ChatRoomViewController_FullscreenPopGesture(session: session)
            navigationController?.pushViewController(vc, animated: true)
        case .presentViewController:
            let vc = PresentViewController()
            let nav = MMNavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            nav.modalPresentationCapturesStatusBarAppearance = true
            present(nav, animated: true, completion: nil)
        case .setViewControllers:
            let vc = ChatRoomViewController_BackgroundImage(session: session)
            if var controllers = navigationController?.viewControllers {
                controllers.append(vc)
                navigationController?.setViewControllers(controllers, animated: true)
            }
        case .preferStatusBarHidden:
            let vc = ChatRoomViewController_StatusBarHidden(session: session)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - SessionMoreMenuViewDelegate
extension SessionViewController: SessionMoreMenuViewDelegate {
    
    func moreMenuView(_ menu: SessionMoreMenuView, didTap item: SessionMoreItem) {
        switch item.type {
        case .money:
            let paymentVC = PaymentViewController()
            navigationController?.pushViewController(paymentVC, animated: true)
        default:
            break
        }
        hideMoreMenu(animated: false)
    }
}
