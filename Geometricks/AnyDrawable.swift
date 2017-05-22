struct AnyDrawable<RawValue: FloatingPoint>: Drawable {
    private let _draw: (AnyDrawingContext<RawValue>) -> Void
    
    init<D: Drawable>(_ Drawable: D) where D.RawValue == RawValue {
        _draw = Drawable.draw
    }
    
    func draw(in context: AnyDrawingContext<RawValue>) {
        _draw(context)
    }
    
    func draw<Context: DrawingContext>(in context: Context) where Context.RawValue == RawValue {
        draw(in: AnyDrawingContext(context))
    }
}
