@testable import Geometricks

final class BasicDrawingContext<Raw: FloatingPoint>: DrawingContext {
    typealias RawValue = Raw
    
    enum Log {
        case point(RawPoint<RawValue>)
        case line(start: RawPoint<RawValue>, end: RawPoint<RawValue>)
        case curve(start: RawPoint<RawValue>, end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>)
    }
    
    private var currentLogs: Set<Log> = []
    var logs: [Set<Log>] = []
    
    private func log(_ log: Log) {
        currentLogs.insert(log)
    }
    
    func drawPoint(at location: RawPoint<RawValue>) {
        log(.point(location))
    }
    
    func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>) {
        log(.line(start: start, end: end))
    }
    
    func drawCurve(from start: RawPoint<Raw>, to end: RawPoint<Raw>, controlPoint1: RawPoint<Raw>, controlPoint2: RawPoint<Raw>) {
        log(.curve(start: start, end: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2))
    }
    
    func drawingDidEnd() {
        logs.append(currentLogs)
        currentLogs.removeAll(keepingCapacity: true)
    }
}

extension BasicDrawingContext.Log: Equatable {
    static func == (left: BasicDrawingContext.Log, right: BasicDrawingContext.Log) -> Bool {
        switch (left, right) {
        case let (.point(left), .point(right)):
            return left == right
        case let (.line(leftStart, leftEnd), .line(rightStart, rightEnd)):
            return leftStart == rightStart && leftEnd == rightEnd
        case let (.curve(leftStart, leftEnd, leftControlPoint1, leftControlPoint2), .curve(rightStart, rightEnd, rightControlPoint1, rightControlPoint2)):
            return leftStart == rightStart && leftEnd == rightEnd && leftControlPoint1 == rightControlPoint1 && leftControlPoint2 == rightControlPoint2
        case (.point, _), (.line, _), (.curve, _):
            return false
        }
    }
}

extension BasicDrawingContext.Log: Hashable {
    var hashValue: Int {
        switch self {
        case .point(let point):
            return point.hashValue
        case let .line(start, end):
            return start.hashValue ^ end.hashValue
        case let .curve(start, end, controlPoint1, controlPoint2):
            return start.hashValue ^ end.hashValue ^ controlPoint1.hashValue ^ controlPoint2.hashValue
        }
    }
}
