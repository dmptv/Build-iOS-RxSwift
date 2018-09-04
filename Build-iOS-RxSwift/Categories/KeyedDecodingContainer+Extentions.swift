//
//  File.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 04.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

// MARK: - KeyedDecodingContainer

extension KeyedDecodingContainer {
    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
        where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
}
