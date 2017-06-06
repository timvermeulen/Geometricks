struct AnyDrawable<RawValue: FloatingPoint>: Drawable {
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
    
    init<T: Drawable>(_ Drawable: T) where T.RawValue == RawValue {
        _draw = Drawable.draw
    }
    
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(drawingUnit)
    }
    
    func draw<T: DrawingUnit>(in drawingUnit: T) where T.RawValue == RawValue {
        draw(in: AnyDrawingUnit(drawingUnit))
    }
}
