//
//  String+Extention.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/12.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation

//MARK: String Extension
extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

extension String {
    subscript(value: NSRange) -> String {
        self[value.lowerBound..<value.upperBound]
    }
}

extension String {
    subscript(value: Range<Int>) -> String {
        String(self[index(at: value.lowerBound)..<index(at: value.upperBound)])
    }
    subscript(value: ClosedRange<Int>) -> String {
        String(self[index(at: value.lowerBound)...index(at: value.upperBound)])
    }
    subscript(value: PartialRangeUpTo<Int>) -> String {
        String(self[..<index(at: value.upperBound)])
    }
    
    subscript(value: PartialRangeThrough<Int>) -> String {
        String(self[...index(at: value.upperBound)])
    }
    
    subscript(value: PartialRangeFrom<Int>) -> String {
        String(self[index(at: value.lowerBound)...])
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}


extension String {
    //Mark: not know date format
    func stringToDate() -> Date?{
        // appending date format
        let dateFormats = ["yyyy-MM-dd",
                           "yyyy-MM-dd HH:mm:ss",
                           "yyyy-MM-dd HH:mm",
                           "yyyy.MM.dd",
                           "yyyy.MM.dd HH:mm:ss",
                           "yyyy.MM.dd HH:mm",
                           "yyyy-MM-dd'T'HH:mm:ss'Z'",
                           "MM/dd/yyyy"
        ]
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        for format in dateFormats{
            dateFormatter.dateFormat = format
            let d = dateFormatter.date(from: self)
            if d != nil{
                print(format)
                return d
            }
        }
        return nil
    }
}
