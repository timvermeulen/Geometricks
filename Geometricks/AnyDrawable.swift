struct AnyDrawable<_RawValue: Real>: Drawable {
    typealias RawValue = _RawValue
    
    private let _draw: (RawRect<RawValue>?, AnyDrawingUnit<RawValue>) -> Void
    let identifier: Identifier
    
    init<T: Drawable>(_ drawable: T) where T.RawValue == RawValue {
        _draw = drawable.draw
        identifier = drawable.identifier
    }
    
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(rect, drawingUnit)
    }
}
