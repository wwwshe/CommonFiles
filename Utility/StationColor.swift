//
//  StationColor.swift

//
//  Created by jungwook on 2019/11/21.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import UIKit

enum StationColor : Int{
    case Line1 = 1
    case Line2 = 2
    case Line3 = 3
    case Line4 = 4
    case Line5 = 5
    case Line6 = 6
    case Line7 = 7
    case Line8 = 8
    case Line9 = 9
    case LineA = 10 // 공항 철도
    case LineB = 11 // 분당선
    case LineE = 12 // 용인 에버랜드 경전철
    case LineG = 13 // 경의중앙선
    case LineGG = 14 // 김포 도시철도
    case LineI1 = 15 // 인천 1호선
    case LineI2 = 16// 인천 2호선
    case LineK  = 17// 경의선
    case LineKK = 18// 경강선
    case LineS  = 19 // 신분당선
    case LineSU = 20 // 수인선
    case LineSL = 21 // 서해선
    case LineU  = 22 // 의정부 경전철
    case LineUI = 23// 우이신설선
}

extension UIColor{
    static func getStationColor(line : StationColor) -> UIColor{
          switch line {
          case .Line1:
              return UIColor(red: 9, green: 52, blue: 128)
          case .Line2:
             return UIColor(red: 57, green: 160, blue: 55)
          case .Line3:
             return UIColor(red: 221, green: 92, blue: 50)
          case .Line4:
             return UIColor(red: 19, green: 107, blue: 212)
          case .Line5:
              return UIColor(red: 136, green: 0, blue: 255)
          case .Line6:
              return UIColor(red: 144, green: 77, blue: 35)
          case .Line7:
             return UIColor(red: 91, green: 105, blue: 46)
          case .Line8:
              return UIColor(red: 200, green: 28, blue: 100)
          case .Line9:
              return UIColor(red: 151, green: 125, blue: 32)
          case .LineA:
             return UIColor(red: 106, green: 168, blue: 205)
          case .LineB:
             return UIColor(red: 221, green: 167, blue: 42)
          case .LineE:
              return UIColor(red: 111, green: 177, blue: 109)
          case .LineG:
              return UIColor(red: 27, green: 180, blue: 129)
          case .LineGG:
              return UIColor(red: 236, green: 151, blue: 96)
          case .LineI1:
             return UIColor(red: 96, green: 132, blue: 180)
          case .LineI2:
              return UIColor(netHex: 0xED8B00)
          case .LineK:
            return UIColor(red: 118, green: 182, blue: 155)
          case .LineKK:
              return UIColor(netHex: 0x003DA5)
          case .LineS:
              return UIColor(red: 172, green: 36, blue: 53)
          case .LineSU:
             return UIColor(red: 219, green: 168, blue: 40)
          case .LineSL:
              return UIColor(netHex: 0x81A914)
          case .LineU:
               return UIColor(red: 231, green: 133, blue: 34)
          case .LineUI:
              return UIColor(netHex: 0xB0CE18)
          }
      }
}
