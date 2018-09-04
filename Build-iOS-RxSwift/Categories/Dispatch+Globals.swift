//
//  Dispatch+Globals.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 04.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

func afterDelayOnMain(_ seconds: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}
