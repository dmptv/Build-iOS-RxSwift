//
//  DeatilFlickrPhotoViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 11.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import SnapKit
import Material
import NVActivityIndicatorView

class DetailFlickrPhotoViewController: UIViewController {
    
    let photoImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let closeButton: Button = {
        let btn = Button()
        btn.image = Icon.cm.close
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return btn
    }()
    
     var spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 120, height: 80), type: .ballPulseRise, color: App.Color.coolGrey, padding: 0)
    
    @objc
    private func closeAction() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    //MARK: - UI
    private func setupUI() {
        setupImageView()
        setupCloseButton()
        setupSpinner()
    }
    
    fileprivate func setupImageView() {
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.frame = CGRect(x: 20, y: 20, width: 44, height: 44)
    }
    
    fileprivate func setupSpinner() {
        view.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        view.bringSubview(toFront: spinner)
    }

    //MARK: - Methods
    public func startLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    public func stopLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }, completion: nil)
    }
  

}





























