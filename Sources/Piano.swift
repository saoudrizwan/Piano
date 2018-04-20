// The MIT License (MIT)
//
// Copyright (c) 2018 Saoud Rizwan <hello@saoudmr.com>
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

import Foundation
import AudioToolbox.AudioServices
import AVFoundation

@available(iOS 10.0, *)
public typealias 🎹 = Piano

/// Piano
///
/// Compose a symphony of sounds and vibrations using Taptic Engine
@available(iOS 10.0, *)
public class Piano {
    
    /// Internal instance of Piano to manage shared feedback generators and symphony trackers
    private static let `default` = Piano()
    
    /// Allocatable/deallocatable tuple of UIFeedbackGenerators (Apple recommended)
    private var feedbackGenerator: (notification: UINotificationFeedbackGenerator?,
        impact: (light: UIImpactFeedbackGenerator?,
        medium: UIImpactFeedbackGenerator?,
        heavy: UIImpactFeedbackGenerator?),
        selection: UISelectionFeedbackGenerator?) = (nil, (nil, nil, nil), nil)
    
    private var player: AVAudioPlayer?
    
    /// Keeps track of multiple symphonies, preventing multiple symphonies from being played at once
    private var symphonyCounter = 0
    
    /// Holds all the scheduled Timers with music
    private var timers = [Timer]()
    
    private init() { }
    
    /// Wakes the Taptic Engine up from an idle state
    public static func wakeTapticEngine() {
        if Piano.default.feedbackGenerator.notification == nil {
            Piano.default.feedbackGenerator = (notification: UINotificationFeedbackGenerator(),
                                               impact: (light: UIImpactFeedbackGenerator(style: .light),
                                                        medium: UIImpactFeedbackGenerator(style: .medium),
                                                        heavy: UIImpactFeedbackGenerator(style: .heavy)),
                                               selection: UISelectionFeedbackGenerator())
        }
    }
    
    /// This tells the Taptic Engine to prepare itself before creating any feedback to reduce latency when triggering feedback. You can call this as many times as you want, preferrably right before playing a .hapticFeedback note.
    ///
    /// Apple docs:
    /// When you call this method, the generator is placed into a prepared state for a short period of time. While the generator is prepared, you can trigger feedback with lower latency.
    /// Think about when you can best prepare your generators. Call prepare() before the event that triggers feedback. The system needs time to prepare the Taptic Engine for minimal latency. Calling prepare() and then immediately triggering feedback (without any time in between) does not improve latency.
    /// To conserve power, the Taptic Engine returns to an idle state after any of the following events:
    /// - You trigger feedback on the generator.
    /// - A short period of time passes (typically seconds).
    /// - The generator is deallocated.
    ///
    /// After feedback is triggered, the Taptic Engine returns to its idle state. If you might trigger additional feedback within the next few seconds, immediately call prepare() to keep the Taptic Engine in the prepared state.
    /// You can also extend the prepared state by repeatedly calling the prepare() method. However, if you continue calling prepare() without ever triggering feedback, the system may eventually place the Taptic Engine back in an idle state and ignore any further prepare() calls until after you trigger feedback at least once.
    public static func prepareTapticEngine() {
        if Piano.default.feedbackGenerator.notification == nil {
            Piano.wakeTapticEngine()
        }
        Piano.default.feedbackGenerator.selection?.prepare()
        Piano.default.feedbackGenerator.notification?.prepare()
        Piano.default.feedbackGenerator.impact.light?.prepare()
        Piano.default.feedbackGenerator.impact.medium?.prepare()
        Piano.default.feedbackGenerator.impact.heavy?.prepare()
    }
    
    /// Returns the Taptic Engine to an idle state
    public static func putTapticEngineToSleep() {
        Piano.default.feedbackGenerator = (nil, (nil, nil, nil), nil)
    }
    
