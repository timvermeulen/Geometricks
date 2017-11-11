struct RawPoint<_RawValue: Real> {
    typealias RawValue = _RawValue
    
    let x, y: RawValue
}

extension RawPoint {
    static func + (left: RawPoint, right: RawVector<RawValue>) -> RawPoint {
        return RawPoint(x: left.x + right.changeInX, y: left.y + right.changeInY)
    }
    
    static func - (left: RawPoint, right: RawPoint) -> RawVector<RawValue> {
        return RawVector(changeInX: left.x - right.x, changeInY: left.y - right.y)
    }
    
    func distance(to point: RawPoint) -> RawValue {
        return (point - self).norm
    }
    
    func rotated(by angle: RawValue, around point: RawPoint) -> RawPoint {
        return point + (self - point).rotated(by: angle)
    }
    
    func angle(relativeTo other: RawPoint) -> RawValue {
        return (self - other).angleWithXAxis
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
