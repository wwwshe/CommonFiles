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

protocol TextToSpeech where Self : VoiceCommon{
    
}

extension TextToSpeech{
    
     /*
     MARK: Text To Speech
     - voice over off 일때만 실행
     - parameter
     - text : Speech할 텍스트
     - isVoiceOver :
     - true : Voice Over Running
     - false : Voice Over Off
     - etc
     utterance.rate : 목소리 톤
     */
    func startTTS(text : String, isVoiceOver : Bool){
        if isVoiceOver{
         
        }else{
            if synthesizer.isSpeaking{
                synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            }
            
            let utterance = AVSpeechUtterance(string: text)
                
            utterance.voice = AVSpeechSynthesisVoice(language: local.rawValue)
            utterance.rate = speechRate
            synthesizer.speak(utterance)
        }
    }
}
