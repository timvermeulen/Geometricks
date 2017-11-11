struct RawCurve<RawValue: Real> {
    let line: RawLine<RawValue>
    let controlPoints: (RawPoint<RawValue>, RawPoint<RawValue>)
}

extension RawCurve {
    var start: RawPoint<RawValue> {
        return line.start
    }
    
    var end: RawPoint<RawValue> {
        return line.end
    }
    
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        let oppositeFraction = 1 - fraction
        
        let b1 = 3 * fraction * oppositeFraction  * oppositeFraction
        let b2 = 3 * fraction * fraction          * oppositeFraction
        let b3 =     fraction * fraction          * fraction
        
        let v1 = b1 * (controlPoints.0 - start)
        let v2 = b2 * (controlPoints.1 - start)
        let v3 = b3 * (end             - start)
        
        return start + v1 + v2 + v3
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
        let p0 = start - point
        let p1 = 3 * (controlPoints.0 - start)
        let p2 = 3 * ((start - controlPoints.0) + (controlPoints.1 - controlPoints.0))
        let p3 = line.delta + 3 * (controlPoints.0 - controlPoints.1)
        
        let d0 = p1
        let d1 = 2 * p2
        let d2 = 3 * p3
        
        let polynomial = QuinticPolynomial(
            p0 • d0,
            p0 • d1 + p1 • d0,
            p0 • d2 + p1 • d1 + p2 • d0,
            p1 • d2 + p2 • d1 + p3 • d0,
            p2 • d2 + p3 • d1,
            p3 • d2
        )
        
        let roots = [0, 1] + (polynomial.realRoots?.filter { 0 ... 1 ~= $0 } ?? [])
        
        func distance(of root: RawValue) -> RawValue {
            return point.distance(to: self.point(at: root))
        }
        
        return roots
            .lazy
            .map { (root: $0, distance: distance(of: $0)) }
            .min(by: { $0.distance < $1.distance })!
            .root
    }
}

extension RawCurve {
    init?(_ curve: Curve<RawValue>) {
        guard
            let rawStart = curve.start.makeRawPoint(),
            let rawEnd = curve.end.makeRawPoint(),
            let rawControlPoint0 = curve.controlPoint0.makeRawPoint(),
            let rawControlPoint1 = curve.controlPoint1.makeRawPoint()
            else { return nil }
        
        line = RawLine(start: rawStart, end: rawEnd)
        controlPoints = (rawControlPoint0, rawControlPoint1)
    }
}
