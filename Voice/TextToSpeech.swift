//
//  TextToSpeech.swift
//  sample
//
//  Created by jungwook on 2019/11/15.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import AVFoundation
import Speech

internal protocol TextToSpeech {
    
}

internal extension TextToSpeech{
    
     /*# Text To Speech
     - voice over off 일때만 실행
     - parameter
     - text : Speech할 텍스트
     - isVoiceOver :
     - true : Voice Over Running
     - false : Voice Over Off
     - etc
     utterance.rate : 목소리 톤
     */
    func startTTS(text : String, isVoiceOver : Bool, speechRate : Float = 0.4, local : SpeechLocal = SpeechLocal.Kor){
        if isVoiceOver{
            print("running")
        }else{
            print("not running")
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
                
            utterance.voice = AVSpeechSynthesisVoice(language: local.rawValue)
            utterance.rate = speechRate
            synthesizer.speak(utterance)
        }
    }
}
