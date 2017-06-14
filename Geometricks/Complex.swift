struct Complex<RawValue: Real> {
	var realPart: RawValue
	var imaginaryPart: RawValue
    
    init(realPart: RawValue = 0, imaginaryPart: RawValue = 0) {
        self.realPart = realPart
        self.imaginaryPart = imaginaryPart
    }
}

extension Complex {
    static var i: Complex { return Complex(realPart: 0, imaginaryPart: 1) }
    
    static func squareRoot(of value: RawValue) -> Complex {
        return value >= 0 ? Complex(realPart: value.squareRoot()) : Complex(imaginaryPart: (-value).squareRoot())
    }
    
	var squaredNorm: RawValue {
		return realPart * realPart + imaginaryPart * imaginaryPart
	}
	
	var norm: RawValue {
		return squaredNorm.squareRoot()
	}
	
	var real: RawValue? {
		return imaginaryPart.isZero ? realPart : nil
	}
	
	var conjugate: Complex {
		return Complex(realPart: realPart, imaginaryPart: -imaginaryPart)
	}
}

extension Complex {
	static func / (left: Complex, right: RawValue) -> Complex {
        return Complex(realPart: left.realPart / right, imaginaryPart: left.imaginaryPart / right)
    }
}

extension Complex: Equatable {
	static func == (left: Complex, right: Complex) -> Bool {
		return left.realPart == right.realPart && left.imaginaryPart == right.imaginaryPart
	}
}

extension Complex: ExpressibleByIntegerLiteral {
    init(integerLiteral: RawValue.IntegerLiteralType) {
        realPart = RawValue(integerLiteral: integerLiteral)
        imaginaryPart = 0
    }
}

extension Complex: SignedNumeric {
	init?<T: BinaryInteger>(exactly source: T) {
		guard let real = RawValue(exactly: source) else { return nil }
		
		realPart = real
		imaginaryPart = 0
	}
	
	var magnitude: RawValue {
		return norm
	}
	
	static func +(left: Complex<RawValue>, right: Complex<RawValue>) -> Complex<RawValue> {
		return Complex(realPart: left.realPart + right.realPart, imaginaryPart: left.imaginaryPart + right.imaginaryPart)
	}
	
    static func -(left: Complex<RawValue>, right: Complex<RawValue>) -> Complex<RawValue> {
        return Complex(realPart: left.realPart - right.realPart, imaginaryPart: left.imaginaryPart - right.imaginaryPart)
    }
    
	static func *(left: Complex<RawValue>, right: Complex<RawValue>) -> Complex<RawValue> {
        return Complex(
            realPart: left.realPart * right.realPart - left.imaginaryPart * right.imaginaryPart,
            imaginaryPart: left.realPart * right.imaginaryPart + left.imaginaryPart * right.realPart
        )
	}
	
	static func +=(left: inout Complex<RawValue>, right: Complex<RawValue>) {
		left.realPart += right.realPart
		left.imaginaryPart += right.imaginaryPart
	}
    
	static func -=(left: inout Complex<RawValue>, right: Complex<RawValue>) {
		left.realPart -= right.realPart
		left.imaginaryPart -= right.imaginaryPart
	}
	
	static func *=(left: inout Complex<RawValue>, right: Complex<RawValue>) {
		(left.realPart, left.imaginaryPart) = (
			left.realPart * right.realPart - left.imaginaryPart * right.imaginaryPart,
			left.realPart * right.imaginaryPart + left.imaginaryPart * right.realPart
		)
	}
}

extension Complex: CustomStringConvertible {
    var description: String {
        return real.map(String.init(describing:)) ?? "\(realPart) + \(imaginaryPart)i"
    }
}
