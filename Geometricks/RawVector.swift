infix operator •: MultiplicationPrecedence

struct RawVector<RawValue: FloatingPoint> {
    let changeInX, changeInY: RawValue
}

extension RawVector {
    static func * (left: RawValue, right: RawVector) -> RawVector {
        return RawVector(changeInX: left * right.changeInX, changeInY: left * right.changeInY)
    }
	
	static func • (left: RawVector, right: RawVector) -> RawValue {
		return left.changeInX * right.changeInX + left.changeInY * right.changeInY
	}
	
	static func - (left: RawVector, right: RawVector) -> RawVector {
		return RawVector(changeInX: left.changeInX - right.changeInX, changeInY: left.changeInY - right.changeInY)
	}
	
	static func + (left: RawVector, right: RawVector) -> RawVector {
		return RawVector(changeInX: left.changeInX + right.changeInX, changeInY: left.changeInY + right.changeInY)
	}
    
    var length: RawValue {
        return (changeInX * changeInX + changeInY * changeInY).squareRoot()
    }
	
	func rotated(by angle: RawValue) -> RawVector {
		let s = sin(angle)
		let c = cos(angle)
		
		return RawVector(
			changeInX: changeInX * c - changeInY * s,
			changeInY: changeInX * s + changeInY * c
		)
	}
	
	var angleWithXAxis: RawValue {
		let isLeft = changeInX < 0
		let angle = atan(changeInY / changeInX)
		let corrected = isLeft ? angle + .pi : angle
		
		return corrected.mod(.tau)
	}
}

extension RawVector: ConvertibleFromRawVector {
    init(_ rawVector: RawVector) {
        self = rawVector
    }
}

extension RawVector: ConvertibleToRawVector {
    func makeRawVector() -> RawVector {
        return self
    }
}
