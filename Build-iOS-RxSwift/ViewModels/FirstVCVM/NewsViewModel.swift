//
//  NewsViewModel.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 30.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import RealmSwift


class TagsViewModel: NSObject, ViewModel {
    
    private(set) var loading = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    private let provider = MoyaProvider<FetchPhotosServise>()
    
    // MARK: - Methods
    
    public func geiPhotos(search: String, page: Int, completion: @escaping ((Error?) -> Void)) {
        
        loading.accept(true)
        
        provider.rx
            .request(.photos(searchText: search, page: page))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { response in
                self.loading.accept(false)
                
                print(response.data)
                
                
            })
            .disposed(by: disposeBag)
    }

}



















