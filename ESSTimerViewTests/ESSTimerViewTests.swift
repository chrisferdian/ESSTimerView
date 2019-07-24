//
//  ESSTimerViewTests.swift
//  ESSTimerViewTests
//
//  Created by Chris Ferdian on 12/03/19.
//  Copyright © 2019 Chris Ferdian. All rights reserved.
//

import XCTest
@testable import ESSTimerView

class ESSTimerViewTests: XCTestCase {

    var card:ESSCardView?
    var blackColor:UIColor?
    var timerView:ESSTimerView?
    var dummyVC:DummyViewController?
    
    override func setUp() {
        dummyVC = DummyViewController()
        card = ESSCardView(frame: .zero)
        blackColor = UIColor.hexStringToUIColor(hex: "#000")
        timerView = ESSTimerView(frame: .zero)
        dummyVC?.timer = timerView
    }

    override func tearDown() {
        card = nil
        blackColor = nil
        timerView = nil
    }

    func testTimerView() {
        let e = expectation(description: "timer running")
        timerView?.seconds = 75
        timerView?.runTimer()
        XCTAssertNotNil(timerView?.activeColor)
        DispatchQueue.main.async {
            e.fulfill()
        }
        waitForExpectations(timeout: 75.0, handler: nil)
        XCTAssert(true)

    }
    
    func testCard() {
        XCTAssertNotNil(card)
    }
    func testHexColor() {
        XCTAssertNotNil(blackColor)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
