//
//  ViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 22.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import BiometricAuthentication
import KeychainAccess
import Material
import Moya
import RxSwift
import SnapKit

class LoginViewController: UIViewController, ViewModelBased, Stepper {
    
    typealias ViewModelType = LoginViewModel
    
    // Public Properties
    public var viewModel: LoginViewModel!
    public var isUnauthorized = false
    
    private let disposeBag = DisposeBag()
    
    private var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        observeChanges()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isUnauthorized {
            showToast(NSLocalizedString("you_are_unathorized_message", comment: ""))
            
            isUnauthorized = false
        }
        
        promptBiometricLoginIfEnabled()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    
    // MARK: - UI
    
    private func setupUI() {
        loginView = LoginView(frame: .zero)
        
        // FIXME: - Implement here
        view.addSubview(loginView)
        loginView.snp.makeConstraints({ [weak self] (make) in
            guard let `self` = self else { return }
            make.edges.equalTo(self.view)
        })
        
    }
    
    // MARK: - Methods
    
    private func observeChanges() {

    }

    private func promptBiometricLoginIfEnabled() {

    }
    
}


































