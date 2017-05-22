final class FreePoint<RawValue: FloatingPoint> {
    var rawPoint: RawPoint<RawValue>
    
    init(rawPoint: RawPoint<RawValue>) {
        self.rawPoint = rawPoint
    }
}

extension FreePoint: Drawable {
    func draw(in context: AnyDrawingContext<RawValue>) {
        rawPoint.draw(in: context)
    }
}

extension FreePoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return rawPoint
    }
}

extension FreePoint: Point {
}

extension FreePoint: FreeValued {
    func isAtPoint(_ point: RawPoint<RawValue>) -> Bool {
        let distance = (point - rawPoint).length
        return distance < 6
    }

    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        rawPoint = point
    }
}
