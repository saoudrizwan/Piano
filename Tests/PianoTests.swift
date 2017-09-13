//
//  PianoTests.swift
//  PianoTests
//
//  Created by Saoud Rizwan on 9/11/17.
//  Copyright © 2017 Saoud Rizwan. All rights reserved.
//

import XCTest
@testable import Piano

class PianoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        Piano.wakeTapticEngine()
        Piano.prepareTapticEngine()
    }
    
    override func tearDown() {
        super.tearDown()
        
        Piano.putTapticEngineToSleep()
    }
    
    func testExample() {
        Piano.play([
            .sound(.asset(name: "acapella")),
            .hapticFeedback(.impact(.light)),
            .waitUntilFinished,
            .hapticFeedback(.impact(.heavy)),
            .wait(0.2),
            .sound(.system(.chooChoo))
            ])
        
        Piano.cancel()
    }
    
}
