struct AnyDrawable<RawValue: FloatingPoint>: Drawable {
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
    
    init<D: Drawable>(_ Drawable: D) where D.RawValue == RawValue {
        _draw = Drawable.draw
    }
    
    func draw(in context: AnyDrawingUnit<RawValue>) {
        _draw(context)
    }
    
    func draw<Context: DrawingUnit>(in context: Context) where Context.RawValue == RawValue {
        draw(in: AnyDrawingUnit(context))
    }
}
