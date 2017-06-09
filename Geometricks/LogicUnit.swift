protocol LogicUnitDelegate: class {
    func shouldRedraw()
}

final class LogicUnit<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
    private var figures: [AnyDrawable<RawValue>] = []
    private var draggablePoints: [AnyDraggablePoint<RawValue>] = []
    
    weak var delegate: LogicUnitDelegate?
    
    func nearestDraggablePoint<P: ConvertibleToRawPoint>(to point: P) -> (point: AnyDraggablePoint<RawValue>, rawPoint: RawPoint<RawValue>, distance: RawValue)? where P.RawValue == RawValue {
		return draggablePoints(near: point).min(by: { $0.distance < $1.distance })
    }
    
	func draggablePoints<P: ConvertibleToRawPoint>(near point: P) -> [(point: AnyDraggablePoint<RawValue>, rawPoint: RawPoint<RawValue>, distance: RawValue)] where P.RawValue == RawValue {
		return draggablePoints.flatMap {
			guard let rawPoint = $0.makeRawPoint() else { return nil }
			// TODO: fix `!` by adding a protocol?
			return (point: $0, rawPoint: rawPoint, distance: rawPoint.distance(to: point)!)
		}
    }
    
    func startDragging(_ point: AnyDraggablePoint<RawValue>) {
    }
    
    func drag(_ point: AnyDraggablePoint<RawValue>, to location: RawPoint<RawValue>) {
        point.takeOnValue(nearestTo: location)
        delegate?.shouldRedraw()
    }
    
    func stopDragging(_ point: AnyDraggablePoint<RawValue>) {
    }
    
    func addFigure<T: Drawable>(_ drawable: T) where T.RawValue == RawValue {
        figures.append(AnyDrawable(drawable))
    }
    
    func addDraggablePoint<P: DraggablePoint>(_ point: P) where P.RawValue == RawValue {
		addFigure(point)
        draggablePoints.append(AnyDraggablePoint(point))
    }
}

extension LogicUnit: Drawable {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		drawingUnit.drawingWillStart(in: rect)
		figures.forEach { $0.draw(in: rect, using: drawingUnit) }
		drawingUnit.drawingDidEnd()
	}
}
