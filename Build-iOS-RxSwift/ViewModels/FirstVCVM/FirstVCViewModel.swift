//
//  FirstVCViewModel.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import RealmSwift

class FirstVCViewModel: NSObject, ViewModel {
    
    private let disposeBag = DisposeBag()

    private(set) var tagsViewModel = TagsViewModel()
    
    // FIXME: - Photos model, map photos
    
    
}
