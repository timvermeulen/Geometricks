struct RawPoint<RawValue: FloatingPoint> {
    var x, y: RawValue
    
    static func + (left: RawPoint, right: RawVector<RawValue>) -> RawPoint {
        return RawPoint(x: left.x + right.changeInX, y: left.y + right.changeInY)
    }
    
    static func - (left: RawPoint, right: RawPoint) -> RawVector<RawValue> {
        return RawVector(changeInX: left.x - right.x, changeInY: left.y - right.y)
    }
    
    func distance(to point: RawPoint) -> RawValue {
        return (point - self).length
    }
}

extension RawPoint {
	// solve for fraction: (start + (end - start) * fraction - point) • (end - start) = 0
	static func fractionOfProjection(of point: RawPoint, onLineBetween start: RawPoint, and end: RawPoint) -> RawValue {
		let delta1 = end - start
		let delta2 = start - point
		
		let xConstant = delta1.changeInX * delta2.changeInX
		let xCoefficient = delta1.changeInX.squared()
		let yConstant = delta1.changeInY * delta2.changeInY
		let yCoefficient = delta1.changeInY.squared()
		
		return -(xConstant + yConstant) / (xCoefficient + yCoefficient)
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
