protocol LogicUnitDelegate: class {
    func shouldRedraw()
}

final class LogicUnit<RawValue: FloatingPoint> {
    private var figures: [AnyDrawable<RawValue>] = []
    private var freeValuedFigures: [AnyFreeValued<RawValue>] = []
    private var currentPan: (startingPoint: RawPoint<RawValue>, figure: AnyFreeValued<RawValue>)?
    
    weak var delegate: LogicUnitDelegate?
    
    func startPan<PointConvertible: ConvertibleToRawPoint>(at point: PointConvertible) where PointConvertible.RawValue == RawValue {
        let rawPoint = point.makeRawPoint()
        guard let figure = freeValuedFigures.first(where: { $0.isAtPoint(rawPoint) }) else { return }
        
        currentPan = (rawPoint, figure)
    }
    
    func pan<VectorConvertible: ConvertibleToRawVector>(translation: VectorConvertible) where VectorConvertible.RawValue == RawValue {
        guard let (point, figure) = currentPan else { return }
        
        let newPoint = point + translation.makeRawVector()
        figure.takeOnValue(nearestTo: newPoint)
        
        delegate?.shouldRedraw()
    }
    
    func endPan() {
        currentPan = nil
    }
    
    func addFigure<T: Drawable>(_ drawable: T) where T.RawValue == RawValue {
        figures.append(AnyDrawable(drawable))
    }
    
    func addFreeValued<T: FreeValued>(_ freeValued: T) where T.RawValue == RawValue {
        freeValuedFigures.append(AnyFreeValued(freeValued))
    }
}

extension LogicUnit: Drawable {
    func draw(in context: AnyDrawingUnit<RawValue>) {
        figures.forEach { $0.draw(in: context) }
        context.drawingDidEnd()
    }
}
