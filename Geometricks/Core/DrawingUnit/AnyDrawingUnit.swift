struct AnyDrawingUnit<_RawValue: Real> {
    typealias RawValue = _RawValue
    
    private let _drawPoint: (RawPoint<RawValue>, Identifier) -> Void
    private let _drawLine: (RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawCurve: (RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawCircle: (RawPoint<RawValue>, RawValue, Identifier) -> Void
    private let _drawCircleCircleIntersectionArea: (RawCircle<RawValue>, RawValue, RawValue, RawCircle<RawValue>, RawValue, RawValue, Identifier) -> Void
    private let _drawingWillStart: (RawRect<RawValue>?) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<T: DrawingUnit>(_ drawingUnit: T) where T.RawValue == RawValue {
        _drawPoint = drawingUnit.drawRawPoint
        _drawLine = drawingUnit.drawRawLine
        _drawCurve = drawingUnit.drawRawCurve
        _drawCircle = drawingUnit.drawRawCircle
        _drawCircleCircleIntersectionArea = drawingUnit.drawRawCircleCircleIntersectionArea
        _drawingWillStart = drawingUnit.rawDrawingWillStart
        _drawingDidEnd = drawingUnit.drawingDidEnd
    }
}

extension AnyDrawingUnit: DrawingUnit {
    typealias Point = RawPoint<RawValue>
    typealias Rect = RawRect<RawValue>
    
    func drawPoint(at location: RawPoint<RawValue>, identifier: Identifier) {
        _drawPoint(location, identifier)
    }
    
    func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: Identifier) {
        _drawLine(start, end, identifier)
    }
    
    func drawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint0: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, identifier: Identifier) {
        _drawCurve(start, end, controlPoint0, controlPoint1, identifier)
    }
    
    func drawCircle(center: RawPoint<RawValue>, radius: RawValue, identifier: Identifier) {
        _drawCircle(center, radius, identifier)
    }
    
    func drawCircleCircleIntersectionArea(center0: RawPoint<RawValue>, radius0: RawValue, startAngle0: RawValue, endAngle0: RawValue, center1: RawPoint<RawValue>, radius1: RawValue, startAngle1: RawValue, endAngle1: RawValue, identifier: Identifier) {
        let rawCircles = (RawCircle(center: center0, radius: radius0), RawCircle(center: center1, radius: radius1))
        _drawCircleCircleIntersectionArea(rawCircles.0, startAngle0, endAngle0, rawCircles.1, startAngle1, endAngle1, identifier)
    }
    
    func drawingWillStart(in rect: RawRect<RawValue>?) {
        _drawingWillStart(rect)
    }
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
