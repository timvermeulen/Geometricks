final class CircleCircleOverlappingArea<_RawValue: Real> {
    typealias RawValue = _RawValue
    
    private let circles: (Circle<RawValue>, Circle<RawValue>)
    
    let observableStorage = ObservableStorage()
    
    init(_ circle0: Circle<RawValue>, _ circle1: Circle<RawValue>) {
        circles = (circle0, circle1)
    }
}

extension CircleCircleOverlappingArea: Observer, Observable {
}

extension CircleCircleOverlappingArea: Drawable {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        let intersections = CircleCircleIntersection.bothIntersections(circles.0, circles.1)
        
        guard
            let rawCircle0 = RawCircle(circles.0),
            let rawCircle1 = RawCircle(circles.1)
            else { return }
        
        let startAngle0: RawValue
        let endAngle0: RawValue
        let startAngle1: RawValue
        let endAngle1: RawValue
        
        if let intersection0 = intersections.0.makeRawPoint(), let intersection1 = intersections.1.makeRawPoint() {
            startAngle0 = intersection0.angle(relativeTo: rawCircle0.center)
            endAngle0   = intersection1.angle(relativeTo: rawCircle0.center)
            startAngle1 = intersection1.angle(relativeTo: rawCircle1.center)
            endAngle1   = intersection0.angle(relativeTo: rawCircle1.center)
        } else {
            startAngle0 = 0
            startAngle1 = 0
            
            if rawCircle0.encloses(rawCircle1) {
                endAngle0 = 0
                endAngle1 = .tau
            } else if rawCircle1.encloses(rawCircle0) {
                endAngle0 = .tau
                endAngle1 = 0
            } else {
                return
            }
        }
        
        drawingUnit.drawRawCircleCircleIntersectionArea(
            circle0: rawCircle0,
            startAngle0: startAngle0,
            endAngle0: endAngle0,
            circle1: rawCircle1,
            startAngle1: startAngle1,
            endAngle1: endAngle1,
            identifier: identifier
        )
    }
}
