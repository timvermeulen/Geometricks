enum Math<RawValue: FloatingPoint> {
	static func fractionsOfLineIntersections(line1: (start: RawPoint<RawValue>, end: RawPoint<RawValue>), line2: (start: RawPoint<RawValue>, end: RawPoint<RawValue>)) -> (RawValue, RawValue)? {
		let matrix = TwoTwoMatrix(line1.end - line1.start, line2.start - line2.end)
		let vector = line2.start - line1.start
		
		return matrix.inverse.map { vector * $0 }.map { ($0.changeInX, $0.changeInY) }
	}
	
	static func fractionsOfLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, intersectingWith rect: RawRect<RawValue>) -> (RawValue, RawValue)? {
		let sides = rect.sides
		
		let fractions = [sides.0, sides.1, sides.2, sides.3]
			.flatMap { fractionsOfLineIntersections(line1: (start, end), line2: ($0.start, $0.end)) }
			.filter { 0...1 ~= $0.1 }
			.map { $0.0 }
			.sorted()
		
		guard fractions.count == 2 else { return nil }
		
		return (fractions[0], fractions[1])
	}
	
	// solve for fraction: (start + (end - start) * fraction - point) • (end - start) = 0
	static func fractionOfProjection(of point: RawPoint<RawValue>, onLineBetween start: RawPoint<RawValue>, and end: RawPoint<RawValue>) -> RawValue {
		let delta1 = start - end
		let delta2 = start - point
		
		let xConstant    = delta1.changeInX * delta2.changeInX
		let xCoefficient = delta1.changeInX * delta1.changeInX
		let yConstant    = delta1.changeInY * delta2.changeInY
		let yCoefficient = delta1.changeInY * delta1.changeInY
		
		return (xConstant + yConstant) / (xCoefficient + yCoefficient)
	}
	
	static func fractionOfProjectionOnCurve(of point: RawPoint<RawValue>, start: RawPoint<RawValue>, end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>) -> RawValue {
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
