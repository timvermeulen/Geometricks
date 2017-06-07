import AppKit

final class CocoaInteractionUnit {
    let logicUnit: LogicUnit<CGFloat>
    let drawingUnit: CocoaDrawingUnit
    
    init(logicUnit: LogicUnit<CGFloat>, drawingUnit: CocoaDrawingUnit) {
        self.logicUnit = logicUnit
        self.drawingUnit = drawingUnit
    }
    
    var point: (point: AnyDraggablePoint<CGFloat>, location: RawPoint<CGFloat>)?
    
    func startPan<PointConvertible: ConvertibleToRawPoint>(at point: PointConvertible) where PointConvertible.RawValue == CGFloat {
        guard let (nearestPoint, distance) = logicUnit.nearestDraggablePoint(to: point), distance < drawingUnit.pointRadius(of: nearestPoint) else { return }
        
        logicUnit.startDragging(nearestPoint)
        self.point = (nearestPoint, nearestPoint.makeRawPoint())
    }
    
    func pan<VectorConvertible: ConvertibleToRawVector>(translation: VectorConvertible) where VectorConvertible.RawValue == CGFloat {
        guard let (point, location) = point else { return }
        
        let vector = translation.makeRawVector()
        let newLocation = location + vector
        
        logicUnit.drag(point, to: newLocation)
    }
    
    func endPan() {
        guard let point = point?.point else { return }
        
        logicUnit.stopDragging(point)
        self.point = nil
    }
}
