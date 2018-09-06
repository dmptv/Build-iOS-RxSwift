//
//  Sections.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 06.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfCustomData {
    let title: String
    var items: [FlickrPhoto]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = FlickrPhoto
    
    init(original: SectionOfCustomData, items: [FlickrPhoto]) {
        self = original
        self.items = items
    }
}

extension SectionOfCustomData: AnimatableSectionModelType {
    typealias Identity = String
    
    var identity: String {
        return title
    }
}




