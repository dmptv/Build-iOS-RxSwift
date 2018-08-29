//
//  AppToolbarController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 28.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Kingfisher
import Material
import RxSwift
import RxCocoa

class AppNavbarController: NavigationController, Stepper {
    
    private(set) var shadowHidden = true
    let disposeBag = DisposeBag()
    
    var didTapNotifications: (() -> Void)?
    var didTapProfile: (() -> Void)?
    
    var didTapSearch: (() -> Void)?
    
    open override func prepare() {
        super.prepare()
        
        setupStatusBar()
        setupToolbar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Actions
    
    @objc
    private func handleNotificationsTap() {
        if let didTapNotifications = didTapNotifications {
            didTapNotifications()
        }
    }
    
    @objc
    private func handleSearchTap() {
        if let didTapSearch = didTapSearch {
            didTapSearch()
        }
    }
    
    @objc
    private func handleProfileTap() {
        if let didTapProfile = didTapProfile {
            didTapProfile()
        }
    }
    
    // MARK: - Methods
    
    public func setShadow(hidden: Bool) {
        shadowHidden = hidden
        
        if let navBar = navigationBar as? NavigationBar {
            navBar.shadowColor = hidden ? UIColor.clear : UIColor.black.withAlphaComponent(0.16)
            
            let depthNone = Depth(preset: .none)
            let depthExist = Depth(offset: Offset.init(horizontal: 0, vertical: 1), opacity: 1, radius: 6)
            navBar.depth =  hidden ? depthNone : depthExist
        }
    }
    
    // MARK: - UI
    
    private func setupStatusBar() {
        statusBarStyle = .default
    }
    
    private func setupToolbar() {
        if let navBar = navigationBar as? NavigationBar {
            navBar.backButtonImage = #imageLiteral(resourceName: "left").resize(toWidth: 24)?.withRenderingMode(.alwaysTemplate)
            navBar.backgroundColor = App.Color.white
            navBar.interimSpacePreset = .none
            navBar.contentEdgeInsetsPreset = EdgeInsetsPreset.none
            navBar.contentEdgeInsets = .init(top: 4, left: 7, bottom: 4, right: 0)
        }
        
        setShadow(hidden: false)
    }
    
    // MARK: - Toolbar
    
    public func setupToolbarButtons(for viewController: UIViewController) {
        let leftButton = setupLefttButton()
        let notificationsButton = setupNotificationsButton()
        let searchButton = setupSearchButton()
        viewController.navigationItem.leftViews = [leftButton]
        viewController.navigationItem.rightViews = [notificationsButton, searchButton ]
    }
    
    private func setupLefttButton() -> SizedButton {
        let leftButton = SizedButton(image: #imageLiteral(resourceName: "messenger_icon").resize(toWidth: 30), size: .init(width: 43, height: 22))
        leftButton.contentMode = .scaleAspectFit
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.pulseColor = App.Color.azure
        return leftButton
    }
    
    private func setupNotificationsButton() -> IconButton {
        let notificationsButton = IconButton(image: #imageLiteral(resourceName: "share").resize(toWidth: 26)?.withRenderingMode(.alwaysOriginal))
        notificationsButton.addTarget(self, action: #selector(handleNotificationsTap), for: .touchUpInside)
        notificationsButton.pulseColor = App.Color.azure
        return notificationsButton
    }
    
    private func setupSearchButton() -> SizedButton {
        let searchButton = SizedButton(image: nil, size: .init(width: 24, height: 24))
        searchButton.addTarget(self, action: #selector(handleSearchTap), for: .touchUpInside)
        searchButton.iconView.backgroundColor = .clear
        searchButton.pulseColor = App.Color.azure
        searchButton.iconView.layer.cornerRadius = 12
        searchButton.iconView.layer.masksToBounds = true
        searchButton.iconView.tintColor = App.Color.coolGrey
        searchButton.iconView.image = #imageLiteral(resourceName: "Search_Selected").resize(toWidth: 24)?.withRenderingMode(.alwaysTemplate)
        return searchButton
    }
    
}





















