protocol LogicUnitDelegate: class {
    func shouldRedraw()
}

final class LogicUnit<RawValue: FloatingPoint> {
    private var figures: [AnyDrawable<RawValue>] = []
    private var draggablePoints: [AnyDraggablePoint<RawValue>] = []
    
    weak var delegate: LogicUnitDelegate?
    
    func nearestDraggablePoint<P: ConvertibleToRawPoint>(to point: P) -> (point: AnyDraggablePoint<RawValue>, distance: RawValue)? where P.ConvertibleToRawPointRawValue == RawValue {
        return draggablePoints
            .lazy
            .map { (point: $0, distance: $0.distance(to: point)) }
            .min(by: { $0.distance < $1.distance })
    }
    
    func draggablePoints<P: ConvertibleToRawPoint>(near point: P) -> [(point: AnyDraggablePoint<RawValue>, distance: RawValue)] where P.ConvertibleToRawPointRawValue == RawValue {
        return draggablePoints.map { (point: $0, distance: $0.distance(to: point)) }
    }
    
    func startDragging(_ point: AnyDraggablePoint<RawValue>) {
    }
    
    func drag(_ point: AnyDraggablePoint<RawValue>, to location: RawPoint<RawValue>) {
        point.takeOnValue(nearestTo: location)
        delegate?.shouldRedraw()
    }
    
    func stopDragging(_ point: AnyDraggablePoint<RawValue>) {
    }
    
    func addFigure<T: Drawable>(_ drawable: T) where T.DrawableRawValue == RawValue {
        figures.append(AnyDrawable(drawable))
    }
    
    func addDraggablePoint<P: DraggablePoint>(_ point: P) where P.DrawableRawValue == RawValue {
		addFigure(point)
        draggablePoints.append(AnyDraggablePoint(point))
    }
}

extension LogicUnit: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        figures.forEach { $0.draw(in: drawingUnit) }
        drawingUnit.drawingDidEnd()
    }
}
