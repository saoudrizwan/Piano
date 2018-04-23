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

/// Device extension to check whether user's device supports Taptic Engine and/or Haptic Feedback
/// Be sure to use with UIDevice.current
public extension UIDevice {
    /// In order to check if the iPhone has Taptic Engine and/or Haptic Feedback support, we need to check the device's model version. This function returns the generation and version of the current device.
    /// Note: Simulators will return a result of (0, 0), resulting in the hasTapticEngine and hasHapticFeedback BOOLs returning false
    /* Example:
     "iPhone7,1" on iPhone 6 Plus -> (7, 1)
     "iPhone7,2" on iPhone 6 -> (7, 2)
     "iPhone8,1" on iPhone 6S -> (8, 1)
     "iPhone8,2" on iPhone 6S Plus -> (8, 2)
     "iPhone8,4" on iPhone SE -> (8, 4)
     "iPhone9,1" on iPhone 7 (CDMA) -> (9, 1)
     "iPhone9,3" on iPhone 7 (GSM) -> (9, 3)
     "iPhone9,2" on iPhone 7 Plus (CDMA) -> (9, 2)
     "iPhone9,4" on iPhone 7 Plus (GSM) -> (9, 4)
     iPhone 8, 8S, and X will likely use a generation of 10 or greater, and will support Haptic Feedback, so this extension will work for those devices as well.
     iPhone X -> iPhone10,6
     */
    private func getDeviceGenerationVersion() -> (generation: Int, version: Int) {
        var sysinfo = utsname()
        uname(&sysinfo)
        let platform = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
        if platform.lowercased().prefix("iPhone".count) != "iPhone".lowercased() { // Not an iPhone (probably simulator)
            return (0, 0)
        }
        let numbers = platform.filter { "0123456789,".contains($0) }
        if let commaIndex = numbers.index(of: ",") {
            let firstNumber = numbers[numbers.startIndex..<commaIndex]
            let afterCommaIndex = numbers.index(after: commaIndex)
            let secondNumber = numbers[afterCommaIndex..<numbers.endIndex] // endIndex is an index after the last index
            let generation = Int(firstNumber) ?? 0
            let version = Int(secondNumber) ?? 0
            return (generation, version)
        } else {
            return (0, 0)
        }
    }
    
    // Returns a BOOL value representing whether the current device has a Taptic Engine or not
    public var hasTapticEngine: Bool {
        get {
            let device = getDeviceGenerationVersion()
            if device.generation == 8 {
                if device.version == 4 { // SE
                    return false
                } else {
                    return true
                }
            } else if device.generation > 8 {
                return true
            } else {
                return false
            }
        }
    }
    
    // Returns a BOOL value representing whether the current device has a Taptic Engine with Haptic Feedback support
    public var hasHapticFeedback: Bool {
        get {
            let device = getDeviceGenerationVersion()
            if device.generation >= 9 {
                return true
            } else {
                return false
            }
        }
    }
}
