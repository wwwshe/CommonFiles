//
//  Date+Extention.swift
//  TabGestureSample
//
//  Created by jungwook on 2019/11/13.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation


extension Date {
    // 두날짜의 차이 일수 구하기
    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)

        return abs(components.day ?? 0)
    }
}
