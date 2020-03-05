//
//  Bytes.swift
//
//  Created by jun wook on 2020/02/27.
//  Copyright © 2020 jungwook. All rights reserved.
//

import Foundation


public struct BytesUtil {
    public let bytes: Int64
    
    public var kilobytes: Double {
        return Double(bytes) / 1024
    }
    
    public var megabytes: Double {
        return kilobytes / 1024
    }
    
    public var gigabytes: Double {
        return megabytes / 1024
    }
    
    public init(bytes: Int64) {
        self.bytes = bytes
    }
    
    /// byte to string
    /// - Parameter format: digit format ex) "%.2f"
    public func getReadableUnit(format : String) -> String {
        switch bytes {
        case 0..<1024:
            return "\(bytes) bytes"
        case 1024..<(1024 * 1024):
            return "\(String(format: format, kilobytes)) KB"
        case 1024..<(1024 * 1024 * 1024):
            return "\(String(format: format, megabytes)) MB"
        case (1024 * 1024 * 1024)...Int64.max:
            return "\(String(format: format, gigabytes)) GB"
        default:
            return "\(bytes) bytes"
        }
    }
}
