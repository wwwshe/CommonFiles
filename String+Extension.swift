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
extension String {
    // 문자열 단어 갯수 세기
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
}

extension String {
     // 지정된 길이보다 문자열이 길때 문자열 뒤에 ... 붙이기
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }
        
        let trimmed = self[..<length]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }
}

extension String {
    // 접두사 ex) http:// 가 있을경우 체크해서 없으면 붙여서 리턴
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}
