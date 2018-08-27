//
//  LoginView.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 24.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import BiometricAuthentication
import DateToolsSwift
import Hue
import Material
import SnapKit

class LoginView: UIView, UITextFieldDelegate, MaskedTextFieldDelegateListener {
    
    private(set) var headerView: GradientView?
    private(set) var headerImageView: UIImageView?
    private(set) var phoneField: TextField?
    private(set) var passwordField: TextField?
    private(set) var loginButton: ButtonFromRaised?
    private(set) lazy var useTouchIDLabel = UILabel()
    private(set) lazy var useTouchIDSwitch = Switch(state: .off, style: .light, size: .medium)
    private(set) var forgotPasswordView: UIView?
    private(set) var forgotPasswordLabel: UILabel?
    private(set) var forgotPasswordButton: FlatButton?
    private(set) var companyLabel: UILabel?
    
    // Public Properies
    public var didTapLogin: ((String, String) -> Void)?
    public var didTapForgotPassword: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderView()
        setupPhoneField()
        setupPasswordField()
        setupLoginButton()
        setupTouchIDViews()
        setupForgotPasswordView()
        setupCompanyLabel()
    }
    
    // MARK: - Actions
    
    @objc
    private func handleLoginButton() {
        let login = phoneField?.text ?? ""
        let password = passwordField?.text ?? ""
        
        if let didTapLogin = didTapLogin {
            didTapLogin(login, password)
        }
    }
    
    @objc
    private func handleForgotPasswordButton() {
        let login = phoneField?.text ?? ""
        
        if let didTapForgotPassword = didTapForgotPassword {
            didTapForgotPassword(login)
        }
    }
    
    // MARK: - Methods
    
    public func setLogin(error: String?) {
        phoneField?.detail = error
        phoneField?.isErrorRevealed = error != nil
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public func setPassword(error: String?) {
        passwordField?.detail = error
        passwordField?.isErrorRevealed = error != nil
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - UI
    
    private func setupHeaderView() {
        headerView = GradientView()
        
        guard let headerView = headerView else { return }
        
        headerView.makeHorizontal()
        headerView.setGradient(colors: App.Color.blueGradient)
        headerView.shadowColor = App.Color.black12
        // depth to show shadow effect which is even for all sides.
        headerView.depth = Depth(offset: Offset.init(horizontal: 0, vertical: 6), opacity: 1, radius: 6)
        
        addSubview(headerView)
        headerView.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else { return }
            
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(headerView.snp.width).multipliedBy(144.0 / 360.0)
        }
        
        setupHeaderImageView()
    }
    
    private func setupHeaderImageView() {
        headerImageView = UIImageView()
        
        guard let headerView = headerView, let headerImageView = headerImageView
            else { return }
        
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.image = #imageLiteral(resourceName: "logo")
        
        headerView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            let width = 112.0
            make.centerX.equalTo(headerView)
            make.centerY.equalTo(headerView).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(headerImageView.snp.width).multipliedBy(90.0 / width)
        }
    }
    
    private func setupPhoneField() {
        // maskFormatter = MaskedTextFieldDelegate(format: "{+7} ([000]) [000] [00] [00]")
        // maskFormatter.listener = self
        
        phoneField = TextField(frame: .zero)
        
        guard let headerView = headerView, let phoneField = phoneField
            else { return }
        
        phoneField.placeholder = NSLocalizedString("login_name", comment: "")
        phoneField.autocorrectionType = .no
        phoneField.autocapitalizationType = .none
        phoneField.delegate = self
        
        if #available(iOS 11.0, *) {
            phoneField.textContentType = .username
        }
        
        // phoneField.delegate = maskFormatter
        // maskFormatter.put(text: "+7 ", into: phoneField)

        addSubview(phoneField)
        phoneField.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else { return }
            
            make.top.equalTo(headerView.snp.bottom).offset(App.Layout.itemSpacingMedium * 2)
            make.left.equalTo(self).inset(App.Layout.sideOffset)
            make.right.equalTo(self).inset(App.Layout.sideOffset)
        }
    }
    
    private func setupPasswordField() {
        passwordField = TextField(frame: .zero)
        passwordField?.placeholder = NSLocalizedString("password", comment: "")
        passwordField?.clearButtonMode = .whileEditing
        passwordField?.visibilityIconButton?.tintColor = App.Color.azure
        passwordField?.isVisibilityIconButtonEnabled = true
        passwordField?.delegate = self
        
        if #available(iOS 11.0, *) {
            passwordField?.textContentType = .password
        }
        
        guard let passwordField = passwordField, let phoneField = phoneField
            else { return }
        
        addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(App.Layout.itemSpacingMedium)
            make.left.equalTo(phoneField.snp.left) //equalTo(self).inset(App.Layout.sideOffset)
            make.right.equalTo(phoneField.snp.right) //equalTo(self).inset(App.Layout.sideOffset)
        }
        
    }
    
    private func setupLoginButton() {
        loginButton = ButtonFromRaised(title: NSLocalizedString("login", comment: "").uppercased())
        
        guard let passwordField = passwordField, let loginButton = loginButton
            else { return }
        
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(App.Layout.itemSpacingBig)
            $0.left.equalTo(passwordField.snp.left)
            $0.right.equalTo(passwordField.snp.right)
        }

    }
    
    private func setupTouchIDViews() {
        if BioMetricAuthenticator.canAuthenticate(),
            let loginButton = loginButton {
            
            useTouchIDSwitch.buttonOnColor = App.Color.azure
            useTouchIDSwitch.trackOnColor = App.Color.azure.withAlphaComponent(0.5)
            addSubview(useTouchIDSwitch)
            useTouchIDSwitch.snp.makeConstraints { (make) in
                make.top.equalTo(loginButton.snp.bottom).offset(App.Layout.itemSpacingMedium)
                make.right.equalTo(self).inset(App.Layout.sideOffset)
            }
            
            useTouchIDLabel.font = App.Font.body
            useTouchIDLabel.numberOfLines = 0
            useTouchIDLabel.lineBreakMode = .byWordWrapping
            useTouchIDLabel.textColor = App.Color.slateGrey
            
            let text = BioMetricAuthenticator.shared.faceIDAvailable() ? NSLocalizedString("use_face_id_to_login", comment: "") : NSLocalizedString("use_touch__to_login", comment: "")
            useTouchIDLabel.text = text
            
            addSubview(useTouchIDLabel)
            useTouchIDLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).inset(App.Layout.sideOffset)
                make.right.equalTo(self.useTouchIDSwitch.snp.left).offset(-App.Layout.itemSpacingMedium)
                make.centerY.equalTo(self.useTouchIDSwitch)
            }
        }
    }
    
    private func setupForgotPasswordView() {
        forgotPasswordView = UIView()
        
        guard let forgotPasswordView = forgotPasswordView,
            let loginButton = loginButton else {
                return
        }
        
        addSubview(forgotPasswordView)
        forgotPasswordView.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else { return }
            
            if BioMetricAuthenticator.canAuthenticate() {
                make.top.equalTo(useTouchIDLabel.snp.bottom).offset(App.Layout.itemSpacingMedium * 2)
            } else {
                make.top.equalTo(loginButton.snp.bottom).offset(App.Layout.itemSpacingMedium * 2)
            }
            make.centerX.equalTo(self)
        }
        
        setupForgotPasswordLabel()
        setupForgotPasswordButton()
    }
    
    private func setupForgotPasswordLabel() {
        forgotPasswordLabel = UILabel()
        
        guard let forgotPasswordView = forgotPasswordView,
            let forgotPasswordLabel = forgotPasswordLabel else {
                return
        }
        
        forgotPasswordLabel.font = App.Font.footnote
        forgotPasswordLabel.textColor = App.Color.slateGrey
        forgotPasswordLabel.text = NSLocalizedString("forgot_password_descr", comment: "")
        
        addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPasswordView)
            make.left.equalTo(forgotPasswordView)
            make.bottom.equalTo(forgotPasswordView)
        }
    }
    
    private func setupForgotPasswordButton() {
        forgotPasswordButton = FlatButton(title: NSLocalizedString("help", comment: ""), titleColor: App.Color.azure
        )
        
        guard let forgotPasswordView = forgotPasswordView,
            let forgotPasswordLabel = forgotPasswordLabel,
            let forgotPasswordButton = forgotPasswordButton else {
                return
        }
        
        forgotPasswordButton.addTarget(self, action: #selector(handleForgotPasswordButton),
                                       for: .touchUpInside)
        forgotPasswordButton.titleLabel?.font = App.Font.footnote
        
        addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgotPasswordView.snp.top)
            make.left.equalTo(forgotPasswordLabel.snp.right).offset(App.Layout.itemSpacingSmall)
            make.right.equalTo(forgotPasswordView.snp.right)
            make.bottom.equalTo(forgotPasswordView.snp.bottom)
        }
    }
    
    private func setupCompanyLabel() {
        companyLabel = UILabel()
        
        guard let companyLabel = companyLabel else { return }
        
        companyLabel.font = App.Font.footnote
        companyLabel.textColor = App.Color.slateGrey
        
        let format = NSLocalizedString("company_2018", comment: "") as NSString
        let companyText = NSString(string: "").appendingFormat(format, Date().year)
        companyLabel.text = companyText as String
        
        addSubview(companyLabel)
        companyLabel.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else { return }
            
            make.centerX.equalTo(self)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(App.Layout.itemSpacingMedium)
            } else {
                make.bottom.equalTo(self).inset(App.Layout.itemSpacingMedium)
            }
        }
    }
    
    // MARK: - MaskedTextFieldDelegateListener
    
    open func textField(_ textField: UITextField,
                        didFillMandatoryCharacters complete: Bool,
                        didExtractValue value: String) { }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










































