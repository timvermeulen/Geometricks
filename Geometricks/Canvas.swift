import Cocoa

final class Canvas: NSView {
    let model = Model<CGFloat>()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        model.delegate = self
        
        addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        let startPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 100, y: 100))
        let endPoint = FreePoint<CGFloat>(rawPoint: RawPoint(x: 300, y: 200))
        let line = Line<CGFloat>(start: startPoint, end: endPoint)
        
        model.addFigure(line)
        model.addFreeValued(startPoint)
        model.addFreeValued(endPoint)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = CocoaDrawingContext()
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
