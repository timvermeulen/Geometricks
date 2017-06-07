import Cocoa

final class Canvas: NSView {
    let logicUnit = LogicUnit<CGFloat>()
	let drawingUnit = CocoaDrawingUnit(defaultPointRadius: 3)
    let interactionUnit: CocoaInteractionUnit
    
    required init?(coder: NSCoder) {
        interactionUnit = CocoaInteractionUnit(logicUnit: logicUnit, drawingUnit: drawingUnit)
        super.init(coder: coder)
        logicUnit.delegate = self
        addGestureRecognizer(NSPanGestureRecognizer(target: interactionUnit, action: #selector(CocoaInteractionUnit.handlePan)))
		
		loadLineSegment()
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
		
		logicUnit.addFigure(curve)
		logicUnit.addDraggablePoint(startPoint)
		logicUnit.addDraggablePoint(endPoint)
		logicUnit.addDraggablePoint(controlPoint1)
		logicUnit.addDraggablePoint(controlPoint2)
		
		drawingUnit.setCurveWidth(5, of: curve)
		drawingUnit.setCurveColor(.blue, of: curve)
		drawingUnit.setPointRadius(10, of: startPoint)
		drawingUnit.setPointRadius(4, of: endPoint)
		drawingUnit.setPointFillColor(.green, of: startPoint)
		drawingUnit.setPointFillColor(.red, of: controlPoint1)
		drawingUnit.setPointBorderColor(.purple, of: controlPoint2)
		drawingUnit.setPointBorderWidth(3, of: endPoint)
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
}

extension Canvas: LogicUnitDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
