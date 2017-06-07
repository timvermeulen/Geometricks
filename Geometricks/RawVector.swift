infix operator •: MultiplicationPrecedence

struct RawVector<RawValue: FloatingPoint> {
    let changeInX, changeInY: RawValue
    
    static func * (left: RawValue, right: RawVector) -> RawVector {
        return RawVector(changeInX: left * right.changeInX, changeInY: left * right.changeInY)
    }
	
	static func • (left: RawVector, right: RawVector) -> RawValue {
		return left.changeInX * right.changeInX + left.changeInY * right.changeInY
	}
    
    var length: RawValue {
        return (changeInX * changeInX + changeInY * changeInY).squareRoot()
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
