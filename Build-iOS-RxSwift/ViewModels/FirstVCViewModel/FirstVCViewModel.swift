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
                        
                        self.onSuccess.onNext(())
                        
                        self.photo.accept(photos)

                    } catch (let error) {
                        printMine(items: error.localizedDescription)
                    }

                    
                case .error(let error):
                    printMine(items: error.localizedDescription)
                    self.onError.onNext(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
}























































