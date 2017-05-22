struct RawPoint<RawValue: FloatingPoint> {
    var x, y: RawValue
    
    static func + (left: RawPoint, right: RawVector<RawValue>) -> RawPoint {
        return RawPoint(x: left.x + right.changeInX, y: left.y + right.changeInY)
    }
    
    static func - (left: RawPoint, right: RawPoint) -> RawVector<RawValue> {
        return RawVector(changeInX: left.x - right.x, changeInY: left.y - right.y)
    }
}

extension RawPoint: ConvertibleFromRawPoint {
    init(_ rawPoint: RawPoint) {
        self = rawPoint
    }
}

extension RawPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint {
        return self
    }
}

extension RawPoint: Drawable {
    func draw(in context: AnyDrawingContext<RawValue>) {
        context.drawPoint(at: self)
    }
}

extension RawPoint: Point {
}
