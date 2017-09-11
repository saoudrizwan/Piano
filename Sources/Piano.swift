// The MIT License (MIT)
//
// Copyright (c) 2017 Saoud Rizwan <hello@saoudmr.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import AudioToolbox.AudioServices
import AVFoundation

/// Default system sounds predefined and available on all iPhones
/// Source: http://iphonedevwiki.net/index.php/AudioServices
public enum SystemSound: Int {
    case newMail = 1000
    case mailSent = 1001
    case voiceMail = 1002
    case receivedMessage = 1003
    case sentMessage = 1004
    case alarm = 1005
    case lowPower = 1006
    case smsReceived1 = 1007
    case smsReceived2 = 1008
    case smsReceived3 = 1009
    case smsReceived4 = 1010
    case smsReceived7 = 1012
    case smsReceived5 = 1013
    case smsReceived6 = 1014
    case voicemail = 1015
    case tweetSent = 1016
    case anticipate = 1020
    case bloom = 1021
    case calypso = 1022
    case chooChoo = 1023
    case descent = 1024
    case fanfare = 1025
    case ladder = 1026
    case minuet = 1027
    case newsFlash = 1028
    case noir = 1029
    case sherwhoodForest = 1030
    case spell = 1031
    case suspense = 1032
    case telegraph = 1033
    case tiptoes = 1034
    case typewriters = 1035
    case update = 1036
    case ussd = 1050
    case simToolkitCallDropped = 1051
    case simToolkitGeneralBeep = 1052
    case simToolkitNegativeAck = 1053
    case simToolkitPositiveAck = 1054
    case simToolkitSms = 1055
    case tinkQuiet = 1057
    case ctBusy = 1070
    case ctCongestion = 1071
    case ctPathAck = 1072
    case ctError = 1073
    case ctCallWaiting = 1074
    case ctKeyTone2 = 1075
    case lock = 1100
    case unlock = 1101
    case unlockFailed = 1102
    case tink = 1103
    case tock = 1104
    case beepBeep = 1106
    case ringerChanged = 1107
    case photoShutter = 1108
    case shake = 1109
    case jblBegin = 1110
    case jblConfirm = 1111
    case jblCancel = 1112
    case beginRecord = 1113
    case endRecord = 1114
    case jblAmbiguous = 1115
    case jblNoMatch = 1116
    case beginVideoRecord = 1117
    case endVideoRecord = 1118
    case vcInvitationAccepted = 1150
    case vcRinging = 1151
    case vcEnded = 1152
    case ctCallWaiting2 = 1153
    case vcRingingQuiet = 1154
    case touchTone0 = 1200
    case touchTone1 = 1201
    case touchTone2 = 1202
    case touchTone3 = 1203
    case touchTone4 = 1204
    case touchTone5 = 1205
    case touchTone6 = 1206
    case touchTone7 = 1207
    case touchTone8 = 1208
    case touchTone9 = 1209
    case touchToneStar = 1210
    case touchTonePound = 1211
    case headsetStartCall = 1254
    case headsetRedial = 1255
    case headsetAnswerCall = 1256
    case headsetEndCall = 1257
    case headsetWait = 1258
    case headsetTransitionEnd = 1259
    case tockQuiet = 1306
}

/// Audio types - used for finding desired audio file from main bundle or any .xcassets catalogs
public enum AudioType: String {
    case mov = "mov"
    case qt = "qt"
    case mp4 = "mp4"
    case m4v = "m4v"
    case m4a = "m4a"
    case caf = "caf"
    case wav = "wav"
    case wave = "wave"
    case bwf = "bwf"
    case aif = "aif"
    case aiff = "aiff"
    case aifc = "aifc"
    case cdda = "cdda"
    case amr = "amr"
    case mp3 = "mp3"
    case au = "au"
    case snd = "snd"
    case ac3 = "ac3"
    case eac3 = "eac3"
    //case jpg = "jpg"
    //case jpeg = "jpeg"
    //case dng = "dng"
    //case heic = "heic"
    //case avci = "avci"
    //case heif = "heif"
    //case tiff = "tiff"
    //case tif = "tif"
    case other = ""
}


