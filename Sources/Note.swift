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

@available(iOS 10.0, *)
extension Piano {
    /// Sound, feedback, vibration, or pause for Piano to play
    public enum Note {
        /// Audio file to play
        case sound(Audio)
        
        /// Standard vibrations available on all models of the iPhone
        case vibration(Vibration)
        
        /// First generation Taptic Engine vibrations
        case tapticEngine(TapticEngine)
        
        /// Second Generation Taptic Engine vibrations
        case hapticFeedback(HapticFeedback)
        
        /// Tells Piano to wait until the previous note is done playing before playing the next note
        case waitUntilFinished
        
        /// Tells Piano to wait a given duration before playing the next note
        case wait(TimeInterval)
    }
}
