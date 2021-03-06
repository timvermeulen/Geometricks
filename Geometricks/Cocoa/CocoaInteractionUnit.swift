import AppKit

final class CocoaInteractionUnit {
    private let logicUnit: LogicUnit<CGFloat>
    private let drawingUnit: CocoaDrawingUnit
    
    init(logicUnit: LogicUnit<CGFloat>, drawingUnit: CocoaDrawingUnit) {
        self.logicUnit = logicUnit
        self.drawingUnit = drawingUnit
    }
    
    private var point: (point: AnyDraggablePoint<CGFloat>, location: RawPoint<CGFloat>)?
    
    @objc func handlePan(recognizer: NSPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            let point = recognizer.location(in: recognizer.view)
            guard let (nearestPoint, rawPoint, _) = logicUnit.draggablePoints(near: point).first(where: { $0.distance < drawingUnit.pointRadius(of: $0.point) }) else { return }
            
            logicUnit.startDragging(nearestPoint)
            self.point = (nearestPoint, rawPoint)
            
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            guard let (point, location) = point else { return }
            
            let vector = translation.makeRawVector()
            let newLocation = location + vector
            
            logicUnit.drag(point, to: newLocation)
            
        default:
            guard let point = point?.point else { return }
            
            logicUnit.stopDragging(point)
            self.point = nil
        }
    }
}
