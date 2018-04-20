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
    /// Possible errors when trying to play notes
    public enum PianoError: Error {
        case notFound(String)
        case couldNotPlay(String)
    }
    
    /// Currently, printing the errors in console is the most friendly way to handle them
    func handle(error: Error) {
        if let error = error as? PianoError {
            switch error {
            case .notFound(let name):
                print("🎹 Piano could not find \(name)!")
            case .couldNotPlay(let name):
                print("🎹 Piano could not play \(name)!")
            }
        } else {
            let error = error as NSError
            print("""
                🎹 Piano encountered an error!
                Domain: \(error.domain)
                Code: \(error.code)
                Description: \(error.localizedDescription)
                Failure Reason: \(error.localizedFailureReason ?? "")
                Suggestions: \(error.localizedRecoverySuggestion ?? "")
                """)
        }
    }
}
