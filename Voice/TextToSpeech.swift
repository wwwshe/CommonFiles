//
//  TextToSpeech.swift
//  
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
   
    /// Text To Speech
    /// - Parameters:
    ///   - text: Speech할 텍스트
    ///   - isVoiceOver: default : false , true : Voice Over Running, false : Voice Over Off
    func startTTS(text : String, isVoiceOver : Bool = false){
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
