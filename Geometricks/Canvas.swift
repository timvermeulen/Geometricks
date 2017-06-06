import Cocoa

final class Canvas: NSView {
    let logicUnit = LogicUnit<CGFloat>()
    let drawingUnit = CocoaDrawingUnit()
    let interactionUnit: CocoaInteractionUnit
    
    required init?(coder: NSCoder) {
        interactionUnit = CocoaInteractionUnit(logicUnit: logicUnit, drawingUnit: drawingUnit)
        
        super.init(coder: coder)
        
        logicUnit.delegate = self
        
        addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
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
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        logicUnit.draw(in: drawingUnit)
    }
    
    @objc func handlePan(recognizer: NSPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactionUnit.startPan(at: recognizer.location(in: self))
        case .changed:
            interactionUnit.pan(translation: recognizer.translation(in: self))
        default:
            interactionUnit.endPan()
        }
    }
}

extension Canvas: LogicUnitDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
