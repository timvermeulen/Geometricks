struct AnyDrawable<RawValue: FloatingPoint>: Drawable {
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
	let identifier: Identifier
    
    init<T: Drawable>(_ drawable: T) where T.RawValue == RawValue {
        _draw = drawable.draw
		identifier = drawable.identifier
    }
    
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(drawingUnit)
    }
    
    func draw<T: DrawingUnit>(in drawingUnit: T) where T.RawValue == RawValue {
        draw(in: AnyDrawingUnit(drawingUnit))
    }
}
