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
    /// Second Generation Taptic Engine vibration options
    public enum HapticFeedback {
        /// Use notification feedback to communicate that a task or action has succeeded, failed, or produced a warning of some kind.
        case notification(Notification)
        public enum Notification {
            /// Indicates that a task or action, such as depositing a check or unlocking a vehicle, has completed.
            case success
            
            /// Indicates that a task or action, such as depositing a check or unlocking a vehicle, has produced a warning of some kind.
            case warning
            
            /// Indicates that a task or action, such as depositing a check or unlocking a vehicle, has failed.
            case failure
        }
        
        /// Use impact feedback generators to indicate that an impact has occurred. For example, you might trigger impact feedback when a user interface object collides with something or snaps into place.
        case impact(Impact)
        public enum Impact {
            /// Provides a physical metaphor representing a collision between small, light user interface elements. For example, the user might feel a thud when a view slides into place or two objects collide.
            case light
            
            /// Provides a physical metaphor representing a collision between moderately sized user interface elements. For example, the user might feel a thud when a view slides into place or two objects collide.
            case medium
            
            /// Provides a physical metaphor representing a collision between large, heavy user interface elements. For example, the user might feel a thud when a view slides into place or two objects collide.
            case heavy
        }
        
        /// Indicates that the selection is actively changing. For example, the user feels light taps while scrolling a picker wheel. This feedback is intended for communicating movement through a series of discrete values, not making or confirming a selection.
        case selection
    }
}