/// Audio file to play
///
/// - file: searches main bundle and any .xcassets catalogs for file with given name and type
/// - url: url of audio file
/// - system: predefined system sound included in all iPhones
public enum Audio {
    case file(name: String, type: AudioType)
    case url(URL)
    case system(SystemSound)
}

/// Standard vibrations available on all models of the iPhone
public enum Vibration: Int {
    /// `default` basic 1 second vibration
    case `default` = 4095
    /// alert two short consecutive vibrations
    case alert = 1011
}

/// First generation Taptic Engine vibrations
///
/// - peek: weak boom
/// - pop: strong boom
/// - cancelled: three sequential weak booms
/// - tryAgain: week boom then strong boom
/// - failed: three sequential strong booms
public enum TapticEngine: Int {
    case peek = 1519
    case pop = 1520
    case cancelled = 1521
    case tryAgain = 1102
    case failed = 1107
}


public enum HapticFeedback {
    case notification(Notification)
    /// <#Description#>
    ///
    /// - success: <#success description#>
    /// - warning: <#warning description#>
    /// - failure: <#failure description#>
    public enum Notification {
        case success
        case warning
        case failure
    }
    
    case impact(Impact)
    public enum Impact {
        case light
        case medium
        case heavy
    }
    
    case selection
}

public enum Note {
    case sound(Audio)
    
    case vibration(Vibration)
    case tapticEngine(TapticEngine)
    case hapticFeedback(HapticFeedback)
    
    case pause(TimeInterval)
}

public typealias 🎹 = Piano

public class Piano {
    
    private init() { }
    
    private static let `default` = Piano()
    
    private var feedbackGenerator: (notification: UINotificationFeedbackGenerator?,
        impact: (light: UIImpactFeedbackGenerator?,
        medium: UIImpactFeedbackGenerator?,
        heavy: UIImpactFeedbackGenerator?),
        selection: UISelectionFeedbackGenerator?) = (nil, (nil, nil, nil), nil)
    
    public static func wakeTapticEngine() {
        Piano.default.feedbackGenerator = (notification: UINotificationFeedbackGenerator(), impact: (light: UIImpactFeedbackGenerator(style: .light), medium: UIImpactFeedbackGenerator(style: .medium), heavy: UIImpactFeedbackGenerator(style: .heavy)), selection: UISelectionFeedbackGenerator())
    }
    
    public static func prepareTapticEngine() {
        Piano.default.feedbackGenerator.selection?.prepare()
        Piano.default.feedbackGenerator.notification?.prepare()
        Piano.default.feedbackGenerator.impact.light?.prepare()
        Piano.default.feedbackGenerator.impact.medium?.prepare()
        Piano.default.feedbackGenerator.impact.heavy?.prepare()
    }
    
    public static func putTapticEngineToSleep() {
        Piano.default.feedbackGenerator = (nil, (nil, nil, nil), nil)
    }
    
    private var player: AVAudioPlayer?
    
