//
//  Bytes.swift
//  AppstoreDemoRxSwift
//
//  Created by jun wook on 2020/02/27.
//  Copyright © 2020 jungwook. All rights reserved.
//

import Foundation


public struct Bytes {
    
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
  
  public func getReadableUnit() -> String {
    
    switch bytes {
    case 0..<1024:
      return "\(bytes) bytes"
    case 1024..<(1024 * 1024):
      return "\(String(format: "%.2f", kilobytes)) KB"
    case 1024..<(1024 * 1024 * 1024):
      return "\(String(format: "%.2f", megabytes)) MB"
    case (1024 * 1024 * 1024)...Int64.max:
      return "\(String(format: "%.2f", gigabytes)) GB"
    default:
      return "\(bytes) bytes"
    }
  }
}
