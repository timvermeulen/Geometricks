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
		
		loadIntersection()
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
		drawingUnit.setPointBorderWidth(0, of: midPoint)
		drawingUnit.setPointFillColor(.red, of: midPoint)
		drawingUnit.setLineWidth(0.5, of: line1)
		drawingUnit.setLineWidth(0.5, of: line2)
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
		drawingUnit.setPointBorderWidth(0, of: midPoint)
		drawingUnit.setPointFillColor(.red, of: midPoint)
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
		drawingUnit.setPointBorderWidth(0, of: midPoint)
		drawingUnit.setPointFillColor(.red, of: midPoint)
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
		drawingUnit.setPointFillColor(.red, of: sliding)
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
		[point1, point2, point3, point4].forEach(logicUnit.addFigure)
		[line1, line2].forEach(logicUnit.addFigure)
		logicUnit.addFigure(intersection)
		
		drawingUnit.setPointRadius(6, of: intersection)
		drawingUnit.setPointBorderWidth(0, of: intersection)
		drawingUnit.setPointFillColor(.red, of: intersection)
	}
}

extension Canvas: LogicUnitDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
