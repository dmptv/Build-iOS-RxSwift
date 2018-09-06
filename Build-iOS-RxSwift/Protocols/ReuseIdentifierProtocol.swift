//
//  ReuseIdentifierProtocol.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 06.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

public protocol ReuseIdentifierProtocol: class {
    //Get identifier from class
    static var defaultReuseIdentifier: String { get }
}

public extension ReuseIdentifierProtocol where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
