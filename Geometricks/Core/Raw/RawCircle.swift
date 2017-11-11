struct RawCircle<RawValue: Real> {
    let center: RawPoint<RawValue>
    let radius: RawValue
}

extension RawCircle {
    func fractionOfIntersection(with other: RawCircle<RawValue>, option: CircleCircleIntersection<RawValue>.Option, makeFraction: (RawPoint<RawValue>) -> RawValue?) -> RawValue? {
        guard let fractions = fractionsOfIntersections(with: other, makeFraction: makeFraction) else { return nil }
        
        switch option {
        case .first:
            return fractions.0
        case .second:
            return fractions.1
        }
    }
    
    func fractionsOfIntersections(with other: RawCircle<RawValue>, makeFraction: (RawPoint<RawValue>) -> RawValue?) -> (RawValue, RawValue)? {
        let line = RawLine(start: center, end: other.center)
        let delta = line.delta
        let squaredDistance = delta.squaredNorm
        let distance = delta.norm
        
        let t0 = -distance - radius + other.radius
        let t1 = -distance + radius - other.radius
        let t2 = -distance + radius + other.radius
        let t3 =  distance + radius + other.radius
        let product = t0 * t1 * t2 * t3
        
        guard product >= 0 else { return nil }
        
        let x = (squaredDistance + radius.squared() - other.radius.squared()) / (2 * distance)
        let y = (1 / (2 * distance)) * (t0 * t1 * t2 * t3).squareRoot()
        
        let vector0 = RawVector(changeInX: x, changeInY: -y)
        let vector1 = RawVector(changeInX: x, changeInY: y)
        
        let angle = other.center.angle(relativeTo: center)
        
        let rotated0 = vector0.rotated(by: angle)
        let rotated1 = vector1.rotated(by: angle)
        
        let intersection0 = center + rotated0
        let intersection1 = center + rotated1
        
        guard
            let fraction0 = makeFraction(intersection0),
            let fraction1 = makeFraction(intersection1)
            else { return nil }
        
        return (fraction0, fraction1)
    }
}

extension RawCircle {
    init?(_ circle: Circle<RawValue>) {
        guard let rawCenter = circle.center.makeRawPoint(), let rawPointOnBoundary = circle.pointOnBoundary.makeRawPoint() else { return nil }
        
        center = rawCenter
        radius = rawCenter.distance(to: rawPointOnBoundary)
    }
    
    func encloses(_ other: RawCircle) -> Bool {
        return radius > center.distance(to: other.center) + other.radius
    }
}
