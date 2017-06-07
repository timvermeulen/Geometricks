protocol Drawable: Identifiable {
    associatedtype RawValue: FloatingPoint
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>)
}

extension Drawable {
    func draw<T: DrawingUnit>(in drawingUnit: T) where T.RawValue == RawValue {
        draw(in: AnyDrawingUnit(drawingUnit))
    }
}
