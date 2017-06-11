import Cocoa

final class Canvas: NSView {
    let logicUnit = LogicUnit<CGFloat>()
	let drawingUnit = CocoaDrawingUnit()
    let interactionUnit: CocoaInteractionUnit
    
    required init?(coder: NSCoder) {
        interactionUnit = CocoaInteractionUnit(logicUnit: logicUnit, drawingUnit: drawingUnit)
        super.init(coder: coder)
        logicUnit.delegate = self
        addGestureRecognizer(NSPanGestureRecognizer(target: interactionUnit, action: #selector(CocoaInteractionUnit.handlePan)))
		
		loadIntersectionArea()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        logicUnit.draw(in: dirtyRect, using: drawingUnit)
    }
}

extension Canvas {
	func loadCurve() {
		let startPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 100))
		let endPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 100))
		let controlPoint1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 400, y: 200))
		let controlPoint2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 200))
		let curve = Curve(from: startPoint, to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
		let midPoint = SlidingPoint(oneDimensional: curve, fraction: 2 / 3)
		let line1 = LineSegment(from: startPoint, to: controlPoint1)
		let line2 = LineSegment(from: endPoint, to: controlPoint2)
		
		logicUnit.addFigure(curve)
		logicUnit.addDraggablePoint(startPoint)
		logicUnit.addDraggablePoint(endPoint)
		logicUnit.addDraggablePoint(controlPoint1)
		logicUnit.addDraggablePoint(controlPoint2)
		logicUnit.addFigure(midPoint)
		logicUnit.addDraggablePoint(midPoint)
		logicUnit.addFigure(line1)
		logicUnit.addFigure(line2)
		
		drawingUnit.setPointRadius(6, of: midPoint)
		drawingUnit.setStrokeWidth(0, of: midPoint)
		drawingUnit.setFillColor(.red, of: midPoint)
		drawingUnit.setStrokeWidth(0.5, of: line1)
		drawingUnit.setStrokeWidth(0.5, of: line2)
	}
	
	func loadLine() {
		let startPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let endPoint   = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 150))
		let line = Line(from: startPoint, to: endPoint)
		let midPoint = SlidingPoint(oneDimensional: line, fraction: 1 / 2)
		
		logicUnit.addFigure(line)
		logicUnit.addFigure(midPoint)
		logicUnit.addDraggablePoint(startPoint)
		logicUnit.addDraggablePoint(endPoint)
		logicUnit.addDraggablePoint(midPoint)
		
		drawingUnit.setPointRadius(6, of: midPoint)
		drawingUnit.setStrokeWidth(0, of: midPoint)
		drawingUnit.setFillColor(.red, of: midPoint)
	}
	
	func loadLineSegment() {
		let startPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 100))
		let endPoint   = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 200))
		let lineSegment = LineSegment(from: startPoint, to: endPoint)
		let midPoint = SlidingPoint(oneDimensional: lineSegment, fraction: 1 / 3)
		
		logicUnit.addFigure(lineSegment)
		logicUnit.addDraggablePoint(startPoint)
		logicUnit.addDraggablePoint(endPoint)
		logicUnit.addDraggablePoint(midPoint)
		logicUnit.addFigure(midPoint)
		
		drawingUnit.setPointRadius(6, of: midPoint)
		drawingUnit.setStrokeWidth(0, of: midPoint)
		drawingUnit.setFillColor(.red, of: midPoint)
	}
	
	func loadCircle() {
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 150, y: 100))
		let circle = Circle(center: point1, pointOnBoundary: point2)
		let sliding = SlidingPoint(oneDimensional: circle, fraction: .pi)
		
		logicUnit.addFigure(circle)
		logicUnit.addDraggablePoint(point1)
		logicUnit.addDraggablePoint(point2)
		logicUnit.addDraggablePoint(sliding)
		
		drawingUnit.setPointRadius(6, of: sliding)
		drawingUnit.setFillColor(.red, of: sliding)
	}
	
	func loadIntersection() {
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 150, y: 100))
		let point3 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 200))
		let point4 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 150, y: 200))
		
		let line1 = Line(from: point1, to: point2)
		let line2 = Line(from: point3, to: point4)
		
		let intersection = LineLineIntersection(line1, line2)
		
		[point1, point2, point3, point4].forEach(logicUnit.addDraggablePoint)
		[line1, line2].forEach(logicUnit.addFigure)
		[point1, point2, point3, point4].forEach(logicUnit.addFigure)
		logicUnit.addFigure(intersection)
		
		drawingUnit.setPointRadius(6, of: intersection)
		drawingUnit.setStrokeWidth(0, of: intersection)
		drawingUnit.setFillColor(.red, of: intersection)
	}
	
	func loadLineCircle() {
		let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 100))
		let line = Line(from: point0, to: point1)
		
		let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 200))
		let point3 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 250))
		let circle = Circle(center: point2, pointOnBoundary: point3)
		
		let intersection0 = LineCircleIntersection(line: line, circle: circle, option: .first)
		let intersection1 = LineCircleIntersection(line: line, circle: circle, option: .second)
		
		let segment0 = LineSegment(from: point0, to: point1)
		let segment1 = LineSegment(from: intersection0, to: intersection1)
		
		logicUnit.addFigure(line)
		logicUnit.addFigure(circle)
		logicUnit.addFigures(segment0, segment1)
		logicUnit.addFigures(intersection0, intersection1)
		logicUnit.addDraggablePoints(point0, point1)
		
		drawingUnit.setStrokeColor(.clear, of: line)
		drawingUnit.setStrokeColor(.red, of: segment1)
	}
	
	func loadCircles() {
		let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 150))
		let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 200))
		let point3 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 150))
		
		let circle0 = Circle(center: point0, pointOnBoundary: point1)
		let circle1 = Circle(center: point2, pointOnBoundary: point3)
		
		let intersection0 = CircleCircleIntersection(circle0, circle1, option: .first)
		let intersection1 = CircleCircleIntersection(circle0, circle1, option: .second)
		
		let segment = LineSegment(from: intersection0, to: intersection1)
		
		logicUnit.addFigures(circle0, circle1)
		logicUnit.addFigure(segment)
		logicUnit.addDraggablePoint(point1)
		logicUnit.addFigures(intersection0, intersection1)
		
		drawingUnit.setStrokeColor(.red, of: segment)
	}
	
	func loadPerpendicularBisector() {
		let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		
		let circle0 = Circle(center: point0, pointOnBoundary: point1)
		let circle1 = Circle(center: point1, pointOnBoundary: point0)
		
		let intersection0 = CircleCircleIntersection(circle0, circle1, option: .first)
		let intersection1 = CircleCircleIntersection(circle0, circle1, option: .second)
		
		let bisector = Line(from: intersection0, to: intersection1)
		
		logicUnit.addFigure(bisector)
		logicUnit.addDraggablePoints(point0, point1)
	}
	
	func loadSquare() {
		let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let line0 = Line(from: point0, to: point1)
		
		let circle0 = Circle(center: point0, pointOnBoundary: point1)
		let circle1 = Circle(center: point1, pointOnBoundary: point0)
		
		let point2 = LineCircleIntersection(line: line0, circle: circle0, option: .first)
		let point3 = LineCircleIntersection(line: line0, circle: circle1, option: .second)
		
		let bisector0 = Line.perpendicularBisector(point2, point1)
		let bisector1 = Line.perpendicularBisector(point0, point3)
		
		let point4 = LineCircleIntersection(line: bisector0, circle: circle0, option: .second)
		let point5 = LineCircleIntersection(line: bisector1, circle: circle1, option: .second)
		
		let segment0 = LineSegment(from: point0, to: point1)
		let segment1 = LineSegment(from: point1, to: point5)
		let segment2 = LineSegment(from: point5, to: point4)
		let segment3 = LineSegment(from: point4, to: point0)
		
		logicUnit.addFigures(circle0, circle1)
		logicUnit.addFigures(line0, bisector0, bisector1)
		logicUnit.addFigures(segment0, segment1, segment2, segment3)
		logicUnit.addFigures(point2, point3, point4, point5)
		logicUnit.addDraggablePoints(point0, point1)
		
		drawingUnit.setStrokeWidth(0, of: circle0)
		drawingUnit.setStrokeWidth(0, of: circle1)
		drawingUnit.setStrokeWidth(0, of: line0)
		drawingUnit.setStrokeWidth(0, of: bisector0)
		drawingUnit.setStrokeWidth(0, of: bisector1)
		drawingUnit.setPointRadius(3, of: point2)
		drawingUnit.setPointRadius(3, of: point3)
		drawingUnit.setStrokeWidth(0, of: point2)
		drawingUnit.setStrokeWidth(0, of: point3)
	}
	
	func loadOffsetPoint() {
		let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
		let point1 = OffsetPoint(anchor: point0, offset: NSPoint(x: 50, y: 0))
		let circle0 = Circle(center: point0, pointOnBoundary: point1)
		
		let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 250, y: 100))
		let point3 = OffsetPoint(anchor: point2, offset: NSPoint(x: 50, y: 0))
		let circle1 = Circle(center: point2, pointOnBoundary: point3)
		
		let intersections = CircleCircleIntersection.bothIntersections(circle0, circle1)
		let line = LineSegment(from: intersections.0, to: intersections.1)
		
		logicUnit.addFigure(line)
		logicUnit.addFigures(circle0, circle1)
		logicUnit.addDraggablePoints(point0)
		logicUnit.addDraggablePoint(point1)
		
		drawingUnit.setStrokeColor(.red, of: line)
	}
	
	func loadSharedBoundaryPoint() {
		let point = FreePoint<CGFloat>(x: 100, y: 100)
		
		let center0 = FreePoint<CGFloat>(x: 100, y: 150)
		let center1 = FreePoint<CGFloat>(x: 175, y: 100)
		
		let circle0 = Circle(center: center0, pointOnBoundary: point)
		let circle1 = Circle(center: center1, pointOnBoundary: point)
		
		let intersections = CircleCircleIntersection.bothIntersections(circle0, circle1)
		
		logicUnit.addFigures(circle0, circle1)
		logicUnit.addFigures(intersections.0, intersections.1)
		logicUnit.addDraggablePoints(point, center0, center1)
		
		drawingUnit.setFillColor(.red, of: point)
		drawingUnit.setFillColor(.green, of: intersections.0)
		drawingUnit.setFillColor(.blue, of: intersections.1)
	}
    
    func loadIntersectionArea() {
        let point0 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 300))
        let point1 = OffsetPoint(anchor: point0, offset: NSPoint(x: 50, y: 0))
        let circle0 = Circle(center: point0, pointOnBoundary: point1)
        
        let point2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 450, y: 300))
        let point3 = OffsetPoint(anchor: point2, offset: NSPoint(x: 50, y: 0))
        let circle1 = Circle(center: point2, pointOnBoundary: point3)
        
        let intersectionArea = CircleCircleOverlappingArea(circle0, circle1)
        
        logicUnit.addFigure(intersectionArea)
        logicUnit.addFigures(circle0, circle1)
        logicUnit.addDraggablePoints(point1, point3)
        
        drawingUnit.setFillColor(.red, of: intersectionArea)
    }
}

extension Canvas: LogicUnitDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
