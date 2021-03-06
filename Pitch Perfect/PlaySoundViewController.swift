//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Gil Felot on 22/06/15.
//  Copyright (c) 2015 Gil Felot. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receiveAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slowSound(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariableSpeed(0.75)
    }
    
    
    @IBAction func fastSound(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariableSpeed(1.5)
    }
    
    func playAudioWithVariableSpeed(speed: Float)
    {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
    
    @IBAction func playChimpmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playVadorAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopButton(sender: UIButton) {
        stopAllAudio()
    }
    
    func stopAllAudio() {
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
}
