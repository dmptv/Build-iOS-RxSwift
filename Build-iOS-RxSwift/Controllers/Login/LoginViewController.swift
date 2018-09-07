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
        
        print("resources: \(RxSwift.Resources.total)")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    
    // MARK: - UI
    
    private func setupUI() {
        loginView = LoginView(frame: .zero)
        loginView.didTapLogin = { [weak self] (login, password) in
            self?.login(login, password: password)
        }
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints({ [weak self] (make) in
            guard let `self` = self else { return }
            make.edges.equalTo(self.view)
        })
        
    }
    
    // MARK: - Methods
    
    private func observeChanges() {
        viewModel.loginErrorMessage
            .asObservable()
            .subscribe(onNext: { [weak self] (errorMessage) in
                self?.loginView.setLogin(error: errorMessage)
            })
            .disposed(by: disposeBag)
        
        viewModel.passwordErrorMessage
            .asObservable()
            .subscribe(onNext: { [weak self] (errorMessage) in
                self?.loginView.setPassword(error: errorMessage)
            })
            .disposed(by: disposeBag)
    }

    private func promptBiometricLoginIfEnabled() {
        guard UserDefaults.standard.bool(forKey: App.Key.useTouchOrFaceIdToLogin) else {
            return
        }
        
        let isFaceIdAvailable = BioMetricAuthenticator.shared.faceIDAvailable()
        
        var reason = NSLocalizedString("kTouchIdAuthenticationReason", comment: "")
        if isFaceIdAvailable {
            reason = NSLocalizedString("kFaceIdAuthenticationReason", comment: "")
        }
        
        let fallbackTitle = NSLocalizedString("enter_manually", comment: "")
        
        BioMetricAuthenticator.authenticateWithBioMetrics(
            reason: reason,
            fallbackTitle: fallbackTitle,
            success: { [weak self] in
                self?.loginWithSavedCredentials()
            },
            failure: { [weak self] (error) in
                self?.handleBiometric(error: error, isFaceIdAvailable: isFaceIdAvailable)
            }
        )
    }
    
    private func handleBiometric(error: AuthenticationError,
                                 isFaceIdAvailable: Bool,
                                 isPasscode: Bool = false) {
        
        if error == .canceledByUser || error == .canceledBySystem {
            resetSavedUserLoginCredentials()
            return
        } else if error == .biometryNotAvailable {
            let reason = NSLocalizedString("kBiometryNotAvailableReason", comment: "")
            showErrorAlert(reason)
        } else if error == .fallback {
            resetSavedUserLoginCredentials()
            _ = loginView.phoneField?.becomeFirstResponder()
        } else if error == .biometryNotEnrolled {
            var reason = NSLocalizedString("kNoFingerprintEnrolled", comment: "")
            if isFaceIdAvailable {
                reason = NSLocalizedString("kNoFaceIdentityEnrolled", comment: "")
            }
            
            if isPasscode {
                reason = NSLocalizedString("kSetPasscodeToUseTouchID", comment: "")
                if isFaceIdAvailable {
                    reason = NSLocalizedString("kSetPasscodeToUseFaceID", comment: "")
                }
            }
            
            showErrorAlert(reason)
        } else if error == .biometryLockedout {
            var reason = NSLocalizedString("kTouchIdPasscodeAuthenticationReason", comment: "")
            if isFaceIdAvailable {
                reason = NSLocalizedString("kFaceIdPasscodeAuthenticationReason", comment: "")
            }
            
            BioMetricAuthenticator.authenticateWithPasscode(
                reason: reason,
                success: { [weak self] in
                    self?.loginWithSavedCredentials()
                },
                failure: { [weak self] (error) in
                    self?.handleBiometric(
                        error: error,
                        isFaceIdAvailable: isFaceIdAvailable,
                        isPasscode: true
                    )
                }
            )
        } else {
            var reason = NSLocalizedString("kDefaultTouchIDAuthenticationFailedReason", comment: "")
            if isFaceIdAvailable {
                reason = NSLocalizedString("kDefaultFaceIDAuthenticationFailedReason", comment: "")
            }
            showErrorAlert(reason)
        }
    }
    
    private func resetSavedUserLoginCredentials() {
        UserDefaults.standard.set(false, forKey: App.Key.useTouchOrFaceIdToLogin)
        UserDefaults.standard.synchronize()
        
        let keychain = Keychain(service: App.Key.loginCredentialsIdentifier)
        try? keychain.removeAll()
        
        loginView.useTouchIDSwitch.setSwitchState(state: .off)
    }
    
    private func loginWithSavedCredentials() {
        let keychain = Keychain(service: App.Key.loginCredentialsIdentifier)
        
        let login = UserDefaults.standard.string(forKey: App.Key.name) ?? ""
        let password = keychain[string: login] ?? ""
        
        self.loginView.loginButton?.buttonState = .loading
        self.viewModel.login(login,
                             password: password,
                             completion:
            { [weak self] (response: SingleEvent<Response>) in
                self?.loginView.loginButton?.buttonState = .normal
                
                switch response {
                case .success(let json):
                    self?.onLogin(json: json, saveCredentials: false)
                case .error(let error):
                    self?.onLoginError(error)
                }
        })
    }
        
    private func login(_ login: String, password: String) {
        self.loginView.loginButton?.buttonState = .loading
        self.viewModel.login(login,
                             password: password,
                             completion:
            { [weak self] (response: SingleEvent<Response>) in
                self?.loginView.loginButton?.buttonState = .normal
                
                // fake validation
                if !login.isEmpty, !password.isEmpty {
                    let saveCredentials = self?.loginView.useTouchIDSwitch.isOn ?? false
                    self?.onLogin(json: nil, saveCredentials: saveCredentials)
                    return
                } else {
                    self?.showToast("Login, password are empty", position: .top)
                    return
                }
                
                switch response {
                case .success(let json):
                    let saveCredentials = self?.loginView.useTouchIDSwitch.isOn ?? false
                    self?.onLogin(json: json, saveCredentials: saveCredentials)
                case .error(let error):
                    self?.onLoginError(error)
                }
        })
    }
    
    fileprivate func handleResponse(response: SingleEvent<Response>) {
        
    }
    
    private func onLogin(json: Response?, saveCredentials: Bool = true) {
        if let json = json {
            saveUser(json)
        }
        
        if saveCredentials {
            let name = self.loginView.phoneField?.text ?? ""
            let password = self.loginView.passwordField?.text ?? ""
            
            let keychain = Keychain(service: App.Key.loginCredentialsIdentifier)
            // login will be a key
            keychain[name] = password

            User.current.name = name
            User.current.password = password
            User.current.save()
        }
        
        // fake isAuthenticated
        if !User.current.isAuthenticated {
            print("---> isAuthenticated ")
            step.accept(AppStep.mainMenu)
        }
    }
    
    private func onLoginError(_ error: Error) {
        let errorMessages = error.parseMessages()
        
        viewModel.loginErrorMessage.accept(errorMessages[App.Field.login])
        viewModel.passwordErrorMessage.accept(errorMessages[App.Field.password])
        
        showToast("error", position: .top)
        
        if let error = errorMessages[App.Field.default] {
            showToast(error, position: .top)
        }
    }
    
    private func saveUser(_ json: Response) {
        if let user = try? JSONDecoder().decode(User.self, from: json.data) {
            User.current.name = user.name
            User.current.password = user.password
            User.current.save()
        }
    }
    
}


































