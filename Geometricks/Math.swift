enum Math<RawValue: FloatingPoint> {
	static func fractionsOfIntersections(line line0: RawLine<RawValue>, line line1: RawLine<RawValue>) -> (RawValue, RawValue)? {
		let matrix = TwoTwoMatrix(line0.end - line0.start, line1.start - line1.end)
		let vector = line1.start - line0.start
		
		return matrix.inverse.map { vector * $0 }.map { ($0.changeInX, $0.changeInY) }
	}
	
	static func fractionsOfLine(_ line: RawLine<RawValue>, intersectingWith rect: RawRect<RawValue>) -> (RawValue, RawValue)? {
		let sides = rect.sides
		
		let fractions = [sides.0, sides.1, sides.2, sides.3]
			.flatMap { fractionsOfIntersections(line: line, line: $0) }
			.filter { 0...1 ~= $0.1 }
			.map { $0.0 }
			.sorted()
		
		guard fractions.count == 2 else { return nil }
		
		return (fractions[0], fractions[1])
	}
	
	static func fractionOfIntersection(line: RawLine<RawValue>, circle: RawCircle<RawValue>, option: LineCircleIntersection<RawValue>.Option) -> RawValue? {
		let delta = line.start - circle.center
		
		let c0 = delta • delta - circle.radius.squared()
		let c1 = 2 * (delta • line.delta)
		let c2 = line.delta • line.delta
		
		let polynomial = QuadraticPolynomial(c0, c1, c2)
		
		switch (option, polynomial.realRoots) {
		case (.only, .one(let root)):
			return root
		case (.first, .two(let root0, _)):
			return root0
		case (.second, .two(_, let root1)):
			return root1
		default:
			return nil
		}
	}
	
	static func fractionOfintersection(circle circle0: RawCircle<RawValue>, circle circle1: RawCircle<RawValue>, option: CircleCircleIntersection<RawValue>.Option, makeFraction: (RawPoint<RawValue>) -> RawValue?) -> RawValue? {
		let line = RawLine(start: circle0.center, end: circle1.center)
		let delta = line.delta
		let squaredDistance = delta.squaredNorm
		let distance = delta.norm
		
		let t0 = -distance - circle0.radius + circle1.radius
		let t1 = -distance + circle0.radius - circle1.radius
		let t2 = -distance + circle0.radius + circle1.radius
		let t3 =  distance + circle0.radius + circle1.radius
		let product = t0 * t1 * t2 * t3
		
		guard product >= 0 else { return nil }
		
		let x = (squaredDistance + circle0.radius.squared() - circle1.radius.squared()) / (2 * distance)
		let y = (1 / (2 * distance)) * (t0 * t1 * t2 * t3).squareRoot()
		
		let vector0 = RawVector(changeInX: x, changeInY: y)
		let vector1 = RawVector(changeInX: x, changeInY: -y)
		
		let angle = circle1.center.angle(relativeTo: circle0.center)
		
		let rotated0 = vector0.rotated(by: angle)
		let rotated1 = vector1.rotated(by: angle)
		
		let intersection0 = circle0.center + rotated0
		let intersection1 = circle0.center + rotated1
		
		guard
			let fraction0 = makeFraction(intersection0),
			let fraction1 = makeFraction(intersection1)
			else { return nil }
		
		switch (product, option) {
		case (0, .only):
			return fraction0
		case (0, _):
			return nil
		case (_, .first):
			return min(fraction0, fraction1)
		case (_, .second):
			return max(fraction0, fraction1)
		case (_, .only):
			return nil
		}
	}
		
	// solve for fraction: (start + (end - start) * fraction - point) • (end - start) = 0
	static func fractionOfProjection(of point: RawPoint<RawValue>, on line: RawLine<RawValue>) -> RawValue {
		let delta1 = line.delta
		let delta2 = line.start - point
		
		let xConstant    = delta1.changeInX * delta2.changeInX
		let xCoefficient = delta1.changeInX * delta1.changeInX
		let yConstant    = delta1.changeInY * delta2.changeInY
		let yCoefficient = delta1.changeInY * delta1.changeInY
		
		return (xConstant + yConstant) / (xCoefficient + yCoefficient)
	}
	
	static func fractionOfProjection(of point: RawPoint<RawValue>, on curve: RawCurve<RawValue>) -> RawValue {
		let p0 = curve.line.delta
		let p1 = 3 * (curve.controlPoints.0 - curve.start)
		let p2 = 3 * ((curve.start - curve.controlPoints.0) + (curve.controlPoints.1 - curve.controlPoints.0))
		let p3 = p0 + 3 * (curve.controlPoints.0 - curve.controlPoints.1)
		
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
		
		// TODO
		return 1/2
	}
}
