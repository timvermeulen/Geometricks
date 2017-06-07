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
		
		loadCircle()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        logicUnit.draw(in: drawingUnit)
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
}

extension Canvas: LogicUnitDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
