struct RawPoint<_RawValue: FloatingPoint> {
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

extension RawPoint {
	static func point(on curve: RawCurve<RawValue>, at fraction: RawValue) -> RawPoint {
		let oppositeFraction = 1 - fraction
		
		let b1 = 3 * fraction * oppositeFraction * oppositeFraction
		let b2 = 3 * fraction * fraction 	     * oppositeFraction
		let b3 =     fraction * fraction 	     * fraction
		
		let v1 = b1 * (curve.controlPoints.0 - curve.start)
		let v2 = b2 * (curve.controlPoints.1 - curve.end)
		let v3 = b3 * (curve.end             - curve.start)
		
		return curve.start + v1 + v2 + v3
	}
	
	static func point(on line: RawLine<RawValue>, at fraction: RawValue) -> RawPoint {
		return line.start + fraction * line.delta
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

extension RawPoint: AlwaysConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint {
        return self
    }
}
