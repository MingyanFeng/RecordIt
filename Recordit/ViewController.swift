//
//  ViewController.swift
//  Recordit
//
//  Created by 冯明妍 on 16/5/13.
//  Copyright © 2016年 冯明妍. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    // Custom audio encoding parameter, which determines the recording format, quality, capacity, size and other attributes, I chose to use AAC (Advanced Audio Coding) coding scheme.
    // Set voice sampling rate
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        // Set encoding (compressioin) format
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        // Start tracking voice
        AVNumberOfChannelsKey : NSNumber(int: 1),
        // Set the quality of recording audio
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.High.rawValue))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            // Initialization
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                                                settings: recordSettings)
            // Prepare to record
            audioRecorder.prepareToRecord()
        } catch {
        }
    }
    
    func directoryURL() -> NSURL? {
        // Define and build a url to store audio, set the audio file name as "demoRecording.caf".
        // The file name is set based on time
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "demoRecording"
        let recordingName = formatter.stringFromDate(currentDateTime)+".caf"
        print(recordingName)
        
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent(recordingName)
        return soundURL
    }
    
    @IBAction func startRecord(sender: AnyObject) {
        // Start recording
        if !audioRecorder.recording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder.record()
                print("Recording in process...")
            } catch {
            }
        }
    }
    @IBAction func stopRecord(sender: AnyObject) {
        // Stop recoring
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
            print("Stop recording!")
        } catch {
        }
    }
    
    
    @IBAction func startPlaying(sender: AnyObject) {
        // Start playback
        if (!audioRecorder.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                audioPlayer.play()
                print("Playback your voice!")
            } catch {
            }
        }
    }
    
    
    @IBAction func pausePlaying(sender: AnyObject) {
        // Pause playback
        if (!audioRecorder.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                audioPlayer.pause()
                
                print("Pause playback.")
            } catch {
            }
        }
        
    }
}




