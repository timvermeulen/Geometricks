final class CircleCircleIntersectionArea<_RawValue: FloatingPoint> {
    typealias RawValue = _RawValue
    
    private let circles: (Circle<RawValue>, Circle<RawValue>)
    
    let observableStorage = ObservableStorage()
    
    init(_ circle0: Circle<RawValue>, _ circle1: Circle<RawValue>) {
        circles = (circle0, circle1)
    }
}

extension CircleCircleIntersectionArea: Observer, Observable {
}

extension CircleCircleIntersectionArea: Drawable {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        let intersections = CircleCircleIntersection.bothIntersections(circles.0, circles.1)
        
        guard
            let center0 = circles.0.center.makeRawPoint(),
            let center1 = circles.1.center.makeRawPoint(),
            let intersection0 = intersections.0.makeRawPoint(),
            let intersection1 = intersections.1.makeRawPoint(),
            let radius0 = RawCircle(circles.0)?.radius,
            let radius1 = RawCircle(circles.1)?.radius
            else { return }
        
        let startAngle0 = intersection0.angle(relativeTo: center0)
        let endAngle0   = intersection0.angle(relativeTo: center1)
        let startAngle1 = intersection1.angle(relativeTo: center1)
        let endAngle1   = intersection1.angle(relativeTo: center0)
        
        drawingUnit.drawCircleCircleIntersectionArea(
            center0: center0,
            radius0: radius0,
            startAngle0: startAngle0,
            endAngle0: endAngle0,
            center1: center1,
            radius1: radius1,
            startAngle1: startAngle1,
            endAngle1: endAngle1,
            identifier: identifier
        )
    }
}
