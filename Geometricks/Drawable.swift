protocol Drawable {
    associatedtype RawValue: FloatingPoint
    func draw(in context: AnyDrawingContext<RawValue>)
}

extension Drawable {
    func draw<Context: DrawingContext>(in context: Context) where Context.RawValue == RawValue {
        draw(in: AnyDrawingContext(context))
    }
}
