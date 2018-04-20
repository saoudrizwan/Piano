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
    /// Default system sounds predefined and available on all iPhones
    /// Source: http://iphonedevwiki.net/index.php/AudioServices
    public enum SystemSound: Int {
        case newMail = 1000
        case mailSent = 1001
        case voicemail = 1002
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
}
