protocol Drawable: Identifiable {
    associatedtype DrawableRawValue: FloatingPoint
    func draw(in drawingUnit: AnyDrawingUnit<DrawableRawValue>)
}

extension Drawable {
    func draw<T: DrawingUnit>(in drawingUnit: T) where T.DrawingUnitRawValue == DrawableRawValue {
        draw(in: AnyDrawingUnit(drawingUnit))
    }
}

extension Drawable where Self: ConvertibleToRawPoint, DrawableRawValue == Self.ConvertibleToRawPointRawValue {
	func draw(in drawingUnit: AnyDrawingUnit<DrawableRawValue>) {
		drawingUnit.drawPoint(at: makeRawPoint(), identifier: identifier)
	}
}
