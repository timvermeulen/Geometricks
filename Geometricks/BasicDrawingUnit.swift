@testable import Geometricks

final class BasicDrawingUnit<Raw: FloatingPoint> {
    typealias DrawingUnitRawValue = Raw
    
    enum Log {
        case point(RawPoint<DrawingUnitRawValue>, size: DrawingUnitRawValue)
        case lineSegment(start: RawPoint<DrawingUnitRawValue>, end: RawPoint<DrawingUnitRawValue>)
        case curve(start: RawPoint<DrawingUnitRawValue>, end: RawPoint<DrawingUnitRawValue>, controlPoint1: RawPoint<DrawingUnitRawValue>, controlPoint2: RawPoint<DrawingUnitRawValue>)
    }
    
    private let defaultPointRadius: DrawingUnitRawValue = 1
    private var pointRadii: [Identifier: DrawingUnitRawValue] = [:]
    
    private func pointRadius(of identifier: Identifier) -> DrawingUnitRawValue {
        return pointRadii[identifier] ?? defaultPointRadius
    }
    
    func setPointRadius<P: Point>(_ pointRadius: DrawingUnitRawValue, of point: P) {
        pointRadii[point.identifier] = pointRadius
    }
    
    private var currentLogs: Set<Log> = []
    var logs: [Set<Log>] = []
    
    private func log(_ log: Log) {
        currentLogs.insert(log)
    }
}

extension BasicDrawingUnit: DrawingUnit {
    func drawPoint(at location: RawPoint<DrawingUnitRawValue>, identifier: Identifier) {
        log(.point(location, size: pointRadius(of: identifier)))
    }
    
    func drawLineSegment(from start: RawPoint<DrawingUnitRawValue>, to end: RawPoint<DrawingUnitRawValue>, identifier: Identifier) {
        log(.lineSegment(start: start, end: end))
    }
    
    func drawCurve(from start: RawPoint<Raw>, to end: RawPoint<Raw>, controlPoint1: RawPoint<Raw>, controlPoint2: RawPoint<Raw>, identifier: Identifier) {
        log(.curve(start: start, end: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2))
    }
    
    func drawingDidEnd() {
        logs.append(currentLogs)
        currentLogs.removeAll(keepingCapacity: true)
    }
}

extension BasicDrawingUnit.Log: Equatable {
    static func == (left: BasicDrawingUnit.Log, right: BasicDrawingUnit.Log) -> Bool {
        switch (left, right) {
        case let (.point(left), .point(right)):
            return left == right
        case let (.lineSegment(left), .lineSegment(right)):
            return left == right
        case let (.curve(left), .curve(right)):
            return left == right
        case (.point, _), (.lineSegment, _), (.curve, _):
            return false
        }
    }
}

extension BasicDrawingUnit.Log: Hashable {
    var hashValue: Int {
        switch self {
        case let .point(point, isFilled):
            return point.hashValue ^ isFilled.hashValue
        case let .lineSegment(start, end):
            return start.hashValue ^ end.hashValue
        case let .curve(start, end, controlPoint1, controlPoint2):
            return start.hashValue ^ end.hashValue ^ controlPoint1.hashValue ^ controlPoint2.hashValue
        }
    }
}
