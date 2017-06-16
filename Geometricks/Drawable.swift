protocol Drawable: Identifiable, RawValueType {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>)
}

extension Drawable {
	func draw<T: ConvertibleToRawRect, U: DrawingUnit>(in rect: T?, using drawingUnit: U) where T.RawValue == RawValue, U.RawValue == RawValue {
		draw(in: rect?.makeRawRect(), using: AnyDrawingUnit(drawingUnit))
	}
	
	func draw<T: DrawingUnit>(using drawingUnit: T) where T.RawValue == RawValue {
		draw(in: nil, using: AnyDrawingUnit(drawingUnit))
	}
}

extension Drawable where Self: ConvertibleToRawPoint {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		drawingUnit.drawPoint(at: makeRawPoint(), identifier: identifier)
	}
}

extension Drawable where Self: OptionallyConvertibleToRawPoint {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        guard let rawPoint = makeRawPoint() else { return }
        drawingUnit.drawPoint(at: rawPoint, identifier: identifier)
    }
}
