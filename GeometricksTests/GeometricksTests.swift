import XCTest
@testable import Geometricks

class GeometricksTests: XCTestCase {
    func testLine() {
        let logicUnit = LogicUnit<Double>()
        let drawingUnit = BasicDrawingUnit<Double>()
        
        let start = FreePoint<Double>(rawPoint: RawPoint(x: 100, y: 100))
        let end = FreePoint<Double>(rawPoint: RawPoint(x: 200, y: 200))
        let line = Line(from: start, to: end)
        
        logicUnit.addFigure(line)
        logicUnit.addDraggablePoint(start)
        logicUnit.addDraggablePoint(end)
        
        drawingUnit.setPointRadius(5, of: end)
        
        logicUnit.draw(in: drawingUnit)
        
        let expectedLogs: Set<BasicDrawingUnit<Double>.Log> = [
            .point(RawPoint(x: 100, y: 100), size: 1),
            .point(RawPoint(x: 200, y: 200), size: 5),
            .line(start: RawPoint(x: 100, y: 100), end: RawPoint(x: 200, y: 200))
        ]
        
        XCTAssertEqual(drawingUnit.logs, [expectedLogs])
    }
}
