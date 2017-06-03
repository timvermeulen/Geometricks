struct RawPoint<RawValue: FloatingPoint> {
    var x, y: RawValue
    
    static func + (left: RawPoint, right: RawVector<RawValue>) -> RawPoint {
        return RawPoint(x: left.x + right.changeInX, y: left.y + right.changeInY)
    }
    
    static func - (left: RawPoint, right: RawPoint) -> RawVector<RawValue> {
        return RawVector(changeInX: left.x - right.x, changeInY: left.y - right.y)
    }
}

extension RawPoint: Equatable {
    static func == (left: RawPoint, right: RawPoint) -> Bool {
        return left.x == right.x && left.y == right.y
    }
}

extension RawPoint: Hashable {
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
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
