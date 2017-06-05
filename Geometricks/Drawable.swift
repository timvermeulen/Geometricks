protocol Drawable {
    associatedtype RawValue: FloatingPoint
    func draw(in context: AnyDrawingUnit<RawValue>)
}

extension Drawable {
    func draw<Context: DrawingUnit>(in context: Context) where Context.RawValue == RawValue {
        draw(in: AnyDrawingUnit(context))
    }
}
