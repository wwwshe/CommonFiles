//
//  Bytes.swift
//  AppstoreDemoRxSwift
//
//  Created by jun wook on 2020/02/27.
//  Copyright © 2020 jungwook. All rights reserved.
//

import Foundation


public class StringUtil {
    public var string: String
    
    public init(string : String) {
        self.string = string
    }
    
    public var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: string, range: NSRange(location: 0, length: string.utf16.count)) ?? 0
    }
    
    //문자열에서 숫자만 가져오기
    public var decimalDigits : String{
        return string.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    //문자열에서 숫자지우기
    public var removeNumbers : String{
        return string.components(separatedBy: CharacterSet.decimalDigits)
            .joined()
    }
    
    // 문자열 공백 삭제
    public var trim : String{
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // 접두사 ex) http:// 가 있을경우 체크해서 없으면 붙여서 리턴
    func withPrefix(_ prefix: String) -> String {
        if string.hasPrefix(prefix) { return string }
        return "\(prefix)\(string)"
    }

}
