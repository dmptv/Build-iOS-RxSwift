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

class FirstVCViewModel: NSObject, ServicesViewModel {
    typealias Services = MoyaProvider<FetchPhotosServise>
    var services: MoyaProvider<FetchPhotosServise>!
    
    private(set) var loading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    private var provider: MoyaProvider<FetchPhotosServise> {
        get {
            return services
        }
    }
    
    let photo = BehaviorRelay<[FlickrPhoto]>(value: [])
    let pages = BehaviorRelay<Int>(value: 1)

    let onSuccess = PublishSubject<Void>()
    let onError = PublishSubject<Error>()
        
    // MARK: - Methods
    
    public func geiPhotos(search: String, page: Int) {
        loading.accept(true)
        
        provider.rx
            .request(.photos(searchText: search, page: page))
            .filterSuccessfulStatusCodes()
            .subscribe { response in
                self.loading.accept(false)
                
                switch response {
                case .success(let json):
                    do {
                        let root = try JSONDecoder().decode(Root.self, from: json.data)
                        let photos: [FlickrPhoto] = root.photos.photo
                        let pages: Int = Int(root.photos.total) ?? 0
                        
                        self.onSuccess.onNext(())
                        
                        self.pages.accept(pages)
                        self.photo.accept(photos)

                    } catch (let error) {
                        printMine(items: "try JSONDecoder().decode error: ",  error.localizedDescription)
                        self.onError.onNext(error)
                    }
                case .error(let error):
                    printMine(items: "response's error ", error.localizedDescription)
                    self.onError.onNext(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
}























































