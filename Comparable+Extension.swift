//
//  Comparable+Extension.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/14.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation


extension Comparable{
    // low 보다 작으면 low값, high보다 크면 high값으로 맞추는 메소드
   func clamp(low: Self, high: Self) -> Self {
        if (self > high) {
            return high
        } else if (self < low) {
            return low
        }
        return self
    }
}
