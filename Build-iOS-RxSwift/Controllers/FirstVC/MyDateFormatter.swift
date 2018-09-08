//
//  MyDateFormatter.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 08.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

class MyDateFormatter {
    
    private static var privateShared : MyDateFormatter?
    
    var dateFormatter : DateFormatter?
    var dateReader : NSDataDetector?
    
    class func shared() -> MyDateFormatter {
        guard let uwShared = privateShared else {
            privateShared = MyDateFormatter()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    private init() {
        dateReader = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        dateFormatter = DateFormatter()
        dateFormatter!.dateFormat = "EEEE MMM dd"
    }
}
    
    /* Tests in View Controller
     let event = SomeEvent()
     event.formattedDate = "tomorrow"
     event.formattedDate // "Friday Dec 04"
     event.formattedDate = "25/02/2010"
     event.formattedDate // "Thursday Feb 25"
     event.formattedDate = "Sunday Mar 13"
     event.formattedDate // "Sunday Mar 13"
     */

class SomeEvent {
    
    // Store calculated results.
    // This is private to make the class cleaner in use.
    private var storedDate : Date?
    
    private var storedFormattedDate : String = ""
    
    // get returns stored values without calculations
    // set updates both stored values after calculations
    var date : Date? {
        get {
            return storedDate
        }
        set(value) {
            storedFormattedDate = format(date: value)
            storedDate = value
        }
    }
    
    var formattedDate : String {
        get {
            return storedFormattedDate
        }
        set(value) {
            storedDate = readDateFrom(dateString: value)
            storedFormattedDate = format(date: storedDate)
        }
    }
    
    // hidden functions, again to make the class cleaner in use.
    private func format(date maybeDate: Date?) -> String {
        
        guard let date = maybeDate else {
            return ""
        }
        guard let dateFormatter = MyDateFormatter.shared().dateFormatter else {
            return ""
        }
        return dateFormatter.string(from: date)
        
    }
    
    private func readDateFrom(dateString string: String) -> Date? {
        
        // get detector
        if let detector = MyDateFormatter.shared().dateReader {
            // results
            let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
            // first result
            if let match = matches.first, let date = match.date {
                return date
            }
        }
        
        // just format if there is no detector
        if let dateFormatter = MyDateFormatter.shared().dateFormatter {
            if let date = dateFormatter.date(from: string) {
                return date
            }
        }
        
        // everything failed
        return nil
    }
}










































