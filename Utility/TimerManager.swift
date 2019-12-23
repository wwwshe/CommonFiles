//
//  TimerManager.swift
//  DDota
//
//  Created by jungwook on 2019/12/23.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation

class TimerManager{
    var mTimer : Timer?
    
    func timerStart(interval : Int , run : @escaping (Timer) -> Void){
        if let timer = mTimer{
            if !timer.isValid{
                mTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: run)
            }
        }else{
            mTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: run)
        }
    }
}
