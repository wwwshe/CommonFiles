//
//  SpeechToText.swift
//  
//
//  Created by jungwook on 2019/11/15.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation
import AVFoundation
import Speech


protocol SpeechToText  where Self : VoiceCommon{
    
    
}
extension SpeechToText {
    /// 녹음 시작 메소드
    /// - audioEngine 꺼져 있을 경우 음성인식 실행
    /// - 실행중일때 오디오입력과 음성인식 중단
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
                    throw VoiceError.RequestNilError
                }
                //사용자가 말할 때의 인식 부분적인 결과를보고하도록 recognitionRequest에 지시합니다.
                recognitionRequest.shouldReportPartialResults = isReport
                
                
                let inputNode = self.audioEngine.inputNode
                
                recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                    
                    // 부울을 정의하여 인식이 최종인지 확인
                    var isFinal = false
                    
                    if result != nil {
                        isFinal = (result?.isFinal)!
                    }
                    self.sttString = result?.bestTranscription.formattedString ?? ""
                    self.sttString = self.sttString.stringTrim()
                    //오류가 없거나 최종 결과가 나오면 audioEngine (오디오 입력)을 중지
                    if (error == nil && self.sttString != "") || (isFinal && !self.isReport){
                        self.stopSTT()
                        if self.isSTTRunning == true {
                            self.delegate?.STTReusltMsg(result: self.sttString)
                            self.isSTTRunning = false
                            self.sttString = ""
                        }
                    }
                })
                
                //recognitionRequest에 오디오 입력을 추가
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                    self.recognitionRequest?.append(buffer)
                }
                // Prepare and start the audioEngine.
                audioEngine.prepare()
                do {
                    try audioEngine.start()
                } catch {
                    print("audoEngine Start Error : \(error)")
                }
                
                isSTTRunning = true
                speechTimer.timerStart(timeInterval: timeInterval)
                delegate?.STTStart()
            }
    }

    /// 녹음 중지 메소드
    /// - 오디오입력과 음성인식 중단
    func stopSTT(){
        guard recognitionRequest != nil else {
            return
        }
        audioEngine.stop()      // 오디오 입력 중단
        recognitionRequest?.endAudio()   // 음성인식 중단
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.inputNode.reset()
        recognitionTask?.cancel()
        self.recognitionRequest = nil
        speechTimer.timerStop()
        delegate?.STTStop()
    }
    
    
    
}


internal extension SpeechToText {
    /// 타임아웃 메소드
    func timeOut() {
        if isSTTRunning{
            if timeInterval > 0.0{
                delegate?.timeOutSTT(result: sttString)
                stopSTT()
                self.isSTTRunning = false
                self.sttString = ""
            }
        }else{
            stopSTT()
        }
    }
}
