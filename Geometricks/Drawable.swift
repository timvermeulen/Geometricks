protocol Drawable: Identifiable, RawValueType {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>)
}

extension Drawable {
    func draw<T: DrawingUnit>(in drawingUnit: T) where T.RawValue == RawValue {
        draw(in: AnyDrawingUnit(drawingUnit))
    }
}

extension Drawable where Self: ConvertibleToRawPoint {
	func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
		drawingUnit.drawPoint(at: makeRawPoint(), identifier: identifier)
	}
}
