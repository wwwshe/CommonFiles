//
//  AudioCommon.swift
//  
//
//  Created by jungwook on 2019/11/15.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import AVFoundation
import Speech


/*
 MARK: Audio Local
 - Kor : 한국어
 - Eng : 영어
 */
public enum SpeechLocal : String{
    case Kor = "ko-KR"
    case Eng = "en_AS"
}

internal typealias Voice = TextToSpeech & SpeechToText & SpeechTimerDelegate

/*
 MARK: 음성 관련 Delegate
 - Speech To Text 관련
 */

internal protocol VoiceDelegate : class{
    func STTReusltMsg(result : String)
    func STTStart()
    func STTStop()
    func TTSFinish()
    func timeOutSTT(result : String)
}

// MARK: VoiceDelegate default func
internal extension VoiceDelegate{
    func timeOutSTT(result : String){
        
    }
    func STTStop(){
        
    }
    func TTSFinish(){
    }
}


// MARK: 음성 관련 Error
internal enum VoiceError : Error {
    case RequestNilError   // Request 객체가 nil일때 에러
}
/*
 MARK: 커스텀 에러 description
 */
internal extension VoiceError{
    var localizedDescription: String{
        switch self {
        case .RequestNilError:
            return "Unable to create an SFSpeechAudioBufferRecognitionRequest object"
        }
    }
}
/// Voice관련 Class
open class VoiceCommon : NSObject, Voice, AVSpeechSynthesizerDelegate{
    internal var speechRecognizer : SFSpeechRecognizer!
    internal var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    internal let audioEngine = AVAudioEngine()
    internal var recognitionTask: SFSpeechRecognitionTask?
    internal var audioLocal = SpeechLocal.Kor
    var timeInterval = 0.0  // defalut : 0.0초 : 시간제한 없음

    var isSTTRunning = false // true : Recoding , false : not recoding
    internal var speechTimer = SpeechTimer()
    weak var delegate : VoiceDelegate?
    var speechRate : Float = 0.4
    internal let synthesizer = AVSpeechSynthesizer()
    internal var sttString = ""
    var isReport = true // true : 중간중간 리포트
    var isEnableVoice = false
    var beforeSTTComment = ""

    /// Audio Session Recoding Setting
    func audioSessionRecordSet() throws{
        //오디오 녹음을 준비 할 AVAudioSession을 만듭니다. 여기서 우리는 세션의 범주를 녹음, 측정 모드로 설정하고 활성화합니다. 이러한 속성을 설정하면 예외가 발생할 수 있으므로 try catch 절에 넣어야합니다.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
    }
    override init() {
        super.init()
        self.speechTimer.delegate = self
        self.synthesizer.delegate = self
    }
    
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if utterance.speechString == beforeSTTComment{
           self.delegate?.TTSFinish()
        }
    }
    
    func resetVoice(){
        stopSTT()
   
        disableAVSession()
    }
    func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch  {
            DLogPrint(error)
        }
    }
}
