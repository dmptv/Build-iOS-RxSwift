//
//  NewsViewModel.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 30.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import IGListKit
import Moya
import RxSwift
import RxCocoa

class NewsViewModel: NSObject {

}

extension NewsViewModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? NewsViewModel {
            return self == object
        }
        return false
    }
}