    /// Plays the audio asset with the given name
    ///
    /// - Parameters:
    ///   - assetName: name of asset as per in its respective .xcassets catalog
    ///   - completion: completion handler
    private func playAudio(from assetName: String, completion: (() -> Void)?) {
        guard let asset = NSDataAsset(name: assetName) else {
            handle(error: PianoError.notFound(assetName))
            completion?()
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(data: asset.data, fileTypeHint: nil)
            if let player = player {
                player.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + player.duration, execute: {
                    completion?()
                })
            } else {
                handle(error: PianoError.couldNotPlay(assetName))
                completion?()
            }
        } catch {
            handle(error: error)
            completion?()
        }
    }
    
    /// Plays the audio file with the given name and extension
    ///
    /// - Parameters:
    ///   - file: name of file (Sound.mp4 -> ("Sound", "mp4")
    ///   - completion: completion handler
    private func playAudio(from file: (name: String, extension: String), completion: (() -> Void)?) {
        guard let url = Bundle.main.url(forResource: file.name, withExtension: file.extension) else {
            handle(error: PianoError.notFound("\(file.name + "." + file.extension)"))
            completion?()
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            if let player = player {
                player.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + player.duration, execute: {
                    completion?()
                })
            } else {
                handle(error: PianoError.couldNotPlay("\(file.name + "." + file.extension)"))
                completion?()
            }
        } catch {
            handle(error: error)
            completion?()
        }
    }
    
    /// Plays the audio from the specified URL
    ///
    /// - Parameters:
    ///   - url: file URL of audio file
    ///   - completion: completion handler
    private func playAudio(from url: URL, completion: (() -> Void)?) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            if let player = player {
                player.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + player.duration, execute: {
                    completion?()
                })
            } else {
                handle(error: PianoError.couldNotPlay(url.absoluteString))
                completion?()
            }
        } catch {
            handle(error: error)
            completion?()
        }
    }
    
    /// Plays system sound using Audio Services
    ///
    /// - Parameters:
    ///   - soundId: System Sound ID of sound
    ///   - completion: completion handler
    private func playSystemSound(with soundId: Int, completion: (() -> Void)?) {
        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(soundId)) {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    /// Plays the specified haptic feedback, calling the specified completion handler after a time manually calculated from Apple's website
    ///
    /// - Parameters:
    ///   - feedback: type of feedback to generate
    ///   - completion: completion handler
    private func playHapticFeedback(_ feedback: HapticFeedback, completion: (() -> Void)?) {
        let duration: TimeInterval // value is calculated from https://developer.apple.com/ios/human-interface-guidelines/interaction/feedback/
        switch feedback {
        case .notification(let notification):
            switch notification {
            case .success:
                Piano.default.feedbackGenerator.notification?.notificationOccurred(.success)
                duration = 0.2
            case .warning:
                Piano.default.feedbackGenerator.notification?.notificationOccurred(.warning)
                duration = 0.25
            case .failure:
                Piano.default.feedbackGenerator.notification?.notificationOccurred(.error)
                duration = 0.5
            }
        case .impact(let impact):
            switch impact {
            case .light:
                Piano.default.feedbackGenerator.impact.light?.impactOccurred()
            case .medium:
                Piano.default.feedbackGenerator.impact.medium?.impactOccurred()
            case .heavy:
                Piano.default.feedbackGenerator.impact.heavy?.impactOccurred()
            }
            duration = 0.1
        case .selection:
            Piano.default.feedbackGenerator.selection?.selectionChanged()
            duration = 0.05
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            completion?()
        })
    }
    
    /// Cancels the currently playing symphony
    public static func cancel() {
        for timer in Piano.default.timers {
            timer.invalidate()
        }
        Piano.default.timers.removeAll()
    }
    
    /// Play a symphony of notes
    ///
    /// Note: This method automatically cancels any previously playing symphonies
    public static func play(_ notes: [Note], completion: (() -> Void)? = nil) {
        cancel()
        Piano.default.symphonyCounter += 1
        var pauseDurationBeforeNextNote: TimeInterval = 0
        let notes = Piano.default.removeUnnecessaryNotes(from: notes)
        var completion = completion
        if notes.contains(where: { (note) -> Bool in
            switch note {
            case .hapticFeedback: return true
            default: return false
            }
        }) {
            prepareTapticEngine()
            if let definedCompletion = completion {
                let newCompletion: (() -> Void) = {
                    definedCompletion()
                    putTapticEngineToSleep()
                }
                completion = newCompletion
            } else {
                completion = {
                    putTapticEngineToSleep()
                }
            }
        }
        notesLoop: for i in 0..<notes.count {
            let note = notes[i]
            var music: (() -> Void)? = nil
            var iterationCompletion: (() -> Void)? = nil
            if (i < notes.count - 2) {
                let nextNote = notes[i + 1]
                switch nextNote {
                case .waitUntilFinished:
                    let afterNextNoteIndex = i + 2
                    let finalNoteIndex = notes.count - 1
                    let restOfNotes = Array(notes[afterNextNoteIndex...finalNoteIndex])
                    let capturedCounter = Piano.default.symphonyCounter
                    iterationCompletion = {
                        if Piano.default.symphonyCounter == capturedCounter {
                            play(restOfNotes, completion: completion)
                        }
                    }
                default: break
                }
            } else if (i < notes.count - 1) {
                let nextNote = notes[i + 1]
                switch nextNote {
                case .waitUntilFinished:
                    iterationCompletion = completion
                default: break
                }
            } else if i == notes.count - 1 {
                iterationCompletion = completion
            }
            switch note {
            case .sound(let audio):
                switch audio {
                case .asset(let name):
                    music = { Piano.default.playAudio(from: name, completion: iterationCompletion) }
                case .file(let name, let type):
                    music = { Piano.default.playAudio(from: (name, type), completion: iterationCompletion) }
                case .url(let url):
                    music = { Piano.default.playAudio(from: url, completion: iterationCompletion) }
                case .system(let sound):
                    music = { Piano.default.playSystemSound(with: sound.rawValue, completion: iterationCompletion) }
                }
            case .vibration(let vibration):
                music = { Piano.default.playSystemSound(with: vibration.rawValue, completion: iterationCompletion) }
            case .tapticEngine(let engine):
                music = { Piano.default.playSystemSound(with: engine.rawValue, completion: iterationCompletion) }
            case .hapticFeedback(let feedback):
                music = { Piano.default.playHapticFeedback(feedback, completion: iterationCompletion) }
            case .waitUntilFinished:
                if i != 0 {
                    break notesLoop
                }
            case .wait(let interval):
                pauseDurationBeforeNextNote += interval
                if i == notes.count - 1 {
                    music = { iterationCompletion?() }
                }
            }
            if let music = music {
                let timer = Timer.scheduledTimer(withTimeInterval: pauseDurationBeforeNextNote, repeats: false, block: { (_) in
                    music()
                })
                Piano.default.timers.append(timer)
            }
        }
        if notes.count == 0 {
            completion?()
        }
    }
    
    /// Helper method for .play() to remove unnecessary .waitUntileFinisheds
    private func removeUnnecessaryNotes(from notes: [Note]) -> [Note] {
        var results = [Note]()
        for note in notes {
            if results.count == 0 {
                results.append(note)
            } else if let last = results.last {
                switch note {
                case .waitUntilFinished:
                    switch last {
                    case .waitUntilFinished: break
                    default: results.append(note)
                    }
                default: results.append(note)
                }
            }
        }
        if results.count == 1 {
            let onlyNote = results[0]
            switch onlyNote {
            case .waitUntilFinished: return []
            default: break
            }
        } else {
            var removedFirstWaits = false
            var removedLastWaits = false
            while !removedFirstWaits || !removedLastWaits {
                switch results.first! {
                case .waitUntilFinished: results.removeFirst()
                default: removedFirstWaits = true
                }
                switch results.last! {
                case .waitUntilFinished: results.removeLast()
                default: removedLastWaits = true
                }
            }
        }
        return results
    }
}
