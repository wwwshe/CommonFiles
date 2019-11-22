//
//  StationColor.swift
//  DDota
//
//  Created by jungwook on 2019/11/21.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

enum StationColor{
    case Line1
    case Line2
    case Line3
    case Line4
    case Line5
    case Line6
    case Line7
    case Line8
    case Line9
    case LineA  // 공항 철도
    case LineB // 분당선
    case LineE // 용인 경전철
    case LineG // 경의중앙선
    case LineGG // 김포 도시철도
    case LineI1 // 인천 1호선
    case LineI2 // 인천 2호선
    case LineK  // 경의선
    case LineKK // 경강선
    case LineS // 신분당선
    case LineSU // 수인선
    case LineSL // 서해선
    case LineU // 의정부 경전철
    case LineUI // 우이신설선
}

extension UIColor{
    static func getStationColor(line : StationColor) -> UIColor{
          switch line {
          case .Line1:
              return UIColor(netHex: 0x0052A4)
          case .Line2:
              return UIColor(netHex: 0x009D3E)
          case .Line3:
              return UIColor(netHex: 0xEF7C1C)
          case .Line4:
              return UIColor(netHex: 0x00A5DE)
          case .Line5:
              return UIColor(netHex: 0x996CAC)
          case .Line6:
              return UIColor(netHex: 0xCD7C2F)
          case .Line7:
              return UIColor(netHex: 0x747F00)
          case .Line8:
              return UIColor(netHex: 0xEA545D)
          case .Line9:
              return UIColor(netHex: 0xBDB092)
          case .LineA:
              return UIColor(netHex: 0x0090D2)
          case .LineB:
              return UIColor(netHex: 0xF5A200)
          case .LineE:
              return UIColor(netHex: 0x509F22)
          case .LineG:
              return UIColor(netHex: 0x77C4A3)
          case .LineGG:
              return UIColor(netHex: 0xAD8605)
          case .LineI1:
              return UIColor(netHex: 0x7CA8D5)
          case .LineI2:
              return UIColor(netHex: 0xED8B00)
          case .LineK:
              return UIColor(netHex: 0x77C4A3)
          case .LineKK:
              return UIColor(netHex: 0x003DA5)
          case .LineS:
              return UIColor(netHex: 0xD4003B)
          case .LineSU:
              return UIColor(netHex: 0xF5A200)
          case .LineSL:
              return UIColor(netHex: 0x81A914)
          case .LineU:
              return UIColor(netHex: 0xFDA600)
          case .LineUI:
              return UIColor(netHex: 0xB0CE18)
          }
      }
}
