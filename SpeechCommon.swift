//
//  SpeechCommon.swift
//
//
//  Created by jungwook on 07/10/2019.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import AVFoundation
import Speech

/*
    # 음성 관련 Delegate
    - Speech To Text 관련
*/
@objc protocol SpeechDelegate : class{
    func didSTTReusltMsg(result : String)
    func didSTTStart()
    func didSTTStop()
    @objc optional func timeOutSTT()
}
/*
    # 음성 관련 Error
*/
enum SpeechError : Error {
    case RequestNilError   // Request 객체가 nil일때 에러
}
/*
   커스텀 에러 description
 */
extension SpeechError{
    public var localizedDescription: String{
        switch self {
        case .RequestNilError:
            return "Unable to create an SFSpeechAudioBufferRecognitionRequest object"
        }
    }
}

/*
    # 음성 관련 클래스
    - TTS(Text To Speech), STT(Speech To Text)
*/
class SpeechCommon : NSObject, SFSpeechRecognizerDelegate{
    /*
        # Audio Local
          - Kor : 한국어
          - Eng : 영어
    */
    enum SpeechLocal : String{
        case Kor = "ko-KR"
        case Eng = "en_AS"
    }
    
    var delegate : SpeechDelegate?
    private var speechRecognizer : SFSpeechRecognizer!
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    private let audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioLocal = SpeechLocal.Kor
    private var timeInterval = 0.0  // defalut : 60.0(1분) , 0.0 : 시간제한 없음
    private var timerSST : Timer!
    private var isAudioEnginSetting = false
    var isSTTRunning = false // true : Recoding , false : not recoding
    
    /*
      - speechRecognizer 생성 및 delegate 할당
      */
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }
    
    init(audioLocal : SpeechLocal) {
        super.init()
        self.audioLocal = audioLocal
        speechRecognizer?.delegate = self
    }
    /*
       녹음 중지 메소드
       - 오디오입력과 음성인식 중단
    */
    func stopSTT(){
        audioEngine.stop()      // 오디오 입력 중단
        recognitionRequest?.endAudio()   // 음성인식 중단
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.inputNode.reset()
        timerStop()
        delegate?.didSTTStop()
        self.isSTTRunning = false
    }
    

    /*
     녹음 시작 메소드
     - audioEngine 꺼져 있을 경우 음성인식 실행
     - 실행중일때 오디오입력과 음성인식 중단
     */
    func startSTT() throws {
        
        if audioEngine.isRunning{   // 음성인식 러닝 체크
            stopSTT()
            
        }else{
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }
            if speechRecognizer == nil {
                speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: audioLocal.rawValue))
            }
            if isAudioEnginSetting == false {
                try audioSessionRecordSet()
            }
            
            
            //recognitionRequest를 인스턴스화합니다. 여기서 우리는 SFSpeechAudioBufferRecognitionRequest 객체를 생성합니다. 나중에 우리는 오디오 데이터를 Apple 서버에 전달하는 데 사용합니다.
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            //recognitionRequest 객체가 인스턴스화되고 nil이 아닌지 확인합니다.
            guard let recognitionRequest = recognitionRequest else {
                throw SpeechError.RequestNilError
            }
            //사용자가 말할 때의 인식 부분적인 결과를보고하도록 recognitionRequest에 지시합니다.
            recognitionRequest.shouldReportPartialResults = true
        
            let inputNode = self.audioEngine.inputNode
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                // 부울을 정의하여 인식이 최종인지 확인
                var isFinal = false
                
                if result != nil {
                    isFinal = (result?.isFinal)!
                }
                 //오류가 없거나 최종 결과가 나오면 audioEngine (오디오 입력)을 중지
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recognitionRequest = nil
                    self.isSTTRunning = false
                    self.delegate?.didSTTReusltMsg(result:  result?.bestTranscription.formattedString ?? "")
                }
            })
            
            //recognitionRequest에 오디오 입력을 추가
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.recognitionRequest?.append(buffer)
            }
            // Prepare and start the audioEngine.
            audioEngine.prepare()
                try audioEngine.start()
                isSTTRunning = true
                timerStart()
                delegate?.didSTTStart()
        }
    }
    /*
     Audio Session Recoding Setting
     */
    private func audioSessionRecordSet() throws{
        //오디오 녹음을 준비 할 AVAudioSession을 만듭니다. 여기서 우리는 세션의 범주를 녹음, 측정 모드로 설정하고 활성화합니다. 이러한 속성을 설정하면 예외가 발생할 수 있으므로 try catch 절에 넣어야합니다.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    /*
     # Text To Speech
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
            print("running")
        }else{
            print("not running")
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: audioLocal.rawValue)
            utterance.rate = 0.4
            synthesizer.speak(utterance)
        }
    }
    /*
      음성입력 시간초과일경우 중지
    */
    @objc private func fire(){
        if isSTTRunning{
            if timeInterval > 0.0{
                stopSTT()
                delegate?.timeOutSTT?()
            }
        }else{
            stopSTT()
        }
    }
    /*
       타이머 시작
    */
    private func timerStart(){
        if timeInterval > 0.0{
            if let timer = timerSST  {
                if !timer.isValid{
                    timerSST = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
                }
            }else{
                timerSST = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
            }
        }
    }
    /*
     타이머 중지
     */
    private func timerStop(){
        if timerSST != nil && timerSST.isValid {
            timerSST.invalidate()
        }
    }
}
