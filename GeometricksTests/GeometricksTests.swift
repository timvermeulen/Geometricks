import XCTest
@testable import Geometricks

class GeometricksTests: XCTestCase {
    func testLineSegment() {
        let logicUnit = LogicUnit<Double>()
        let drawingUnit = BasicDrawingUnit<Double>()
        
        let start = FreePoint<Double>(rawPoint: RawPoint(x: 100, y: 100))
        let end = FreePoint<Double>(rawPoint: RawPoint(x: 200, y: 200))
        let lineSegment = LineSegment(from: start, to: end)
        
        logicUnit.addFigure(lineSegment)
        logicUnit.addDraggablePoint(start)
        logicUnit.addDraggablePoint(end)
        
        drawingUnit.setPointRadius(5, of: end)
        
		logicUnit.draw(in: RawRect(origin: RawPoint(x: 0, y: 0), size: RawVector(changeInX: 0, changeInY: 0)), using: drawingUnit)
        
        let expectedLogs: Set<BasicDrawingUnit<Double>.Log> = [
            .point(RawPoint(x: 100, y: 100), size: 1),
            .point(RawPoint(x: 200, y: 200), size: 5),
            .lineSegment(start: RawPoint(x: 100, y: 100), end: RawPoint(x: 200, y: 200))
        ]
        
        XCTAssertEqual(drawingUnit.logs, [expectedLogs])
    }
}
