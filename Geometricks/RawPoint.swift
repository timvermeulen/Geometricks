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
        return (point - self).length
    }
	
	func rotated(by angle: RawValue, around point: RawPoint) -> RawPoint {
		return point + (self - point).rotated(by: angle)
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
	
	static func pointOnCurve(at fraction: RawValue, start: RawPoint, end: RawPoint, controlPoint1: RawPoint, controlPoint2: RawPoint) -> RawPoint {
		let oppositeFraction = 1 - fraction
		
		let b1 = 3 * fraction         * oppositeFraction * oppositeFraction
		let b2 = 3 * fraction 	      * fraction 	     * oppositeFraction
		let b3 =     fraction 	      * fraction 	     * fraction
		
		let v1 = b1 * (controlPoint1 - start)
		let v2 = b2 * (controlPoint2 - start)
		let v3 = b3 * (end           - start)
		
		return start + v1 + v2 + v3
	}
	
	static func fractionOfProjectionOnCurve(of point: RawPoint, start: RawPoint, end: RawPoint, controlPoint1: RawPoint, controlPoint2: RawPoint) -> RawValue {
		let p0 = start - point
		let p1 = 3 * (controlPoint1 - start)
		let p2 = 3 * ((start - controlPoint1) + (controlPoint2 - controlPoint1))
		let p3 = (end - start) + 3 * (controlPoint1 - controlPoint2)
		
		let d0 = p1
		let d1 = 2 * p2
		let d2 = 3 * p3
		
		let a0 = p0 • d0
		let a1 = p0 • d1 + p1 • d0
		let a2 = p0 • d2 + p1 • d1 + p2 • d0
		let a3 = p1 • d2 + p2 • d1 + p3 • d0
		let a4 = p2 • d2 + p3 • d1
		let a5 = p3 • d2
		
		_ = "\(a0) + \(a1)x + \(a2)x^2 + \(a3)x^3 + \(a4)x^4 + \(a5)x^5"
		
		return 1/2
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