    private func playAudio(from url: URL) {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try? AVAudioSession.sharedInstance().setActive(true)
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    private func playAudio(from file: (name: String, type: AudioType)) {
        var playedAudioFromBundle = false
        if let url = Bundle.main.url(forResource: file.name, withExtension: file.type.rawValue) {
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try? AVAudioSession.sharedInstance().setActive(true)
            player = try? AVAudioPlayer(contentsOf: url)
            if let player = player {
                player.play()
                playedAudioFromBundle = true
            }
        }
        
        guard !playedAudioFromBundle else { return }
        guard let sound = NSDataAsset(name: file.name) else {
            print("Piano couldn't find audio named \(file.name + "." + file.type.rawValue)")
            return
        }
        var audioType: AVFileType?
        switch file.type {
        case .mov, .qt: audioType = .mov
        case .mp4: audioType = .mp4
        case .m4v: audioType = .m4v
        case .m4a: audioType = .m4a
        case .caf: audioType = .caf
        case .wav, .wave, .bwf: audioType = .wav
        case .aif, .aiff: audioType = .aiff
        case .aifc, .cdda: audioType = .aifc
        case .amr: audioType = .amr
        case .mp3: audioType = .mp3
        case .au, .snd: audioType = .au
        case .ac3: audioType = .ac3
        case .eac3: audioType = .eac3
        //case .jpg, .jpeg: audioType = .jpg
        //case .dng: audioType = .dng
        //case .heic: audioType = .heic
        //case .avci: audioType = .avci
        //case .heif: audioType = .heif
        //case .tiff, .tif: audioType = .tif
        case .other: audioType = nil
        }
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try? AVAudioSession.sharedInstance().setActive(true)
        player = try? AVAudioPlayer(data: sound.data, fileTypeHint: audioType?.rawValue)
        if let player = player {
            player.play()
        } else {
            print("Piano couldn't find audio named \(file.name + "." + file.type.rawValue)")
        }
    }
    
    private var timers = [Timer]()
    private typealias Block = (() -> Void)
    
    public static func cancel() {
        for timer in Piano.default.timers {
            timer.invalidate()
        }
    }
    
    public static func play(_ notes: [Note]) {
        cancel()
        Piano.default.timers.removeAll()
        var pauseDurationBeforeNextNote: TimeInterval = 0
        for i in 0..<notes.count {
            let note = notes[i]
            var music: Block? = nil
            switch note {
            case .sound(let audio):
                switch audio {
                case .file(let name, let type):
                    music = { Piano.default.playAudio(from: (name, type)) }
                case .url(let url):
                    music = { Piano.default.playAudio(from: url) }
                case .system(let sound):
                    music = { AudioServicesPlaySystemSound(SystemSoundID(sound.rawValue)) }
                }
            case .vibration(let vibration):
                music = { AudioServicesPlaySystemSound(SystemSoundID(vibration.rawValue)) }
            case .tapticEngine(let engine):
                music = { AudioServicesPlaySystemSound(SystemSoundID(engine.rawValue)) }
            case .hapticFeedback(let feedback):
                switch feedback {
                case .notification(let notification):
                    switch notification {
                    case .success:
                        music = { Piano.default.feedbackGenerator.notification?.notificationOccurred(.success) }
                    case .warning:
                        music = { Piano.default.feedbackGenerator.notification?.notificationOccurred(.warning) }
                    case .failure:
                        music = { Piano.default.feedbackGenerator.notification?.notificationOccurred(.error) }
                    }
                case .impact(let impact):
                    switch impact {
                    case .light:
                        music = { Piano.default.feedbackGenerator.impact.light?.impactOccurred() }
                    case .medium:
                        music = { Piano.default.feedbackGenerator.impact.medium?.impactOccurred() }
                    case .heavy:
                        music = { Piano.default.feedbackGenerator.impact.heavy?.impactOccurred() }
                    }
                case .selection:
                    music = { Piano.default.feedbackGenerator.selection?.selectionChanged() }
                }
            case .pause(let interval):
                pauseDurationBeforeNextNote += interval
            }
            if let music = music {
                let timer = Timer.scheduledTimer(withTimeInterval: pauseDurationBeforeNextNote, repeats: false, block: { (_) in
                    music()
                })
                Piano.default.timers.append(timer)
            }
        }
    }
}

public extension UIDevice {
    public enum DevicePlatform: String {
        case other = "Old Device"
        case iPhone6S = "iPhone 6S"
        case iPhone6SPlus = "iPhone 6S Plus"
        case iPhone7 = "iPhone 7"
        case iPhone7Plus = "iPhone 7 Plus"
    }
    
    public var platform: DevicePlatform {
        get {
            var sysinfo = utsname()
            uname(&sysinfo)
            let platform = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
            switch platform {
            case "iPhone9,2", "iPhone9,4":
                return .iPhone7Plus
            case "iPhone9,1", "iPhone9,3":
                return .iPhone7
            case "iPhone8,2":
                return .iPhone6SPlus
            case "iPhone8,1":
                return .iPhone6S
            default:
                return .other
            }
        }
    }
    
    public var hasTapticEngine: Bool {
        get {
            return platform == .iPhone6S || platform == .iPhone6SPlus ||
                platform == .iPhone7 || platform == .iPhone7Plus
        }
    }
    
    public var hasHapticFeedback: Bool {
        get {
            return platform == .iPhone7 || platform == .iPhone7Plus
        }
    }
}

