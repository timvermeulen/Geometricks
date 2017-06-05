import Cocoa

final class Canvas: NSView {
    let model = Model<CGFloat>()
    let context = CocoaDrawingUnit()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        model.delegate = self
        
        addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        let startPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 200, y: 100))
        let endPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 100))
        let controlPoint1 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 400, y: 200))
        let controlPoint2 = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 200))
        let curve = Curve(from: startPoint, to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        model.addFigure(curve)
        model.addFreeValued(startPoint)
        model.addFreeValued(endPoint)
        model.addFreeValued(controlPoint1)
        model.addFreeValued(controlPoint2)
        
        context.setCurveWidth(5, of: curve)
        context.setCurveColor(.blue, of: curve)
        context.setPointRadius(10, of: startPoint)
        context.setPointRadius(4, of: endPoint)
        context.setPointColor(.green, of: startPoint)
        context.setPointColor(.red, of: controlPoint1)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        model.draw(in: context)
    }
    
    @objc func handlePan(recognizer: NSPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            model.startPan(at: recognizer.location(in: self))
        case .changed:
            model.pan(translation: recognizer.translation(in: self))
        default:
            model.endPan()
        }
    }
}

extension Canvas: ModelDelegate {
    func shouldRedraw() {
        setNeedsDisplay(frame)
    }
}
