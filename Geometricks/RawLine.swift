struct RawLine<RawValue: Real> {
    let start: RawPoint<RawValue>
    let end: RawPoint<RawValue>
}

extension RawLine {
    var delta: RawVector<RawValue> {
        return end - start
    }
    
    var midPoint: RawPoint<RawValue> {
        return start + (1 / 2) * delta
    }
    
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        return start + fraction * delta
    }
    
    func fractionsOfIntersections(with other: RawLine) -> (RawValue, RawValue)? {
        let matrix = TwoTwoMatrix(delta, -other.delta)
        let vector = other.start - start
        
        return matrix.inverse.map { vector * $0 }.map { ($0.changeInX, $0.changeInY) }
    }
    
    func fractionsOfIntersections(with rect: RawRect<RawValue>) -> (RawValue, RawValue)? {
        let sides = rect.sides
        
        let fractions = [sides.0, sides.1, sides.2, sides.3]
            .flatMap { fractionsOfIntersections(with: $0) }
            .filter { 0...1 ~= $0.1 }
            .map { $0.0 }
            .sorted()
        
        guard fractions.count == 2 else { return nil }
        
        return (fractions[0], fractions[1])
    }
    
    func fractionOfIntersection(with circle: RawCircle<RawValue>, option: LineCircleIntersection<RawValue>.Option) -> RawValue? {
        let delta = start - circle.center
        
        let c0 = delta • delta - circle.radius.squared()
        let c1 = 2 * (delta • self.delta)
        let c2 = self.delta • self.delta
        
        let polynomial = QuadraticPolynomial(c0, c1, c2)
        
        guard let roots = polynomial.realRoots, roots.count == 2 else { return nil }
        
        switch option {
        case .first:
            return roots[0]
        case .second:
            return roots[1]
        }
    }
    
    // solve for fraction: (start + (end - start) * fraction - point) • (end - start) = 0
    func fractionOfProjection(of point: RawPoint<RawValue>) -> RawValue {
        let delta1 = delta
        let delta2 = start - point
        
        let xConstant    = delta1.changeInX * delta2.changeInX
        let xCoefficient = delta1.changeInX * delta1.changeInX
        let yConstant    = delta1.changeInY * delta2.changeInY
        let yCoefficient = delta1.changeInY * delta1.changeInY
        
        return (xConstant + yConstant) / (xCoefficient + yCoefficient)
    }
}

extension RawLine {
    init(start: RawPoint<RawValue>, delta: RawVector<RawValue>) {
        self.start = start
        end = start + delta
    }
    
    init?<P1: OptionallyConvertibleToRawPoint, P2: OptionallyConvertibleToRawPoint>(start: P1, end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        guard
            let rawStart = start.makeRawPoint(),
            let rawEnd = end.makeRawPoint()
            else { return nil }
        
        self.init(start: rawStart, end: rawEnd)
    }
    
    // TODO: more generic?
    
    init?(_ line: Line<RawValue>) {
        self.init(start: line.start, end: line.end)
    }
    
    init?(_ lineSegment: LineSegment<RawValue>) {
        self.init(start: lineSegment.start, end: lineSegment.end)
    }
}
