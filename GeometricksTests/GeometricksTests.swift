//
//  GeometricksTests.swift
//  GeometricksTests
//
//  Created by Tim Vermeulen on 22/05/2017.
//  Copyright © 2017 Tim Vermeulen. All rights reserved.
//

import XCTest
@testable import Geometricks

class GeometricksTests: XCTestCase {
    func testLine() {
        let model = Model<Double>()
        let context = BasicDrawingContext<Double>()
        
        let start = FreePoint<Double>(rawPoint: RawPoint(x: 100, y: 100))
        let end = FreePoint<Double>(rawPoint: RawPoint(x: 200, y: 200))
        let line = Line(from: start, to: end)
        
        model.addFigure(line)
        model.addFreeValued(start)
        model.addFreeValued(end)
        
        model.draw(in: context)
        
        let expectedLogs: Set<BasicDrawingContext<Double>.Log> = [
            .point(RawPoint(x: 100, y: 100)),
            .point(RawPoint(x: 200, y: 200)),
            .line(start: RawPoint(x: 100, y: 100), end: RawPoint(x: 200, y: 200))
        ]
        
        XCTAssertEqual(context.logs.count, 1)
        XCTAssertEqual(context.logs.first, expectedLogs)
    }
}
