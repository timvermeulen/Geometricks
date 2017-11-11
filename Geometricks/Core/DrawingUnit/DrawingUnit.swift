protocol DrawingUnit {
    associatedtype RawValue
    associatedtype Point: ConvertibleFromRawPoint = RawPoint<RawValue> where Point.RawValue == RawValue
    associatedtype Rect: ConvertibleFromRawRect = RawRect<RawValue> where Rect.RawValue == RawValue
    
    func drawPoint(at location: Point, identifier: Identifier)
    func drawLine(from start: Point, to end: Point, identifier: Identifier)
    func drawCurve(from start: Point, to end: Point, controlPoint0: Point, controlPoint1: Point, identifier: Identifier)
    func drawCircle(center: Point, radius: RawValue, identifier: Identifier)
    func drawCircleCircleIntersectionArea(center0: Point, radius0: RawValue, startAngle0: RawValue, endAngle0: RawValue, center1: Point, radius1: RawValue, startAngle1: RawValue, endAngle1: RawValue, identifier: Identifier)
    
    func drawingWillStart(in rect: Rect?)
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawingWillStart(in rect: Rect?) {
    }
    
    func drawingDidEnd() {
    }
}

extension DrawingUnit {
    func drawRawPoint(at location: RawPoint<RawValue>, identifier: Identifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
    
    func drawRawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: Identifier) {
        drawLine(from: Point(start), to: Point(end), identifier: identifier)
    }
    
    func drawRawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint0: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, identifier: Identifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint0: Point(controlPoint0), controlPoint1: Point(controlPoint1), identifier: identifier)
    }
    
    func drawRawCircle(center: RawPoint<RawValue>, radius: RawValue, identifier: Identifier) {
        drawCircle(center: Point(center), radius: radius, identifier: identifier)
    }
    
    func drawRawCircleCircleIntersectionArea(circle0: RawCircle<RawValue>, startAngle0: RawValue, endAngle0: RawValue, circle1: RawCircle<RawValue>, startAngle1: RawValue, endAngle1: RawValue, identifier: Identifier) {
        drawCircleCircleIntersectionArea(center0: Point(circle0.center), radius0: circle0.radius, startAngle0: startAngle0, endAngle0: endAngle0, center1: Point(circle1.center), radius1: circle1.radius, startAngle1: startAngle1, endAngle1: endAngle1, identifier: identifier)
    }
    
    func rawDrawingWillStart(in rect: RawRect<RawValue>?) {
        drawingWillStart(in: rect.map(Rect.init))
    }
}

extension DrawingUnit {
    func drawConvertiblePoint<P: OptionallyConvertibleToRawPoint>(at location: P, identifier: Identifier) where P.RawValue == RawValue {
        guard let rawPoint = location.makeRawPoint() else { return }
        drawRawPoint(at: rawPoint, identifier: identifier)
    }
    
    func drawConvertibleLine<P0: OptionallyConvertibleToRawPoint, P1: OptionallyConvertibleToRawPoint>(from start: P0, to end: P1, identifier: Identifier) where P0.RawValue == RawValue, P1.RawValue == RawValue {
        guard let rawStart = start.makeRawPoint(), let rawEnd = end.makeRawPoint() else { return }
        drawRawLine(from: rawStart, to: rawEnd, identifier: identifier)
    }
    
    func drawConvertibleCurve<P1: OptionallyConvertibleToRawPoint, P2: OptionallyConvertibleToRawPoint, P3: OptionallyConvertibleToRawPoint, P4: OptionallyConvertibleToRawPoint>(from start: P1, to end: P2, controlPoint0: P3, controlPoint1: P4, identifier: Identifier) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
        guard
            let rawStart = start.makeRawPoint(),
            let rawEnd = end.makeRawPoint(),
            let rawControlPoint0 = controlPoint0.makeRawPoint(),
            let rawControlPoint1 = controlPoint1.makeRawPoint()
            else { return }
        
        drawRawCurve(from: rawStart, to: rawEnd, controlPoint0: rawControlPoint0, controlPoint1: rawControlPoint1, identifier: identifier)
    }
    
    func drawConvertibleCircle<P: OptionallyConvertibleToRawPoint>(center: P, radius: RawValue, identifier: Identifier) where P.RawValue == RawValue {
        guard let rawCenter = center.makeRawPoint() else { return }
        drawRawCircle(center: rawCenter, radius: radius, identifier: identifier)
    }
    
    func convertibleDrawingWillStart<T: ConvertibleToRawRect>(in rect: T?) where T.RawValue == RawValue {
        rawDrawingWillStart(in: rect?.makeRawRect())
    }
}
