//
//  SpeechTimer.swift
//  sample
//
//  Created by jungwook on 2019/11/15.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation

internal protocol SpeechTimerDelegate : class{
    func timeOut()
}


internal class SpeechTimer{
    var timer : Timer!
    var timeInterval = 0.0  // defalut : 60.0(1분) , 0.0 : 시간제한 없음
    weak var delegate : SpeechTimerDelegate?
    /*
     음성입력 시간초과일경우 중지
     */
    @IBAction func fire(){
        delegate?.timeOut()
    }
    /*
     타이머 시작
     */
    func timerStart(timeInterval : Double){
        if timeInterval > 0.0{
            if let timer = self.timer  {
                if !timer.isValid{
                    self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
                }
            }else{
                timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
            }
        }
    }
    /*
     타이머 중지
     */
    func timerStop(){
        if timer != nil && timer.isValid {
            timer.invalidate()
        }
    }
}
